Date: Mon, 29 Jul 2002 19:51:23 -0700 (PDT)
Message-Id: <20020729.195123.59797547.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020729181702.E25451@flint.arm.linux.org.uk>
References: <20020729100009.A23843@flint.arm.linux.org.uk>
	<20020729144408.GA11206@opus.bloom.county>
	<20020729181702.E25451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 29 Jul 2002 18:17:02 +0100

   d. we keep serial.h, make it 8250-compatible ports only, and change
      CONFIG_SERIAL_MULTIPORT and friends to CONFIG_SERIAL_8250_MULTIPORT
      This is the simplest and least likely to break other code.  On the
      other hand, we end up hauling the ISA table and struct old_serial_port
      into 2.6.

My only suggestion here is that, whatever you do, if you keep
serial.h rename it to serial8250.h or similar thanks :-)

   b. serial consoles.  Each hardware driver handles its serial consoles
      by itself, and if you have two or more hardware drivers built in
      with serial console support, you need to be able to tell them apart
      with the console= kernel parameter.

      Again, this could be solvable if we have one "ttyS" view of everything
      (core.c would then be responsible for registering the console with
       printk.c and passing the various methods off to the relevant
       hardware).

On many platforms we know exactly which serial port is for
the console because this is set in some firmware variable.
For others we could say "it's ttyS0 unless stated otherwise
in console=" as one possible solution.

Hey while we're on this topic.  While converting over the sparc
drivers I've come to the conclusion that the serial console write
should be interrupt driven just like any other serial port TX.  The
con->write() algorithm in such a scheme would look something like:

static void
fooserial_console_write(struct console *con, const char *s,
			unsigned int count)
{
	struct uart_fooserial_port *up = CON_TO_UART(con);
	unsigned long flags;
	int i, true_count;

	true_count = count;
	for (i = count - 1; i >= 0; i--) {
		if (s[i] == '\n')
			true_count++;
	}

	spin_lock_irqsave(up, flags);
	poll_until_xmit_buffer_bytes_free(up, true_count);
	append_con_buffer_to_xmit_tail(up, s, count);
	spin_unlock_irqrestore(up, flags);
}

The reason it is done with this "poll until enough space" mechanism
is because we can't sleep.

Upon further consideration this does have some problems.  Because of
the silly '\n' handling this means we have to make sure printk
console output cannot give us more than 1/2 the xmit buffer size
in a single write call else we could potentially never have enough
space free to do the whole write.  We could size the xmit buffer
appropriately for console uart instances, using some value from
the console layer, to solve this.  Or we could make con->write()
calls limit how much they give at one call.  We could indicate this
limit in con->write_max or similar.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

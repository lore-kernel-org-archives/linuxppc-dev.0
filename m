From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial port text corruption
Date: Tue, 18 May 2004 23:05:27 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHMEBDCGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3EECAC02-A8EC-11D8-BBC2-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On May 18, 2004, at 6:03 AM, Joakim Tjernlund wrote:
>
> > This is very confusing and I would fix it but I don't know where to
> > start.
> > Any guesses as to where the problem is? Kernel serial layer, the 8xx
> > uart.c driver,
> > the user space login program or somewhere else?
>
> Are you using a USB to serial adapter on your laptop?

Nope, this is a plain RS232 port with TeraTerm on top. This
has also happened on different laptops.

> On the other hand, many. many years ago when the 8xx uart driver was
> written we added some delays during mode changes (which happens
> during this phase of the log in) to ensure all of the CPM fifos were
> drained
> properly.  Again, this wasn't exactly the SMC problem, but shifting out
> bits
> that didn't look proper messed up the host serial interface.  Maybe
> during
> all of the recent updates to the drivers people "optimized" things not
> knowing
> their effects.

Had a look in the driver and the rs_8xx_ioctl()
calls tty_wait_until_sent(tty, 0) for most things but
rs_8xx_set_termios() calls change_speed without a delay.
Is this the delays you are thinking about?

I am using agetty and I have just read that agetty tries to figure
out parity settings during login and sets the tty accordinly. So
maybe agetty gets confused and changes the parity? Would
that affect the Password line but not the previous line where the username
is entered?

Relevant line of my inittab is:
  con:2345:respawn:/sbin/getty -L console 115200 vt100

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

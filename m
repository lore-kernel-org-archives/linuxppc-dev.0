Date: 14 Nov 2001 03:00:45 -0000
Message-ID: <20011114030045.2376.qmail@mailweb9.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: IDE in Mode 1 (Sandpoint) how ?
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I forgot, is this an X2 or X3 (or X3b) version of the
> Sandpoint?
>
  Dan, This is an X2 board. I am able to
telnet to the machine and work cooly..But
serial is dead slow and the reason is as u said,
ISA interrupts.. They are not coming in.. Its
very clear. After a small investigation, I found
out that the serial chip times out on the
interrupt and "rs_timer" prints output in polled
mode. By changing the "Timeout value", I was
able to get faster output on the serial line.
  But the problem of ISA interrupts not being
routed is still there. This is very irritating.

Dan, I further noticed that "i8259_init" disables
all 8259 interrupts during initialization.
I thot this could be a reason and enabled all
8259 interrupts in a seperate loop. Even that
dint pay much except for a gush of ISA interrupts
immediately after enabling.

But what I am wondering is "How ISA interrupts
tick" for mvista kernel, when all 8259 interrupts
are disabled !! Am i missing sthg ?

Thanks,
Sincerely
Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

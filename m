Content-Type: text/plain;
  charset="iso-8859-1"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: Jerry Van Baren <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected.
Date: Wed, 10 Jul 2002 21:53:19 -0400
References: <8D7C5F56B409554D9D46AC22195807F3156BEB@exchwenz01.smtp.dmcwave.co.nz> <5.1.0.14.2.20020710070749.0223f9a0@falcon.si.com>
In-Reply-To: <5.1.0.14.2.20020710070749.0223f9a0@falcon.si.com>
MIME-Version: 1.0
Message-Id: <200207102153.19746.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This too is an excellent response! Thanks Jerry!

Here are some thoughts on the issue:

- The problem is may be because of hardware signals/flow control
  (RTS/CTS and/or DSR/DTR).  Perhaps, null modem cross
  connections may be made on the board itself for the console port.

- However, many boards have more than one serial port. In which
  case it is not possible to know at hardware design time which
  port is going to be used at a later time as console, and which for
  general purpose access. For those port(s) not used as a console,
  the hardware flow control may be important.

Given this paradigm, the flow control needs ignored or used by
software depending on whether the port is to be used as a console.
The default implementation/behavior, I believe, is also done properly
in this context - just the console case needs to be specialized.


If the above is a common case for other boards too, a common
solution may also be discussed/investigated. This was my thought
in the starting post for looking at a clean/proper solution. Again,
I think, the problem is common to ppcboot and Linux.


Jerry has also some good points, I intend to check some of
these tomorrow. Will keep the list posted with my findings.

Best regards,
-Arun.

On Wednesday 10 July 2002 07:41 am, Jerry Van Baren wrote:
> Disclaimer: This is all generic speculation (not based on knowledge of the
> board, just based on cruel experience :-)...
>
> Your description sounds a lot like flow control, either hardware or
> software, is happening.  It could also be an unhandled (or mishandled)
> error condition.  Addressing these possibilities...
>
> Hardware flow control was discounted because the hardware flow control
> lines are not run to the serial connector.  This still could cause
> problems, however, because the linux driver doesn't necessarily know that
> and quite likely still sets up the UART for hardware flow control.  If the
> flow control line (CTS*) is unterminated or used for some other purpose, it
> could be going low inadvertently, causing the hardware flow control to stop
> the UART.  Check your port initialization and what is connected to the CTS*
> line.  You want the port to be initialized so that the CTS* line is always
> high or you want to configure (or modify) the serial driver to disable
> hardware flow control.  Since your problem description explicitly stated
> that it occurred with both the SCC (has CTS*) and the SMC (no CTS*) this
> doesn't seem likely.
>
> A quick perusal of the UM indicates software flow control (XON/XOFF)
> requires software handling, so that doesn't appear to apply.  However, this
> fits your problem description fairly well.  One complaint was that an
> _unterminated_ serial connector causes problems, but plugging it into a
> terminal works.  The explanation here is that an unterminated (or
> terminated too weakly) RxData line will tend to flop around.  This will
> cause spurious characters to be received and, if ever an XOFF character is
> received (synthesized :-), the output will freeze just as you
> described.  Note that transmitting more characters will cause more spurious
> characters to be received, increasing the probability of an inadvertent
> XOFF, which also matches the problem description.  Of course, once an XOFF
> is received, the TxData stops generating noise on the RxData line and you
> never get the XON synthesized :-(.
>
> This theory also applies to an unhandled error condition: the same thing
> happens, but lots of bad characters are synthesized causing error
> interrupts.  If an error condition is unhandled or mishandled, the also Tx
> could wedge just like you described.
>
> Solutions in this case are:
> 1) Add or increase the termination to prevent the RxData line from flopping
> around when nothing is plugged in.  This is the best, but hardest, fix.
>
> 2) Unplug the serial cable: if you have a serial cable plugged into the
> board but unterminated at the far end, you just put a noise antenna onto
> your RxData line.  I've had equipment that was OK when nothing was plugged
> into the serial port, but locked up when a 6' serial cable was plugged in,
> even though there was nothing plugged into the far side.
>
> 3) Configure (or modify) the serial driver to disable software flow control
> in the driver.
>
> 4) If it is an unhandled or mishandled error condition, fix the driver.
>
> gvb
>
> At 07:45 PM 7/9/2002 -0400, Arun Dharankar wrote:
> >Thanks for your reply, Richard!
> >
> >This is definitely not so in my case, there is very little output
> >generated. Also have the serial port speed set at 115200,  I
> >dont believe this is buffer overrun issue.
> >
> >Anyway, I could work around the problem by checking for
> >the previous buffer's state and drop the characters. Would be
> >nice to get to the root cause.
> >
> >Best regards,
> >-Arun.
> >
> >On Tuesday 09 July 2002 06:08 pm, Richard Williams wrote:
> > > I've had a board hang in the same place before. Can't remember exactly
> > > the circumstances but it was triggered by me turning on a lot of debug
> > > messages in kernel modules.
> > >
> > > Perhaps buffer overrun on the console port?
> > >
> > > Regards,
> > > Richard
> > >
> > > -----Original Message-----
> > > From: Arun Dharankar [mailto:ADharankar@ATTBI.Com]
> > > Sent: Wednesday, 10 July 2002 12:08 a.m.
> > > To: Wolfgang Denk
> > > Cc: linuxppc-embedded@lists.linuxppc.org
> > > Subject: Re: Serial console ports on systems with no console connected.
> > >
> > >
> > >
> > > Hello, and thanks for your reply!
> > >
> > > The board has SCC4 and SMC1 based serial ports. I have
> > > tried both of these as console ports under Linux and PPCBOOT.
> > > PPCBOOT code is unmodified (as it is from the distribution) for
> > > SCC4 and SMC1 code. The Linux code is unmodified for
> > > SMC1, and I see this behavior in case of both these serial
> > > ports.
> > >
> > > The place where the BDI shows the PC to hang is in
> > > serial_putc(...) waiting for the transmit buffer to be drained by the
> > > 8260:
> > >
> > >     /* Wait for last character to go.
> > >     */
> > >     while (tbdf->cbd_sc & BD_SC_READY)
> > >         ;
> > >
> > > Ofcourse, when the cable is present, things work well.
> > >
> > > Though I dont see any code path, or from hardware perspective
> > > what could be wrong, I am open to any guesses/hints at
> > > debugging it.
> > >
> > >
> > > Best regards,
> > > -Arun.
> > >
> > > On Tuesday 09 July 2002 01:14 am, Wolfgang Denk wrote:
> > > > In message <200207082127.16518.ADharankar@ATTBI.Com> you wrote:
> > > > > This question is common to both ppcboot and ppc-linux.
> > > > > The ppcboot I am using is 1.1.5 and Linux kernel 2.4.18.
> > > > >
> > > > > If there is no console connected to the serial console port,
> > > > > is it true that a thread sending output to it hangs? If this is
> > > >
> > > > No, this is NOT true.
> > > >
> > > > Why should it? There is no flow control used - neither in the PPCBoot
> > > > nor in the Linux UART drivers...
> > > >
> > > > > I have a MPC8260ADS based board, and see the above
> > > >
> > > > ...at least not in the standard MPC8xx and MPC8260 UART drivers.
> > > >
> > > > > behavior under ppcboot. Under Linux using a BDI debugger
> > > > > the thread sending output to the console hangs. Perhaps
> > > >
> > > > You must be doing something wrong.
> > > >
> > > > Wolfgang Denk
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

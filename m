Content-Type: text/plain;
  charset="iso-8859-1"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: Richard Williams <richard_williams@stratexnet.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected.
Date: Tue, 9 Jul 2002 19:45:19 -0400
References: <8D7C5F56B409554D9D46AC22195807F3156BEB@exchwenz01.smtp.dmcwave.co.nz>
In-Reply-To: <8D7C5F56B409554D9D46AC22195807F3156BEB@exchwenz01.smtp.dmcwave.co.nz>
MIME-Version: 1.0
Message-Id: <200207091945.19620.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your reply, Richard!

This is definitely not so in my case, there is very little output
generated. Also have the serial port speed set at 115200,  I
dont believe this is buffer overrun issue.

Anyway, I could work around the problem by checking for
the previous buffer's state and drop the characters. Would be
nice to get to the root cause.

Best regards,
-Arun.


On Tuesday 09 July 2002 06:08 pm, Richard Williams wrote:
> I've had a board hang in the same place before. Can't remember exactly the
> circumstances but it was triggered by me turning on a lot of debug messages
> in kernel modules.
>
> Perhaps buffer overrun on the console port?
>
> Regards,
> Richard
>
> -----Original Message-----
> From: Arun Dharankar [mailto:ADharankar@ATTBI.Com]
> Sent: Wednesday, 10 July 2002 12:08 a.m.
> To: Wolfgang Denk
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Serial console ports on systems with no console connected.
>
>
>
> Hello, and thanks for your reply!
>
> The board has SCC4 and SMC1 based serial ports. I have
> tried both of these as console ports under Linux and PPCBOOT.
> PPCBOOT code is unmodified (as it is from the distribution) for
> SCC4 and SMC1 code. The Linux code is unmodified for
> SMC1, and I see this behavior in case of both these serial
> ports.
>
> The place where the BDI shows the PC to hang is in
> serial_putc(...) waiting for the transmit buffer to be drained by the
> 8260:
>
>     /* Wait for last character to go.
>     */
>     while (tbdf->cbd_sc & BD_SC_READY)
>         ;
>
> Ofcourse, when the cable is present, things work well.
>
> Though I dont see any code path, or from hardware perspective
> what could be wrong, I am open to any guesses/hints at
> debugging it.
>
>
> Best regards,
> -Arun.
>
> On Tuesday 09 July 2002 01:14 am, Wolfgang Denk wrote:
> > In message <200207082127.16518.ADharankar@ATTBI.Com> you wrote:
> > > This question is common to both ppcboot and ppc-linux.
> > > The ppcboot I am using is 1.1.5 and Linux kernel 2.4.18.
> > >
> > > If there is no console connected to the serial console port,
> > > is it true that a thread sending output to it hangs? If this is
> >
> > No, this is NOT true.
> >
> > Why should it? There is no flow control used - neither in the PPCBoot
> > nor in the Linux UART drivers...
> >
> > > I have a MPC8260ADS based board, and see the above
> >
> > ...at least not in the standard MPC8xx and MPC8260 UART drivers.
> >
> > > behavior under ppcboot. Under Linux using a BDI debugger
> > > the thread sending output to the console hangs. Perhaps
> >
> > You must be doing something wrong.
> >
> > Wolfgang Denk
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 18 Nov 2003 00:08:43 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Miku Jha <jha_miku@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc440 and i2c
Message-ID: <20031118080843.GA28129@gate.ebshome.net>
References: <20031118071829.43116.qmail@web40301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031118071829.43116.qmail@web40301.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 11:18:29PM -0800, Miku Jha wrote:
>
> I am running ppc440 with linux kernel version 2.4
>
> If I reboot the ppc440 in middle of a read transaction
> from a slave say( at the 3rd clock pulse for example)
> then somehow ppc440 is hung.
>
> Basically when it comes up it sees that data line
> held low.
> How does the powerpc deal with this situation.?
>
> From the i2c bus trace it looks like in this
> situation ppc440 keeps issuing the clock pulses
> until the data line SDL is released by the slave
> but following that the SCL line is held low
> by ppc440 and is never released or set to IDLE?
>
> Is this the expected behaviour if the SDL is held
> low when the ppc440 comes up.
> Is there anyway I can fix this in the ppcboot code.
>

Your problem sounds strange.

Are you saying that after 440GP _reset_ IIC line state affects 440 ?

This is _very_ unlikely. I doubt that 440GP even sample IIC lines (and
drive clock) until it's asked to do so by software.

Could you elaborate a little: what kernel are you using, what
bootloader (version)?

Maybe it's bootloader's driver problem, not 440 itself.

The other possibility is that you are using bootstrap IIC controller
(it shares lines with IIC0). Is this intended configuration? If not
you may want to check pull-down on UART0DCD_N line.

If bootstrap IIC is accidentaly activated you may get problems if you
have non-compliant/not-properly-reset device on IIC0 bus.

Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

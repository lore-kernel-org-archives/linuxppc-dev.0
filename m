Message-Id: <4.3.2.20010108112126.00b95f00@falcon.si.com>
Date: Mon, 08 Jan 2001 11:25:27 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: MV kernel on 405GP
In-Reply-To: <3A59E708.5E9375CD@GreenCurrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sounds like you have one or more pending interrupts that you are not
handling properly.  As soon as you enable external interrupts, you take
the vector, but don't clear the pending interrupt(s).  Since you don't
clear the interrupt, as soon as you leave the ISR, you get hit by
another interrupt.  Viola, instant loop.

Suggestions:
1) Check what interrupts are enabled and verify that they are handled
properly.
2) Mask any external interrupt you don't need right now.
3) If that doesn't work, mask all external interrupts and see if you
get further.
4) Re-enable the interrupts one at a time until you die again.
5) Repeat step #1 with the last interrupt you enabled :-).

gvb


At 06:12 PM 1/8/01 +0200, Juha Okkonen wrote:

>         I have a custom board that uses IBM 405GP -prosessor. I have
> already
>         modified ppcboot-0.5.3 for booting. And am trying to get
> Monta Vista's
>         linux-2.4.0-test2 kernel to run on it also. But there is some
> problem
>         with exceptions. When start_kernel(void)-function calls sti()
> to enable
>         external interrupts, the prosessor hangs totally. I don't get any
>register
>         dumps or anything else either. I have been able to verify
> with kgdb
>that
>         everything works until update of MSR-register.
>
>         If somebody has a version of the kernel modified for 405GP
> and ppcboot
>         both working, I would like to have the sources or at least
> ideas about
>         my problemn.
>
>                                                         'Okko
>
>
>--
>Juha
>Okkonen/CTO                                 Juha.Okkonen@GreenCurrent.com
>Green Current Oy                                Phone +358  9 2517 5525
>Tekniikantie 21 E 226                                         +358
>41  517 6542
>02150 Espoo
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

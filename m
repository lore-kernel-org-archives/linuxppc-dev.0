Message-ID: <3AB26CEA.E4111263@vienna.at>
Date: Fri, 16 Mar 2001 20:43:38 +0100
From: Roman Weissgaerber <weissg@vienna.at>
Reply-To: weissg@vienna.at
MIME-Version: 1.0
To: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	"linux-usb-devel@lists.sourceforge.net" <linux-usb-devel@lists.sourceforge.net>
Subject: Re:USB questions (for the MPC8xx)
References: <EADB10BAC266A14A85ECBF8686A73E3108AFCF@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kári Davíðsson wrote:
> Hi,
>
> In the m8xxhci.c hci driver for the mpc one can select to use TIMER1 for
> the SOF generator.
> A interruopt handler, m8xxhci_timer_interrupt() is registered to handle
> this interrupt and generate the SOF.
> Why is it then that the timer is also exported to PA6?
> Why is it the the USE_TIMER1_FOR_SOF is defined within the
> USE_UCODE_PATCH which is for external generated SOF-interrupt?
> Isn't the timer option exactly for the case where you do not have
> externally generated SOF-interrupt?
> If we can use a timer for generating the SOF why can't we just use a
> regular kernel timer instead, and therfore free one timer or baud rate
> generator?
>
The microcode patch needs an external 1kHz Signal on dreq input.
Timer 1 is one option to generate that external signal.
The interrupt handler is not needed anymore so my patch should have
changed a little bit more. The timer can run without interrupt handler
it just must generate the external 1kHz Signal.

- Roman

> Thanks,
>
> K.D.
>
> P.S. sorry for the x-post I am not shure if this belongs to the embedded
> list or the usb list.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <linuxppcleo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by ozlabs.org (Postfix) with ESMTP id 2D0C467B8A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Sep 2006 04:37:31 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so308210wxc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 07 Sep 2006 11:37:30 -0700 (PDT)
Message-ID: <a0bc9bf80609071137o254edcc1s7bfd905c489cb604@mail.gmail.com>
Date: Fri, 8 Sep 2006 02:37:30 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Subject: Re: MPC8360E USB Host Controller Driver
In-Reply-To: <450029E3.2030303@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D14C7B2@zch01exm20.fsl.freescale.net>
	<450029E3.2030303@cambridgebroadband.com>
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/7/06, Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> Li Yang-r58472 wrote:
> >> i have a MPC8347E running with the Freescale E(F)HCI driver
> >> and Kernel 2.6.17 (Freescale LTIB).
> >>
> >> Because of this mail, i checked, if there are any periodical
> >> interrupts, without real USB payload.
> >>
> >> The result is: NO
> >>
> >> If i attach a USB-mouse, i get 5 interrupts.
> >> If i remove it again, 1 additional.
> >>
> >> Nothing else, silence !
> >>
> >> USB works well with USB 1.1 and 2.0 devices (This was not the
> >> case with earlier Kernels, e.g. 2.6.13, because for the
> >> switching between 1.1 and 2.0 you need a transaction
> >> translator driver).
> >
> > MPC834x USB is very different from the USB of CPM/QE.  It is an
> > integrated EHCI controller.
> >
>
>
> So, the question is still open, does the QuiccEngine HCI (a.k.a. FHCI)
> generate loading on the PPC core when there is no traffic on the USB?

Yes, but no.  If the bus is idle for some time, you can put the bus
into suspend state.  Then there will be no extra load to the core.

- Leo

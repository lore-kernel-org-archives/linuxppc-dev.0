Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB874B7C65
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:47:48 +1100 (EST)
In-Reply-To: <4AF99B00.6080504@freescale.com>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
	<OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
	<20091109215321.GA4351@loki.buserror.net>
	<20091109230004.GA24671@loki.buserror.net>
	<OF0C254AE9.CCCFDCCC-ONC125766A.002D331C-C125766A.002E7C69@transmode.se>
	<4AF99695.800@freescale.com> <4AF99B00.6080504@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 10 Nov 2009 20:08:53 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 17:55:28:
>
> Scott Wood wrote:
> > Joakim Tjernlund wrote:
> >> Why does not pinning interact well with CPU15? If pinned, you never get
> >> a TLB miss for kernel text so that should mitigate the CPU15 problem.
> >
> > The nature of the workaround for CPU15 is that we can't keep it pinned
> > -- we have to take an ITLB miss on every page boundary crossing.  If you
> > try to pin, it'll just be invalidated by the workaround.
>
> Except that the invalidation only happens when you take an ITLB miss on
> an adjacent page, which means we'd likely never get CPU15 protection for
> kernel code if pinning is enabled. :-(

So tlbie invalidates pinned TLBs too?
It is likely that you won't get ITLB Misses for normal kernel
space but for modules you will. Also, since the pinned D&I TLBs overlap,
how do you make sure that invalidating a kernel DTLB won't
spill over to the pinned ITLB?

Does pinned TLBs work for you?
Rex, how does it look in your end?

 Jocke

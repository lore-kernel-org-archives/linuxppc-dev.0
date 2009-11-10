Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EC32B804B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 08:57:52 +1100 (EST)
In-Reply-To: <4AF9DCE0.4030805@freescale.com>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
	<OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
	<20091109215321.GA4351@loki.buserror.net>
	<20091109230004.GA24671@loki.buserror.net>
	<OF0C254AE9.CCCFDCCC-ONC125766A.002D331C-C125766A.002E7C69@transmode.se>
	<4AF99695.800@freescale.com> <4AF99B00.6080504@freescale.com>
	<OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
	<4AF9CC99.1030500@freescale.com>
	<OFDF13AF8E.1B38CEA9-ONC125766A.0073E59F-C125766A.0075ABE6@transmode.se>
	<4AF9DCE0.4030805@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 10 Nov 2009 22:47:26 +0100
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

Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 22:36:32:
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 21:27:05:
> >> Joakim Tjernlund wrote:
> >>> Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 17:55:28:
> >>>> Except that the invalidation only happens when you take an ITLB miss on
> >>>> an adjacent page, which means we'd likely never get CPU15 protection for
> >>>> kernel code if pinning is enabled. :-(
> >>> So tlbie invalidates pinned TLBs too?
> >> Yes.
> >
> > OK, and this is in no way unique for 8xx?
>
> Not sure about others, but 8xx manual explicitly says that it
> invalidates reserved entries.
>
> >> But who knows when CPU15 will strike...
> > yes, maybe there is a way around that. Perhaps by using one of the
> > pinned entries for loaded modules, i.e avoid ITLB misses for kernel space?
>
> Not sure what you mean...  loaded modules won't be pinned, and since
> they shouldn't contain rfi, don't need to be.

But CPU15 may invalidate a pinned TLB if you take a TLB Miss?
If not there should not be a problem, because the rest
of the kernel will never take a ITLB Miss.

>
> I don't see how to pin any part of the kernel without introducing some
> possibility of CPU15, unless we go scanning the last word of every
> instruction page, creating trampolines, and hoping there's no data
> embedded in the text segment. :-P

Yes, it is not going to be easy.
So aligning the srr0/srr1/rfi properly is needed.

BTW, you could probably cram the DARFix into the DTLBerror with some luck.
Especially if you allow it to spill over to the next trap. Then create a
branch insn at 0x1500 to 0x1600. Would that make everything aligned again?

  Jocke

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6668EB6F1E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 11:06:28 +1100 (EST)
In-Reply-To: <4AF9F56E.9080104@freescale.com>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
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
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
	<4AF9E2E2.7030100@freescale.com> <OF1F
	<4AF9F56E.9080104@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF2843D474.207958C1-ONC125766A.00828F87-C125766B.00009091@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 11 Nov 2009 01:06:10 +0100
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


Scott Wood <scottwood@freescale.com> wrote on 11/11/2009 00:21:18:
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 23:02:10:
> >> Joakim Tjernlund wrote:
> >> It wasn't the CPU15 workaround that I was worried about taking down the
> >> pinning -- but rather the CPU15 bug itself causing bad code to be
> >> executed inside the pinned kernel mapping.
> >
> > Oh, but then one is screwed anyway.
>
> Not if there's a workaround...
>
> >> However, the erratum says "MMU page", not "4K region", so I suppose if
> >> we have a pinned 8M page the problem could only occur at the end of the
> >> 8M (by which point the text segment should have ended).
> >
> > The wording makes me wonder why not a dcbi would fix the problem too.
> > Invalidate the problem cache lines and let the branch resolve.
>
> Where would you put the dcbi?  How do you regain control after that
> cache line has been refilled, but before code flows back to the bad branch?

The dcbi would replace the current CPU15 tlbie.

I would try mitigating bullet 3 (unresolved long enough ...) by
invalidating n+1 cache line. Hopefully that will abort the prefetch.

If that doesn't work, invalidate n+2(bullet 4) as it says it must be in cache for the problem
to manifest.

But I see now that I probably misread the errata so the above wont work.

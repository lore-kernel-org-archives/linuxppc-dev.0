Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC3CBB7BA4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 08:19:04 +1100 (EST)
In-Reply-To: <4AFC65F7.4050600@freescale.com>
References: <4AF99695.800@freescale.com> <4AF99B00.6080504@freescale.com>
	<OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
	<4AF9CC99.1030500@freescale.com>
	<OFDF13AF8E.1B38CEA9-ONC125766A.0073E59F-C125766A.0075ABE6@transmode.se>
	<4AF9DCE0.4030805@freescale.com>
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
	<4AF9E2E2.7030100@freescale.com> <4AF9F56E.9080104@freescale.com>
	<OF2843D474.207958C1-ONC125766A.00828F87-C125766B.00009091@transmode.se>
	<20091111152653.GA688@loki.buserror.net>
	<OFE47A9BB7.59140781-ONC125766C.00322B87-C125766C.003266AD@transmode.se>
	<4AFC65F7.4050600@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.com>
Date: Thu, 12 Nov 2009 22:14:30 +0100
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

Scott Wood <scottwood@freescale.com> wrote on 12/11/2009 20:45:59:
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 11/11/2009 16:26:53:
> >> On Wed, Nov 11, 2009 at 01:06:10AM +0100, Joakim Tjernlund wrote:
> >>> Scott Wood <scottwood@freescale.com> wrote on 11/11/2009 00:21:18:
> >>>> Where would you put the dcbi?  How do you regain control after that
> >>>> cache line has been refilled, but before code flows back to the bad branch?
> >>> The dcbi would replace the current CPU15 tlbie.
> >> But that only works if you take an ITLB miss at the right time.
> >
> > Yeah, I misread the CPU15 errata so my ideas will not work.
> >
> > Anyhow, will you send a patch that make TLB pinning mandatory?
> > After that my series can go in.
>
> One other concern with pinning on 8xx -- could it cause problems with
> uncached DMA mappings?  What happens if a speculative load pulls in a
> cache line in an area that's supposed to be uncached?

hmm, why should this be a problem? Pinning has been around as a config option
for a long time so any problems should have surfaced by now.

Secondly, I was thinking that we could just make the ITLB pinning
mandatory and let the DTLB pinning be as is, configurable.

 Jocke

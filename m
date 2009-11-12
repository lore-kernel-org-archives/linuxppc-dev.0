Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE6CFB7BB5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 08:57:51 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nACLvWVa027576
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 14:57:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nACM1M6g008591
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 16:01:22 -0600 (CST)
Message-ID: <4AFC84E7.6050706@freescale.com>
Date: Thu, 12 Nov 2009 15:57:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
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
	<OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
In-Reply-To: <OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 12/11/2009 20:45:59:
>> One other concern with pinning on 8xx -- could it cause problems with
>> uncached DMA mappings?  What happens if a speculative load pulls in a
>> cache line in an area that's supposed to be uncached?
> 
> hmm, why should this be a problem?

Because then you would be accessing potentially stale DMA data -- and 
more generally, the architecture prohibits such mixing.

> Pinning has been around as a config option
> for a long time so any problems should have surfaced by now.

It has existed as an option, which is going to get less test coverage 
than something that is always on.  Plus, it would not be a particularly 
common failure -- easy to blame one-off weirdness on something else.

> Secondly, I was thinking that we could just make the ITLB pinning
> mandatory and let the DTLB pinning be as is, configurable.

That could work.  We could also limit the pool of memory 
dma_alloc_coherent() uses to not overlap with anything pinned.

-Scott

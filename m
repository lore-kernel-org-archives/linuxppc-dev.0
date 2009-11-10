Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9963EB7C4B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:01:44 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAAM1eER027639
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 15:01:41 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAAM5QPX021764
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 16:05:27 -0600 (CST)
Message-ID: <4AF9E2E2.7030100@freescale.com>
Date: Tue, 10 Nov 2009 16:02:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
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
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
In-Reply-To: <OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
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
> Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 22:36:32:
>> Joakim Tjernlund wrote:
>>> yes, maybe there is a way around that. Perhaps by using one of the
>>> pinned entries for loaded modules, i.e avoid ITLB misses for kernel space?
>> Not sure what you mean...  loaded modules won't be pinned, and since
>> they shouldn't contain rfi, don't need to be.
> 
> But CPU15 may invalidate a pinned TLB if you take a TLB Miss?
> If not there should not be a problem, because the rest
> of the kernel will never take a ITLB Miss.

It wasn't the CPU15 workaround that I was worried about taking down the 
pinning -- but rather the CPU15 bug itself causing bad code to be 
executed inside the pinned kernel mapping.

However, the erratum says "MMU page", not "4K region", so I suppose if 
we have a pinned 8M page the problem could only occur at the end of the 
8M (by which point the text segment should have ended).

Unless we have any evidence that this is not what the erratum means, I'd 
say make pinning mandatory, and avoid placing modules immediately after 
a pinned entry.

> BTW, you could probably cram the DARFix into the DTLBerror with some luck.
> Especially if you allow it to spill over to the next trap. Then create a
> branch insn at 0x1500 to 0x1600. Would that make everything aligned again?

Yes, until some other code change breaks it again.

-Scott

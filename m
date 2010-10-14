Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCB10B70E2
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 03:02:49 +1100 (EST)
Received: from mail162-tx2 (localhost.localdomain [127.0.0.1])	by
	mail162-tx2-R.bigfish.com (Postfix) with ESMTP id C1837260567	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:02:45 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.246])	by
	mail162-tx2.bigfish.com (Postfix) with ESMTP id 4F806160056	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:02:45 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9EG32jx012814	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:03:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9EGIvjf019096	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 11:18:57 -0500 (CDT)
Date: Thu, 14 Oct 2010 11:02:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 1/3 v4] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Message-ID: <20101014110239.466072be@udp111988uds.am.freescale.net>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A2B0329@zch01exm23.fsl.freescale.net>
References: <20100920153718.GA4411@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A2B0329@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Oct 2010 23:43:38 -0700
"Zang Roy-R61911" <r61911@freescale.com> wrote:

> > Plus, I think the patch is not runtime bisectable (i.e. you
> > now do request_irq() here, but not removing it from the nand
> > driver, so nand will fail to probe).
> Nand driver does not need to request irq. It will use the irq requested by lbc.
> remember, other lbc device may also need to use this registered irq. 
> It should not be removed in nand driver.

The point is that you need to make both changes in the same patch.

-Scott

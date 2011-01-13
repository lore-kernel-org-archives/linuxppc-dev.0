Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8523BB70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2011 11:08:28 +1100 (EST)
Received: from mail106-va3 (localhost.localdomain [127.0.0.1])	by
	mail106-va3-R.bigfish.com (Postfix) with ESMTP id 2E9ED178834B	for
	<linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2011 00:08:24 +0000 (UTC)
Received: from VA3EHSMHS032.bigfish.com (unknown [10.7.14.242])	by
	mail106-va3.bigfish.com (Postfix) with ESMTP id F1C3110A8058	for
	<linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2011 00:08:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id p0D08Lpq024855	for <linuxppc-dev@ozlabs.org>;
	Wed, 12 Jan 2011 17:08:21 -0700 (MST)
Subject: Re: [PATCH] powerpc: fix warning when compiling immap_qe.h
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1287087330-11172-1-git-send-email-timur@freescale.com>
Date: Wed, 12 Jan 2011 18:08:21 -0600
Message-ID: <EE8341E6-3EE7-4923-89D5-4CC2298CB91D@freescale.com>
References: <1287087330-11172-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2010, at 3:15 PM, Timur Tabi wrote:

> Fix the warnings genereted by arch/powerpc/include/asm/immap_qe.h when
> CONFIG_PHYS_ADDR_T_64BIT is defined:
> 
> immap_qe.h: In function 'immrbar_virt_to_phys':
> immap_qe.h:472:8: warning: cast from pointer to integer of different size
> immap_qe.h:472:24: warning: cast from pointer to integer of different size
> immap_qe.h:473:5: warning: cast from pointer to integer of different size
> immap_qe.h:473:21: warning: cast from pointer to integer of different size
> immap_qe.h:474:36: warning: cast from pointer to integer of different size
> 
> Note that the QE does not support 36-bit physical addresses, so even when
> CONFIG_PHYS_ADDR_T_64BIT is defined, the QE MURAM must be located below the
> 4GB boundary.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/immap_qe.h |   21 +++++++++++++++------
> 1 files changed, 15 insertions(+), 6 deletions(-)

applied to next

- k

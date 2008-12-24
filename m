Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8717DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 04:04:20 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBOH2KZ3030592
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 10:02:20 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBOH4EW7210168
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 10:04:14 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBOH4DkC001380
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 10:04:13 -0700
Date: Wed, 24 Dec 2008 12:03:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
Message-ID: <20081224170359.GA22129@zod.rchland.ibm.com>
References: <49406F61.2000004@emcraft.com>
	<1228960541-11407-1-git-send-email-yanok@emcraft.com>
	<20081217195607.GE3049@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081217195607.GE3049@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Vladimir Panfilov <pvr@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 02:56:07PM -0500, Josh Boyer wrote:
>On Thu, Dec 11, 2008 at 04:55:41AM +0300, Ilya Yanok wrote:
>>This patch adds support for page sizes bigger than 4K (16K/64K) on
>>PPC 44x.
>>PGDIR table is much smaller than page in case of 16K/64K pages (512
>>and 32 bytes resp.) so we allocate PGDIR with kzalloc() instead of
>>__get_free_pages().
>>PTE table covers rather big memory area in case of 16K/64K pages
>>(32MB and 512MB resp.) so we can easily put FIXMAP and PKMAP in
>>area covered by one PTE table.
>>
>>Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>>Signed-off-by: Vladimir Panfilov <pvr@emcraft.com>
>>Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>
>I tested this a bit today on a Bamboo board.  Overall, it functioned
>well enough to not crash :).  Note that I also included Hollis'
>memory size alignment patch which is required.
>
>The code looks pretty clean now.  I think if we're going to include
>this patch it should go in now.
>
>Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Ben, Paul,

What else is needed to get this patch included?

josh

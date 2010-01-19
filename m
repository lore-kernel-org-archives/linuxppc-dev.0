Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46385B7CFF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 06:15:20 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix oops during MSI driver probe on
	MPC85xxMDS boards
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100118155324.GA10014@oksana.dev.rtsoft.ru>
Date: Tue, 19 Jan 2010 13:15:15 -0600
Message-Id: <F52441BF-6A5F-4A59-97E3-A90203FB07D0@kernel.crashing.org>
References: <20091215225809.GA32140@oksana.dev.rtsoft.ru>
	<20100118155324.GA10014@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2010, at 9:53 AM, Anton Vorontsov wrote:

> On Wed, Dec 16, 2009 at 01:58:09AM +0300, Anton Vorontsov wrote:
>> MPC85xx chips report the wrong value in feature reporting register,
>> and that causes the following oops:
>> 
>> Unable to handle kernel paging request for data at address 0x00000c00
>> Faulting instruction address: 0xc0019294
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> MPC8569 MDS
>> Modules linked in:
>> [...]
>> NIP [c0019294] mpic_set_irq_type+0x2f0/0x368
>> LR [c0019124] mpic_set_irq_type+0x180/0x368
>> Call Trace:
>> [ef851d60] [c0019124] mpic_set_irq_type+0x180/0x368 (unreliable)
>> [ef851d90] [c007958c] __irq_set_trigger+0x44/0xd4
>> [ef851db0] [c007b550] set_irq_type+0x40/0x7c
>> [ef851dc0] [c0004a60] irq_create_of_mapping+0xb4/0x114
>> [ef851df0] [c0004af0] irq_of_parse_and_map+0x30/0x40
>> [ef851e20] [c0405678] fsl_of_msi_probe+0x1a0/0x328
>> [ef851e60] [c02e6438] of_platform_device_probe+0x5c/0x84
>> [...]
>> 
>> This is because mpic_alloc() assigns wrong values to
>> mpic->isu_{size,shift,mask}, and things eventually break when
>> _mpic_irq_read() is trying to use them.
>> 
>> This patch fixes the issue by enabling MPIC_BROKEN_FRR_NIRQS quirk.
>> 
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
> 
> Kumar,
> 
> Did you miss this patch or it's just in a queue for review?
> 
> Thanks!

I just missed it will pick it up in a merge request to benh/linus.

- k

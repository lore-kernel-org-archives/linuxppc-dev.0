Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67C21DE160
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:26:25 +1100 (EST)
Message-Id: <163A79D0-237C-4513-948A-6460AB497ACC@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <0A1FE637C2C7E148B9573BB60CC630E5041F58@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use in c
	file
Date: Mon, 5 Jan 2009 10:26:02 -0600
References: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
	<0A1FE637C2C7E148B9573BB60CC630E5041F58@zch01exm26.fsl.freescale.net>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	hollisb@us.ibm.com, kvm-ppc@vger.kernel.org,
	Piepho Trent-B16872 <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'll pick this up, but wondering about this patch vs Trent's changes  
to remove this.

How is KVM on fsl-booke using this value?

- k

On Jan 4, 2009, at 12:57 AM, Liu Yu wrote:

> Hi Kumar,
>
> Can I get your ack?
> So that I can submit this patch through KVM tree.
>
>
>> -----Original Message-----
>> From: Liu Yu-B13201
>> Sent: Friday, December 19, 2008 10:35 AM
>> To: kvm-ppc@vger.kernel.org; linuxppc-dev@ozlabs.org
>> Cc: hollisb@us.ibm.com; Gala Kumar-B11780; Piepho
>> Trent-B16872; Wood Scott-B07421; Liu Yu-B13201
>> Subject: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index
>> for use in c file
>>
>> KVM on E500 platform currently utilize TLB1 entries without
>> bothering host,
>> that is using unused TLB1 entries.
>>
>> So, KVM needs to read tlbcam_index to know exactly
>> which TLB1 entry is unused by host.
>>
>> Signed-off-by: Liu Yu <yu.liu@freescale.com>
>> ---
>> [v2]
>> Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG
>> in KVM instead.
>>
>> arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h
>> b/arch/powerpc/include/asm/mmu-fsl-booke.h
>> index 925d93c..c86af6c 100644
>> --- a/arch/powerpc/include/asm/mmu-fsl-booke.h
>> +++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
>> @@ -73,6 +73,8 @@
>>
>> #ifndef __ASSEMBLY__
>>
>> +extern unsigned int tlbcam_index;
>> +
>> typedef struct {
>> 	unsigned long id;
>> 	unsigned long vdso_base;
>> -- 
>> 1.5.4
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

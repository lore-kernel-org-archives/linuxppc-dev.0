Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1A362C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:44:09 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Mar 2013 23:37:34 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3AA2B2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:44:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2DDVLC08585530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:31:21 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2DDi5oX014812
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:44:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 2/3] powerpc: Update kernel VSID range
In-Reply-To: <20130313034254.GC21125@iris.ozlabs.ibm.com>
References: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363090131-14545-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130313034254.GC21125@iris.ozlabs.ibm.com>
Date: Wed, 13 Mar 2013 19:14:02 +0530
Message-ID: <874ngfct3x.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

>>  BEGIN_FTR_SECTION
>>  	b	slb_finish_load
>>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>> @@ -91,24 +97,19 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>>  	_GLOBAL(slb_miss_kernel_load_io)
>>  	li	r11,0
>>  6:
>> -	li	r9,0x1
>>  	/*
>> -	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
>> -	 * the necessary adjustment
>> +	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
>>  	 */
>> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>> +	rldicl	r9,r3,4,62
>> +	addis	r9,r9,8
>> +	subi	r9,r9,4
>
> If you did the context calculation earlier, before the "bne cr7,1f",
> you could save 3 more instructions.

We use r9 later as region id in 

#ifdef CONFIG_SPARSEMEM_VMEMMAP
	/* Check virtual memmap region. To be patches at kernel boot */
	cmpldi	cr0,r9,0xf
	bne	1f

hence i didn't do the above suggested change.

-aneesh

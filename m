Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292AEC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:15:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBE8206DD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr8BLuPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBE8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zp223Z08zDqRM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:15:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gr8BLuPO"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zp0M5xgpzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:13:39 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y3so1457672pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=a4FTPbVSmwCsilTNXkknNMI5yYR7eNQpJANgyIZo6Mg=;
 b=gr8BLuPOdqEdI3JVYE5Eo9X8rlvmeGEBunODHtvHrYmryLAsTpz/xuP5/4Ug/vjjI+
 d4a3aPF7sKits+PddbDaFHuCPEb0+AaCmMqQKa4dSLGFbNZRHCygGKY/e+zws7W3AwXC
 j1b8qp8DfLKkD81G4gAWNLDpT0IYj5L//VCHQgKvIBrlINI0+SHXd83O0w3iC/lgFXF7
 PWaRYussofc39FH7gCfeLN706Dy4EE9dIxYYVY2zhh0RsOkgRRUqREsm1iVc6HcHj9Sm
 5JGN7xBWsWJ0sdwcK+bzwNCLOP36za//01k2toWyjZ9UdlrBhmumrr9RmFEQsNDJhXId
 3MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=a4FTPbVSmwCsilTNXkknNMI5yYR7eNQpJANgyIZo6Mg=;
 b=bMKKi75N9bdnvip8ai4xE2CV+kXQZJ7OHBEpb7XuKDWZ85IQSIE6F4cF+bqE6ISHWn
 VHvnV0f+0BFYj3XmMUUPiLiaJgxxroDEsIPODLJUMUUg4QuU49m5OvspIsZwyIuJM8xB
 xii8ZkIUOyrJ6f2+z4nvdNcQuIJDh0IX0x/+DoM4FHf1JhQvtaWW5iUGAzB1b6Hkk0Ic
 WOEnbSLA3Ak1zGoXS0quVi67/GLD7fx0b5Ue7iAqeHDYgiXSq9nH699RZRdvTxRSVHL4
 9kzsYOaio4v1FP1vwwCKkydRPgHGL7cK1OHiSl0xqxGSP+NhClOhBMacU27v0J2YoAxJ
 xxww==
X-Gm-Message-State: APjAAAUePg5FXgiX62R3Eo8mc6dWwgov6gjyf7viD9gfzJXepYlelZKE
 rztn1NO/D3ajvKZrVAb3sgI=
X-Google-Smtp-Source: APXvYqySdMKrUzyO8+bV4DCRKJlB6EVYNKl8oGO4En/8FIA9+Evu82Fwj6kf5Syh5w8BAXQAZpW6Yg==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr6745664pgh.199.1554394416366; 
 Thu, 04 Apr 2019 09:13:36 -0700 (PDT)
Received: from localhost (193-116-89-42.tpgi.com.au. [193.116.89.42])
 by smtp.gmail.com with ESMTPSA id l26sm30578686pfb.20.2019.04.04.09.13.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Apr 2019 09:13:35 -0700 (PDT)
Date: Fri, 05 Apr 2019 02:13:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org, 
 Christophe Leroy <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
 paulus@samba.org
References: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
 <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
In-Reply-To: <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554393943.3joom3btwy.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy's on April 3, 2019 4:31 am:
>=20
>=20
> Le 02/04/2019 =C3=A0 16:34, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>> Currently, our mm_context_t on book3s64 include all hash specific
>> context details like slice mask, subpage protection details. We
>> can skip allocating those on radix. This will help us to save
>> 8K per mm_context with radix translation.
>>=20
>> With the patch applied we have
>>=20
>> sizeof(mm_context_t)  =3D 136
>> sizeof(struct hash_mm_context)  =3D 8288
>>=20
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> NOTE:
>>=20
>> If we want to do this, I am still trying to figure out how best we can d=
o this
>> without all the #ifdef and other overhead for 8xx book3e
>>=20
>>=20
>>   arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>>   arch/powerpc/include/asm/book3s/64/mmu.h      | 48 +++++++++++--------
>>   arch/powerpc/include/asm/book3s/64/slice.h    |  6 +--
>>   arch/powerpc/kernel/paca.c                    |  9 ++--
>>   arch/powerpc/kernel/setup-common.c            |  7 ++-
>>   arch/powerpc/mm/hash_utils_64.c               | 10 ++--
>>   arch/powerpc/mm/mmu_context_book3s64.c        | 16 ++++++-
>>   arch/powerpc/mm/slb.c                         |  2 +-
>>   arch/powerpc/mm/slice.c                       | 48 +++++++++----------
>>   arch/powerpc/mm/subpage-prot.c                |  8 ++--
>>   10 files changed, 91 insertions(+), 65 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerp=
c/include/asm/book3s/64/mmu-hash.h
>> index a28a28079edb..d801be977623 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -657,7 +657,7 @@ extern void slb_set_size(u16 size);
>>  =20
>>   /* 4 bits per slice and we have one slice per 1TB */
>>   #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
>> -#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
>> +#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.hash_context->slb_addr_lim=
it >> 41)
>>  =20
>>   #ifndef __ASSEMBLY__
>>  =20
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/inc=
lude/asm/book3s/64/mmu.h
>> index a809bdd77322..07e76e304a3b 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -114,6 +114,33 @@ struct slice_mask {
>>   	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
>>   };
>>  =20
>> +struct hash_mm_context {
>> +
>> +	u16 user_psize; /* page size index */
>=20
> Could we keep that in mm_context_t ?

Why do you want it there?


>> @@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(stru=
ct mm_struct *mm, int psize)
>>   {
>>   #ifdef CONFIG_PPC_64K_PAGES
>>   	if (psize =3D=3D MMU_PAGE_64K)
>> -		return &mm->context.mask_64k;
>> +		return &mm->context.hash_context->mask_64k;
>=20
> You should take the two patches below, that would help:
> https://patchwork.ozlabs.org/patch/1059056/
> https://patchwork.ozlabs.org/patch/1059058/

Above patches seem good I think. What I think Aneesh should have is
is a macro or inline that gives a pointer to the hash_mm_context from
an mm_context pointer.

Architectures which always want it should just put the hash struct
in their mm_context struct and that avoids the pointer overhead
completely.

Thanks,
Nick

=

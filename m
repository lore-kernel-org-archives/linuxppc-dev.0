Return-Path: <linuxppc-dev+bounces-19212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E178D39410
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 10:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmdzG585rz2yfS;
	Thu, 02 Apr 2026 21:54:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775127290;
	cv=none; b=VQOeeT7nw3jW5FUBx1q9FLJNw+uLQ3yn4lvL/JQtwIomH0Kud0aPIYnDSEIO5Da2yEXEUs6kqVAfe4zRJbqeszZBz3VJvLm3jCcVHqujDib0DmFJ/Oo3jdT0m59WmL2iHH2CjeeV81SxK1uFQSstfJq3Bg3HKq1zCLsiY/jvlXLwLAzVB3n5Bvn4wdk31UjMTfdcbY6MDqi5HN8x/lR1uJK6FnpghiQrhRjcFYTtXdd0j2MH/dE5JRLObxbd9MUuOkBEMR1OfwPIVKhg5gi+tBTxddll/54Vbse7JpMfFQDc6hkHcecND6oo9zRu7q7SufnKWc5T5OEh17Ozk3PBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775127290; c=relaxed/relaxed;
	bh=0RVIWJ4ylqtORZ1L+Mwi1bTJovcNPY/rDERTjKhDyF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbQIA3V7puopvwD/lRaBLubdJuUmRH06HKL3p0TgnAcbpPp4XSJDu7oSy9+q6lIGYqljGdMWbRatF/cUmVKT55UJ2aR5264eXYp/8EY+vdD2gJr5NWkAWTtPA3+ovHJlAP7Rh7GqIxOIioXxa+bMWfmsOTx+0G/Z+qoSfOuRZT2xvffs4hHIvAOW2W1WFeU3aDk1TAsl/NsReCx7Z+FW0vKKzwyOI8rJIdlNgtRTWlGwqKJBEnM0mp9EGbManwcqemJizZltZ9FTaEXGaJ6jvZeyllkXArj1qGCikHvBBg7oVSH1IMRQs2gv5xY6it5/hyGpoDbfyEG3BFHCb0nU4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a/t6YWte; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a/t6YWte;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmdzF5Kv1z2ydq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 21:54:49 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M9oxR115373;
	Thu, 2 Apr 2026 10:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0RVIWJ
	4ylqtORZ1L+Mwi1bTJovcNPY/rDERTjKhDyF4=; b=a/t6YWtepXkgy3HnC1LPNl
	NR+Sa0T2m4F5OUreTADI9RhCPsGdkaq2wKrdARBIMfuSA4P3rIph73h5RWyUHcy0
	vYl6+ty77D+/tt99X7WPZDxLhObX+/xdhalR/HkVr2Y2FlQXpP9MXCCy6F4Xe/1t
	QiF3hzYQqahWCGn7Qjlm2QEhZbi4N8E2Fdn+H4BRg2qwa2cvFUdcL+JWnNTe6Nlf
	XVNv7IZjqcNrzu9yObzkou48pXnS8lfA6b5Cy/0MtNlQWh5RWesV3xnFTUTXDzDX
	OoyGhs/Hq0hNeXpVtXUV5h0JJQopD2GLU818VVJ8mI/3VIaPgFokCSoEYCp4QRUw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3ccfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:54:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6327koKJ008685;
	Thu, 2 Apr 2026 10:54:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11sfrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:54:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632AsKD952298136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:54:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C46B2004E;
	Thu,  2 Apr 2026 10:54:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789E220040;
	Thu,  2 Apr 2026 10:54:15 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 10:54:15 +0000 (GMT)
Message-ID: <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
Date: Thu, 2 Apr 2026 16:24:14 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
        Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Thomas Staudt <tstaudt@de.ibm.com>, Will Deacon <will@kernel.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Saravana Kannan <saravanak@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260225060347.718905-4-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1IJpf8nhQkcVXt5GniLlCr3XWgW66IQM
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ce4ae1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=b2T7Ds_qAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8 a=CgUfrdhd2qi-7wTTnboA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=thWvoDmNLqknv6kuXhLH:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: x_IWhrErDeETCiTEFlITfxiDIXysEuLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX4FDLit6NpI3L
 shC2rKHIH4E6HToakFkgZdHxWXdbkbPhbeADWr0jBlBnA5PNnlA7MfMtUl8VyQk5+vLGbLfZ82Z
 fMEhRxMXapCTYXQUzQw8z3uBrDVdmEOeYrDLjR3ZDkkAlgpJ/EpseC2rxJCCw4T4MALgUtFvSpi
 rkpL2TCWdgvkaOZUWdQABxYoXOvIirYnjQBDxcjrjT3bCxWtrdT4AgGSi0bpn1h32jQCkeRMNkO
 8ycQMVRnS4Kz8Nx8XDtY1QdhUQ9eO4RePsUBiNd0hVeH1x5UepoLHv/YZQPm40io7TiKUjOLBkf
 7rDk2GXzJhphRwRJzGScyjFo0rg+fHeriBkLeXUw7wpJ5L7G7PfND2ADZKSaaYZIW9U9MzXzKEg
 rhoSnAlIKyZOEE94DL3ZLYiXUkRjpIzLFxvXh6Osg/59lN6LpVl8yTLgny/Vnj/oQyvpbSxi+c0
 bkZ0+M4Dq/Uk/a8tQqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097



On 25/02/26 11:33, Coiby Xu wrote:
> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>   - Kdump kernel may not be able to decrypt the LUKS partition. For some
>     machines, a system administrator may not have a chance to enter the
>     password to decrypt the device in kdump initramfs after the 1st kernel
>     crashes
>
>   - LUKS2 by default use the memory-hard Argon2 key derivation function
>     which is quite memory-consuming compared to the limited memory reserved
>     for kdump.
>
> To also enable this feature for ARM64 and PowerPC, the missing piece is
> to let the kdump kernel know where to find the dm-crypt keys which are
> randomly stored in memory reserved for kdump. Introduce a new device
> tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
> memory address of the stored info of dm-crypt keys to the kdump kernel.
> Since this property is only needed by the kdump kernel, it won't be
> exposed to user space.
>
> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
> [2] https://github.com/devicetree-org/dt-schema/pull/181
>
> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Thomas Staudt <tstaudt@de.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>   arch/powerpc/kexec/elf_64.c            |  4 ++++
>   drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>   drivers/of/kexec.c                     | 19 +++++++++++++++++++
>   4 files changed, 48 insertions(+)
>
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index fba260ad87a9..e31fabed378a 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -134,6 +134,10 @@ int load_other_segments(struct kimage *image,
>   
>   		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>   			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +		ret = crash_load_dm_crypt_keys(image);
> +		if (ret)
> +			goto out_err;
>   	}
>   #endif
>   
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index 5d6d616404cf..ea50a072debf 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -79,6 +79,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   			goto out;
>   		}
>   
> +		ret = crash_load_dm_crypt_keys(image);
> +		if (ret)
> +			goto out;
> +
>   		/* Setup cmdline for kdump kernel case */
>   		modified_cmdline = setup_kdump_cmdline(image, cmdline,
>   						       cmdline_len);
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 331646d667b9..2967e4aff807 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   		 elfcorehdr_addr, elfcorehdr_size);
>   }
>   
> +static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
> +{
> +	const char *prop_name = "linux,dmcryptkeys";
> +	const __be32 *prop;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
> +		return;
> +
> +	pr_debug("Looking for dmcryptkeys property... ");
> +
> +	prop = of_get_flat_dt_prop(node, prop_name, NULL);
> +	if (!prop)
> +		return;
> +
> +	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +
> +	/* Property only accessible to crash dump kernel */
> +	fdt_delprop(initial_boot_params, node, prop_name);
> +}
> +
>   static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
>   /*
> @@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>   
>   	early_init_dt_check_for_initrd(node);
>   	early_init_dt_check_for_elfcorehdr(node);
> +	early_init_dt_check_for_dmcryptkeys(node);
>   
>   	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>   	if (rng_seed && l > 0) {
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index c4cf3552c018..fbd253f0d3c5 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -423,6 +423,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>   		if (ret)
>   			goto out;
>   
> +		if (image->dm_crypt_keys_addr != 0) {
> +			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> +						       "linux,dmcryptkeys",
> +						       image->dm_crypt_keys_addr,
> +						       image->dm_crypt_keys_sz);
> +
> +			if (ret)
> +				goto out;
> +
> +			/*
> +			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
> +			 * setting up memory reserve map.
> +			 */
> +			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
> +					      image->dm_crypt_keys_sz);
> +			if (ret)
> +				goto out;
> +		}
> +
>   #ifdef CONFIG_CRASH_DUMP
>   		/* add linux,usable-memory-range */
>   		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,

The above changes look good to me.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
double free at the address pointed by `keys_header`:

In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
     snip...

     kbuf.buffer = keys_header;

     snip....

     r = kexec_add_buffer(&kbuf);
     if (r) {
         pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
         kvfree((void *)kbuf.buffer);                           <--- 
First Free
         return r;
     }

Since `keys_header` is not reset, the next call to build_keys_header()
will cause a double free at `keys_header`.

static int build_keys_header(void)
{

     snip...

     if (keys_header != NULL)
         kvfree(keys_header);

     snip...
}

What do you think?

- Sourabh Jain



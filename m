Return-Path: <linuxppc-dev+bounces-19265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2EE7E35D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:40:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnDH05wJyz2yVP;
	Fri, 03 Apr 2026 20:40:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775209228;
	cv=none; b=D5fY0ZPdXq31nuKKOSgH60ijXwcX/x12AEqHdEKwM973EAzLxkvfU1SpyPIAjWSyLRw3Uowr9fDO9bfTCAAjcV1B40opMGhnaqRFwpgX453NvZmICHl89xCfu2nPrRhcYtGR6QpIQf9HjUjjP1hzxD9G9Xk7fXfcoPcAbJqJ7VC5BuOz9M228Gi+9/+FfUJy3IhytV7pe7BZ2p6JxO68u0aP7yM2iZGqh0SuEI0t+Nx3AflvoDRTG5zKAMuCw6F3gxdNbOGTnz+a3VA4unUJr3EGIKBz1QnfTQ/FR/Y3pHsD5GJsEdRlDsGJcJB5z8HGnKmYx563umIFSkmW9zhmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775209228; c=relaxed/relaxed;
	bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DSWlpZ8UOAiefnRm8VChYQMgpHhJkxPADe3TZqEVw4d6K7LnTcUtfSVKkMc826MHpjCts7qpQeDa2w3QnTHyTb4S1vcjqunvpHS4DXv7+ox9ZtfcWkQ/4XKi/wRMqqEllMy5tZ1H/RIR39jpEeOkDlVT3Jd4ay6zY93+tKk1szRtj+MmIgIA155MGjkq2qhZP7bmDi0/uXTqFkWEkYIUBvLHSKj5yoX/5MrORMwoXvz9yrgilFMXs4eMHHkE42CBGe0PdcL9CXwAKlLg3h+z/T78ExUJQekdelympIAwIQRNEtW3YKCJUxDOLljc+mkyJpNPrsc/bQxl3QOr7+4eTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0dIu9OR; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6L1PFzH; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0dIu9OR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6L1PFzH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnDGz0hQFz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 20:40:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
	b=A0dIu9ORhbggiYvPd1998w+q9RQACT2bSqZLVKkp0imw3McPSbMqfwrDseZtx5BqIsPdgR
	v5o7VQSerWFelVD0PlB/4W1WmlckUX310ZWZwQT4szzSpQjfDejkHgRuv+JajcD/LFhi8e
	7LB0cgVGyWKlGaQvQO+Wg35ebqrq+7Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
	b=T6L1PFzHDeJbluQl/JsBDaTEw+JrsOuFNZgB6df2XaAW5leZtcSysxnEwhy1svD06DMlGG
	WQ05urdOGyiPsV18ZufFwQTcOQcfr5ogrF8PQXK5afWXwQFF4EYmWA411ukFDOz0S0vKfR
	7RI0veKVKSseMMXnWzmGk6BuNXHod94=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-IaQRvIWEOOCValribvQ8lw-1; Fri, 03 Apr 2026 05:40:17 -0400
X-MC-Unique: IaQRvIWEOOCValribvQ8lw-1
X-Mimecast-MFC-AGG-ID: IaQRvIWEOOCValribvQ8lw_1775209217
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso4263960a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 02:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209217; x=1775814017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlIqRCpSkn+vkqIUF9eytfuVueKTfFVCaHifeJ7gRrQ=;
        b=sJK6Z9l7WO7M2r63kgPfxQTYHQ5WHfaOhH2sxOwJJ4Y6CeSDhueI+4/VPytvuTwWGB
         U2/XK4oInUd8HNCh8jf6TJ4svXb5OWK0XuSYghayY3AV2WSjwoqNmzGzN0PpZAFuAPII
         WJEjy6hzLRR4IrjUIKowDZwRHUAaOg5QowUAEoyYsmlHPI8bN3xyl5Jk2x3QLWjxD3RG
         SpAoh83nVdL+1RsOTCHh0cpjz3yXmPWeEn93od6qc8H4DXeH0la/VJaZE3fSXLDvR4vW
         QQMFf6CblNe2VrGQ2titbtWnqWnK6hHkP0Z6yXBRWIWRLCzlV+tKEcGwTcpPRXQdPnsm
         0wVA==
X-Forwarded-Encrypted: i=1; AJvYcCV/F6lPRk0cgJofhkXccZzhk9zooB7x6mbthBaMLGSu9INz7quD1p1JK7x2dSodONqdT5KUHqpTfSVWgaM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNqCs/Gb0nDfiEleYtjIUwIXaOOkztDg70tdfA0FC0X4Mx2bu/
	nzO9vvd/ArE8p1mvq1D3WwbAHlmDWwLwNBaKKpEE/TbA5/MbzQ6wEXKitfZsfQr+4KLB+5T63Wo
	wATcNE9+a6+akThj0MyA/kIkT3Kl+25nstNYiInKHwwQ4GVfd+IdysbMW1DNOOf8/JB0=
X-Gm-Gg: ATEYQzyHVaA8Q6PBho3CuQk2+rCN9ujyxLT0EYxivWp/eO7p14yegCigCdwS46sNx4s
	BaG+OzvqWT+wrBEg85PxZ/lS0rNQUuka0zHdPKQm9QGz55NpbX1ltQcETTKTVasx++nKNC55d+4
	2RjKnDaJGjFADJi80tw8a9PkDQkLICY8xnfvGI4f8pcHEQWn9P1TZIK0EMP69reTsA+N9PCLdad
	fjIaVYivd/PeEXq7h2FExeTuEI6G7xhMWKIJYwV2BoXoAsNkxww9tthlCZuOWWf/jAhCueq/41Z
	7v0tMPTQiEhnnCUJVz1nfRR3XLay2OjW6Yk3HkpPBoaC7OqNyEDPn5gMfa34m8Zm5GqYnurycVh
	pvAlO53NVH/Ja
X-Received: by 2002:a05:6a20:734b:b0:39b:c4cd:d854 with SMTP id adf61e73a8af0-39f2f072479mr2129497637.30.1775209216623;
        Fri, 03 Apr 2026 02:40:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:39b:c4cd:d854 with SMTP id adf61e73a8af0-39f2f072479mr2129461637.30.1775209215889;
        Fri, 03 Apr 2026 02:40:15 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm4419498a12.11.2026.04.03.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:40:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:36:38 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Rob Herring <robh@kernel.org>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Will Deacon <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <ac-HoiqxZma0M7Ko@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
 <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
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
In-Reply-To: <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HCJ1qumcGfge-GV7lFV_pvkjsS9NwiUuBs2knlP1Xmc_1775209217
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 02, 2026 at 04:24:14PM +0530, Sourabh Jain wrote:
>
>
>On 25/02/26 11:33, Coiby Xu wrote:
>>CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>>device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>>To also enable this feature for ARM64 and PowerPC, the missing piece is
>>to let the kdump kernel know where to find the dm-crypt keys which are
>>randomly stored in memory reserved for kdump. Introduce a new device
>>tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
>>memory address of the stored info of dm-crypt keys to the kdump kernel.
>>Since this property is only needed by the kdump kernel, it won't be
>>exposed to user space.
>>
>>[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>>[2] https://github.com/devicetree-org/dt-schema/pull/181
>>
>>Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>>Cc: Baoquan he <bhe@redhat.com>
>>Cc: Dave Young <dyoung@redhat.com>
>>Cc: Kairui Song <ryncsn@gmail.com>
>>Cc: Pingfan Liu <kernelfans@gmail.com>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>Cc: Rob Herring <robh@kernel.org>
>>Cc: Thomas Staudt <tstaudt@de.ibm.com>
>>Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Cc: Will Deacon <will@kernel.org>
>>Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>>  arch/powerpc/kexec/elf_64.c            |  4 ++++
>>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>>  4 files changed, 48 insertions(+)
>>
>>diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>index fba260ad87a9..e31fabed378a 100644
>>--- a/arch/arm64/kernel/machine_kexec_file.c
>>+++ b/arch/arm64/kernel/machine_kexec_file.c
>>@@ -134,6 +134,10 @@ int load_other_segments(struct kimage *image,
>>  		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>  			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>>+
>>+		ret = crash_load_dm_crypt_keys(image);
>>+		if (ret)
>>+			goto out_err;
>>  	}
>>  #endif
>>diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>>index 5d6d616404cf..ea50a072debf 100644
>>--- a/arch/powerpc/kexec/elf_64.c
>>+++ b/arch/powerpc/kexec/elf_64.c
>>@@ -79,6 +79,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  			goto out;
>>  		}
>>+		ret = crash_load_dm_crypt_keys(image);
>>+		if (ret)
>>+			goto out;
>>+
>>  		/* Setup cmdline for kdump kernel case */
>>  		modified_cmdline = setup_kdump_cmdline(image, cmdline,
>>  						       cmdline_len);
>>diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>index 331646d667b9..2967e4aff807 100644
>>--- a/drivers/of/fdt.c
>>+++ b/drivers/of/fdt.c
>>@@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>>  		 elfcorehdr_addr, elfcorehdr_size);
>>  }
>>+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
>>+{
>>+	const char *prop_name = "linux,dmcryptkeys";
>>+	const __be32 *prop;
>>+
>>+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
>>+		return;
>>+
>>+	pr_debug("Looking for dmcryptkeys property... ");
>>+
>>+	prop = of_get_flat_dt_prop(node, prop_name, NULL);
>>+	if (!prop)
>>+		return;
>>+
>>+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>+
>>+	/* Property only accessible to crash dump kernel */
>>+	fdt_delprop(initial_boot_params, node, prop_name);
>>+}
>>+
>>  static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>>  /*
>>@@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>  	early_init_dt_check_for_initrd(node);
>>  	early_init_dt_check_for_elfcorehdr(node);
>>+	early_init_dt_check_for_dmcryptkeys(node);
>>  	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>  	if (rng_seed && l > 0) {
>>diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>>index c4cf3552c018..fbd253f0d3c5 100644
>>--- a/drivers/of/kexec.c
>>+++ b/drivers/of/kexec.c
>>@@ -423,6 +423,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>>  		if (ret)
>>  			goto out;
>>+		if (image->dm_crypt_keys_addr != 0) {
>>+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
>>+						       "linux,dmcryptkeys",
>>+						       image->dm_crypt_keys_addr,
>>+						       image->dm_crypt_keys_sz);
>>+
>>+			if (ret)
>>+				goto out;
>>+
>>+			/*
>>+			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
>>+			 * setting up memory reserve map.
>>+			 */
>>+			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
>>+					      image->dm_crypt_keys_sz);
>>+			if (ret)
>>+				goto out;
>>+		}
>>+
>>  #ifdef CONFIG_CRASH_DUMP
>>  		/* add linux,usable-memory-range */
>>  		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
>
>The above changes look good to me.
>
>Feel free to add:
>Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for reviewing the patch!

>
>But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
>double free at the address pointed by `keys_header`:
>
>In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>    snip...
>
>    kbuf.buffer = keys_header;
>
>    snip....
>
>    r = kexec_add_buffer(&kbuf);
>    if (r) {
>        pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>        kvfree((void *)kbuf.buffer);                           <--- 
>First Free
>        return r;
>    }
>
>Since `keys_header` is not reset, the next call to build_keys_header()
>will cause a double free at `keys_header`.
>
>static int build_keys_header(void)
>{
>
>    snip...
>
>    if (keys_header != NULL)
>        kvfree(keys_header);
>
>    snip...
>}
>
>What do you think?
>
>- Sourabh Jain

Good catch! I'll send a patch to address this issue. Thanks!

-- 
Best regards,
Coiby



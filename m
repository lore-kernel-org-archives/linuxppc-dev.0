Return-Path: <linuxppc-dev+bounces-16800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66006EB5976
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 08:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9s0k2P0gz2xlM;
	Wed, 11 Feb 2026 19:24:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770798262;
	cv=none; b=MAKdZ4vpQatrx47llNB6Vg1A6HsUBI2jhqX5qN4qdKMsDvfsWlfkTRpdRUgXJJhfoVcVKB7+qvSPkTdrN4uk/i8KikkV+afS+7hQQQf9YNHiNP+fhitXxsQTqR1ze/2ZwdCUOSOKDwmjR+aNooFIUeqOhRKq/jOlZsHi+I3ylDZcYgBT8hqmm4M026l+zUVcAb96S1vR7UecnyicIYPHeDBlCkk5Uff8OWt3L4xyYNqy8np/r0Z4181Vb0hwg8paPPz3aAB3O9XPL3mXv/8Xue1XeVtbBUo8fsKUfE6PRYS2blP39aKl2PpVBdoV936yn+Q50lT1gK6QVuTu0CNaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770798262; c=relaxed/relaxed;
	bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WlSr15q5OpK0n1jTEc9zkruA9EMz5VIiEiAPI+7kdxUUjM1v0ebV3lTWF/IgJKwlSexo1YzHYbx7XLBMUJmixDE1E5E2D5piwUZbbX2sgTFPu7/wgDilr59u7HlXJqXOKeG/XHSd89pEbPYHO//SB3Lyxw5r0otoY67vI36SorQQrjlP86E1eP8KJLrSxS9M76vqVpP3BFrZ1LJkNXnB6uaWXrQwI5cZWXRNHK1yi+ks/tJbn/Njjseb02vu6azd9vCXpWEw5L9gicCmp4yeFkh2f/oAOxnNbkbbnB89wdncIMiDhzeyTxudq57xO0BxpxKPnIVMdhsa10K6OWvIbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mnwo53Ar; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mnwo53Ar; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mnwo53Ar;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mnwo53Ar;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9s0j0h2Bz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 19:24:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
	b=Mnwo53ArF/UDBoE3bsjVIWZz+MkFxTXWR2q+BQA2T82sr0Ny3bskFOQY+ErwPkflkQaW8Q
	1J1GsbgazhZx3ECRVb0WEJ0rxPb5N0nT9NzSi2fImclgwQEeS5MYcUJYOiUaCuktNy1zjF
	IrTcsbDKKA3fUToW3CVl2RhsvIQ+Nxs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
	b=Mnwo53ArF/UDBoE3bsjVIWZz+MkFxTXWR2q+BQA2T82sr0Ny3bskFOQY+ErwPkflkQaW8Q
	1J1GsbgazhZx3ECRVb0WEJ0rxPb5N0nT9NzSi2fImclgwQEeS5MYcUJYOiUaCuktNy1zjF
	IrTcsbDKKA3fUToW3CVl2RhsvIQ+Nxs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-2G3yac53OpiR8HKhcolVpA-1; Wed, 11 Feb 2026 03:24:15 -0500
X-MC-Unique: 2G3yac53OpiR8HKhcolVpA-1
X-Mimecast-MFC-AGG-ID: 2G3yac53OpiR8HKhcolVpA_1770798255
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82442b44d94so2828212b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 00:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798254; x=1771403054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jg6rUiFx+q06U0spbnVO76byiw3N0jzh2FjIOHbS9H8=;
        b=q4PCwDQrxGMCOPA7U/EK13bGZMa4SzvsUn92UNNGcXNkn3MpsMymQehYLgkY7eySYy
         IghGoEKSzoU20Qd8hj6kcjqJUUJ/GdR9IObxNqmxyGD5eO7YqoJAZdA/f32xREQYuLup
         78gIXTDQscYSsTi8sfw1ScYxAXVaT2aMyeOnddTjz240Ncfj/y0VrMVl6iu/wfReiY/b
         uEA9I76HjK2Oc46qgVXEXGm6mZ0fwHFgPqTfLICLAwAX5MSOV5ub/cnp//XkZktck1cM
         mJndzuNrk5lZZTrzDFUUmyqtCxY/n5uV97uIkuNrkpBADS55vuCOFk/UbMW36SGd4CA8
         FyQg==
X-Forwarded-Encrypted: i=1; AJvYcCWd5V2WHM0yVmd67Vuk04MacGDAhH8Jawgr7hQ/QomJFijafhjruEMk38EGSyDv5REHtYPssyJAyHY6CdM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxoAUHEbla3RzvZKvvx7PEg3p141Q8zpDWXjeXuPpSvRVz9KGZc
	x08TGSIkwzuxOewdplgHY5+phgbIOY8ve2eH0um9D31iOl9gSx9crxgLWwnGQmFDkH2UWUQ0Si3
	s4ifzDKcMVoqEo3MXYenJfFj+GHbJ9cKe9A6dodf6cKoOsJqG8PifZKD+L2ZsVehWYbM=
X-Gm-Gg: AZuq6aLx6LpVIWqQhbNpfRBB0fWkMHtD9oXtUTaBz1CBoLWmomzZlVZ9sDXJeLAOBZf
	yOQ3Cb22elpbHL4b3iLNq49CF0/OH4Ac2SIglZbfL2+++Zavtx6XIZO4kQCVlnz0Gs0EWoJzMER
	lMz0gXVOQa8xP76IFdDSLTlzr8Vnp4wjMGyya8C7rh+3Y0LtRqavci/Jgta3+tr9v5IsROIFtvb
	j5PDJcnAOMXnqgjChyHVw2U1f/YV3xGoIiYyxrEeFgmb80+DdM3CoR1KM4hmF1+8tPYYOA0j4eS
	6QviVQ3ShM2X19Ub8ZQrvv4l36xA18szJzD0lTOokiaNXz/yZjNVo/XACG3P58FR59DwzhECqlT
	Xlwt98oPg7W21
X-Received: by 2002:a05:6a00:4211:b0:81f:c6d1:d167 with SMTP id d2e1a72fcca58-8249fdf39edmr1252050b3a.61.1770798254460;
        Wed, 11 Feb 2026 00:24:14 -0800 (PST)
X-Received: by 2002:a05:6a00:4211:b0:81f:c6d1:d167 with SMTP id d2e1a72fcca58-8249fdf39edmr1252015b3a.61.1770798253951;
        Wed, 11 Feb 2026 00:24:13 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d7136sm1228850b3a.42.2026.02.11.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:24:13 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
Date: Wed, 11 Feb 2026 16:24:00 +0800
Message-ID: <20260211082401.2407853-3-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211082401.2407853-1-coxu@redhat.com>
References: <20260211082401.2407853-1-coxu@redhat.com>
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_CL2mUDM6Z1zJgsLAFQD5bqEFN4wp9C2iKi0B3_qzU_1770798255
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for ARM64 and PowerPC, we only need to add
a device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
the memory address of the stored info of dm-crypt keys to the kdump
kernel. Since this property is only needed by the kdump kernel, it won't
be exposed to user space.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://github.com/devicetree-org/dt-schema/pull/181

Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Thomas Staudt <tstaudt@de.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c |  4 ++++
 arch/powerpc/kexec/elf_64.c            |  4 ++++
 drivers/of/fdt.c                       | 21 +++++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 410060ebd86d..b6798bb2bb82 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -134,6 +134,10 @@ int load_other_segments(struct kimage *image,
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			goto out_err;
 	}
 #endif
 
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 5d6d616404cf..ea50a072debf 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -79,6 +79,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			goto out;
 		}
 
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			goto out;
+
 		/* Setup cmdline for kdump kernel case */
 		modified_cmdline = setup_kdump_cmdline(image, cmdline,
 						       cmdline_len);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..2967e4aff807 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
+{
+	const char *prop_name = "linux,dmcryptkeys";
+	const __be32 *prop;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
+		return;
+
+	pr_debug("Looking for dmcryptkeys property... ");
+
+	prop = of_get_flat_dt_prop(node, prop_name, NULL);
+	if (!prop)
+		return;
+
+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+
+	/* Property only accessible to crash dump kernel */
+	fdt_delprop(initial_boot_params, node, prop_name);
+}
+
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /*
@@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
+	early_init_dt_check_for_dmcryptkeys(node);
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 1ee2d31816ae..4bfb1ea5744e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -432,6 +432,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+		if (image->dm_crypt_keys_addr != 0) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+						       "linux,dmcryptkeys",
+						       image->dm_crypt_keys_addr,
+						       image->dm_crypt_keys_sz);
+
+			if (ret)
+				goto out;
+
+			/*
+			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
+			 * setting up memory reserve map.
+			 */
+			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
+					      image->dm_crypt_keys_sz);
+			if (ret)
+				goto out;
+		}
+
 #ifdef CONFIG_CRASH_DUMP
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-- 
2.53.0



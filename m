Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E50606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNV56Fltz2xb9;
	Wed, 04 Nov 2026 22:28:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793780123;
	cv=none; b=IPY831/AkuU4G0rTjRUdORtdcoBx4Xs0pCf2I3B3gFPZ2Vac5D5cj19YgAIhP4GdUdJ+uZobBPJnP9i3CNeer4atUsqE3Hz+YINUbUiBQM2HskXgMguqeu+jGTi7mr3jK83ZkB4anFwhYvvv/v5164wXiHtU4fAKSzO44KRUCvD9G1yrDZhQxxpjFhuMvkLcjwKAmhCd2f7glOrNdHHHqI/pLPQ3W3qRo/kDMITtbm9WrujD5haeYrclGJ8ydWMA2WMkCJGj86ktFBOO4VZOMTmA6WhHX3Rc5MOCyxjJ1YwVXeILPgiepFxFpq8qJZ67M5Fp+daHi5vBfB+1hzm36A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793780123; c=relaxed/relaxed;
	bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZJUOT2DiubKG85Bi56+75Y96nKXwLNobUj2ZPP2uhJ4ZAE37Lxph1B+/2bFTYp6jtJ5R8VNT8Rrptf3qvswdkubXYVE2YfUauNISB+dnF4JaQMFEIlWXGHQ5/1c/e5OpVwaLx5ckTH5XWm1HfaxkD4jNVEbOXQezockJXpFz9KuzyZgHRWwt6Epluh5ypd5n7xZrkqjUJX4QVeL8kzLAS0E3mA00i1uq8ryTJi6/nDif8n3yDwqbLteN8Vf+Wb5LauLVBLREmaeFMuKRRrO7OrfEp/WnhbGi1mS8kb+HoLBW8vP4vkt6Dj6BTZAdhEVcSzTyrXYp/tpHO975P/hsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpilaniy@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeHr3qQb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpilaniy@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 67 seconds by postgrey-1.37 at boromir; Wed, 04 Nov 2026 19:15:22 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKJCZ3qjtz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 19:15:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793780119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
	b=FeHr3qQbY4EnLnMo1WEZlo33XcTOv0p7CVy+YfM/+LztuOBrdGU7az0iNRe553L++nddC5
	SPVTC3LKL6oaSPKFl9PYZMFtPE1wC6ODiZOtq/uF9cTwBTvToXdza06c2nbkkkSVQTycqb
	+WhjQiUzyVxDJShwBzTv9atEHwzgqFw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793780119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
	b=FeHr3qQbY4EnLnMo1WEZlo33XcTOv0p7CVy+YfM/+LztuOBrdGU7az0iNRe553L++nddC5
	SPVTC3LKL6oaSPKFl9PYZMFtPE1wC6ODiZOtq/uF9cTwBTvToXdza06c2nbkkkSVQTycqb
	+WhjQiUzyVxDJShwBzTv9atEHwzgqFw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793780119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
	b=FeHr3qQbY4EnLnMo1WEZlo33XcTOv0p7CVy+YfM/+LztuOBrdGU7az0iNRe553L++nddC5
	SPVTC3LKL6oaSPKFl9PYZMFtPE1wC6ODiZOtq/uF9cTwBTvToXdza06c2nbkkkSVQTycqb
	+WhjQiUzyVxDJShwBzTv9atEHwzgqFw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-HaZtBkeHNw6WyhqtqCME1A-1; Wed, 04 Nov 2026 03:14:07 -0500
X-MC-Unique: HaZtBkeHNw6WyhqtqCME1A-1
X-Mimecast-MFC-AGG-ID: HaZtBkeHNw6WyhqtqCME1A_1793780047
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05bfa6af5so545930b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 00:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780046; x=1794384846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qA3iBaIijakHB1QdN+Ns5adqey4iVefqmbVMKWtw4sQ=;
        b=FzxWBFVExt07KiUg7UqYbXvSlegKlaBXZQf2MhPCi6WPsfHMChf9hDf0Yis2XJx3p6
         iQ7IrS8KBHcyEGzVCwpYRVwMw14r6F0NZmdmAeUAzjt/11gOV3XpXgsg3+7qyxlKy+6R
         TXJl8EBEFtz5zPjSA9OOTsGEMoB5xwTKPwGAjWhnd46IKv5Eabvic/uAiWvA9N9fg4C5
         6K5dU2h7NbqHsPG6eWkHtWNf2Ws7b9rxVC2w02Mm2PSa5R8e1aR22BKR2r+EnMkXayUP
         gl8b5H/N4rsCtVDlm6VllCpv5O5G6yCDJu7wgKK7wl63wJYda9Y3CXkCPo857rt8add7
         bnog==
X-Forwarded-Encrypted: i=1; AKwUvBxSc2Ynhbyz342R8AV2oaSAlP4U6sOg9sS9hpFzUZXvGtsO5uygmkkcoIQdKxvDTqjb6H8jLY5Q9kSIsVw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/GMGAkwVbJOiasRiKykQf0B0UK+Nv8opvRaVyPmgTTo2HoMnfm
	84hKzh269aFBagNapmMUCJzYfDVSmiEh/L+wKhQv+dUEA8agVmvrNTfUFOfuI8OeUjdvuMTl3Ui
	i1vh7CouNl4GhK6Wc96jrOSUUdgsz75MI8yHGy8kDGjwZxLTWcIrCy9DYN30Zz1CB6Tg=
X-Gm-Gg: AYBFou11vB/3D5vhy2JBjGAE1O85tIpLPA9iIAZ8H06MO254Bw4KyjJv2xI44W1tCmG
	rcPbAWeBZV57et6o1R/ICUfqZ5eGUELu9ePMyjoJTmJCpffqPvKXT+O1zlCUhK7wUYgPJIYru59
	O20ruWgrSfIPAlZXiFMRSG/2TgrezV8lGEcKKMiadfeIg9EFKM3AxvIH0PwxMW3TbNJmM2QXlmS
	9HtpeERgKasC4NmaL++2RDk3qBHGZA9RtWixyDVb+J1u/froGx5bhaBRFFNJFict15wagG1pOMf
	5PXm5w403MOvzS1Fe2kO0gY/H63WMA7vszUI5OD4I/0qGSzQ5Ngpzpj+9NbpWEUMgQDBcYxYwnx
	qZHCmHfvgU5gohP+tWX00b9w43W0CpeUPhiznkkZyYKEMnnfeSa56Kx7S9za0TPBYrPPZwm92Mm
	zTUjmauIgwGqWYzIgrm/AoFZjwxTndR5JN2quxub9CI2g=
X-Received: by 2002:a05:6a00:a219:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8a9bffd58e4mr11887835b3a.56.1793780046360;
        Wed, 04 Nov 2026 00:14:06 -0800 (PST)
X-Received: by 2002:a05:6a00:a219:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8a9bffd58e4mr11887807b3a.56.1793780045818;
        Wed, 04 Nov 2026 00:14:05 -0800 (PST)
Received: from ?IPV6:2401:4900:1f28:63e0:edae:927e:c670:b679? ([2401:4900:1f28:63e0:edae:927e:c670:b679])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b56926csm585851b3a.38.2026.11.04.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:14:05 -0800 (PST)
Message-ID: <e2f4e63c-481c-4e25-bc77-e890fcfaad95@redhat.com>
Date: Wed, 4 Nov 2026 13:43:56 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/crash: Add only the onlined CPU's node to the
 crash FDT
To: Vishal Chourasia <vishalc@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, sshegde@linux.ibm.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 seanjc@google.com, samir@linux.ibm.com, sourabhjain@linux.ibm.com
References: <20261104053848.1381005-1-vishalc@linux.ibm.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261104053848.1381005-1-vishalc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iW3m5hV5P38hHwzf5vpPgFq45AJw_H7XXJOdOrwozow_1793780047
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Vishal,
On 04/11/26 11:08 am, Vishal Chourasia wrote:
> A CPU coming online never changes the nodes that are already in the FDT,
> so add only the node of that CPU. update_crash_fdt() looks up the device
> node of the onlined CPU and does nothing if the FDT already has a node of
> that name, which is the case when an offlined CPU comes back online. Only
> when the node is missing, the crash image is invalidated while the node is
> created with fdt_add_subnode() and its properties are copied from the live
> device node with fdt_setprop(). All of this is done directly in
> update_crash_fdt().
> 
> fdt_add_subnode() inserts the node as the first child of /cpus, which is
> the same position a node attached to the live device tree takes, so the
> FDT keeps the order of the live tree.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 65 +++++++++++++++++++++++++++++++-------
>  arch/x86/kernel/crash.c    |  2 +-
>  kernel/crash_core.c        | 11 +++++--
>  3 files changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 775895f31037..ca37006bddea 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -18,6 +18,7 @@
>  #include <linux/types.h>
>  #include <linux/libfdt.h>
>  #include <linux/memory.h>
> +#include <linux/of.h>
>  
>  #include <asm/processor.h>
>  #include <asm/machdep.h>
> @@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
>  }
>  
>  /**
> - * update_crash_fdt - updates the cpus node of the crash FDT.
> + * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
>   *
>   * @image: a pointer to kexec_crash_image
> + * @cpu: the CPU that was onlined
> + *
> + * The node is added as the first child of /cpus, the same position a node
> + * attached to the live device tree takes. Nothing is done if the FDT already
> + * has the node, for example when an offlined CPU comes back.
>   */
> -static void update_crash_fdt(struct kimage *image)
> +static void update_crash_fdt(struct kimage *image, unsigned int cpu)
>  {
> +	struct device_node *dn;
> +	struct property *pp;
>  	void *fdt;
> -	int fdt_index;
> +	int fdt_index, cpus_offset, node_offset;
> +
> +	dn = of_get_cpu_node(cpu, NULL);
> +	if (!dn) {
> +		pr_err("No device node found for CPU %u\n", cpu);
> +		return;
> +	}
>  
>  	fdt_index = get_fdt_index(image);
>  	if (fdt_index < 0) {
>  		pr_err("Unable to locate FDT segment.\n");
> -		return;
> +		goto put;
>  	}
>  
>  	fdt = __va((void *)image->segment[fdt_index].mem);
>  
> -	/* Temporarily invalidate the crash image while it is replaced */
> +	cpus_offset = fdt_path_offset(fdt, "/cpus");
> +	if (cpus_offset < 0) {
> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
> +		       fdt_strerror(cpus_offset));
> +		goto put;
> +	}
> +
> +	/* Node already present, e.g. an offlined CPU came back online */
> +	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0)
> +		goto put;
> +
> +	/* Temporarily invalidate the crash image while it is updated */
>  	xchg(&kexec_crash_image, NULL);
>  
> -	/* update FDT to reflect changes in CPU resources */
> -	if (update_cpus_node(fdt))
> -		pr_err("Failed to update crash FDT");
> +	node_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
> +	if (node_offset < 0) {
> +		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
> +		       fdt_strerror(node_offset));
> +		goto out;
> +	}
>  
> +	for_each_property_of_node(dn, pp) {
> +		int ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
> +
> +		if (ret < 0) {
> +			pr_err("Unable to add %s property: %s\n", pp->name,
> +			       fdt_strerror(ret));
> +			break;
> +		}
If a property copy fails the loop just breaks and the image is
re-validated leaving a partially populated CPU node in the FDT. The
next hotplug event then sees the node as already present and never
repairs it so either drop or roll back the node on failure instead.

> +	}
> +out:
>  	/* The crash image is now valid once again */
>  	xchg(&kexec_crash_image, image);
> +put:
> +	of_node_put(dn);
>  }
>  
>  int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
> @@ -625,10 +665,11 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>   * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
>   *				     necessary kexec segments based on the hotplug event.
>   * @image: a pointer to kexec_crash_image
> - * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
> + * @arg: struct memory_notify handler for memory hotplug case and pointer to the
> + *	 cpu number for CPU hotplug case.
>   *
>   * Update the kdump image based on the type of hotplug event, represented by image->hp_action.
> - * CPU add: Update the FDT segment to include the newly added CPU.
> + * CPU add: Add the node of the newly added CPU to the FDT segment, if missing.
>   * CPU remove: No action is needed, with the assumption that it's okay to have offline CPUs
>   *	       part of the FDT.
>   * Memory add/remove: No action is taken as this is not yet supported.
> @@ -636,13 +677,15 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	struct memory_notify *mn;
> +	unsigned int cpu;
>  
>  	switch (image->hp_action) {
>  	case KEXEC_CRASH_HP_REMOVE_CPU:
>  		return;
>  
>  	case KEXEC_CRASH_HP_ADD_CPU:
> -		update_crash_fdt(image);
> +		cpu = *(unsigned int *)arg;
> +		update_crash_fdt(image, cpu);
>  		break;
>  
>  	case KEXEC_CRASH_HP_REMOVE_MEMORY:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e6f23933a6df..1660f26f3a44 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -441,7 +441,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>   * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>   * @image: a pointer to kexec_crash_image
>   * @arg: struct memory_notify handler for memory hotplug case and
> - *       NULL for CPU hotplug case.
> + *       pointer to the cpu number (unused here) for CPU hotplug case.
>   *
>   * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>   */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf899..53d4f2c1760c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -651,6 +651,9 @@ int crash_check_hotplug_support(void)
>   * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>   * excluded from SHA verification by default if the architecture
>   * supports crash hotplug.
> + *
> + * @arg is a struct memory_notify pointer for memory hotplug events and a
> + * pointer to the unsigned int cpu number for CPU hotplug events.
>   */
>  static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
> @@ -676,10 +679,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  		goto out;
>  
>  	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> -		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU) {
>  		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> -	else
> +		/* CPU events are raised with no argument, the CPU number is passed instead */
> +		WARN_ON(arg);
> +		arg = &cpu;
> +	} else {
>  		pr_debug("hp_action %u\n", hp_action);
> +	}
>  
>  	/*
>  	 * The elfcorehdr_index is set to -1 when the struct kimage

-- 
Regards,
Mukesh Pilaniya



Return-Path: <linuxppc-dev+bounces-28125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F683C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:17:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLB85KkJz2yPG;
	Fri, 25 Sep 2026 03:17:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790270256;
	cv=none; b=WNIod6EwBMzuJsHUTFw+c4rYs5qF5LY8YGo0LYijpa4aIJ0AzToo3OJ8Cl0sA3e8gyJmAVpuuq8Z4GljrMQgmlPzjh+Vv9MxIdo8Cd1SH461Vg9eS5S6JACwAPZvj7sAnHqASMxxCPvAeWTjGuidtvt4xQlqRIOUnmU9hHgJTX3e5YD8ge4uBow4rsTOqOlQuOEs/s24pRgzPC/S6sejI2kvys6EvdUKyZ8Sx5FaSwAnZ0v26FnuIYttmR+lRaH5nsGjSVJlcrixd4+6vdILVxeSUZW61GkKATtAHS8bsrrspU20HNknNJtcsqpzobwUQ0m8uvINQIb0LgOZBznWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790270256; c=relaxed/relaxed;
	bh=feTLx7y3sxZ57LB+c+M8YbdddVhljMzyHzPRAu6TpA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhZ1qo7Rt4gRchJk914QltjeTNg0u+P0VnvmN3+qdGtEnMBYrt2Xl1v75Npy4sxK7u1NlWZb3xKRqKwsP/a/5IM+2xlKNLMBAnwKOVj9JL7xo5u18aKlXEW2tv1E/hbccUyBGDoWK9n/2a2CjABiLwHlnpwXq4+DjWHA02K1DWu8dLhnKNqFYz5yYg2Lo/uPfEZ7UcZbzCGK1EOf3XFNUCcIvBCZeKt+wcs1Ay7L5/bAEoiw+JrOLB1RQTeVSv2zGCVfr8FgfGX7FTAYrb4CWSNPKFl4+TAAfNESzyqsT1vTGqv3BgpaxCX2ZW3/yXNrRt6Gbhnx4SyuYn/Qfu6gYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DCNd+p3D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DCNd+p3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com [IPv6:2607:f8b0:4864:34::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLB70GKBz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:17:34 +1000 (AEST)
Received: by mail-qk2-x11.google.com with SMTP id d75a77b69052e-52fb76bcb1fso765461cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790270251; x=1790875051; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=feTLx7y3sxZ57LB+c+M8YbdddVhljMzyHzPRAu6TpA4=;
        b=DCNd+p3D85W8YrH06bs9XvsWzBkmcfPkrelIM8y/pu/Ino8b9Lc2B1DfLRzq0AYiPU
         rSDlIhYJIdnjtKH/IqBsfxDot0Zg5VRZFkXk+rP/DilELmlzVwvkWRMfXKBFaExmao4C
         18nVWDn9qvSLydtS08U9hD5oKKJAgohdpo1wrlniFW26UsclebS96T7vAVVLGrF1LlCT
         38nNlCBTxRX6chuLfJKYtyFHcbezxjHa91GuueXMPXVEOgcEeGjwoSRZ4jkvuSwQPKhK
         lNC4FNdDZM0Fwi2ZVPS56+WiLkk6R2VsXJIy7QKF1EbwXUtJQBwhrU9milRQoSQ5f1MY
         0VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270251; x=1790875051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=feTLx7y3sxZ57LB+c+M8YbdddVhljMzyHzPRAu6TpA4=;
        b=TBYKniB5tlUJN7MK65pny0kOQXpiknxzwBsnC3mv64GlGLJWNADlE4RIqJ7f5pk4kc
         uaWfyKPixpObpgONy+MA8JTxfjt1chC9Wm7/8PjsJo/PgyiMNkigr/nV+Ao7HJuJxZmB
         4w/abzUwXaV0KRnRIxXy4cRupYheoCgILMrjSVaSvj0PPD4kn82U5IIi/OaFH9jS8Z4K
         J1qFgFFgkIuqlaB3GWMI4pAozMj+0vycHRnfjkKIku4snwuzKwYw6K8ydlMdVnly4FU7
         jvG0iWKWJu6Kbt4k4c7AcG9iIHdX4H/rK8L5az0D/iE2KOqEa1FG5qDh5EHXg7vb+lZH
         NenA==
X-Forwarded-Encrypted: i=1; AKwUvBxtklOGVl2iYKZsT1fZbzhYbNg6fLl5KLGrMWKCPaYNgRr9BzZzh+Hhh5NyUFcNciVj+RtgPh2rxG7GWgI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++myFpJZamDcHR8K8SkV+UUZR1Rrrde0J6IE/UlkvX2D8vTOlEC4
	Md6AQe0UdwEXlVgyLKKbFFDXrjCpmDWHTFVEi66lpQ/Lj3Y3VOMLHSEWumSS7tv9wi4toCvVme6
	zi20JdlM=
X-Gm-Gg: AYBFou29PvI84jknodjKg14FZ4Ck0jfFQm+N1RSvgdCxrI0mTnigXPgBjtKQ5zd300t
	ALHEoA/QoYwodC1XKVQ9ckJj4HImukoV7jcCqOk9htERuWIZvCYA+fhpPJWD/gYKciwYcd3zw+d
	5IoDpeq1xy3TABo+AmTBUpoKYuiheZPtbIWwCSk8GTMgGHDDb+TOBBu5fgHoIpbKyYJDKS/fCrV
	SW8ClJu+U4ODsu9bVgIfd3Y2lTS0NZoASoQVaDR0Imqf2W5BSkpXzdXLNRPK9JMcNPvZt9ya+BB
	G6wyH1cQsCWPNj3Dz32xE/0bUu51YAQvHDcs/UAytmwa2ub2eU2bw3xPPGIuH0iiPrvZzVsa+w9
	TOiX2UDukssUH7AD7OkBBsnibsNpHzqZ2j9zoNBjTVmDHlky3IeI86ytId2smeMM8cwrV8xT3Ok
	bwbcqwersSM1vjtYJJekZTLkCA3dv4615xKG+yHduMWzSSIW0PBCa6QNMmlICW+qamxidS1WuJt
	9upe55pdiLsWl2PQnlr0zg+88qurjJ1Q7+6QoEngIGKyeo303i+JyQ=
X-Received: by 2002:a05:622a:2b05:b0:530:42e4:f001 with SMTP id d75a77b69052e-532feb3025amr31555731cf.46.1790270250746;
        Thu, 24 Sep 2026 10:17:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532f8b7174asm25743881cf.14.2026.09.24.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:17:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:17:28 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 04/40] mm: consistently validate VMA state after
 mmap[_prepare] hooks
Message-ID: <arVW5i8pvySq6Co2@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:13PM +0100, Lorenzo Stoakes (ARM) wrote:
>  static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
>  {
...
> +	err = mmap_hook_validate(prev_start, prev_end, &prev_flags, vma);
> +	if (unlikely(err)) {
> +		vma->vm_start = prev_start;
> +		vma->vm_end = prev_end;
> +		vma_close(vma);
>  	}
> +
> +	return err;
>  }
>  

I indepdeantly validated the sashiko report on this chunk.  Seems like
close() should be deferred until after __map_new_file_vma() calls
unmap_region().

suggested fix is to drop vma_close() from mmap_file()  and update the
cleanup in __mmap_new_file_vma() 

if (error) {
	UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
		    map->prev, map->next);
	vma_iter_set(vmi, vma->vm_end);
	unmap_region(&unmap);

	/* Release driver state only after its mappings are gone. */
	vma_close(vma);

	if (map_same_file(map))
		fput(map->vm_file);
	vma->vm_file = NULL;

	return error;
}

Example race:

  Thread A                              Thread B

  mmap(MAP_FIXED, address A)
    driver remap_pfn_range(A, page P)
                                         load/store at known address A
                                         hardware finds the new present PTE
    validation fails
    ->close() frees page P
                                         UAF
    unmap_region()
    TLB shootdown

With that fix

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

~Gregory



Return-Path: <linuxppc-dev+bounces-23996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDBDC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxNCh1d34z2yS4;
	Fri, 10 Jul 2026 17:06:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783667168;
	cv=none; b=HGTLYuzNHJeR+hpLu4DX1dXMTWJ2f6zYcY0w6+YE6Q+4kjM+AC9JD+Xar95iNi9/qerluer+hjGWLCZvLf/qDu+xWnhQxk0bP0FMzVIXlOx4nhykD1hOUpN+hQX+SGB56kvFU7KbQYG69VPGD/2075qlw6wjW5KLh15PSBDMqBD+yH5RtbihPjULZAvPlwUTcLkhV98lEmuiqkkYTCWh+KSGPbQ5AO294VB0yYeO0F0RLy5EVRfRfZjRjQ+8VQdmia5DC19xaTGneCPgCi5AFmRWbNAU2a/psLhzcur2W9UlJzRKjWj8ZcN/sp28m14ykfdHmrn4zIga3gHEWKky8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783667168; c=relaxed/relaxed;
	bh=4bUcgckp4TyyQf6oi3rC9wiyM95zx1Fb72hB2fAsHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfZ19dUTeMS27zaOhNHjN4hdJhGdU7TUqyZH78tQQnFTYcMK6t/ttlHDtKLrMImEUaKFtQy8OoPs333S7NgAb7dRQxZmzUNMKoQ8l5y8i5IZJ7yenJ221dO6twpUoZsUv7kSVAlPO5Dg/UbNlyiqaWkazIy7aRqRTzzdmifGaKq/ytSvuQPWPoFxS5btKlLh7dVa2WkNELFHpaSOmwgri4zDK3fo+BijKoh+Hd5X+jruvCp/ypg1pXECo4nNWMCvHrWdqjKEBiMgwfdl1pUTEQBBO1WWvGOcdPz2XwHASOd7hM1tf4vQAfxNQ2AM7UMr2T7QiGfPyNtFf4iDJsQcaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EHOQq9Rf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EHOQq9Rf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxNCd2msbz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 17:06:04 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cca24023edso6909415ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783667161; x=1784271961; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4bUcgckp4TyyQf6oi3rC9wiyM95zx1Fb72hB2fAsHaE=;
        b=EHOQq9RfX92sa/g25KESnU39Ur377lmHsogttgbtIbidQ6caqTAH4fnQRhFd5R0ihH
         I2dRosSfh1IwFuYELBUwfb7gFJbOaMaqIdmNZcSg3nJxP8mb4Q95uLh23Ap5G60abzxh
         9sivHr8V69lkoCW+GE8k1fOAwXz/oG1V27jyhcdSHmF2jafjfKZMOC4Fpw5ScG6mTdFq
         JdC5AlS20nJqc/i55Y1lCu4vJqHGQZhORJVnh3VaSgxIFAr2pLsyLvBNEezt+0eInSFE
         RpV5O+cxoFF0mMif2pahfasi/GQsx/DVO6/cgOlp403h14DHDaxDv03Vi+L4CScH0r8U
         oqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667161; x=1784271961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bUcgckp4TyyQf6oi3rC9wiyM95zx1Fb72hB2fAsHaE=;
        b=kNr3hU8miQNSYcLtcLRjdRzvdNn1UIbZfhHCdxp6V24ikrhCAXr+kz8CXsIfsYnrxD
         qB/yrqoHdnHD7OTtdgzepUAtgzmJ4IZHda5iz1TZs9oDA9kkCbEW4nqHO1RdWsyp25LS
         FUR7I3cynH56iIKBUCHROZSYB5YKsnyFUZwvUWUOTy/AZmZNgNvneU2PJa6c6RGEibl3
         FLYAkrICv71n08UHIxecHMbFTTWWWoIPHErzj0PaRGDBaqe/bMR0fJ4A0Y9D4USe59H8
         jjAUkFMwibyAAZLqDvu/C8iV3OIaTr0KDVbHjANedqKkPvkmtLJfeVnawXLl+xddkO0v
         dK5A==
X-Gm-Message-State: AOJu0YxO+mwvW2D0cCPadPeOa9xIt+l3Qtci/1dU62Yzzbvlzol8vJWF
	BviPnrVyHP+uJ1jXuribIIJRIyurmVNLdk9ylQ2S7S9SHllbESgs5bQ7
X-Gm-Gg: AfdE7cnBnb2PM+IB45kkEn5uGV/zYUQWEuJPDIOwsRb89EZpDrpfZjzydK38SmEG/wO
	8umTfSMo+xrERfYa4YbzpIpFGbW0H59Hof0DUUMqh2SItsjCWJISZWjYs5qfaSXJWYo8hLs3Jwc
	8lJBua6wg6qVvrj+R1/0mHfRuc+bcA8Xw22HPEvwAxw5sKdWEHKmIpZgEEOrezu08yxS6FcPccN
	4U+xY+gGlgGwLCVdTXWeDES2saSFb8tt+ETpr8o8dl/XPonUdYiREx6awcSguQpO4hG4gJI/PDq
	EM8C9Lf7RizYKDAYt4gOKOsmDpEi9hEdNfq02M0RPFeqKWZLssUSAOjK6n9jIw4SfgNbgPo2f6m
	n/B39rFdYqf0quD87ZPmWi3v0yMMcLfCH0WGtjAmb+vGr1j0BUXUnSc7XWaZe5uoRswbnUUYjiY
	y8+fqaall11jTIYL+Sj4p/vJVRveQXXBbdHyNRy9UzXNygpx26sY5UB23SBpUG
X-Received: by 2002:a17:902:e950:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2ccea37e996mr104888635ad.3.1783667161138;
        Fri, 10 Jul 2026 00:06:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c1fdb5sm54838675ad.33.2026.07.10.00.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:06:00 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:35:56 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/kexec_file: print configured kernel command line
Message-ID: <alCZmAgklrVsN3Fr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20250725124438.327593-1-sourabhjain@linux.ibm.com>
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
In-Reply-To: <20250725124438.327593-1-sourabhjain@linux.ibm.com>

On Fri, Jul 25, 2025 at 06:14:38PM +0530, Sourabh Jain wrote:
> Kexec with the -d option prints extra logs about the kexec/kdump kernel
> that help debug kexec and kdump. For example, it shows what kexec
> segments are loaded, their locations, and sizes.
> 
> One key piece of information still missing is the kernel command line
> configured for the kexec/kdump kernel.
> 
> With this patch included, the kernel will print the kernel command line
> configured for the kexec/kdump kernel as shown below:
> 
> kexec --initrd=./initrd ./kernel -lspd --command-line="test1 test2"
> 
> Loaded elf core header at 0x22e30000, bufsz=0x2000 memsz=0x80000
> kexec_elf: Command line: elfcorehdr=0x22e30000 test1 test2   <--- New
> kexec_elf: Loaded initrd at 0x22eb0000
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/elf_64.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index 5d6d616404cf..db0af790c784 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -90,6 +90,8 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  		cmdline = modified_cmdline;
>  	}
>  
> +	kexec_dprintk("Command line: %s", cmdline ? cmdline : "");
> +
>  	if (initrd != NULL) {
>  		kbuf.buffer = initrd;
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
> -- 
> 2.50.1
> 
> 
Tested this on P11 LPAR.

[  485.755942] kexec_file: kernel: 00000000cb90aae7 kernel_size: 0x1d1531d0
[  485.762870] kexec_elf: Loaded the kernel at 0x80000000
[  485.762930] kexec_elf: Loaded purgatory at 0x9fff0000
[  485.762944] Loaded the backup region at 0x84160000
[  485.763088] crash_core: Crash PT_LOAD ELF header. phdr=00000000364832a7 vaddr=0xc000000000000000, paddr=0x0, sz=0x10000 e_phnum=178 p_offset=0x0
[  485.763095] crash_core: Crash PT_LOAD ELF header. phdr=000000009122d5f0 vaddr=0xc000000000010000, paddr=0x10000, sz=0x7fff0000 e_phnum=179 p_offset=0x10000
[  485.763099] crash_core: Crash PT_LOAD ELF header. phdr=000000007ead431b vaddr=0xc0000000a0000000, paddr=0xa0000000, sz=0xb10000000 e_phnum=180 p_offset=0xa0000000
[  485.763103] crash_core: Crash PT_LOAD ELF header. phdr=0000000001ee8e6f vaddr=0xc000000bb0000000, paddr=0xbb0000000, sz=0x5d0000000 e_phnum=181 p_offset=0xbb0000000
[  485.763108] crash_core: Crash PT_LOAD ELF header. phdr=000000004566b315 vaddr=0xc000001180000000, paddr=0x1180000000, sz=0x1d20000000 e_phnum=182 p_offset=0x1180000000
[  485.763112] crash_core: Crash PT_LOAD ELF header. phdr=00000000a9df7c03 vaddr=0xc000002ea0000000, paddr=0x2ea0000000, sz=0x1d10000000 e_phnum=183 p_offset=0x2ea0000000
[  485.763116] crash_core: Crash PT_LOAD ELF header. phdr=0000000077ee5d4c vaddr=0xc000004bb0000000, paddr=0x4bb0000000, sz=0x1d10000000 e_phnum=184 p_offset=0x4bb0000000
[  485.763119] crash_core: Crash PT_LOAD ELF header. phdr=000000000ea82932 vaddr=0xc0000068c0000000, paddr=0x68c0000000, sz=0x1740000000 e_phnum=185 p_offset=0x68c0000000
[  485.763124] Backup region offset updated to 0x84160000
[  485.763130] Loaded elf core header at 0x84170000, bufsz=0x3000 memsz=0x80000
[  485.763134] No dm-crypt keys
[  485.763139] kexec_elf: Command line: elfcorehdr=0x84170000 BOOT_IMAGE=(ieee1275//vdevice/v-scsi@30000065/disk@8100000000000000,gpt2)/vmlinuz-6.19.7-200.fc43.ppc64le root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root crashkernel=512M@2G test1 test2
[  485.763145] kexec_elf: Loaded initrd at 0x841f0000
[  485.763678] Memory node path: /memory@0
[  485.795492] kexec_elf: Loaded device tree at 0x9ffd0000
[  486.417820] kexec_file: nr_segments = 6
[  486.417839] kexec_file: segment[0]: buf=0x00000000ac04377b bufsz=0x3f74bc4 mem=0x80000000 memsz=0x4160000
[  486.424367] kexec_file: segment[1]: buf=0x00000000b22938ec bufsz=0x310 mem=0x9fff0000 memsz=0x10000
[  486.424403] kexec_file: segment[2]: buf=0x0000000043b34bd4 bufsz=0x10000 mem=0x84160000 memsz=0x10000
[  486.424417] kexec_file: segment[3]: buf=0x00000000421e955d bufsz=0x3000 mem=0x84170000 memsz=0x80000
[  486.424450] kexec_file: segment[4]: buf=0x000000009a7ce2c9 bufsz=0x4ed96f8 mem=0x841f0000 memsz=0x4ee0000
[  486.432514] kexec_file: segment[5]: buf=0x0000000023a3b280 bufsz=0x1553b mem=0x9ffd0000 memsz=0x20000
[  486.432558] kexec_file: kexec_file_load: type:1, start:0x9fff0000 head:0x4 flags:0xa


Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


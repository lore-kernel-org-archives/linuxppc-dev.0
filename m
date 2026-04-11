Return-Path: <linuxppc-dev+bounces-19646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9BF3ED46
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 10:40:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft9F005Knz2ypY;
	Sat, 11 Apr 2026 20:40:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::632" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775904051;
	cv=pass; b=aaPOJ9s2FurjbKe2Z4hKWVJyALyyDLpECD78QcgMHV6x6HHg5/VL3y7UUKnMA/run0lIpgWENQ8Z0T+SpJsa2ozLlLcNvHvLMjxQYTXpbm4djWOa2i4cHA1+cZ4C4/lgY1vfSy7W9yjStZNcR7Q5L0LuO78xPhZSztpcmEjaTAZqF6P9bamorOtq/4uM/aM15qbiZcJptr4DA08UHSGs7lDimOTPVuA3u+taMK5iUAdqhE74BQackqSgnq8iWKDHFFqVF2xtl+9en13AFgsZb/JYUVHdqeml+FQWZzsfR5BHkd+U48zopRQ+ZC3UlwAPe46Becl3kokYc7cgZCQYcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775904051; c=relaxed/relaxed;
	bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3rhRR1nV4YkZpZRajH4Navmkv3bv3tJ5X1SbMfXG3WXuDtL2RKKZBkGySBpouCCQjR0mXYhB2jy3MQrJhWEYfYjXeGXa/JEAqXBocpCLr8MUl3uFp2z0b8isXRAT0P0TLrI2MfaDNO5XNi4LnPyIVuTCRbANvq7t4B/I/R20/Q3/by6Gg9tIDExAutKnf8s3UsR9x78Qet8ztlljUC0IATvb4hHaZ7VPdceNMUXdt+ss9BPJK9S2l9m7S2ahidyaEtc1GTirEqASXh7oPdXkZbEuonRIrrAZ/kJGDanFiOJj4UVOzYKS/QAbs8qXFcq/saH+wO/vxfJbnIX1xo+tg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j6I3QOdS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j6I3QOdS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft9Dy0Gz7z2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 20:40:49 +1000 (AEST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so446675266b.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 03:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775904042; cv=none;
        d=google.com; s=arc-20240605;
        b=Hh7j/x7+CPZM7buqZt7JRlwdCkpC1ny80bGcohWR/BFc8N78SpZlPvOw8aGCXlgTN+
         +iRzAhQ2HBkdPJ3BPFpggoRsuAafESLwHKgEY384RYiH407rz6pnxCYRGB6hBs33IdLh
         Bjp7mfyAAWYFe1+AFRy6ZXDROvOzsxUVrgySFvmuJhcvyY3fnemAncOiGA9Wvkcx7/lZ
         iIaHJtmP4tdQAJX3gw77ZZwJLIRNzxaLY8fl0jO2vqd+xWYNTglE1lMV9bxlQPOJpl//
         GBw+9iirPtOUqgJivCQRYF1rFCQkbvg4cIIi5TOsfWCDtnyaYeV84CWnOTQnhfh/r/tI
         kMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        fh=Cuo20izZM3siqo9YR7dYzPBLD9kH0iYKjzMsfo/5Iac=;
        b=jW+5AoRGi3qC7hautC0bQ1Uz82+p8XKzz4rEZ5oTjUand/KwEv6WbRtii8g3R5Kj3C
         WpCroc+0HGn4NQZQ/bVCTEMf5E5CMrbmp6W87HWlixwFray4v3XMe5R6zhQzuz0zxckn
         fBxCiDie/+OyIJp34W2kCTMrRziiWwYVqCeE5U3cJvpEk6J3Z9yPQ2YDLSMOHy489U61
         htzmFKW5ivBBE03/99YLu8GS/njGCTV1/7v3eGUVMAXUmtgSJ1qQo/JWTxQ2pU2xUou8
         96qumKu18STSInwdz3j3qTG0b9uVSrJ+HCiDr+NaaWst2HIEIBHhI7bm6J++I3YhVWx4
         XQ3A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775904042; x=1776508842; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        b=j6I3QOdSLp6GhvV3B2bWyeCRvxH2+hhyVQYyzRgzrmJxt7OULtDDMil0izYiKTPNa0
         tPCGJQDa8HqkeULySvB26XJa9475pRlS83Bmd/ov+fVfCAI0vpMfnzqMVWJbUWRoYySw
         IWhwJpwZqdSDAuXqsyZYIxnkcYXYx0Sp8WytHx/A4sssXfgZLJr9D3bwSn12OFqNHtS2
         7OLkJsgQ1h4hkEXI8io3GxWTFguYy58QtJeR5W3NYh4M8vIoutsf191tSJkh5ofq2OpM
         OGcvuIAM+Hx1UTe3mvKiqYC97I+eDPwNm80hOASVV7I/1fCMyVShZLxv/0T2ckwa+JjJ
         jsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775904042; x=1776508842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        b=WONfAGeElWSgtE55qoD/I/XSbA40edqCeHawA/NJmOaghYDS0y2EDnS/GY6cwguMk9
         V3G5yv5EwaCTDXnwYuuKuUr0bWRMpH1mlkRV4DFllgfCQmqF2e+JH6l1vRtAOb5thYOS
         yDc8i+ZTPurEqqOW3xAEeCmhdiIuWSfOXYbFI/3+6CrY/xy1zgNUSgsBMsnH8Y/iNEFl
         7ejVP77kHtqt3f3zH63xuwGdYUWrTIj0rNTaApmlDAezBorzHBDUh5xonRv8hCdu5zX5
         NUnpx1VmGtWSNm2NUbG+QaW7VnWeh2E3yMvYVmai7BA4Jl/FRV4ZIbefApGHhiyvudUV
         gdZw==
X-Forwarded-Encrypted: i=1; AJvYcCU6tlGhfoGzZv0BuiUVia6/uH2C92MFTj8SSEDibAiBFfBdvv1KIZrfb5hX7W1IqRS+jBO66yAdO1ZHsmY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1wuvIaeCeHhWUmR69iXbxG31OpKmoS0eOcUOSUICBMuyRjPxi
	PTrckrYgPqFzawI1bFj0OriV3rTAnwus7oUrfdgklNhN0d3kUcwXNskbAK7A/oMCeXG0r3lM6wq
	1c+/+APR/poeQ6oxR7bwvN/Hp+SUrCdc=
X-Gm-Gg: AeBDietmJzni37UPYHfPcsR8Z1JVWPHCheQurS9FowikO+ejWxWwaE2o+8+VN3d82qN
	yiYMIU8Vi8SRPNXtgHzjLrTCqXV2hYN2IBoF9UAwCEMcq4kZ5RBUAcyDVUuhhF6C8uyAd2m9lXx
	O4p4ZyWYhytXxeBA76LaNIPbob0imq/lBpajEnNpa/e5Xv6tWONIVWMLo29kHWjmbObUH2rjbEu
	0BdJKL5pV6CRQauoahJXFmr7ADjkSiiw2nYrbHwWbT0fNTLbGbH3hocj5WZt1zxbWRc0MSajPhm
	06EwcItdvxiuwwKdnxQzVX37vfUfJEfUvQHQVyMS8YuHULVAkw==
X-Received: by 2002:a17:907:1b1b:b0:b9d:3c22:b2c8 with SMTP id
 a640c23a62f3a-b9d724f0c56mr414074566b.1.1775904041152; Sat, 11 Apr 2026
 03:40:41 -0700 (PDT)
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
References: <20260411080148.471335-1-kwilczynski@kernel.org>
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Apr 2026 12:40:29 +0200
X-Gm-Features: AQROBzBL0ISJ1oDzmS1WdKnfmR7mJ-8b5qly2wKGmSLW0OsznpAbrTTOYjF1FCI
Message-ID: <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] PCI: Convert all dynamic sysfs attributes to static
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:01=E2=80=AFAM Krzysztof Wilczy=C5=84ski
<kwilczynski@kernel.org> wrote:
>
> Hello,
>
> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
>
> Currently, the PCI resource files (resourceN, resourceN_wc) and the
> legacy bus files (legacy_io, legacy_mem) are created dynamically
> from two unsynchronised paths:
>
> Path A: late_initcall
>
>   pci_sysfs_init                        (late_initcall)
>     sysfs_initialized =3D 1
>     for_each_pci_dev
>       pci_create_sysfs_dev_files
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
>     pci_find_next_bus
>       pci_create_legacy_files
>         sysfs_create_bin_file           (legacy_io, legacy_mem)
>
> Path B: device registration / hotplug
>
>   pci_bus_add_devices
>     pci_bus_add_device
>       pci_create_sysfs_dev_files
>         if (!sysfs_initialized) return  <- only guard
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
>
> On most ACPI systems this does not race because PCI enumeration
> completes at subsys_initcall time, before pci_sysfs_init() runs:
>
>   subsys_initcall (level 4):
>     acpi_pci_root_add
>       pci_bus_add_device
>         pci_create_sysfs_dev_files
>           if (!sysfs_initialized)          <- not yet set
>             return -EACCES
>
>   late_initcall (level 7):
>     pci_sysfs_init
>       sysfs_initialized =3D 1
>       for_each_pci_dev
>         pci_create_sysfs_dev_files         <- creates the files, no race
>
> On Devicetree platforms the host controller is a platform driver that
> probes via the driver model, often on a workqueue, and overlaps with the
> late_initcall:
>
>   CPU 0 (late_initcall)                CPU 1 (driver probe)
>   ---------------------------          ----------------------------
>   pci_sysfs_init()
>     sysfs_initialized =3D 1
>     for_each_pci_dev(pdev)             pci_bus_add_device(pdev)
>       pci_create_sysfs_dev_files()       pci_create_sysfs_dev_files()
>         sysfs_create_bin_file()            sysfs_create_bin_file()
>                                              -> "duplicate filename"
>
> The same happens on ACPI when probing is asynchronous (hv_pci on
> Azure, RISC-V with ACPI).
>
> The duplicate causes sysfs_create_bin_file() to fail with -EEXIST.
> pci_create_resource_files() then calls pci_remove_resource_files() in
> its error unwind, tearing down files the other thread created and
> still references through pdev->res_attr[].  This has caused kernel
> panics on i.MX6 and boot failures on other platforms.
>
> Several different fixes have been proposed over the years: reordering
> the sysfs_initialized assignment, adding locks, checking
> pci_dev_is_added(), setting pdev->res_attr[] to NULL after kfree
> (which only prevents a double-free on the teardown path, not the
> error unwind removing the other thread's files).  None would address the
> root cause.
>
> This has been reported a few times:
>
>   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@byte=
dance.com/
>   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110=
e@h-partners.com/
>   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-s=
sengar@linux.microsoft.com/
>   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897=
B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
>   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
>   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
>   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pal=
i/
>   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-a=
rtem.savkov@gmail.com/
>   - https://bugzilla.kernel.org/show_bug.cgi?id=3D215515
>   - https://bugzilla.kernel.org/show_bug.cgi?id=3D216888
>
> With static attributes the driver model creates sysfs entries once per
> device at device_add() time, under the device lock, eliminating the
> late_initcall iteration and the race along with it.
>
>         Krzysztof
>
> ---
> Changes in v4:
>   https://lore.kernel.org/linux-pci/20260410055040.39233-1-kwilczynski@ke=
rnel.org/
>
>    - Added new Reviewed-by tags.
>    - Added pci_resource_is_io() and pci_resource_is_mem() helpers
>      for resource type checks, replacing the open-coded bitwise
>      flag tests in pci_mmap_resource(), pci_resource_io(), and
>      Alpha's pci_mmap_resource(), as per Ilpo J=C3=A4rvinen's
>      suggestion.
>    - Split the __pci_mmap_fits() cleanup into two patches.  An
>      overflow fix for zero-length BARs, which now includes a
>      Fixes: tag referencing the original Alpha PCI sysfs commit,
>      and the WARN macro removal is a separate cleanup as per Ilpo
>      J=C3=A4rvinen's suggestion.
>    - Added a missing Fixes: tag to the Alpha lockdown check,
>      referencing the commit that added the check to the generic
>      path but missed Alpha's implementation.
>    - Added PCI_LEGACY_IO_SIZE and PCI_LEGACY_MEM_SIZE macros to
>      replace the raw literals used for legacy address space sizes.
>      These are used in both Alpha's pci_mmap_legacy_page_range()
>      and the static legacy attribute definitions, as per Ilpo
>      J=C3=A4rvinen's suggestion.
>    - Replaced sysfs_update_groups() in the BAR resize path with
>      sysfs_remove_groups() before the resize and sysfs_create_groups()
>      after, restoring the original teardown before BAR resize
>      ordering.  This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D7
>    - Defined pci_dev_resource_attr_groups as a NULL macro when
>      HAVE_PCI_MMAP and ARCH_GENERIC_PCI_MMAP_RESOURCE are both
>      absent, so the resize path compiles unconditionally without
>      #ifdef guards in the function body.  This was reported by
>      Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D7
>    - Moved the pci_legacy_has_sparse() prototype into the patch
>      that introduces the function, alongside the existing
>      pci_adjust_legacy_attr() declaration, to fix a bisection
>      issue where Alpha would warn on -Wmissing-prototypes.
>      This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D18
>
> Changes in v3:
>   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com=
/
>
>   - Updated for modern kernel releases and expanded scope.  The
>     v2 only covered the generic resource files.  This version
>     also converts Alpha's sparse/dense resource files and the
>     legacy bus attributes, removing pci_sysfs_init() entirely.
>   - Split the single macro definition into three distinct ones
>     (per I/O, UC, and WC), to make sure that each carries only
>     the callbacks its resource type needs.
>   - Updated to use the new .bin_size callback, as the attributes
>     are const, to replace using a->size directly, which was not
>     ideal.  This required changes to pci_llseek_resource(), to
>     ensure that it would work for device and bus-level attributes.
>   - Updated the __resource_resize_store() to include CAP_SYS_ADMIN
>     capabilities check.
>   - Added the security_locked_down() check to Alpha's
>     pci_mmap_resource(), to align with other architectures.
>
> Changes in v2:
>   https://lore.kernel.org/linux-pci/20210825212255.878043-1-kw@linux.com/
>
>   - Refactored code so that the macros, helpers and internal
>     functions can be used to correctly leverage the read(),
>     write() and mmap() callbacks rather than to use the
>     .is_bin_visible() callback to set up sysfs objects
>     internals as this is not supported.
>   - Refactored some if-statements to check for a resource
>     flag first, and then call either arch_can_pci_mmap_io()
>     or arch_can_pci_mmap_wc(), plus store result of testing
>     for IORESOURCE_MEM and IORESOURCE_PREFETCH flags into
>     a boolean variable, as per Bjorn Helgaas' suggestion.
>   - Renamed pci_read_resource_io() and pci_write_resource_io()
>     callbacks so that these are not specifically tied to I/O
>     BARs read() and write() operations also as per Bjorn
>     Helgaas' suggestion.
>   - Updated style for code handling bitwise operations to
>     match the style that is preferred as per Bjorn Helgaas'
>     suggestion.
>   - Updated commit messages adding more details about the
>     implementation as requested by Bjorn Helgaas.
>
> Krzysztof Wilczy=C5=84ski (24):
>   PCI/sysfs: Use PCI resource accessor macros
>   PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
>   PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
>   PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is
>     zero
>   PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
>   PCI/sysfs: Add static PCI resource attribute macros
>   PCI/sysfs: Convert PCI resource files to static attributes
>   PCI/sysfs: Convert __resource_resize_store() to use static attributes
>   PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
>   PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
>   alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
>   alpha/PCI: Use BAR index in sysfs attr->private instead of resource
>     pointer
>   alpha/PCI: Use PCI resource accessor macros
>   alpha/PCI: Clean up pci_mmap_resource()
>   alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
>   alpha/PCI: Remove WARN from __pci_mmap_fits()
>   alpha/PCI: Add static PCI resource attribute macros
>   alpha/PCI: Convert resource files to static attributes
>   PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
>   PCI: Add macros for legacy I/O and memory address space sizes
>   alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
>   PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
>   PCI/sysfs: Convert legacy I/O and memory attributes to static
>     definitions
>   PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
>
>  arch/alpha/include/asm/pci.h   |  13 +-
>  arch/alpha/kernel/pci-sysfs.c  | 373 +++++++++++----------
>  arch/powerpc/include/asm/pci.h |   2 -
>  drivers/pci/bus.c              |   1 -
>  drivers/pci/pci-sysfs.c        | 575 +++++++++++++++++++--------------
>  drivers/pci/pci.h              |  16 +-
>  drivers/pci/probe.c            |   6 -
>  drivers/pci/remove.c           |   3 -
>  include/linux/pci.h            |  39 ++-
>  9 files changed, 578 insertions(+), 450 deletions(-)
>

Hi ,

Applied the series on an Alpha UP2000+, built and booted
successfully. PCI enumeration and device initialization looked
normal, I saw no relevant sysfs/PCI warnings in dmesg, and PCI
sysfs resource files for tested devices looked sane.

From the Alpha side, this looks good to me.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>


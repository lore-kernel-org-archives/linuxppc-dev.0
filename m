Return-Path: <linuxppc-dev+bounces-19566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C9CF44842
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:48:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZnv6cLHz2yZ6;
	Fri, 10 Apr 2026 21:48:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775821731;
	cv=none; b=d2rIRNKKvb6ffMXYxTVAMJdF5r7Fm2pUTkRrPjK14g67WEBWTJXDCsPLMXqiiycpMKY0Or43x3N8CcZMFHM9eBtUL5wUCMl91qhvVDVTEfp9fzn1YPyLEibFcgZESvjGm6+YyTdyVN3jVNoOlh3oe7pDaWWJ5Fzf2Cv1O4Bqfgl+Q6BEwFgPZLnuH2j5Aqb5UYVfPvef2K7GaH+PKGVUHXBaOX5fRR+kOeXDtqDMhXNOepZc1uO8ZGtHuXeeXYCC8LbVGWuzo9rQOIIbN6mG4A0vgDf/vunBQ7y7cLFgzOBvtcReZ3MVownyck6UuHWlKFDd5wXwDSyiBrJqit3MuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775821731; c=relaxed/relaxed;
	bh=yslpP4ruPzSzoFjAxDvMUygLvJxdYGuFousaUNGU2ug=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PTN4CCf+VT6BgRlgzdO6vzMzzlWpRq+uEHINUpMyZ5HRTylqY6F0nryHp02tjhE+HIq4SsIoxJTRH/ObVZ2o7y4+wskC+sMHq+SWqGmIy2PWTTJraGNY6/YceFIH63ieznEQqfUbomJxhOVUqZGwpUJi36bWxJVsrER5oU6XJqRDApUwsnK/Fm4VUp0bGWG2/OQtWYPIvhthswxDTSZQy6nJoHqHWJ/o8f/Kg91mhvy+M90/A8dHdmar4AAmlcs2u2NIATBUSyUsvznEY10ZK6yQWV10v0ZUE6dnP3C2m1MoMVuhNtVlFrlmkPVCpI7Y4NWSfqsm/j9gQOdwfsRafQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aU3MSRX8; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aU3MSRX8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 67 seconds by postgrey-1.37 at boromir; Fri, 10 Apr 2026 21:48:48 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZnr0GcNz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775821728; x=1807357728;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0pWx6KeF8UUq1KmtaLtAIvWwx3IczipWJf0r+7YAW4Q=;
  b=aU3MSRX8nTHjwSDkb3s1KXEDmqCTH8GCxv+rP3QBwttzZsdYElt2VbcQ
   SmvfAlLegEwFq/MsaCk23RbpjVKSN3n7vX+7k8HOSDgmdJc8zkx1pW41D
   CqSVwLzlvE+FZofaMpnONmkFdMdFVihSrd16zeVuZ+1qTctSlEg4sGh+e
   VOHoQqNan6Bt5kWKrXkGMqsn1z8i90Dtp7PGOECVWFXHrMcQAMV+zwmNK
   chLLc40Ydp18zEt5nkemI9y8PJhemOi64QFmdKqpn1XMlGCKpdngGdTN5
   BYQn2usKoFXjk2mObL/fVM3qDKcQeWLrS4F9sVCRkB1V7MwJILQDUcvYH
   w==;
X-CSE-ConnectionGUID: 21em1pIrQs+tRfOCd+4h2w==
X-CSE-MsgGUID: ksVAI6gdScm+kD/tyO3cow==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76912799"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76912799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:47:37 -0700
X-CSE-ConnectionGUID: WbZ76Js1RNy+Y+L6H9CAjw==
X-CSE-MsgGUID: fKqyVJQ2Q+SRhjuV+qc1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228943873"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:47:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:47:22 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/20] PCI/sysfs: Convert legacy I/O and memory attributes
 to static definitions
In-Reply-To: <20260410055040.39233-20-kwilczynski@kernel.org>
Message-ID: <13001ba0-35fb-f38d-5764-3c95fc3eb074@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-20-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1569654593-1775821642=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1569654593-1775821642=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, legacy_io and legacy_mem are dynamically allocated and
> created by pci_create_legacy_files(), with pci_adjust_legacy_attr()
> updating the attributes at runtime on Alpha to rename them and shift
> the size for sparse addressing.
>=20
> Convert to four static const attributes (legacy_io, legacy_io_sparse,
> legacy_mem, legacy_mem_sparse) with is_bin_visible() callbacks that
> use pci_legacy_has_sparse() to select the appropriate variant per bus.
> The sizes are compile-time constants and .size is set directly on
> each attribute.
>=20
> Register the groups in pcibus_groups[] under a HAVE_PCI_LEGACY guard
> so the driver model handles creation and removal automatically.
>=20
> Stub out pci_create_legacy_files() and pci_remove_legacy_files() as
> the dynamic creation is no longer needed.  Remove the __weak
> pci_adjust_legacy_attr(), Alpha's override, and its declaration from
> both Alpha and PowerPC asm/pci.h headers.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/include/asm/pci.h   |   4 +-
>  arch/alpha/kernel/pci-sysfs.c  |  24 ----
>  arch/powerpc/include/asm/pci.h |   2 -
>  drivers/pci/pci-sysfs.c        | 200 ++++++++++++++++++++-------------
>  4 files changed, 122 insertions(+), 108 deletions(-)
>=20
> diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
> index ef19295f2e33..ad5d1391e1fa 100644
> --- a/arch/alpha/include/asm/pci.h
> +++ b/arch/alpha/include/asm/pci.h
> @@ -84,8 +84,8 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t=
 port, u32 val,
>  extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
>  =09=09=09=09      struct vm_area_struct *vma,
>  =09=09=09=09      enum pci_mmap_state mmap_state);
> -extern void pci_adjust_legacy_attr(struct pci_bus *bus,
> -=09=09=09=09   enum pci_mmap_state mmap_type);
> +extern bool pci_legacy_has_sparse(struct pci_bus *bus,
> +=09=09=09=09  enum pci_mmap_state type);
>  #define HAVE_PCI_LEGACY=091
> =20
>  extern const struct attribute_group pci_dev_resource_attr_group;
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 2031a3b6972c..2db91169bf5a 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -197,30 +197,6 @@ bool pci_legacy_has_sparse(struct pci_bus *bus, enum=
 pci_mmap_state type)
>  =09return has_sparse(hose, type);
>  }
> =20
> -/**
> - * pci_adjust_legacy_attr - adjustment of legacy file attributes
> - * @bus: bus to create files under
> - * @mmap_type: I/O port or memory
> - *
> - * Adjust file name and size for sparse mappings.
> - */
> -void pci_adjust_legacy_attr(struct pci_bus *bus, enum pci_mmap_state mma=
p_type)
> -{
> -=09struct pci_controller *hose =3D bus->sysdata;
> -
> -=09if (!has_sparse(hose, mmap_type))
> -=09=09return;
> -
> -=09if (mmap_type =3D=3D pci_mmap_mem) {
> -=09=09bus->legacy_mem->attr.name =3D "legacy_mem_sparse";
> -=09=09bus->legacy_mem->size <<=3D 5;
> -=09} else {
> -=09=09bus->legacy_io->attr.name =3D "legacy_io_sparse";
> -=09=09bus->legacy_io->size <<=3D 5;
> -=09}
> -=09return;
> -}
> -
>  /* Legacy I/O bus read/write functions */
>  int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t s=
ize)
>  {
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pc=
i.h
> index 46a9c4491ed0..72f286e74786 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -82,8 +82,6 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t=
 port, u32 val,
>  extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
>  =09=09=09=09      struct vm_area_struct *vma,
>  =09=09=09=09      enum pci_mmap_state mmap_state);
> -extern void pci_adjust_legacy_attr(struct pci_bus *bus,
> -=09=09=09=09   enum pci_mmap_state mmap_type);
>  #define HAVE_PCI_LEGACY=091
> =20
>  extern void pcibios_claim_one_bus(struct pci_bus *b);
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fe079fb31dce..dc0bb0488317 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -702,11 +702,6 @@ static const struct attribute_group pcibus_group =3D=
 {
>  =09.attrs =3D pcibus_attrs,
>  };
> =20
> -const struct attribute_group *pcibus_groups[] =3D {
> -=09&pcibus_group,
> -=09NULL,
> -};
> -
>  static ssize_t boot_vga_show(struct device *dev, struct device_attribute=
 *attr,
>  =09=09=09     char *buf)
>  {
> @@ -1025,91 +1020,136 @@ bool __weak pci_legacy_has_sparse(struct pci_bus=
 *bus,
>  =09return false;
>  }
> =20
> -/**
> - * pci_adjust_legacy_attr - adjustment of legacy file attributes
> - * @b: bus to create files under
> - * @mmap_type: I/O port or memory
> - *
> - * Stub implementation. Can be overridden by arch if necessary.
> - */
> -void __weak pci_adjust_legacy_attr(struct pci_bus *b,
> -=09=09=09=09   enum pci_mmap_state mmap_type)
> +static inline umode_t __pci_legacy_is_visible(struct kobject *kobj,
> +=09=09=09=09=09      const struct bin_attribute *a,
> +=09=09=09=09=09      enum pci_mmap_state type,
> +=09=09=09=09=09      bool sparse)
>  {
> +=09struct pci_bus *bus =3D to_pci_bus(kobj_to_dev(kobj));
> +
> +=09if (pci_legacy_has_sparse(bus, type) !=3D sparse)
> +=09=09return 0;
> +
> +=09return a->attr.mode;
>  }
> =20
> -/**
> - * pci_create_legacy_files - create legacy I/O port and memory files
> - * @b: bus to create files under
> - *
> - * Some platforms allow access to legacy I/O port and ISA memory space o=
n
> - * a per-bus basis.  This routine creates the files and ties them into
> - * their associated read, write and mmap files from pci-sysfs.c
> - *
> - * On error unwind, but don't propagate the error to the caller
> - * as it is ok to set up the PCI bus without these files.
> - */
> -void pci_create_legacy_files(struct pci_bus *b)
> +static umode_t pci_legacy_io_is_visible(struct kobject *kobj,
> +=09=09=09=09=09const struct bin_attribute *a, int n)
>  {
> -=09int error;
> -
> -=09if (!sysfs_initialized)
> -=09=09return;
> -
> -=09b->legacy_io =3D kzalloc_objs(struct bin_attribute, 2, GFP_ATOMIC);
> -=09if (!b->legacy_io)
> -=09=09goto kzalloc_err;
> -
> -=09sysfs_bin_attr_init(b->legacy_io);
> -=09b->legacy_io->attr.name =3D "legacy_io";
> -=09b->legacy_io->size =3D 0xffff;
> -=09b->legacy_io->attr.mode =3D 0600;
> -=09b->legacy_io->read =3D pci_read_legacy_io;
> -=09b->legacy_io->write =3D pci_write_legacy_io;
> -=09/* See pci_create_attr() for motivation */
> -=09b->legacy_io->llseek =3D pci_llseek_resource;
> -=09b->legacy_io->mmap =3D pci_mmap_legacy_io;
> -=09b->legacy_io->f_mapping =3D iomem_get_mapping;
> -=09pci_adjust_legacy_attr(b, pci_mmap_io);
> -=09error =3D device_create_bin_file(&b->dev, b->legacy_io);
> -=09if (error)
> -=09=09goto legacy_io_err;
> -
> -=09/* Allocated above after the legacy_io struct */
> -=09b->legacy_mem =3D b->legacy_io + 1;
> -=09sysfs_bin_attr_init(b->legacy_mem);
> -=09b->legacy_mem->attr.name =3D "legacy_mem";
> -=09b->legacy_mem->size =3D 1024*1024;
> -=09b->legacy_mem->attr.mode =3D 0600;
> -=09b->legacy_mem->mmap =3D pci_mmap_legacy_mem;
> -=09/* See pci_create_attr() for motivation */
> -=09b->legacy_mem->llseek =3D pci_llseek_resource;
> -=09b->legacy_mem->f_mapping =3D iomem_get_mapping;
> -=09pci_adjust_legacy_attr(b, pci_mmap_mem);
> -=09error =3D device_create_bin_file(&b->dev, b->legacy_mem);
> -=09if (error)
> -=09=09goto legacy_mem_err;
> -
> -=09return;
> -
> -legacy_mem_err:
> -=09device_remove_bin_file(&b->dev, b->legacy_io);
> -legacy_io_err:
> -=09kfree(b->legacy_io);
> -=09b->legacy_io =3D NULL;
> -kzalloc_err:
> -=09dev_warn(&b->dev, "could not create legacy I/O port and ISA memory re=
sources in sysfs\n");
> +=09return __pci_legacy_is_visible(kobj, a, pci_mmap_io, false);
>  }
> =20
> -void pci_remove_legacy_files(struct pci_bus *b)
> +static umode_t pci_legacy_io_sparse_is_visible(struct kobject *kobj,
> +=09=09=09=09=09       const struct bin_attribute *a,
> +=09=09=09=09=09       int n)
>  {
> -=09if (b->legacy_io) {
> -=09=09device_remove_bin_file(&b->dev, b->legacy_io);
> -=09=09device_remove_bin_file(&b->dev, b->legacy_mem);
> -=09=09kfree(b->legacy_io); /* both are allocated here */
> -=09}
> +=09return __pci_legacy_is_visible(kobj, a, pci_mmap_io, true);
>  }
> +
> +static umode_t pci_legacy_mem_is_visible(struct kobject *kobj,
> +=09=09=09=09=09 const struct bin_attribute *a, int n)
> +{
> +=09return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, false);
> +}
> +
> +static umode_t pci_legacy_mem_sparse_is_visible(struct kobject *kobj,
> +=09=09=09=09=09=09const struct bin_attribute *a,
> +=09=09=09=09=09=09int n)
> +{
> +=09return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, true);
> +}
> +
> +static const struct bin_attribute pci_legacy_io_attr =3D {
> +=09.attr =3D { .name =3D "legacy_io", .mode =3D 0600 },
> +=09.size =3D 0xffff,
> +=09.read =3D pci_read_legacy_io,
> +=09.write =3D pci_write_legacy_io,
> +=09.mmap =3D pci_mmap_legacy_io,
> +=09.llseek =3D pci_llseek_resource,
> +=09.f_mapping =3D iomem_get_mapping,
> +};
> +
> +static const struct bin_attribute pci_legacy_io_sparse_attr =3D {
> +=09.attr =3D { .name =3D "legacy_io_sparse", .mode =3D 0600 },
> +=09.size =3D 0xffff << 5,
> +=09.read =3D pci_read_legacy_io,
> +=09.write =3D pci_write_legacy_io,
> +=09.mmap =3D pci_mmap_legacy_io,
> +=09.llseek =3D pci_llseek_resource,
> +=09.f_mapping =3D iomem_get_mapping,
> +};
> +
> +static const struct bin_attribute pci_legacy_mem_attr =3D {
> +=09.attr =3D { .name =3D "legacy_mem", .mode =3D 0600 },
> +=09.size =3D 0x100000,
> +=09.mmap =3D pci_mmap_legacy_mem,
> +=09.llseek =3D pci_llseek_resource,
> +=09.f_mapping =3D iomem_get_mapping,
> +};
> +
> +static const struct bin_attribute pci_legacy_mem_sparse_attr =3D {
> +=09.attr =3D { .name =3D "legacy_mem_sparse", .mode =3D 0600 },
> +=09.size =3D 0x100000 << 5,

I suggest naming these legacy literals with defines. At least the mem one=
=20
could also use SZ_1M:

#define PCI_LEGACY_MEM_SIZE=09SZ_1M

> +=09.mmap =3D pci_mmap_legacy_mem,
> +=09.llseek =3D pci_llseek_resource,
> +=09.f_mapping =3D iomem_get_mapping,
> +};
> +
> +static const struct bin_attribute *const pci_legacy_io_attrs[] =3D {
> +=09&pci_legacy_io_attr,
> +=09NULL,
> +};
> +
> +static const struct bin_attribute *const pci_legacy_io_sparse_attrs[] =
=3D {
> +=09&pci_legacy_io_sparse_attr,
> +=09NULL,
> +};
> +
> +static const struct bin_attribute *const pci_legacy_mem_attrs[] =3D {
> +=09&pci_legacy_mem_attr,
> +=09NULL,
> +};
> +
> +static const struct bin_attribute *const pci_legacy_mem_sparse_attrs[] =
=3D {
> +=09&pci_legacy_mem_sparse_attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group pci_legacy_io_group =3D {
> +=09.bin_attrs =3D pci_legacy_io_attrs,
> +=09.is_bin_visible =3D pci_legacy_io_is_visible,
> +};
> +
> +static const struct attribute_group pci_legacy_io_sparse_group =3D {
> +=09.bin_attrs =3D pci_legacy_io_sparse_attrs,
> +=09.is_bin_visible =3D pci_legacy_io_sparse_is_visible,
> +};
> +
> +static const struct attribute_group pci_legacy_mem_group =3D {
> +=09.bin_attrs =3D pci_legacy_mem_attrs,
> +=09.is_bin_visible =3D pci_legacy_mem_is_visible,
> +};
> +
> +static const struct attribute_group pci_legacy_mem_sparse_group =3D {
> +=09.bin_attrs =3D pci_legacy_mem_sparse_attrs,
> +=09.is_bin_visible =3D pci_legacy_mem_sparse_is_visible,
> +};
> +
> +void pci_create_legacy_files(struct pci_bus *b) { }
> +void pci_remove_legacy_files(struct pci_bus *b) { }
>  #endif /* HAVE_PCI_LEGACY */
> =20
> +const struct attribute_group *pcibus_groups[] =3D {
> +=09&pcibus_group,
> +#ifdef HAVE_PCI_LEGACY
> +=09&pci_legacy_io_group,
> +=09&pci_legacy_io_sparse_group,
> +=09&pci_legacy_mem_group,
> +=09&pci_legacy_mem_sparse_group,
> +#endif
> +=09NULL,
> +};
> +
>  #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>  /**
>   * pci_mmap_resource - map a PCI resource into user memory space
>=20

--=20
 i.

--8323328-1569654593-1775821642=:1195--


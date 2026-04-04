Return-Path: <linuxppc-dev+bounces-19322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F9DE63FEC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 17:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp2Fr3gqSz2ynh;
	Sun, 05 Apr 2026 03:12:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775322736;
	cv=none; b=Y79N00UHL5slBDgk9uvxczcEzkFnDkDn4csbN2tQLB57PIwptuOcv9aj1bljFzrmH5EFjnW1dGpDipZTmvc7Aoppvx5kfxgAcYvF8DiVsY2cPB0LvNyYvqBwq0sT6Gz4v0kyijHf5rZCsU0MbWWn9YqwDHrbU8OkMm8k9PO98Az8YQfZZuA284kDQUQ0vXbfYN43Z/3Rvjj2lZXiwvhW5QmrwxfNfT5Psje613/5TorO/T0bitkXfXep/yb4yoU21gnpB+bLhjed109zNJsYz15nfo1Ge9ZMCK8zxBVBX233PKcDdD05NLuCUuHjIyzCG/OcHUX7p1tWgp1ekaGfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775322736; c=relaxed/relaxed;
	bh=rjMH1/SsUECEYlZino7gffNjLbrHGi2A1dFabhVdjMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+P2OlbzKlZBTOz8mIE5m/NZpMeriZXQdrprHVFNt/neUXAxJcSc5sbXkthTZLaDiu8HdOeF9GzIVMrHEUKyzfWIyeBoy9T+f19gzHiaNbeNLwf3b8Cre/Kcsm882+nP8boPMPahcKPNUurUS+8b7uMbRsQSqgtfpRZUCeWPqmU+O/qDKG8M9sXRRpzuVA56fXpeQW8ABFTpFBZek3AflbMdZExjiu3seJReN+fQ1yDccsZaCg6ar9PGK9YL5PJmFmvyrBUqhJmz/iS8o3H1nbL663Da6/1zxvX3PfS4jOMTi2J6Gk9q3QWXNQVYQXRXtOXyxF/qamiMaw15Tbb2PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GcgJMoZ0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GcgJMoZ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp2Fq4xjMz2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 03:12:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66BA54455F
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2026 17:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA4C2BCC6
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2026 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322733;
	bh=6HWbdXTvY5ARCKQw/mJejk6jJkYYvhLGzuFZu/CMKrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GcgJMoZ0JuCk1oE2p1uOznAEPZR6CrHmU63ZoUxVtxnX8mJab0r4uPFFxlAmTqcZA
	 myj15f5ytltHO0slbfE7HO6gmrYbw3URX3zm5Ch5rWSlVdR401ec5dfg7RfsH5oBN4
	 PnqK3oN/0RY4LZWR+knx2bZtXfIc8cep3MmTai8iVDgIiE9nPWWVN8CVFPKdI3F70S
	 gC8kQiqGR2CuAUPcJ/9Yaydp3RzrBUC+10/bPsY353+aL5ufFQEdpAgg8xvos3Up3I
	 owNuHEnPhFIkScgSgy7tm8cpYaSl2vK6VDp57FI0G+Yzb2m579C7WS8lt58GdxocpN
	 fGfJdiBZK7yLg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4042905015cso1753039fac.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 10:12:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhe1U5lOIRIhexUa3kBifCAshGGvejgQJpSpu+jTe4PMvr326hZEf+VdF/wo+SD1R6vTyotKfZAqTGmqo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyv72mgAqa8CHRlsGPqTy43tfqQkfMiBe0iTpRBPwfSdz6Clcur
	x1+pi3fw+ERnEgpSzglAJ+fzJqre0/01Mzmx5ExOyUdCWVniMFqIw6OYbYmBmghd+g9+1PCCcEa
	BstX5ZxVLVeAQrhEElZn7zpXpPp9ji6Q=
X-Received: by 2002:a05:6871:581e:b0:422:cd76:929d with SMTP id
 586e51a60fabf-4230fd2d9e4mr3996409fac.18.1775322730928; Sat, 04 Apr 2026
 10:12:10 -0700 (PDT)
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
References: <20260404000644.522677-1-dianders@chromium.org>
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 19:11:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRKyPesMGKGoDZEMDCX-GVw6Z-dxMLhNhwy6Kjz=7MCQ@mail.gmail.com>
X-Gm-Features: AQROBzCS1sK1yep87rT-2xolltVfQ4j4qlt-9lHai0wQJnu4V3tzUHOX8_7jVCo
Message-ID: <CAJZ5v0hRKyPesMGKGoDZEMDCX-GVw6Z-dxMLhNhwy6Kjz=7MCQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Saravana Kannan <saravanak@kernel.org>, Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, 
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 2:07=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> The main goal of this series is to fix the observed bug talked about
> in the first patch ("driver core: Don't let a device probe until it's
> ready"). That patch fixes a problem that has been observed in the real
> world and could land even if the rest of the patches are found
> unacceptable or need to be spun.
>
> That said, during patch review Danilo correctly pointed out that many
> of the bitfield accesses in "struct device" are unsafe. I added a
> bunch of patches in the series to address each one.
>
> Danilo said he's most worried about "can_match", so I put that one
> first. After that, I tried to transition bitfields to flags in reverse
> order to when the bitfield was added.
>
> Even if transitioning from bitfields to flags isn't truly needed for
> correctness, it seems silly (and wasteful of space in struct device)
> to have some in bitfields and some as flags. Thus I didn't spend time
> for each bitfield showing that it's truly needed for correctness.
>
> Transition was done semi manually. Presumably someone skilled at
> coccinelle could do a better job, but I just used sed in a heavy-
> handed manner and then reviewed/fixed the results, undoing anything my
> script got wrong. My terrible/ugly script was:
>
> var=3Dcan_match
> caps=3D"${var^^}"
> for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
>   echo $f
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D tru=
e/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D tru=
e/dev_set_${caps}(\&\\1)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D fal=
se/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D fal=
se/dev_clear_${caps}(\&\\1)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} =3D \([=
^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} =3D \([=
^;]*\)/dev_assign_${caps}(\&\\1, \\2)/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_=
a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
>   sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_=
a-zA-Z\[]\)/dev_${caps}(\&\\1)\\2/" "$f"
> done
>
> From v3 to v4, I transitioned to accessor functions with another ugly
> sed script. I had git format the old patches, then transformed them
> with:
>
> for f in *.patch; do
>   echo $f
>   sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev=
_test_and_set_\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_t=
est_and_set_\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_\\L\\1(=
\\2)/" "$f"
>   sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_\\L\\1(\\=
2)/" "$f"
>   sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_set_\\L\=
\1(\\2)/" "$f"
>   sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_set_\\L\\1=
(\\2)/" "$f"
>   sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_clear_=
\\L\\1(\\2)/" "$f"
>   sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_clear_\\=
L\\1(\\2)/" "$f"
>   sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags, \(.*\))/d=
ev_assign_\\L\\1(\\2, \\3)/" "$f"
>   sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags, \(.*\))/dev=
_assign_\\L\\1(\\2, \\3)/" "$f"
> done
>
> ...and then did a few manual touchups for spacing.
>
> NOTE: one potentially "controversial" choice I made in some patches
> was to always reserve a flag ID even if a flag is only used under
> certain CONFIG_ settings. This is a change from how things were
> before. Keeping the numbering consistent and allowing easy
> compile-testing of both CONFIG settings seemed worth it, especially
> since it won't take up any extra space until we've added a lot more
> flags.
>
> I only marked the first patch as a "Fix" since it is the only one
> fixing observed problems. Other patches could be considered fixes too
> if folks want.
>
> I tested the first patch in the series backported to kernel 6.6 on the
> Pixel phone that was experiencing the race. I added extra printouts to
> make sure that the problem was hitting / addressed. The rest of the
> patches are tested with allmodconfig with arm32, arm64, ppc, and
> x86. I boot tested on an arm64 Chromebook running mainline.
>
> Changes in v4:
> - Use accessor functions for flags
>
> Changes in v3:
> - Use a new "flags" bitfield
> - Add missing \n in probe error message
>
> Changes in v2:
> - Instead of adjusting the ordering, use "ready_to_probe" flag
>
> Douglas Anderson (9):
>   driver core: Don't let a device probe until it's ready
>   driver core: Replace dev->can_match with dev_can_match()
>   driver core: Replace dev->dma_iommu with dev_dma_iommu()
>   driver core: Replace dev->dma_skip_sync with dev_dma_skip_sync()
>   driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
>   driver core: Replace dev->state_synced with dev_state_synced()
>   driver core: Replace dev->dma_coherent with dev_dma_coherent()
>   driver core: Replace dev->of_node_reused with dev_of_node_reused()
>   driver core: Replace dev->offline + ->offline_disabled with accessors
>
>  arch/arc/mm/dma.c                             |   4 +-
>  arch/arm/mach-highbank/highbank.c             |   2 +-
>  arch/arm/mach-mvebu/coherency.c               |   2 +-
>  arch/arm/mm/dma-mapping-nommu.c               |   4 +-
>  arch/arm/mm/dma-mapping.c                     |  28 ++--
>  arch/arm64/kernel/cpufeature.c                |   2 +-
>  arch/arm64/mm/dma-mapping.c                   |   2 +-
>  arch/mips/mm/dma-noncoherent.c                |   2 +-
>  arch/powerpc/kernel/dma-iommu.c               |   8 +-
>  .../platforms/pseries/hotplug-memory.c        |   4 +-
>  arch/riscv/mm/dma-noncoherent.c               |   2 +-
>  drivers/acpi/scan.c                           |   2 +-
>  drivers/base/core.c                           |  53 +++++---
>  drivers/base/cpu.c                            |   4 +-
>  drivers/base/dd.c                             |  28 ++--
>  drivers/base/memory.c                         |   2 +-
>  drivers/base/pinctrl.c                        |   2 +-
>  drivers/base/platform.c                       |   2 +-
>  drivers/dma/ti/k3-udma-glue.c                 |   6 +-
>  drivers/dma/ti/k3-udma.c                      |   6 +-
>  drivers/iommu/dma-iommu.c                     |   9 +-
>  drivers/iommu/iommu.c                         |   5 +-
>  drivers/net/pcs/pcs-xpcs-plat.c               |   2 +-
>  drivers/of/device.c                           |   6 +-
>  drivers/pci/of.c                              |   2 +-
>  drivers/pci/pwrctrl/core.c                    |   2 +-
>  drivers/regulator/bq257xx-regulator.c         |   2 +-
>  drivers/regulator/rk808-regulator.c           |   2 +-
>  drivers/tty/serial/serial_base_bus.c          |   2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c      |   2 +-
>  include/linux/device.h                        | 120 ++++++++++++------
>  include/linux/dma-map-ops.h                   |   6 +-
>  include/linux/dma-mapping.h                   |   2 +-
>  include/linux/iommu-dma.h                     |   3 +-
>  kernel/cpu.c                                  |   4 +-
>  kernel/dma/mapping.c                          |  12 +-
>  mm/hmm.c                                      |   2 +-
>  37 files changed, 206 insertions(+), 142 deletions(-)
>
> --

For the whole set

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>


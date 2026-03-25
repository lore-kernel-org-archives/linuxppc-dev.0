Return-Path: <linuxppc-dev+bounces-18758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5539FEA801
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 03:08:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgX0q3RDGz2yF1;
	Wed, 25 Mar 2026 14:08:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774408107;
	cv=pass; b=LTOE2OTI3VGFfFSZ4zG5JXtCj+Vb/vtj+0Wg8MCYyPFNTtAdps4YiCNjRqWojzj7dth1kI/CKveZJdGfzmPQPZHGhzYnYf00SNMMA4Mv0BeZjEzQa7CXFSfm8jAsjXqYabz80om6Ke0xE94Gu6f17I/jNzrIqdsJywXuh2nkJLg8LFNqC3P6GW6SNivnZMeEtZgRtC+hzCF2BkyHaQmPxzkL+g5UgS9Z/NnKB8VjOWZwlpo1M7RhzYVxRbCoa/F9iutLJhqc7fLBe5I7LkFQkN+B80ZJZoPGBlCH8c73WNhjxjU3+opcFHFwFlR1jHNFwQ/qofR+uwckl+W7sLaz+w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774408107; c=relaxed/relaxed;
	bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luPgsnmGt5UL8ShYNsHegsmYrpi4OvO6qqMKVB4RMV8za21ArS5onWIRsUHUCrYzsc2V1W8b5wWFcawMc9w9JxdYL45RFocPST78/s7un/QpMo38eq3UtKbirnqDJjRWO0GPLvtv3PehSRl2qb5NbTg6+OCHp4vPjtiEBhlPIgKtgvBQw6T4S6A8AXxPgfdNQed2a0KN8H9MLFAdywIt5t+bqf9NJ8V0OjtYvPJNWL+hFhIDZrk6eTkDf580CYYA2rMSkrE6zcTB6P5LyeHmg93SYa+cMU4Su7nIyWG2Uh74CnwVEn+3MnAqYmTKCfYTLVFpejiDA9yOEXLQSA0NeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0xbErpQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=hanguidong02@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X0xbErpQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=hanguidong02@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgX0n52frz2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 14:08:25 +1100 (AEDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-67bbea1e090so3378289eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 20:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408102; cv=none;
        d=google.com; s=arc-20240605;
        b=ZE9QTRqrwzyrPLhRKQKV2ei1DSFRlqggdSOfy1XF+o2pYQKQureSq0hQ1M2tV2FS10
         GR6JL8ThfLCrlOiOn/TpDljMMTNVot588QSLJCdCf3uQw0R3SiN1t3dHHKP5KdO8ppYv
         J1Wp7ZX5BlXxol0yn8hw1t6BGJXjeYi+IuvLnmOGzKt+h3ec+LToXtDTFAYw8QOrjVE3
         9sOUtpfZjnLpcbH/mQNW0b4w6MA0B8cFx/MbaG5YcaXcWpK6kvEWpAo0JRL3eNQyowSg
         ZkDM0hSRUSJSnAPOX96AFpUugiHbW7urIRQ827hGGAzYXC//lGZ/uddUkFLOxQ7tgw/l
         uA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        fh=X4NbtatT70lkmjfsChjR9dCoc4SZ++ySVHvFLTFFsMY=;
        b=VlG8KvEcqrAVjKQGKrl7DHFYqngMb4xboSVe6j2fKr7frdubqmuNUIMKifwOoW1W3m
         xIb3eHR/N9xIu+ajiEtcaMqKtGGXPLMZx1n1bAoHtwBEutyh+jtTr/SWqgy96eQwkRt6
         D9M9J245MjMhUk4dA93jD1khcwfWRdSBFSWArYx94tp2Uh7AdevgkSZDJ0fz0EalJuPI
         YsKFUP5eCQ+ctthLW7fTkHFYGd1KFVUnZqWA+ou1aBJQX+OzEGlWyg1uLV7b44V3ILG6
         cmmjVy104O40nmm8amcsWj77sSPLbUErUS8X51r8qKOqUNq7592YD+v9V//DrJFTPzj2
         GHLQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774408102; x=1775012902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=X0xbErpQ8Afg+t66kWgN3DWosK0IPcG46HdHRZSU3ewk/5AXpmbujSDZ9FmjTGVqDj
         Y5rQ9MdmdkD0k8jIjsHrW9Jz2NJ0BSW3hctE4wE1K1L/sA5+MyUHgU4ijqpC0C6xpJZn
         6HSZgFDW6QdNeR8qzaDqu9+RKrrEppYBPRz1eneuaYVfP2CdPQVH2g3ordpl/bm2Pfsp
         k45yYN3dMaunFGI4+/6r9eKQzWpqsXYYK5T0a6IEYjNdqxs8qVwPkWHOhlIaw+fRsctL
         +ur4a13zufaOy0n9X56Lf+Qq2ztEosM/+sFGpqMJ/nUmax4SlSAHirI3GsQe5XUen9Y2
         Wyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774408102; x=1775012902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=QX4nhdJKvjGfqxGLWl2tpy9pcZ5DzDxSvQxD1Rj9/r+lpC12f3vE+wlL46NtBu83Sh
         +2Cu9A49Qcj3FeiP5JGOJ5MX4TmMc/atS/BbFIEDzfdMZPSkkB8RiVNY/izzlzlYDu6u
         dsKxHowlCuSvWk33aP3cuObo7hJ3BJrd23TPIGZjnNc9T/0XfDzxT64mkhiggGrdoFpC
         8UbVWZzWf7G4hxEeUXI6Wohg0N/PF3E++iTRsZrY9ekev91U8iIxDz9haX18f6xpMeRJ
         xqPwWVrGothqVGIIO5gmc1EOlrDwggy1reUnIy0DdAX5+sjfyh2/KghYwAQyNXJLQQBj
         DQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXIkCs27tP5PLBV2CRT3KveySj4TpaLWlIBN8n8OBbzZ2u7e1uro9UiYIgBs8vbpdo8NxdfRuwc9k/SzwI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVv1gteW30qffZXcE9u9ZcHRAjOuvMf7SAzpDDWqDkh+QyDWH3
	1E9CT7x9qatavfARew5x6Z/Pb5VIah8X5+uSKVU0wyJXH8UiievpW4LvVqQEP72PuTNLKaHjmgU
	dADwkoSZkDps4woc9vi/+xKjArzM8rpw=
X-Gm-Gg: ATEYQzz6b6xT4kBz3/NIvC7/K6AA/IlbY++8zHKa4wClK/Gm+dP321fVCX09HUKVCAk
	y8Zh+6giK7V011+umI/qIpIEil92HWYVH1buApAHFbJ5f53aX8FWvjD5N/1uh+TudruOPJ5UiFZ
	O9xlTLNyI1GUp9InseU5S5izfvTgS1Es/ymaXam8EVU/I/sgNj3Y0y141bSzZDncMtEniPnOLSu
	Gv+Eeji9dgj+gsIrJCdVDkFIRguSsYQQTM9qDRFZmWxEfJY8DUvsIO2uZq+t56i++kWqcwxE79Y
	43sHIlkIqz4Y7aUoQNLVDyTYgW2tCKdGKmqSjb0e3GueHBayH01GPerSB4uys+j1nwbP3bDpv71
	md9huIRM=
X-Received: by 2002:a05:6820:1787:b0:67b:e203:6c8d with SMTP id
 006d021491bc7-67dff53efc8mr1216692eaf.52.1774408101668; Tue, 24 Mar 2026
 20:08:21 -0700 (PDT)
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
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-6-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 25 Mar 2026 11:08:11 +0800
X-Gm-Features: AQROBzD64p8E8k4KuR51RUiYotZVMtC9NAESBq-7RvJsmuQyKbQ4KJC_uWmm37s
Message-ID: <CALbr=La3gV5VmoXauF-fkmXveoJGtTvef1d1nrLtUZNHx2eF+w@mail.gmail.com>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Wang Jiayue <akaieurus@gmail.com>, 
	Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_de=
v.driver_override")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Tested on QEMU PCI with multiple debug configs enabled. The original
PoCs run cleanly without triggering the issue.

Thanks Danilo.

Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>

> ---
>  drivers/pci/pci-driver.c           | 11 +++++++----
>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>  drivers/pci/probe.c                |  1 -
>  drivers/vfio/pci/vfio_pci_core.c   |  5 ++---
>  drivers/xen/xen-pciback/pci_stub.c |  6 ++++--
>  include/linux/pci.h                |  6 ------
>  6 files changed, 13 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dd9075403987..d10ece0889f0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -138,9 +138,11 @@ static const struct pci_device_id *pci_match_device(=
struct pci_driver *drv,
>  {
>         struct pci_dynid *dynid;
>         const struct pci_device_id *found_id =3D NULL, *ids;
> +       int ret;
>
>         /* When driver_override is set, only bind to the matching driver =
*/
> -       if (dev->driver_override && strcmp(dev->driver_override, drv->nam=
e))
> +       ret =3D device_match_driver_override(&dev->dev, &drv->driver);
> +       if (ret =3D=3D 0)
>                 return NULL;
>
>         /* Look at the dynamic ids first, before the static ones */
> @@ -164,7 +166,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>                  * matching.
>                  */
>                 if (found_id->override_only) {
> -                       if (dev->driver_override)
> +                       if (ret > 0)
>                                 return found_id;
>                 } else {
>                         return found_id;
> @@ -172,7 +174,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>         }
>
>         /* driver_override will always match, send a dummy id */
> -       if (dev->driver_override)
> +       if (ret > 0)
>                 return &pci_device_id_any;
>         return NULL;
>  }
> @@ -452,7 +454,7 @@ static int __pci_device_probe(struct pci_driver *drv,=
 struct pci_dev *pci_dev)
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
>         return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprob=
e ||
> -               pdev->driver_override);
> +               device_has_driver_override(&pdev->dev));
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> @@ -1722,6 +1724,7 @@ static const struct cpumask *pci_device_irq_get_aff=
inity(struct device *dev,
>
>  const struct bus_type pci_bus_type =3D {
>         .name           =3D "pci",
> +       .driver_override =3D true,
>         .match          =3D pci_bus_match,
>         .uevent         =3D pci_uevent,
>         .probe          =3D pci_device_probe,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..a9006cf4e9c8 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -615,33 +615,6 @@ static ssize_t devspec_show(struct device *dev,
>  static DEVICE_ATTR_RO(devspec);
>  #endif
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &pdev->driver_override, buf, cou=
nt);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *=
buf)
> -{
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", pdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *pci_dev_attrs[] =3D {
>         &dev_attr_power_state.attr,
>         &dev_attr_resource.attr,
> @@ -669,7 +642,6 @@ static struct attribute *pci_dev_attrs[] =3D {
>  #ifdef CONFIG_OF
>         &dev_attr_devspec.attr,
>  #endif
> -       &dev_attr_driver_override.attr,
>         &dev_attr_ari_enabled.attr,
>         NULL,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..b4707640e102 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2488,7 +2488,6 @@ static void pci_release_dev(struct device *dev)
>         pci_release_of_node(pci_dev);
>         pcibios_release_device(pci_dev);
>         pci_bus_put(pci_dev->bus);
> -       kfree(pci_dev->driver_override);
>         bitmap_free(pci_dev->dma_alias_mask);
>         dev_dbg(dev, "device released\n");
>         kfree(pci_dev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_bl=
ock *nb,
>             pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_overri=
de\n",
>                          pci_name(pdev));
> -               pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
> -                                                 vdev->vdev.ops->name);
> -               WARN_ON(!pdev->driver_override);
> +               WARN_ON(device_set_driver_override(&pdev->dev,
> +                                                  vdev->vdev.ops->name))=
;
>         } else if (action =3D=3D BUS_NOTIFY_BOUND_DRIVER &&
>                    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 struct pci_driver *drv =3D pci_dev_driver(pdev);
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback=
/pci_stub.c
> index e4b27aecbf05..79a2b5dfd694 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -598,6 +598,8 @@ static int pcistub_seize(struct pci_dev *dev,
>         return err;
>  }
>
> +static struct pci_driver xen_pcibk_pci_driver;
> +
>  /* Called when 'bind'. This means we must _NOT_ call pci_reset_function =
or
>   * other functions that take the sysfs lock. */
>  static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id=
 *id)
> @@ -609,8 +611,8 @@ static int pcistub_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
>
>         match =3D pcistub_match(dev);
>
> -       if ((dev->driver_override &&
> -            !strcmp(dev->driver_override, PCISTUB_DRIVER_NAME)) ||
> +       if (device_match_driver_override(&dev->dev,
> +                                        &xen_pcibk_pci_driver.driver) > =
0 ||
>             match) {
>
>                 if (dev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..57e9463e4347 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -575,12 +575,6 @@ struct pci_dev {
>         u8              supported_speeds; /* Supported Link Speeds Vector=
 */
>         phys_addr_t     rom;            /* Physical address if not from B=
AR */
>         size_t          romlen;         /* Length if not from BAR */
> -       /*
> -        * Driver name to force a match.  Do not set directly, because co=
re
> -        * frees it.  Use driver_set_override() to set or clear it.
> -        */
> -       const char      *driver_override;
> -
>         unsigned long   priv_flags;     /* Private flags for the PCI driv=
er */
>
>         /* These methods index pci_reset_fn_methods[] */
> --
> 2.53.0
>


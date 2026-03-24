Return-Path: <linuxppc-dev+bounces-18646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52C1F532C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:59:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsBb2rp6z2yhX;
	Tue, 24 Mar 2026 11:59:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774313975;
	cv=none; b=J8D1m/GmYvcuXO7S6U63ojojk45Q8cSXg0ijdPLW/1wK3EDBsAtzjUrZle8P6/BPa04C8hr9Nv4hsijFH0TAC+BKlGxnx+IFXQ0Pw9wQnWhzS62l/OWjcEzf29ql3duTRAJ4uu2Bw0XhMlPNUIYEUctNf9vkSuSG9pNaSKtjQfBu/qZAonU/Rja3rRwzAoayUkX/CXAQNoRP3FrK9UgQizPGyXy0iXBqVzwAISnhXbvOKk/uOKD6OPFbM6zjwRsvRXefMkoWGplNgym3NjIva3NzGPYUuUZM8oB/CitQM4K2VPJ0M+qJcJ1UlYMFe8pO3VXWnewmJPfieVymny13Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774313975; c=relaxed/relaxed;
	bh=l/PLRrp/kosCKHD/6EHqfX62ZOY+7hmZq9SjOmDvg9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SA+zNL9mapgJ3wf9v7wrm9nLH15v0NE4S6GTg4WsuMs5oKUAADT5Y7nm7TJ7W+m/yBZ17Ah5rMWklLqi6x5s2HYmoIk656zW6yxYMgv8WSDmvSKPUBS9foLrdi0i9gKzpK7NgbQjrYTOSSAv2M2ADGQCuf00YgUVAhiiNsU9KXwwODrN/0nM9xzhDtp399rLjESiDfoqBmPd6crSyR2ADb9y9oxSgcPdYaNyMLFD3HFu+C+rDC6XmoK1bimnybzGsV0iWmCtA8DF1aaPrBCQTyoQdcj4F6TOQqdaS6wKQZctaB4L3zgU65/wUN3J9CaeZLe2Wm3ghsy2rtqqwuon/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r79tvbMT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r79tvbMT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsBZ3QxGz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 11:59:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3151A406AE;
	Tue, 24 Mar 2026 00:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2ECC4CEF7;
	Tue, 24 Mar 2026 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313972;
	bh=g9n6egUYTuF5ke2JJ6m74go1iA9dbs1LNBwQX9Kfxdo=;
	h=From:To:Cc:Subject:Date:From;
	b=r79tvbMTbzL0ftvYwrYFxtc47UR6uhBnmMbW/y7VVV1iRybB+2M4JpIoiYURI0KHc
	 xbQi6Hae6AoFoJmbmbDJaHU6H4twMWZBNd3LQspzN5XukCR8uOrEpuyEmdRt0aOb0U
	 mOwgSJ8cLDV9T8BHYl+ocS0L8OVgW58qmKn8ydBwrFxSGxlpZWrzAsZEqo1gSY7MVu
	 kkOnSl/PVHu6HAiahaLq+b8nbHuZsE8hCdipD5o7lr0426ClKDJ0QYolowXlhy4fkV
	 i8IvftFPJDTfcclR/4ZCSmDk8L1PXC7Ak76kNlhT/lIjYoVE7r0UGtOBo25YTrAjXS
	 EFJsJ4/WWZ6pw==
From: Danilo Krummrich <dakr@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 00/12] treewide: Convert buses to use generic driver_override
Date: Tue, 24 Mar 2026 01:59:04 +0100
Message-ID: <20260324005919.2408620-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

This is the follow-up of the driver_override generalization in [1], converting
the remaining 11 busses and removing the now-unused driver_set_override()
helper.

All of them (except AP, which has a different race condition) are prone to the
potential UAF described in [2], caused by accessing the driver_override field
from their corresponding match() callback.

In order to address this, the generalized driver_override field in struct device
is protected with a spinlock. The driver-core provides accessors, such as
device_match_driver_override(), device_has_driver_override() and
device_set_driver_override(), which all ensure proper locking internally.

Additionally, the driver-core provides a driver_override flag in struct
bus_type, which, once enabled, automatically registers generic sysfs callbacks,
allowing userspace to modify the driver_override field.

SPI and AP are a bit special; both print "\n" when driver_override is not set,
whereas all other buses (and thus the driver-core) produce "(null)\n" in this
case.

Hence, SPI and AP do not take advantage of the driver_override flag in struct
bus_type; AP additionally maintains a counter in its custom sysfs store().

Technically, we could support a custom fallback string when driver_override is
unset in struct bus_type, but only SPI would benefit from this, since AP has
additional custom logic in store() anyways.

(I'm not sure if there are userspace programs that strictly rely on this;
driverctl seems to check for both, but I rather not break some userspace tool
I'm not aware of. :)

This series is based on v7.0-rc5 with no additional dependencies, hence those
patches can be picked up by subsystems individually.

[1] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.org/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=220789
[3] https://gitlab.com/driverctl/driverctl/-/blob/0.121/driverctl?ref_type=tags#L99

Danilo Krummrich (12):
  amba: use generic driver_override infrastructure
  bus: fsl-mc: use generic driver_override infrastructure
  cdx: use generic driver_override infrastructure
  hv: vmbus: use generic driver_override infrastructure
  PCI: use generic driver_override infrastructure
  platform/wmi: use generic driver_override infrastructure
  rpmsg: use generic driver_override infrastructure
  vdpa: use generic driver_override infrastructure
  s390/cio: use generic driver_override infrastructure
  s390/ap: use generic driver_override infrastructure
  spi: use generic driver_override infrastructure
  driver core: remove driver_set_override()

 drivers/amba/bus.c                 | 37 +++------------
 drivers/base/driver.c              | 75 ------------------------------
 drivers/bus/fsl-mc/fsl-mc-bus.c    | 43 +++--------------
 drivers/cdx/cdx.c                  | 40 ++--------------
 drivers/hv/vmbus_drv.c             | 36 ++------------
 drivers/pci/pci-driver.c           | 11 +++--
 drivers/pci/pci-sysfs.c            | 28 -----------
 drivers/pci/probe.c                |  1 -
 drivers/platform/wmi/core.c        | 36 ++------------
 drivers/rpmsg/qcom_glink_native.c  |  2 -
 drivers/rpmsg/rpmsg_core.c         | 43 +++--------------
 drivers/rpmsg/virtio_rpmsg_bus.c   |  1 -
 drivers/s390/cio/cio.h             |  5 --
 drivers/s390/cio/css.c             | 34 ++------------
 drivers/s390/crypto/ap_bus.c       | 34 +++++++-------
 drivers/s390/crypto/ap_bus.h       |  1 -
 drivers/s390/crypto/ap_queue.c     | 24 +++-------
 drivers/spi/spi.c                  | 19 +++-----
 drivers/vdpa/vdpa.c                | 48 ++-----------------
 drivers/vfio/fsl-mc/vfio_fsl_mc.c  |  4 +-
 drivers/vfio/pci/vfio_pci_core.c   |  5 +-
 drivers/xen/xen-pciback/pci_stub.c |  6 ++-
 include/linux/amba/bus.h           |  5 --
 include/linux/cdx/cdx_bus.h        |  4 --
 include/linux/device/driver.h      |  2 -
 include/linux/fsl/mc.h             |  4 --
 include/linux/hyperv.h             |  5 --
 include/linux/pci.h                |  6 ---
 include/linux/rpmsg.h              |  4 --
 include/linux/spi/spi.h            |  5 --
 include/linux/vdpa.h               |  4 --
 include/linux/wmi.h                |  4 --
 32 files changed, 88 insertions(+), 488 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.53.0



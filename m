Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0640C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D241620835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D241620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440cCv1TnqzDqY2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=collabora.com
 (client-ip=2a00:1098:0:82:1000:25:2eeb:e3e3; helo=bhuna.collabora.co.uk;
 envelope-from=boris.brezillon@collabora.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440c6c5B1SzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:04:24 +1100 (AEDT)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A4959278FE6;
 Thu, 14 Feb 2019 13:04:15 +0000 (GMT)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alban Bedel <albeu@free.fr>, linuxppc-dev@lists.ozlabs.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-mtd@lists.infradead.org
Subject: Re: [v3,2/2] drivers/mtd: Fix device registration error
Date: Thu, 14 Feb 2019 14:04:12 +0100
Message-Id: <20190214130412.30059-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133338.30399-2-aneesh.kumar@linux.ibm.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 3e35730dd7540bad2d4e002703996391d9be49a0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Boris Brezillon <bbrezillon@kernel.org>

On Mon, 2019-02-11 at 13:33:38 UTC, "Aneesh Kumar K.V" wrote:
> This change helps me to get multiple mtd device registered. Without this
> I get
> 
> sysfs: cannot create duplicate filename '/bus/nvmem/devices/flash0'
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2-00557-g1ef20ef21f22 #13
> Call Trace:
> [c0000000b38e3220] [c000000000b58fe4] dump_stack+0xe8/0x164 (unreliable)
> [c0000000b38e3270] [c0000000004cf074] sysfs_warn_dup+0x84/0xb0
> [c0000000b38e32f0] [c0000000004cf6c4] sysfs_do_create_link_sd.isra.0+0x114/0x150
> [c0000000b38e3340] [c000000000726a84] bus_add_device+0x94/0x1e0
> [c0000000b38e33c0] [c0000000007218f0] device_add+0x4d0/0x830
> [c0000000b38e3480] [c0000000009d54a8] nvmem_register.part.2+0x1c8/0xb30
> [c0000000b38e3560] [c000000000834530] mtd_nvmem_add+0x90/0x120
> [c0000000b38e3650] [c000000000835bc8] add_mtd_device+0x198/0x4e0
> [c0000000b38e36f0] [c00000000083619c] mtd_device_parse_register+0x11c/0x280
> [c0000000b38e3780] [c000000000840830] powernv_flash_probe+0x180/0x250
> [c0000000b38e3820] [c00000000072c120] platform_drv_probe+0x60/0xf0
> [c0000000b38e38a0] [c0000000007283c8] really_probe+0x138/0x4d0
> [c0000000b38e3930] [c000000000728acc] driver_probe_device+0x13c/0x1b0
> [c0000000b38e39b0] [c000000000728c7c] __driver_attach+0x13c/0x1c0
> [c0000000b38e3a30] [c000000000725130] bus_for_each_dev+0xa0/0x120
> [c0000000b38e3a90] [c000000000727b2c] driver_attach+0x2c/0x40
> [c0000000b38e3ab0] [c0000000007270f8] bus_add_driver+0x228/0x360
> [c0000000b38e3b40] [c00000000072a2e0] driver_register+0x90/0x1a0
> [c0000000b38e3bb0] [c00000000072c020] __platform_driver_register+0x50/0x70
> [c0000000b38e3bd0] [c00000000105c984] powernv_flash_driver_init+0x24/0x38
> [c0000000b38e3bf0] [c000000000010904] do_one_initcall+0x84/0x464
> [c0000000b38e3cd0] [c000000001004548] kernel_init_freeable+0x530/0x634
> [c0000000b38e3db0] [c000000000011154] kernel_init+0x1c/0x168
> [c0000000b38e3e20] [c00000000000bed4] ret_from_kernel_thread+0x5c/0x68
> mtd mtd1: Failed to register NVMEM device
> 
> With the change we now have
> 
> root@(none):/sys/bus/nvmem/devices# ls -al
> total 0
> drwxr-xr-x 2 root root 0 Feb  6 20:49 .
> drwxr-xr-x 4 root root 0 Feb  6 20:49 ..
> lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@0 -> ../../../devices/platform/ibm,opal:flash@0/mtd/mtd0/flash@0
> lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@1 -> ../../../devices/platform/ibm,opal:flash@1/mtd/mtd1/flash@1
> 
> Fixes: acfe63ec1c59 ("mtd: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/fixes, thanks.

Boris

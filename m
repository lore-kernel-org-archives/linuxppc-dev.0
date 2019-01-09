Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8FC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D0220685
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Aaa8OF7k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEdiLyb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D0220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZbFq4lCvzDqby
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 04:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kroah.com
 (client-ip=66.111.4.230; helo=new4-smtp.messagingengine.com;
 envelope-from=greg@kroah.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kroah.com header.i=@kroah.com header.b="Aaa8OF7k"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="kEdiLyb7"; dkim-atps=neutral
X-Greylist: delayed 527 seconds by postgrey-1.36 at bilbo;
 Thu, 10 Jan 2019 04:07:47 AEDT
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZbD31SC1zDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 04:07:46 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5803EC9C3;
 Wed,  9 Jan 2019 11:58:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 09 Jan 2019 11:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=6
 FovQFO2AgejyrsB3wce5dlpU5UTkrtXR63KKxQm3fw=; b=Aaa8OF7ky9GajHsNF
 Vnd2VUbHMhEy0lHl9uKlH5VrLKrNQsnwIBzCxxUOn+FN9+1HQCIKtdW+chYug85M
 5Lvs+FHwkrqebNLTAUpxNYSPK4Equ0f7gGLjkjxnt5KT3gDXr//SnWWDiSLYZ140
 kcnBGUGItK+tjPb2D8ahP/LD+t6T9Y5Zq6SodEPI3dk4jOwM0/ZGlwh4DLthBJMd
 s15WXQkhCLIOiHvYA6Irp0WLl5wcqU3lufjOBqCFsXMMfAnU6+K5y1TCW9Hug7Im
 k/2hNe2qh2Y8e06bQsZLRl+pp1Ef+jpJVSoK1hqHBT0DlRMWCFhGfkqscvbflT2S
 viwqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=6FovQFO2AgejyrsB3wce5dlpU5UTkrtXR63KKxQm3
 fw=; b=kEdiLyb7NRZlQaevxbSGj0l6eUQtJz0KA8ST7FuUVbOkygJYZ1wg70JCd
 SQJD+xg13+eDlEmMPgiX/+GEjucOWNmx5UkdvvOefBKCKRR2Hh252deCvgc0omMv
 kYCc4THYy84sFXyEza9mLHmUPeZ1px058vMXza0tXfKBhG1Bgwq0UotwmW5xIXg/
 wTnEL0L/M/IwLuDjzkPiBYqd1OnfkwExL2OE+XClkgp8fRvW5mbpo1TPlj/2BHjL
 u65eDrRGUzB6sdVqGNoI3aKlOGWIGpGvlV2dmLJ/eRK3G1YTYSPJxCR2aC7am+lI
 t69CGr7tAo4VNbuda3AZao0Riooiw==
X-ME-Sender: <xms:TSg2XJt3PjmqOH0Mr1LVjW85NVKU6KpEWvwvobaAfipw3OxPlqjyOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfedugdelieculddtuddrgedtkedrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhprghmkfhpucdlfedttddmnecujfgurhepfffhvffukfhfgggtugfgjggfsehtkeer
 tddtredunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqe
 enucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
 rhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:TSg2XLCDuoiGU48yggU-Xnt9olGPSSvCl6KJScSevGi-lImRqLTaLg>
 <xmx:TSg2XD3W82xXxoQFWe91Lw2nJKZUZhkMr-aSvvhcSJdX7lCEi0_LYA>
 <xmx:TSg2XFRjXPkirLz0L17sGq7Ft4iXXFKFpVsRgBRxiDhYCryx3IXn9A>
 <xmx:UCg2XPFF-VsBSwKxKlsfW_i_DsJVGjOiWbz1Ko3RMtLYlh0GUTjVTg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id 548EB10106;
 Wed,  9 Jan 2019 11:58:53 -0500 (EST)
Date: Wed, 9 Jan 2019 17:58:51 +0100
From: Greg KH <greg@kroah.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
Message-ID: <20190109165851.GA9424@kroah.com>
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
 <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
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
Cc: aik@ozlabs.ru, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Greg Kurz <groug@kaod.org>, andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 09, 2019 at 05:45:53PM +0100, Frederic Barrat wrote:
> 
> 
> Le 09/01/2019 à 17:25, Greg Kurz a écrit :
> > On Wed,  9 Jan 2019 16:13:42 +0100
> > Frederic Barrat <fbarrat@linux.ibm.com> wrote:
> > 
> > > With a recent change around IOMMU group, a system with an opencapi
> > > adapter is no longer booting and we get a kernel oops:
> > > 
> > > BUG: Kernel NULL pointer dereference at 0x00000028
> > > Faulting instruction address: 0xc0000000000aa38c
> > > Oops: Kernel access of bad area, sig: 7 [#1]
> > > LE SMP NR_CPUS=2048 NUMA PowerNV
> > > Modules linked in:
> > > CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e94bec12
> > > NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
> > > REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001-g3bd6
> > > MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  XER: 20
> > > CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK: 0
> > > GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf761860
> > > GPR04: 0000000000000000 c000000005783834 0000000000000000 0000000000000000
> > > GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 9000000002001003
> > > GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 0000000000000000
> > > GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000a0000
> > > GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000ced978
> > > GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 0000000000000000
> > > GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf761860
> > > NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
> > > LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
> > > Call Trace:
> > > [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0x60/0x
> > > [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
> > > [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0x31c
> > > [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
> > > [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
> > > [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
> > > [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
> > > [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
> > > 
> > > An opencapi device is using a device PE, so the current code breaks
> > > because pe->pbus is not defined.
> > > 
> > > More generally, there's no need to define an IOMMU group for opencapi,
> > > as the device sends real addresses directly (admittedly, the
> > > virtualization story is yet to be written). So let's fix it by
> > 
> > Current plan is to go for mediated VFIO. The real HW stays under the control
> > of the host ocxl driver, and we still don't need an IOMMU group.
> > 
> > > skipping the IOMMU group setup for opencapi PHBs.
> > > 
> > > Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> > > Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> > > ---
> > 
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > 
> > and
> > 
> > Cc: stable@vger.kernel.org      # v4.20
> 
> Thanks for the review! But why did you add stable? that problem is only seen
> on 5.0-rc1, isn't it?

No, this is fixing a patch that got backported to stable.

Well, attempted to be backported, I dropped it because of the problem :)

thanks,

greg k-h

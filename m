Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21495C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:41:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F5D214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jGLz8YIm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isnM4lb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F5D214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b6b21ffnzDqhC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 00:41:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kroah.com
 (client-ip=64.147.123.18; helo=wnew4-smtp.messagingengine.com;
 envelope-from=greg@kroah.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kroah.com header.i=@kroah.com header.b="jGLz8YIm"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="isnM4lb4"; dkim-atps=neutral
X-Greylist: delayed 497 seconds by postgrey-1.36 at bilbo;
 Fri, 11 Jan 2019 00:39:26 AEDT
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com
 [64.147.123.18])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b6YB34YbzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 00:39:26 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.west.internal (Postfix) with ESMTP id 71BD215B1;
 Thu, 10 Jan 2019 08:31:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 10 Jan 2019 08:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=D
 mFuyEMtAI2d1n3c3fiXfRHFRCO5XO7yzaTwCrovlXc=; b=jGLz8YImAvR3jb7b1
 jTDIbCKfTdYHVGBu33f1pNxK7MJsGRkJ8COIhkCSsMNkbLW3DfUyvICtss2uarbk
 Ho+gwR4CFMtlIZnxgsxYEl6kRcILFIyjlThzOfWday5SiQtJrQHrSxCVkImKzxHR
 glHwHznUPHqhH62N+TWNYc5sOB/ABShHuHOr6lj/tV4J7HBYwS1FCiy7m7xPTFYJ
 A1iQMjEoaxeiMUqTg0/iHWUiNDbhppP61jeie0p9en5sFkFePlArEdDcKP3/Z1d5
 CahS96lWXLeeJR1N6eI4WeewnhlVOR4H2njxkGmQ2RVb1UzhzJ476emStH/rze7x
 mKClA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=DmFuyEMtAI2d1n3c3fiXfRHFRCO5XO7yzaTwCrovl
 Xc=; b=isnM4lb48b192QOto+RWgEAbG1Rf9wmax0V8cB0VldTXKUvPBJKz0GPez
 gX7+p12S6PlXW8W1bu0rOVHvNkZiLyHXtgxFyrxzEKNrvNgGszfMskQL0wOLq5dw
 BS5obsPqfCa3KypNmm4uu+m6PFCpUmUz3TnN2DAI29+ZdtuSBqDVbyP3d+Bv1Ftw
 rNExAg8jLfMY0OxrgWmyZy5OlUDl/GNYhrLpHio7oeybAsTGsCaNapf5i96qf6Bo
 6tZHDCJfPM4p35e7guDOH+u9PJ2qNbYDHFFKW37y7OPwRQoxu1RI3Q0gp7nh2AeH
 FTqWTIxT+uqNOmU/KVo9QtZDLqESw==
X-ME-Sender: <xms:Fkk3XEWuBYGTQedQEJMnRwlAfjO6SXd9yZ6F4ASeo5m1lnjCPVhoOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeefgdehvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
 dmnecujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtredunecuhfhrohhmpefi
 rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
 elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
 mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Fkk3XM0mvigWe2f_Hgl2xGLZsdPLgHNicHUmH9fs6l_mQuiutGurIw>
 <xmx:Fkk3XDageXyOVeXNnRzuNPByOAiGCyEnuvHDXjIvbFQGIty_hEw8IQ>
 <xmx:Fkk3XHrEgNqZ8C6xgHW4gQKRHkNtOV3NxX4xuHi4RUiKmKXm_o4DlQ>
 <xmx:GUk3XEsx_ktxsCD17jH8Biu3F2XuZMAUlXVY57EVT5lzW8CmWUKCBTTlSyk>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9BD801026D;
 Thu, 10 Jan 2019 08:31:01 -0500 (EST)
Date: Thu, 10 Jan 2019 14:31:00 +0100
From: Greg KH <greg@kroah.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
Message-ID: <20190110133100.GA8738@kroah.com>
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
 <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
 <20190109175622.75525ff8@bahia.lan>
 <87h8egsnrs.fsf@concordia.ellerman.id.au>
 <d597e75e-ee71-3c1b-fcd9-2a6d65d2d251@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d597e75e-ee71-3c1b-fcd9-2a6d65d2d251@linux.ibm.com>
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
Cc: aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, stable@vger.kernel.org,
 andrew.donnellan@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 01:58:31PM +0100, Frederic Barrat wrote:
> 
> 
> Le 10/01/2019 à 13:25, Michael Ellerman a écrit :
> > Greg Kurz <groug@kaod.org> writes:
> > > On Wed, 9 Jan 2019 17:45:53 +0100
> > > Frederic Barrat <fbarrat@linux.ibm.com> wrote:
> > > 
> > > > Le 09/01/2019 à 17:25, Greg Kurz a écrit :
> > > > > On Wed,  9 Jan 2019 16:13:42 +0100
> > > > > Frederic Barrat <fbarrat@linux.ibm.com> wrote:
> > > > > > With a recent change around IOMMU group, a system with an opencapi
> > > > > > adapter is no longer booting and we get a kernel oops:
> > > > > > 
> > > > > > BUG: Kernel NULL pointer dereference at 0x00000028
> > > > > > Faulting instruction address: 0xc0000000000aa38c
> > > > > > Oops: Kernel access of bad area, sig: 7 [#1]
> > > > > > LE SMP NR_CPUS=2048 NUMA PowerNV
> > > > > > Modules linked in:
> > > > > > CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e94bec12
> > > > > > NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
> > > > > > REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001-g3bd6
> > > > > > MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  XER: 20
> > > > > > CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK: 0
> > > > > > GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf761860
> > > > > > GPR04: 0000000000000000 c000000005783834 0000000000000000 0000000000000000
> > > > > > GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 9000000002001003
> > > > > > GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 0000000000000000
> > > > > > GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000a0000
> > > > > > GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000ced978
> > > > > > GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 0000000000000000
> > > > > > GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf761860
> > > > > > NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
> > > > > > LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
> > > > > > Call Trace:
> > > > > > [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0x60/0x
> > > > > > [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
> > > > > > [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0x31c
> > > > > > [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
> > > > > > [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
> > > > > > [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
> > > > > > [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
> > > > > > [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
> > > > > > 
> > > > > > An opencapi device is using a device PE, so the current code breaks
> > > > > > because pe->pbus is not defined.
> > > > > > 
> > > > > > More generally, there's no need to define an IOMMU group for opencapi,
> > > > > > as the device sends real addresses directly (admittedly, the
> > > > > > virtualization story is yet to be written). So let's fix it by
> > > > > 
> > > > > Current plan is to go for mediated VFIO. The real HW stays under the control
> > > > > of the host ocxl driver, and we still don't need an IOMMU group.
> > > > > > skipping the IOMMU group setup for opencapi PHBs.
> > > > > > 
> > > > > > Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> > > > > > Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> > > > > > ---
> > > > > 
> > > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > > > 
> > > > > and
> > > > > 
> > > > > Cc: stable@vger.kernel.org      # v4.20
> > > > 
> > > > Thanks for the review! But why did you add stable? that problem is only
> > > > seen on 5.0-rc1, isn't it?
> > > 
> > > Based on the fact that 0bd971676e68 was committed in 4.20... but I haven't
> > > tested :)
> > 
> > It was committed to a branch based off 4.20-rc2, but it wasn't merged
> > into the 4.20 release.
> > 
> >    $ git describe --match "v[0-9]*" --contains 0bd971676e68
> >    v5.0-rc1~137^2~15
> > 
> > So it doesn't need to go to stable.
> 
> Which makes me wonder if Greg (KH) was really talking about that original
> patch and whether something worthwhile was dropped from stable by mistake?

Totally different thread, sorry for the noise, my fault...

greg k-h

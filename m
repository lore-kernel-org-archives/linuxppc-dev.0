Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBAC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:15:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208542089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="KrNOHCVL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GM09XKtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208542089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pqnS2KJJzDqVm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="KrNOHCVL"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="GM09XKtf"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pqlW4ZRzzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:14:15 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 9485D417;
 Wed, 24 Apr 2019 02:14:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 24 Apr 2019 02:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 ItKqlgGhNbEwnIA/XlggYfsnzJ4yFj+g3UpTRHjLHC4=; b=KrNOHCVLCc5A2XLo
 x5hZcblCCunX0MiJoaPXhCqbdDyRnJM68iTj3VX4O42vTfUDr2oQP721RSy6gVDH
 xhsXDQYRVs6XuPRjb5+7Sr3Yz3XVe44SiS2+B/POoNGt0oOXYmE2axOKeNrmvn+j
 MYhpVb3ysqic3qww9/WdG0l3rV3TyDNRStbA6AhAubkddReKECU47tfU3NtNJvvK
 FXmpZGth3MrGWns2cYUQ/ef1xOk5NOersdaZmH/j+ISBD8lz8aTXgj/9/fuBYPDo
 YWySEAOA2tf8tdXadi5BI5a/bFTLJF6/s+8VcvKWBz355CXboX6Ln1ULtGmSEH1Z
 54zXgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=ItKqlgGhNbEwnIA/XlggYfsnzJ4yFj+g3UpTRHjLH
 C4=; b=GM09XKtfRAHjTSIKRsownXYymnSVre+eSqErIaowItjJ6S1/iHeVMdy11
 zZuhhFlNktdEPw9OI6NrQIv1EadqO0WFoz0rpo4TChvEcFiX1IJSFm5pO5vdaL8q
 XsOGXs9Vv0qGRuSn3AnGduFa1T/AUhwJzE0huIQmFR5n5J40nuGK4Zy8b4qa9TTd
 O4T7qpqztKdeEhRxauOuiGLxZZ+Mg8eF3WwFKS3Pl2VzAdpU7p1A5kvBCrK316f0
 WfEfXkHjFDqe4vQxp/uPnTS1d5NeyohNO+MU1As6TdC1POeSPDPo8yldN/M11BBj
 QsYQrZlJVPlvmPhmU3UsX7JKtO/Yg==
X-ME-Sender: <xms:sf6_XM38fnd0-Q6PTkFmx92RwzrCrqWaLieknWVCihdImXoR_TX8hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeelgddutdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdluddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusghu
 shgvrhgtohhnthgvnhhtrdgtohhmpddtuddrohhrghenucfkphepuddvvddrleelrdekvd
 druddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdr
 tggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:sf6_XHTHdv_lzoGIWHoW2TF2rsIKyhC1lsHp00zBIOgj06MX6F8LKA>
 <xmx:sf6_XGttjxtPUGsTjxL75m9aLfbXdoljxRDw_Tc84f22ENcNTEoo1g>
 <xmx:sf6_XEY2yiqFkeNMQhdu9qFH82cMMqA1rOemwZhcmDCY9jZjJSxrfg>
 <xmx:s_6_XAqFwnV63g2ffrN5i1nXk8ESFTzqyib1OK6QU6HLQhiTwfpLDQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id B564810319;
 Wed, 24 Apr 2019 02:14:07 -0400 (EDT)
Message-ID: <ce7a8e63c5e7506f910978a62cdad0251d7bc54f.camel@russell.cc>
Subject: Re: [powerpc:next-test 40/58] WARNING: vmlinux.o(.text+0xb038):
 Section mismatch in reference from the function setup_kup() to the function
 .init.text:setup_kuep()
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Wed, 24 Apr 2019 16:14:05 +1000
In-Reply-To: <1d55b63d-3f7d-b8f5-03c8-ac59a3a98acf@c-s.fr>
References: <201904220037.le30gXgO%lkp@intel.com>
 <1d55b63d-3f7d-b8f5-03c8-ac59a3a98acf@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild test robot <lkp@intel.com>,
 kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-04-23 at 14:13 +0200, Christophe Leroy wrote:
> Russel, Michael,
> 
> Looks like the reported problem comes from b28c97505eb1
> ("powerpc/64: 
> Setup KUP on secondary CPUs") 
> (
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=b28c97505eb1a5265e367c398c3406be6ce5e313
> )
> 
> Is it really necessary to remove the __init tag on setup_kup() ?

I don't think so, this was probably a mistake on my end, or something I
was testing and left in.  I'll put it back in and test to make sure it
doesn't break anything.

- Russell

> 
> Christophe
> 
> Le 21/04/2019 à 18:23, kbuild test robot a écrit :
> > tree:   
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
> > next-test
> > head:   26ad26718dfaa7cf49d106d212ebf2370076c253
> > commit: 06fbe81b5909847aa13f9c86c2b6f9bbc5c2795b [40/58]
> > powerpc/8xx: Add Kernel Userspace Execution Prevention
> > config: powerpc-mpc885_ads_defconfig (attached as .config)
> > compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >          wget 
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          git checkout 06fbe81b5909847aa13f9c86c2b6f9bbc5c2795b
> >          # save the attached .config to linux build tree
> >          GCC_VERSION=7.2.0 make.cross ARCH=powerpc
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > WARNING: vmlinux.o(.text+0xb038): Section mismatch in reference
> > > > from the function setup_kup() to the function
> > > > .init.text:setup_kuep()
> >     The function setup_kup() references
> >     the function __init setup_kuep().
> >     This is often because setup_kup lacks a __init
> >     annotation or the annotation of setup_kuep is wrong.
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source
> > Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel
> > Corporation
> > 


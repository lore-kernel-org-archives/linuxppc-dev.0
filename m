Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A682C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 22:40:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A962173B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 22:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="fgap+lk+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FSLDku7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A962173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wYD81y3jzDqTw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:40:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="fgap+lk+"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="FSLDku7y"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wYBF74PNzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 09:38:28 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 19B1A220EE;
 Thu,  7 Feb 2019 17:38:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 07 Feb 2019 17:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 x4TKNzHj0Gy+yN+yACU8i0100YqicrHFFcMz4rYNEG4=; b=fgap+lk+PQIFNwrI
 tFf5UkHFkUq+hA6YAN7LbFWvRiEDfwkcDS5W/3NAqAV3BXZNklw+AuDAdIL4zHPg
 5qlsYApcSxxMqVFCF/FNeVorxJSLXIolgVvOWdZg6PTlwwGDeFiGu/CiuZuHL6Rv
 go4ycf9nY1jXeoFMKA4QtNGsah7UmL5dceyhS8fsPWHpVQI89w+R97yasHDclWO8
 eFLHTD3/GbeCAcrWwPTYk4vozoQmk9VCjVMEaTetQoSkUQ4B9W4LqTBwJ9m1wrTd
 2tP3nJuaPNtaGKx6881xPBH6n0rA/8bkmRXggmyiPFNDTIU4xZ5lUzYyTdWlq5Au
 SFtD8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=x4TKNzHj0Gy+yN+yACU8i0100YqicrHFFcMz4rYNE
 G4=; b=FSLDku7yPJ7NAqPRavXaxhyHt8foFoKkDagwuamL4J6ncaWKCl2/o3bNw
 qDa53j/ndRJKchw3gGJrXCG+iV5Us9CnW9HwbBmmlEkRnZQxtCUQH00ZzCDHh6Dw
 BXOE+G85TYDNLekUSkT7xfh6d9cjNawXQPpvoIVviOrFLffSdSEf3fTs7/hYceBp
 wIyGBSlsxZPH00t4DASj27MuTccB3uP1sRjkwpt/fVxRA5toWz+VM9eqiIHLOBKh
 PH/PlO6UG26+gnQVv16DHeG6ndKYT3y5F5imosOG2kXnTcatuHas+7luHO48+niz
 xXHegmhVLrgDjY3jEXHCbhl2K2dLQ==
X-ME-Sender: <xms:YbNcXEv1KeezaeE80or6P13i_oa_GMZf_JBxslC2W4_AZ2HpyFDhIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledtgdduieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftd
 dmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhu
 shhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukf
 hppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgt
 uhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:YbNcXIVOxLS84V0_GZCkhNTSDerA8JJGKliqjXSBE1cOnFzB_Z_L6A>
 <xmx:YbNcXMttThkOLUj44wE5IGNTgSg1dlSDyqpIqajXEiZqrI2pL-flwA>
 <xmx:YbNcXEUrAOzYvYvj6sKdEB9rQCWAzXFUDHRDGumUL_KzcxFKJf21qw>
 <xmx:YrNcXIdLm7VgrmTv5eQqN83bObHUsLxApaA2kTEeFKIbVT-fcjViQA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 139891030F;
 Thu,  7 Feb 2019 17:38:23 -0500 (EST)
Message-ID: <1695be3f58d484d52d27a4ef438dd54e0efffb05.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Fri, 08 Feb 2019 09:38:20 +1100
In-Reply-To: <878syrlfnf.fsf@morokweng.localdomain>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
 <d7e1bb36080c83353525c39c7bcff7bb7046bae0.camel@russell.cc>
 <878syrlfnf.fsf@morokweng.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-07 at 14:37 -0200, Thiago Jung Bauermann wrote:
> Russell Currey <ruscur@russell.cc> writes:
> > On Thu, 2019-02-07 at 15:08 +1000, Nicholas Piggin wrote:
> > > Russell Currey's on February 6, 2019 4:28 pm:
> > > > 
> > > > Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel
> > > > execution of
> > > > user
> > > > space")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > 
> > > Good catch and debugging. This really should be a quirk, we don't
> > > want
> > > to have to restore this thing on a thread switch.
> > > 
> > > Can we put it under a CONFIG option if we're not using IAMR?
> > 
> > I don't exactly know when we do or don't use the IAMR (since the
> > only
> > thing I've used it for is radix).  When wouldn't we care about
> > restoring it on hash?
> 
> On hash it's used for memory protection keys (code is in
> arch/powerpc/mm/pkeys.c). The kernel doesn't use protection keys, but
> userspace apps may use it explicitly via specific syscalls
> (pkey_alloc(), pkey_mprotect, pkey_free()).
> 
> Also, the kernel may use a protection key if the process does an
> mmap(PROT_EXEC).

I don't understand how this would work, though - in this case we
wouldn't know on boot if we were going to use the IAMR or not.  On
radix (unless booting with nosmep) it would always be used, but on hash
it seems it depends on what userspace does.  How exactly would a
runtime toggle of "IAMR in use" work?

With a CONFIG option it would have to depend on PPC_MEM_KEYS ||
PPC_RADIX_MMU, but those are (pretty much) always going to be on in P8
and P9, which I already check for.

> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 


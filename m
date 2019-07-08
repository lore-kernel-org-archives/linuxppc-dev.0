Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DADCC606BD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 17:53:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F942166E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 17:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="SMv5qvh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F942166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jCjm1wFTzDqTV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 03:53:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="SMv5qvh1"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jCgt20JszDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 03:51:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date;
 bh=kBHi8AK8xJRxLevoFHJtFm5kgrynv2XaZVmm/hsbrWU=; b=SMv5qvh1GkD/fjVjTTT/eKKT6h
 X0w2xVspnXsCfwVIaUoODlVfjR/cHymichkQeMzH/FAKphiG5oS0SqtbxevoggIYX45AfLT+Xr/uF
 IMpTKNhdmcOTxM8ndpL4x71Hk3mJfKaxgtUCPkPlXc2MctjWLsz3ljWjs943e0cCQDMU=;
Received: from [134.3.44.134] (helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hkXni-0002H5-S0; Mon, 08 Jul 2019 19:51:42 +0200
Date: Mon, 8 Jul 2019 19:51:39 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH using git format-patch -C] kexec: add generic support for
 elf kernel images
Message-ID: <20190708175139.GA11402@t470p.stackframe.org>
References: <20190708100624.EBCDF68DB2@pc17473vm.idsi0.si.c-s.fr>
 <e016c0bb-c857-b78c-a159-120e42d0db03@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e016c0bb-c857-b78c-a159-120e42d0db03@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, kexec@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On Mon, Jul 08, 2019 at 12:40:52PM +0200, Christophe Leroy wrote:
> > From: Sven Schnelle <svens@stackframe.org>
> 
> Please describe you patch.
> 
> All the changes you are doing to the ppc64 version in order to make it
> generic should be described.
> 
> Those changes are also maybe worth splitting the patch in several parts,
> either preparing the ppc64 for generic then moving to kernel/kexec_elf.c or
> moving to kernel/kexec_elf.c without modifications, then modifying it to
> make it generic.
> 
> Note that your patch only applies on Linux 5.1, it doesn't apply on
> powerpc/next.
> 
> I think it also be worth taking the opportunity to fix the sparse warnings,
> see https://patchwork.ozlabs.org/patch/1128720/
> 
> checkpatch comments should also be fixed, see https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/8044//artifact/linux/checkpatch.log

Actually this patch shouldn't have been sent out, that was my fault. Appologies
for that. Thanks for your review, i will split up the patch and resent it.

Regards
Sven

Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A667C10F05
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D12075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D12075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TRTG4R7fzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 10:01:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TRRC3Yd5zDqFw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 09:59:51 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2QMxTkM010159;
 Tue, 26 Mar 2019 17:59:31 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2QMxPEY010155;
 Tue, 26 Mar 2019 17:59:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 26 Mar 2019 17:59:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
Message-ID: <20190326225924.GX3969@gate.crashing.org>
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
 <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
 <20190326181914.GS3969@gate.crashing.org>
 <5f4aa4b2-1c44-70b9-c383-5d40aecd695c@c-s.fr>
 <20190326201231.GV3969@gate.crashing.org>
 <20190326222941.GW3969@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326222941.GW3969@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 26, 2019 at 05:29:43PM -0500, Segher Boessenkool wrote:
> On Tue, Mar 26, 2019 at 03:12:31PM -0500, Segher Boessenkool wrote:
> > On Tue, Mar 26, 2019 at 08:28:58PM +0100, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 26/03/2019 à 19:19, Segher Boessenkool a écrit :
> > > >On Tue, Mar 26, 2019 at 07:55:33AM +0000, Christophe Leroy wrote:
> > > >>    STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
> > > >>          filesz 0x00000000 memsz 0x00000000 flags rwx
> > > >
> > > >You need to prevent this one somehow.  What object file forces this?
> > > 
> > > mpc885_ads_defconfig
> > 
> > No, which object file, ".o file".  Not defconfig :-)
> 
> I tried to reproduce this.  It does not fail with a ppc6xx_defconfig
> build, and mpc885_ads_defconfig fails with
> 
> INFO: Uncompressed kernel (size 0x435178) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x500000)
> ln: failed to access 'arch/powerpc/boot/cuImage.mpc885ads': No such file or directory

(Fixed this by getting a working mkimage)

> What is your GCC?

That question remains -- all my powerpc kernel builds work just fine with
that patch applied (recent GCC, recent binutils).


Segher

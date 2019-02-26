Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C29C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 22:26:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C372146F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 22:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="xgiSD0Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C372146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448D1g6CvPzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:26:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Cz1736GzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 09:24:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="xgiSD0Nn"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 448Cz15Jzqz9s71; Wed, 27 Feb 2019 09:24:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551219853; bh=YjQ+L8f4zeePcqAA3Wxa3G0/mN53ATFx5ZaBFER/4Ss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xgiSD0NnUXxLUPuI85XdTSM/F5ZLE0UErrH4H3FPOazzJg0gcbK5dVoOd5vI21zjP
 C18qT86GI9cNDaklIbN/GebUQ4xzvAEyKrDXfFpyhrMeILowU9n1ROjaDFbgCR62WI
 IvqRXRx8eY0E4hn/yqKA4pje7eJrQ4wCoZ1aJzAq3mtY4L8BPJqik7j4iPi9RKr7xn
 CG1V9b2P8izEVBWlyqjIzs9t8A8Zx0BnWgOFeWp8PrXNwFlzWkgyDsNRUYeP9PsBD0
 V+otGfPN4Z0wg4RhOM6ANYBFiiDAAtZqG41SIE/sXA6qcnsNA/2OV+iTMUYh0h9F8W
 I+7xIfNcoYuoQ==
Date: Wed, 27 Feb 2019 09:24:08 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: build failure of current mmotm with skiroot_defconfig
Message-ID: <20190226222408.GE28015@blackberry>
References: <20190226081224.GA11981@rapoport-lnx>
 <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
 <20190226095908.GD11981@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226095908.GD11981@rapoport-lnx>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 11:59:08AM +0200, Mike Rapoport wrote:
> On Tue, Feb 26, 2019 at 10:39:54AM +0100, Christophe Leroy wrote:
> > 
> > 
> > Le 26/02/2019 à 09:12, Mike Rapoport a écrit :
> > >Hi,
> > >
> > >I've encountered the following error when building skyroot_defconfig with
> > >current mmotm tree:
> > >
> > >make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux- ARCH=powerpc vmlinux
> > >   ...
> > >   CC      arch/powerpc/kernel/dbell.o
> > >In file included from arch/powerpc/kernel/dbell.c:20:
> > >arch/powerpc/include/asm/kvm_ppc.h: In function 'xics_on_xive':
> > >arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function 'xive_enabled'; did you mean 'eeh_enabled'? [-Werror=implicit-function-declaration]
> > >   return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
> > >          ^~~~~~~~~~~~
> > >          eeh_enabled
> > 
> > I can neither find the above in arch/powerpc/include/asm/kvm_ppc.h in the
> > powerpc tree, nor a patch removing it.
> > 
> > Where does that comes from ?
> 
> It's from current mmotm, probably some merge conflict...

It's not a merge conflict; see http://patchwork.ozlabs.org/patch/1048584/
for the fix.

Paul.

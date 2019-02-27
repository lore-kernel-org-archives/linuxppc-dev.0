Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 11:15:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FDF20851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 11:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="nWq+ca+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Y4z4XX5zDqLW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 22:15:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Y2P0GV5zDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 22:13:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="nWq+ca+m"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 448Y2N4J3dz9s71; Wed, 27 Feb 2019 22:13:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551265996; bh=jC/ODDt77XgUnmv0+h3hiUubSfcCmoBo8QmKQJwqsok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nWq+ca+mbpeFjXVrXumC6EldBhN2z+LaOsdTJXC0bmnFM/lxLGguPkMdivansPokh
 /7UQhOmzH6+bv1zTRw15OcLEk5w34TdrMwGrvaQN+QLeSsoQrU3f8ZvVjOaZVBA5ss
 +egNGRAndC0ZQMxXhH8uW7QF7fFSx0l6gULTBExikrqghK50dnGpPgz5wOO6Wr0Ihc
 fSox5YjE+77M1UcZsNGFtHMYKUUUt9kadBb+hiW4VTfJBtHwOqfxFPM2YNiIpJvMuU
 S80rlikwBjYJIJn6/cEW8hQyLGQx1GbTsRY6JGR8RN1GOQik5dQzX3NUO74Ys+PbvV
 nUVeLjjian3cA==
Date: Wed, 27 Feb 2019 22:13:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: build failure of current mmotm with skiroot_defconfig
Message-ID: <20190227111314.GA15195@blackberry>
References: <20190226081224.GA11981@rapoport-lnx>
 <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
 <20190226095908.GD11981@rapoport-lnx>
 <20190226222408.GE28015@blackberry>
 <fea8a5ef-2c90-8222-fc80-3ae77a2fd473@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fea8a5ef-2c90-8222-fc80-3ae77a2fd473@c-s.fr>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 07:41:21AM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/02/2019 à 23:24, Paul Mackerras a écrit :
> >On Tue, Feb 26, 2019 at 11:59:08AM +0200, Mike Rapoport wrote:
> >>On Tue, Feb 26, 2019 at 10:39:54AM +0100, Christophe Leroy wrote:
> >>>
> >>>
> >>>Le 26/02/2019 à 09:12, Mike Rapoport a écrit :
> >>>>Hi,
> >>>>
> >>>>I've encountered the following error when building skyroot_defconfig with
> >>>>current mmotm tree:
> >>>>
> >>>>make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux- ARCH=powerpc vmlinux
> >>>>   ...
> >>>>   CC      arch/powerpc/kernel/dbell.o
> >>>>In file included from arch/powerpc/kernel/dbell.c:20:
> >>>>arch/powerpc/include/asm/kvm_ppc.h: In function 'xics_on_xive':
> >>>>arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function 'xive_enabled'; did you mean 'eeh_enabled'? [-Werror=implicit-function-declaration]
> >>>>   return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
> >>>>          ^~~~~~~~~~~~
> >>>>          eeh_enabled
> >>>
> >>>I can neither find the above in arch/powerpc/include/asm/kvm_ppc.h in the
> >>>powerpc tree, nor a patch removing it.
> >>>
> >>>Where does that comes from ?
> >>
> >>It's from current mmotm, probably some merge conflict...
> >
> >It's not a merge conflict; see http://patchwork.ozlabs.org/patch/1048584/
> >for the fix.
> >
> 
> Why not include asm/xive.h all the time, as it defines xive_enabled() for
> when CONFIG_PPC_XIVE is set and for when it is not set ?

I wasn't sure it wouldn't break the build for 32-bit configs.

Paul.

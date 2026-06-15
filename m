Return-Path: <linuxppc-dev+bounces-22634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B769FCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 10:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf6Dd6M0bz3btX;
	Mon, 15 Jun 2026 20:44:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781520241;
	cv=none; b=np1xo/o5wCV34A99mn1s14RmX/HmwQOFEh6kOl0as6NfLajnoJROYRlcvmPrdw3WnALwYFBpvvEGzERapd/L6nr12fZ4+tnlvRi58j25s+WZYctMYg1B5GRf2szXWcV3AHswfnr3eQNKZmmpn9jL/WQ2+5PkVkNLYjf2DVh/Fj/YRDXajaI2CV3d3KsbNQk20nd7tTvBf8dNrwdAW+krcyi+yE5nLIhE5sTJ/d8v9Bag++YAmXYu1kXaYanimSveYdhgeDWbfkoGoNF9z4cWyh88aAyCbgE8KYncZKcSTUMzN8JKh29cyhn/Y3W26xILyFEcvYCpDoocA7gB1nI0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781520241; c=relaxed/relaxed;
	bh=ajv2htXleqTxwdGJhByWHot1ucPx4y8cfx13bd+P3Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3Sb5oG6ApEE5YTDIXL4Dp0gzYUCjXVEKRKLJdC2oLookP6WaXPR9fqA9RwecAUHKlKXx5+I8h+Zl+aiQrHByuH3wnCBca3eYBjOp0CMtK2vL7/h4Lkpri+k49CmApxNsCvXf00VrIlYSoxebxJ2Ad7wJGiPQZkg888BPlnJQYo4i9HkCUwBwjsfSYrONQZEEokWBxTIAywb56GkCjKNseOlh4VQAQHBggP3k0jqYXHiZIr2dp5r232s5zRwrvEBRwzzxaQLiPXyYUsrMC5Z56NF2daXsHo794Mz/tElqP5olVOdxBZzSRwhGv+DnL16o1SLU4x5cl8n5DFFCIKoaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass (client-ip=193.175.24.41; helo=elvis.franken.de; envelope-from=tsbogend@alpha.franken.de; receiver=lists.ozlabs.org) smtp.mailfrom=alpha.franken.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alpha.franken.de (client-ip=193.175.24.41; helo=elvis.franken.de; envelope-from=tsbogend@alpha.franken.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 511 seconds by postgrey-1.37 at boromir; Mon, 15 Jun 2026 20:43:59 AEST
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf6Db5jmTz3btJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 20:43:59 +1000 (AEST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1wZ4ey-0000JT-00; Mon, 15 Jun 2026 12:35:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 66FD9C0650; Mon, 15 Jun 2026 12:28:02 +0200 (CEST)
Date: Mon, 15 Jun 2026 12:28:02 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Catalin Iacob <iacobcatalin@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mips: Remove remaining defconfig references to
 the pktcdvd driver
Message-ID: <ai_TsvPSc6dUt2-X@alpha.franken.de>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
 <20260608-remove-pktcdvd-references-v4-2-72f88b04cc87@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-remove-pktcdvd-references-v4-2-72f88b04cc87@gmail.com>

On Mon, Jun 08, 2026 at 05:29:17PM +0300, Catalin Iacob wrote:
> Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
> CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.
> 
> Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
> ---
>  arch/mips/configs/fuloong2e_defconfig    | 1 -
>  arch/mips/configs/ip22_defconfig         | 1 -
>  arch/mips/configs/ip27_defconfig         | 1 -
>  arch/mips/configs/ip30_defconfig         | 1 -
>  arch/mips/configs/jazz_defconfig         | 1 -
>  arch/mips/configs/malta_defconfig        | 1 -
>  arch/mips/configs/malta_kvm_defconfig    | 1 -
>  arch/mips/configs/maltaup_xpa_defconfig  | 1 -
>  arch/mips/configs/rm200_defconfig        | 1 -
>  arch/mips/configs/sb1250_swarm_defconfig | 1 -
>  10 files changed, 10 deletions(-)

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


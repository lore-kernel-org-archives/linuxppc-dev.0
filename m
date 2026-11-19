Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD47606A33A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:18:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVkCX2m7nz2xH7;
	Fri, 20 Nov 2026 03:18:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795105080;
	cv=none; b=WMuCEzsBP8SlnG4xeubvxThHqgMX4DY0vW8Vr0mJNV1nBm36rbE55c0cBCZ+AJXUDWZfTuPh/1n96h2NpLlR5OS9Uxq+TsiRkO3JsLha50QK2pj0zTO2AcQctkK7d8MbOAVZHq+/r6Du3Wj5l1K+b+MwXC5OC5GG+5g++XJO1w1Hldx/phZmYdgLeHuk3nF8Ah25gqp1/o1ujCB/9skorxb9MWoMSmA172GeO/e9Su+SDKylVmmT/aXM+XJKZkUvj3+U8pmOb730B/qLa9WzdRqAEwt+WwMHKw78pbehhip7DDZrIbP59HAmOkAyHgSLJt6Hye48ZsREoWJ+eDGzow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795105080; c=relaxed/relaxed;
	bh=4HNCrNhLNHDk75H36/a1/Y0v6HUk6DdKnxxYSjc/BiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LOkn72YrFK2wA56ObxLYHpwzzcSiIGe7qheonjodItsH14fCRmZgSR9XMPIOpleiHjfWqN/m1jGqZ80kTU4TgGGmfbbN8uc2w5FCkCHLI88XbjKOpCqQVm7kJErKf1x6mk8Apv3uoByl6ITDSEiXpJRB7quuWJpHRGby3Cx9yi5DdpKjxTZa/bCpPGgMPjK8uF/6/TTplpkg+W8m75R4TZ/4mURioSoozfWfnfrvx7UM+NAy4uhyPLb/s91oXh6bxvRcbB9bOD2voOhSmYk2g8t64UXs/tKAI5V5KT46qmaalpptk2tGO5oy8LhJuFhYQ2LXEeGxb8NjgU5gOU3Ogg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVkCV5dmhz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 03:17:58 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 7C625E8;
	Thu, 19 Nov 2026 17:17:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 7C625E8
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id F391819A005;
	Thu, 19 Nov 2026 17:17:53 +0100 (CET)
Date: Thu, 19 Nov 2026 17:17:53 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: WARNING: mm/slub.c:5459 at ___kmalloc_large_node in 7.4-rc3
Message-Id: <20261119171753.f69a07d6dd21c0c484237762@danny.cz>
In-Reply-To: <7bi9kllm.ritesh.list@gmail.com>
References: <20261119132833.cf48ab8d95a8be3b900332e2@danny.cz>
	<7bi9kllm.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

On Thu, 19 Nov 2026 18:46:21 +0530
Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Dan Horák <dan@danny.cz> writes:
> 
> > Hi,
> >
> > I am seeing "WARNING: mm/slub.c:5459 at ___kmalloc_large_node" when
> > booting 7.4-rc3 on my Power9 based Talos system. The warning wasn't
> > present in 7.4-rc1. Is it something known or should I try bisecting?
> >
> > lis 19 08:02:43 talos.danny.cz kernel: WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x1a4/0x200, CPU#60: swapper/60/1
> 
> I think this patch should fix it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=126b47221b7b98d83c118781ce724c0515d86d9c
> 
> Could you give it a try?

thanks for the pointer, the warning went away with fix applied.


		Dan


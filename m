Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F0C4332D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 09:51:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8404B20722
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="P5t7qg+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8404B20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jhy14RxqzDrBJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 20:51:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jhvx5M6PzDqwV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 20:49:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=P5t7qg+u; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48jhvw5NCyz9sPF;
 Thu, 19 Mar 2020 20:49:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584611389;
 bh=D+Q6J/bh0fif9u1z1m+OOV+M4Bo54jJdaeTGMRX6pe0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=P5t7qg+uFhsXVHj/dGsqwMeHcyT0zb6aCcAP9pCh9sU5LJNryN893v2fqhEN4BqX4
 S3GXGk+rHMaXEOQsacD7MF0Bx5B6TshTYYqYo6ToQMeuLZji/+1ZtQKdyI/rQEGl2h
 pvOsSqItdZeRFJPJ/9eGRLiBr46Johep5VQGxzU2B01YhqNzaKmgx1hPx6gp699FY0
 HqwgCGwc62dtUWU1+rd3NgbkuL5H0S9ICvAo2aqnrd0eKi8ciEPL92vpKdVWnx7fQ5
 3/Aab35W1AEhGldn8upttkR191P6KVZJdVc9H0tYu+++o/In27Fj9LfbXVtvov7Qpa
 X6r19DYk3RAbg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] powernv/memtrace: always online added memory blocks
In-Reply-To: <20200317104942.11178-5-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-5-david@redhat.com>
Date: Thu, 19 Mar 2020 20:49:47 +1100
Message-ID: <8736a4eksk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-hyperv@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Hildenbrand <david@redhat.com> writes:
> Let's always try to online the re-added memory blocks. In case add_memory()
> already onlined the added memory blocks, the first device_online() call
> will fail and stop processing the remaining memory blocks.
>
> This avoids manually having to check memhp_auto_online.
>
> Note: PPC always onlines all hotplugged memory directly from the kernel
> as well - something that is handled by user space on other
> architectures.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Fine by me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index d6d64f8718e6..13b369d2cc45 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -231,16 +231,10 @@ static int memtrace_online(void)
>  			continue;
>  		}
>  
> -		/*
> -		 * If kernel isn't compiled with the auto online option
> -		 * we need to online the memory ourselves.
> -		 */
> -		if (!memhp_auto_online) {
> -			lock_device_hotplug();
> -			walk_memory_blocks(ent->start, ent->size, NULL,
> -					   online_mem_block);
> -			unlock_device_hotplug();
> -		}
> +		lock_device_hotplug();
> +		walk_memory_blocks(ent->start, ent->size, NULL,
> +				   online_mem_block);
> +		unlock_device_hotplug();
>  
>  		/*
>  		 * Memory was added successfully so clean up references to it
> -- 
> 2.24.1

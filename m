Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5930FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 08:18:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A3C61108
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1A3C61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQ42d1qTPz3029
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 19:18:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p/Sjmspu;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7GACDCT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=osalvador@suse.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=p/Sjmspu; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=d7GACDCT; 
 dkim-atps=neutral
X-Greylist: delayed 502 seconds by postgrey-1.36 at boromir;
 Thu, 07 Oct 2021 19:17:35 AEDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQ41q3bXqz2xrD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2021 19:17:35 +1100 (AEDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CFFE225F4;
 Thu,  7 Oct 2021 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633594146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZ78DbAR+r/e/r6GYTwg4MxP7fk6xf1yQWORN1dcpaw=;
 b=p/Sjmspufjnzjjein9NvN3QmLYZhdyAyB0P0BiEw/nO0oDKX6ZKsoQDpDfFMhkcKuArLRN
 fPH4WEuNCqaQ9xxgOiNhGRVVrXuN1qC+dLhq3H65JcZz//9vtSrXeX6sw73n9G6uYsPW0s
 2H+6gC3mhVlYrBwHlU2eArtih6Dm2FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633594146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZ78DbAR+r/e/r6GYTwg4MxP7fk6xf1yQWORN1dcpaw=;
 b=d7GACDCTta4X67QvurOXYEnWzqbvKqOo3kXRGX7FXuY1MWnD0h4KBmo3KUWYLvUGJahujc
 q2Aj7atscFaMIcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC2813A9B;
 Thu,  7 Oct 2021 08:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i1ruByGrXmEPEAAAMHmgww
 (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 08:09:05 +0000
Date: Thu, 7 Oct 2021 10:09:03 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 1/6] mm/memory_hotplug: remove CONFIG_X86_64_ACPI_NUMA
 dependency from CONFIG_MEMORY_HOTPLUG
Message-ID: <YV6rH31mpJG0WLLQ@localhost.localdomain>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-2-david@redhat.com>
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
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Jason Wang <jasowang@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 29, 2021 at 04:35:55PM +0200, David Hildenbrand wrote:
> SPARSEMEM is the only possible memory model for x86-64, FLATMEM is not
> possible:
> 	config ARCH_FLATMEM_ENABLE
> 		def_bool y
> 		depends on X86_32 && !NUMA
> 
> And X86_64_ACPI_NUMA (obviously) only supports x86-64:
> 	config X86_64_ACPI_NUMA
> 		def_bool y
> 		depends on X86_64 && NUMA && ACPI && PCI
> 
> Let's just remove the CONFIG_X86_64_ACPI_NUMA dependency, as it does no
> longer make sense.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d16ba9249bc5..b7fb3f0b485e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -123,7 +123,7 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
>  config MEMORY_HOTPLUG
>  	bool "Allow for memory hot-add"
>  	select MEMORY_ISOLATION
> -	depends on SPARSEMEM || X86_64_ACPI_NUMA
> +	depends on SPARSEMEM
>  	depends on ARCH_ENABLE_MEMORY_HOTPLUG
>  	depends on 64BIT || BROKEN
>  	select NUMA_KEEP_MEMINFO if NUMA
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs

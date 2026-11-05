Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B36606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j2sTp789
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKm8h6rPtz2xNC;
	Thu, 05 Nov 2026 13:14:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::27"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793844868;
	cv=none; b=fq9QoV5y9zuMgjZN16WXtVqe+VTbLGgRZYloAXO204WkCbGyAJ4cnVjdU02wTCLByD22B1x6AxEq4SPHQpmJ09QIqkBZ+B1NoT+jVO89bP5dvkWVH1czu0Gknt4BU114G1CqBc/x0qW7fcfCGIqEQBOypT0cXlp++HdF/1r0q/LD+gXd9vKXjBZ6GyHeCa/yfKUl4r0lqiDKgs32we1YM7IdlgkdnHWBEN3wujcBNdsly9k6pyKg1tFwcjFOL4/wc+cdHHFKHNmjv4z72NrTI1FUZCnC+RNF7d9XdcSxpoaHVb+bu940fxiAWBS3HgYPg/S3ePfaOv9+PKBqwJt7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793844868; c=relaxed/relaxed;
	bh=tXeq94tKXH8bHOz1amsH5XRU51n2PYOOTkgxfF1PjyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6Dl9bWQNDBrW4Tw4xigJcRg86DJrned2Wt+f8JL5hubr01u1d1qgH/dPPi6Ynf8kj/mpQoBLcibGENgzwryZU+0mQWxuzfN7KJ+Eo5OpbNMEk46qWf0x+8Eb3EzyaNREGChPcrRQaNGB6krzBvfhVoFFj3Q1e2EAZpIEiucPxdghydsP7Y5Nkcu97DYnTX4QIDNcoZidxHcHzH7TvCWVIG5ge2u1oZm5H7Nouv6pz+QIce4IKtD+j0RoiDoz3fbOn6ctGRV2o04U/LCyce/ymhixfnSLqM+IFx9RMXlF9Bx8fzng83uETOCxLLqrG7fFM0C0onxQi1vJXqBAX2PeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j2sTp789; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::27; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j2sTp789;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::27; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKm8d6hjxz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 13:14:23 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=l5hRS8qgzR0WOCPLF0tQbQ+of37lp1oZsgw+XUQqwhg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793844844; v=1; x=1794449644;
 b=j2sTp789TAzH4+lGZ7lYWfaDwj4tzc9cwnz9VymVYz+93eIx1j2P1wIewQP0NcIfVbJQKLyf
 0DO8NIIghKzDouBSBnDym1wAnQyGpqJsD9irj2dQSZrGObeDZJB96QtjMGxheDIwPErfv1cfpzT
 zdnAQ3fG/Xx2Ge3hDWonFfXo=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 7ce234fbb2517b84;
	Thu, 05 Nov 2026 02:14:03 +0000
X-Mizu-Trace-ID: 7ce234fbb2517b84
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc4939cc-84ec-4c5c-88a7-658ca800377d@linux.dev>
Date: Thu, 5 Nov 2026 10:15:13 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo
 under the codetag module lock
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org,
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>,
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>,
 stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cc Suren

Hi Christian

On 2026/11/5 03:06, Christian Brauner wrote:
> codetag_alloc_module_section() takes the codetag type's mod_lock for
> writing and calls reserve_module_tags() with it held. When that can't
> reserve the tags, because the section's alignment doesn't fit, because
> there are too many tags for the page flag bits or because the memory
> for them can't be allocated, it shuts memory allocation profiling down
> and removes /proc/allocinfo, still with mod_lock held.
> 
> remove_proc_entry() waits until every reader of the entry has let go of
> it, and a reader of /proc/allocinfo takes mod_lock for reading in
> allocinfo_start() while it holds the entry. So a module load that hits
> one of those paths while /proc/allocinfo is being read waits for the
> reader and the reader waits for the module load, for good.
> 
> Let a work item remove the entry in that case. The profiling is shut
> down right away like before, the file just goes a moment later.
> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks.

is this a problem you have hit in practice?
Sashiko discovered this issue earlier and reported it as follows:

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe106..112a014d4b890 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  		int grow_res;
>  
>  		module_tags.size = offset + size;
> -		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
> +		if (!tags_addressable()) {
>  			shutdown_mem_profiling(true);
This is a pre-existing issue, but does this shutdown_mem_profiling(true) call
introduce an AB-BA deadlock between /proc/allocinfo file readers (pde->in_use)
and module loading (cttype->mod_lock)?
A user reading /proc/allocinfo acquires the procfs in_use reference in
use_pde(), then blocks on down_read(&alloc_tag_cttype->mod_lock) in
allocinfo_start().
Concurrently, if a module loads and tags_addressable() fails,
codetag_alloc_module_section() holds down_write(&cttype->mod_lock) and calls
shutdown_mem_profiling(true), which removes the proc entry. This removal waits
indefinitely for the in_use reference to drop to zero, hanging both procfs
reads and module loading.
> -			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> -				mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> +				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +			release_module_tags(mod, false);
> +			return ERR_PTR(-EAGAIN);
>  		}
>  
>  		grow_res = vm_module_tags_populate();

I previously sent a patch with a comparable idea, though Sashiko remained unconvinced.

[patch]: https://lore.kernel.org/all/20260817062726.106511-3-hao.ge@linux.dev/

[Sashiko's objections]: https://sashiko.dev/#/patchset/20260817062726.106511-1-hao.ge@linux.dev

Could this patch perhaps wait for mine? No worries if this is inconvenient.

Best regards                                                                                                                                                                                                                                                                  
Hao

> ---
>  mm/alloc_tag.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 82e2c3448dcf..7d7ad6704953 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/string_choices.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/alloc_tag.h>
>  
> @@ -604,6 +605,26 @@ static void shutdown_mem_profiling(bool remove_file)
>  	mem_profiling_support = false;
>  }
>  
> +static void remove_allocinfo_file(struct work_struct *work)
> +{
> +	remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +}
> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
> +
> +/*
> + * A module's tags are reserved with the codetag module lock held for
> + * writing, and a reader of /proc/allocinfo takes that lock with the entry
> + * pinned. Removing the entry there would wait for that reader for good, so
> + * let a work item do it.
> + */
> +static void shutdown_mem_profiling_async(void)
> +{
> +	if (!mem_profiling_support)
> +		return;
> +	shutdown_mem_profiling(false);
> +	schedule_work(&remove_allocinfo_work);
> +}
> +
>  void __init alloc_tag_sec_init(void)
>  {
>  	struct alloc_tag *last_codetag;
> @@ -855,7 +876,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  		align = 1;
>  
>  	if (!ensure_alignment(align, &prepend)) {
> -		shutdown_mem_profiling(true);
> +		shutdown_mem_profiling_async();
>  		pr_err("%s: alignment %lu is incompatible with allocation tag indexing. Memory allocation profiling is disabled!\n",
>  			mod->name, align);
>  		return ERR_PTR(-EINVAL);
> @@ -905,14 +926,14 @@ unlock:
>  
>  		module_tags.size = offset + size;
>  		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
> -			shutdown_mem_profiling(true);
> +			shutdown_mem_profiling_async();
>  			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>  				mod->name, NR_UNUSED_PAGEFLAG_BITS);
>  		}
>  
>  		grow_res = vm_module_tags_populate();
>  		if (grow_res) {
> -			shutdown_mem_profiling(true);
> +			shutdown_mem_profiling_async();
>  			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
>  			       mod->name);
>  			return ERR_PTR(grow_res);
> 


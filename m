Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF1C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:39:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B5B206C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B5B206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wqsD43q7zDqXY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 20:39:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wqqf1sR5zDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 20:38:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wqqd5H4mz9sN6;
 Fri,  8 Feb 2019 20:38:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/7] powerpc/eeh: Use debugfs_create_u32 for
 eeh_max_freezes
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
Date: Fri, 08 Feb 2019 20:38:19 +1100
Message-ID: <878syqk4c4.fsf@concordia.ellerman.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver O'Halloran <oohall@gmail.com> writes:

> There's no need to the custom getter/setter functions so we should remove
> them in favour of using the generic one. While we're here, change the type
> of eeh_max_freeze to uint32_t and print the value in decimal rather than

Please use kernel types, ie. u32.

Look fine otherwise.

cheers

> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/eeh.h |  2 +-
>  arch/powerpc/kernel/eeh.c      | 21 +++------------------
>  2 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 8b596d096ebe..c003628441cc 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -219,7 +219,7 @@ struct eeh_ops {
>  };
>  
>  extern int eeh_subsystem_flags;
> -extern int eeh_max_freezes;
> +extern uint32_t eeh_max_freezes;
>  extern struct eeh_ops *eeh_ops;
>  extern raw_spinlock_t confirm_error_lock;
>  
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index ae05203eb4de..f6e65375a8de 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -109,7 +109,7 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
>   * frozen count in last hour exceeds this limit, the PE will
>   * be forced to be offline permanently.
>   */
> -int eeh_max_freezes = 5;
> +uint32_t eeh_max_freezes = 5;
>  
>  /* Platform dependent EEH operations */
>  struct eeh_ops *eeh_ops = NULL;
> @@ -1796,22 +1796,8 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -static int eeh_freeze_dbgfs_set(void *data, u64 val)
> -{
> -	eeh_max_freezes = val;
> -	return 0;
> -}
> -
> -static int eeh_freeze_dbgfs_get(void *data, u64 *val)
> -{
> -	*val = eeh_max_freezes;
> -	return 0;
> -}
> -
>  DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
>  			 eeh_enable_dbgfs_set, "0x%llx\n");
> -DEFINE_DEBUGFS_ATTRIBUTE(eeh_freeze_dbgfs_ops, eeh_freeze_dbgfs_get,
> -			 eeh_freeze_dbgfs_set, "0x%llx\n");
>  #endif
>  
>  static int __init eeh_init_proc(void)
> @@ -1822,9 +1808,8 @@ static int __init eeh_init_proc(void)
>  		debugfs_create_file_unsafe("eeh_enable", 0600,
>  					   powerpc_debugfs_root, NULL,
>  					   &eeh_enable_dbgfs_ops);
> -		debugfs_create_file_unsafe("eeh_max_freezes", 0600,
> -					   powerpc_debugfs_root, NULL,
> -					   &eeh_freeze_dbgfs_ops);
> +		debugfs_create_u32("eeh_max_freezes", 0600,
> +				powerpc_debugfs_root, &eeh_max_freezes);
>  #endif
>  	}
>  
> -- 
> 2.20.1

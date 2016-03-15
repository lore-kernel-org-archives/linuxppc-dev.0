Return-Path: <dja@axtens.net>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPL5D3HGGzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:41:36 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id n5so9115508pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 20:41:36 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a
 fallback
In-Reply-To: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
References: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
Date: Tue, 15 Mar 2016 14:41:29 +1100
Message-ID: <87lh5ke7bq.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:

> The HMI code knows about three types of errors: CORE, NX and UNKNOWN.
> If OPAL were to add a new type, it would not be handled at all since
> there is no fallback case.  Instead of explicitly checking for UNKNOWN,
> treat any checkstop type without a handler as unknown.
>

Just checked the surrounding function; you're quite right.
Reviewed-by: Daniel Axtens <dja@axtens.net>

> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/platforms/powernv/opal-hmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
> index d000f4e..bff4dd1 100644
> --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> @@ -157,7 +157,7 @@ static void print_checkstop_reason(const char *level,
>  	case CHECKSTOP_TYPE_NX:
>  		print_nx_checkstop_reason(level, hmi_evt);
>  		break;
> -	case CHECKSTOP_TYPE_UNKNOWN:
> +	default:
>  		printk("%s	Unknown Malfunction Alert.\n", level);
>  		break;
>  	}
> -- 
> 2.7.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

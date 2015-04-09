Return-Path: <rric.net@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2669F1A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 15:44:01 +1000 (AEST)
Received: by wiun10 with SMTP id n10so84172364wiu.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 22:43:56 -0700 (PDT)
Sender: Robert Richter <rric.net@gmail.com>
Date: Thu, 9 Apr 2015 07:43:52 +0200
From: Robert Richter <rric@kernel.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] oprofile: Disable oprofile NMI timer on ppc64
Message-ID: <20150409054352.GK4201@rric.localhost>
References: <1428547976-24890-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428547976-24890-1-git-send-email-anton@samba.org>
Cc: oprofile-list@lists.sf.net, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.04.15 12:52:55, Anton Blanchard wrote:
> We want to enable the hard lockup detector on ppc64, but right now
> that enables the oprofile NMI timer too.
> 
> We'd prefer not to enable the oprofile NMI timer, it adds another
> element to our PMU testing and it requires us to increase our
> exported symbols (eg cpu_khz).
> 
> Modify the config entry for OPROFILE_NMI_TIMER to disable it on PPC64.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Robert Richter <rric@kernel.org>

Please pass this patch along with patch 2 of this series (ppc tree or
so).

Thanks,

-Robert

> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 05d7a8a..0cc605d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -32,7 +32,7 @@ config HAVE_OPROFILE
>  
>  config OPROFILE_NMI_TIMER
>  	def_bool y
> -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
>  
>  config KPROBES
>  	bool "Kprobes"
> -- 
> 2.1.0
> 

Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7870ADDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 03:36:11 +1100 (EST)
Message-ID: <45B8DC70.7000607@am.sony.com>
Date: Thu, 25 Jan 2007 08:36:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>, paulus@samba.org
Subject: Re: [PATCH 12/14] ps3: fix gpu_context_allocate hcall
References: <45B81898.8000801@am.sony.com>
In-Reply-To: <45B81898.8000801@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> PS3: lv1_gpu_context_allocate() takes only one input parameter
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
>  include/asm-powerpc/lv1call.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- ps3-linux-dev.orig/include/asm-powerpc/lv1call.h
> +++ ps3-linux-dev/include/asm-powerpc/lv1call.h
> @@ -307,7 +307,7 @@ LV1_CALL(gpu_device_map,                
>  LV1_CALL(gpu_device_unmap,                              1, 0, 213 )
>  LV1_CALL(gpu_memory_allocate,                           5, 2, 214 )
>  LV1_CALL(gpu_memory_free,                               1, 0, 216 )
> -LV1_CALL(gpu_context_allocate,                          2, 5, 217 )
> +LV1_CALL(gpu_context_allocate,                          1, 5, 217 )
>  LV1_CALL(gpu_context_free,                              1, 0, 218 )
>  LV1_CALL(gpu_context_iomap,                             5, 0, 221 )
>  LV1_CALL(gpu_context_attribute,                         6, 0, 225 )
> 

Paul,

Please don't apply this one.

There was some discrepancy in the documents, and I just now got
the final word from the lv1 team that this parameter is a flag,
and is needed, but currently should be zero.

Sorry for the trouble.

-Geoff

Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3hsQ2whZzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 02:45:46 +1000 (AEST)
Message-ID: <1470156329.16559.57.camel@infradead.org>
Subject: Re: [PATCH 0867/1285] Replace numeric parameter like 0444 with macro
From: Geoff Levand <geoff@infradead.org>
To: Baole Ni <baolex.ni@intel.com>, benh@kernel.crashing.org,
 paulus@samba.org,  mpe@ellerman.id.au, dwmw2@infradead.org,
 m.chehab@samsung.com, pawel@osciak.com,  m.szyprowski@samsung.com,
 kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 chuansheng.liu@intel.com
Date: Tue, 02 Aug 2016 09:45:29 -0700
In-Reply-To: <20160802115333.7780-1-baolex.ni@intel.com>
References: <20160802115333.7780-1-baolex.ni@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-02 at 19:53 +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access
> permission.
> As we know, these numeric value for access permission have had the
> corresponding macro,
> and that using macro can improve the robustness and readability of
> the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  
>  static int timeout = 5000;	/* in msec ( 5 sec ) */
> -module_param(timeout, int, 0644);
> +module_param(timeout, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

To me, 644 is more 'readable', and as for robustness, the meaning of
644 will never change.

-Geoff

Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDSz55CJVzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 06:21:53 +1000 (AEST)
Date: Fri, 28 Apr 2017 06:21:26 +1000
From: Anton Blanchard <anton@samba.org>
To: Ankit Kumar <ankit@linux.vnet.ibm.com>
Cc: keescook@chromium.org, anton@enomsg.org, ccross@android.com,
 tony.luck@intel.com, xinhui.pan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, mahesh@linux.vnet.ibm.com,
 geliangtang@163.com, paulus@samba.org, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Subject: Re: [PATCH] Enabled pstore write for powerpc
Message-ID: <20170428062126.53f80221@kryten>
In-Reply-To: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
References: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ankit,

> After commit c950fd6f201a kernel registers pstore write based on flag
> set. Pstore write for powerpc is broken as flags(PSTORE_FLAGS_DMESG)
> is not set for powerpc architecture. On panic, kernel doesn't write
> message to /fs/pstore/dmesg*(Entry doesn't gets created at all).
> 
> This patch enables pstore write for powerpc architecture by setting
> PSTORE_FLAGS_DMESG flag.
> 
> Fixes:c950fd6f201a pstore: Split pstore fragile flags

Ouch! We've used pstore to shoot customer bugs, so we should also mark
this for stable. Looks like 4.9 onwards?

Anton

> Signed-off-by: Ankit Kumar <ankit@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/kernel/nvram_64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c
> b/arch/powerpc/kernel/nvram_64.c index d5e2b83..021db31 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -561,6 +561,7 @@ static ssize_t nvram_pstore_read(u64 *id, enum
> pstore_type_id *type, static struct pstore_info nvram_pstore_info = {
>  	.owner = THIS_MODULE,
>  	.name = "nvram",
> +	.flags = PSTORE_FLAGS_DMESG,
>  	.open = nvram_pstore_open,
>  	.read = nvram_pstore_read,
>  	.write = nvram_pstore_write,

Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCn0h5rSvzDqG3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 13:20:36 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 204so32639755pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:20:36 -0800 (PST)
Date: Tue, 31 Jan 2017 18:20:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: make use of for_each_node_by_name() instead
 of open-coding it
Message-ID: <20170201022032.GB17308@dtor-ws>
References: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 05:54:37PM -0800, Dmitry Torokhov wrote:
> Instead of manually coding the loop with of_find_node_by_name(), let's
> switch to the standard macro for iterating over nodes with given name.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/powerpc/platforms/83xx/mpc832x_mds.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc836x_mds.c | 2 +-
>  arch/powerpc/platforms/cell/interrupt.c   | 3 +--
>  arch/powerpc/platforms/cell/setup.c       | 3 +--
>  arch/powerpc/platforms/cell/spider-pic.c  | 3 +--
>  arch/powerpc/platforms/powermac/feature.c | 2 +-
>  7 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> index bb7b25acf26f..1e92f806ee60 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -75,7 +75,7 @@ static void __init mpc832x_sys_setup_arch(void)
>  		par_io_init(np);
>  		of_node_put(np);
>  
> -		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
> +		for_each_node_by_name(np. "ucc")

Gah, kbuild robot even told me about this typo and I missed it. Please
let me know if you can fix up or if I should resend (or drop). I'd
rather it not get dropped as I want to convert of_find_node_by_name() to
stop dropping reference to the starting node, as half of the users do
not expect it.

Thanks.

-- 
Dmitry

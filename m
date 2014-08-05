Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E01DD1A040C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 19:18:24 +1000 (EST)
Message-ID: <1407230219.3073.5.camel@pasglop>
Subject: Re: [PATCH] arch/powerpc/mm/numa.c: Fix break placement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Date: Tue, 05 Aug 2014 19:16:59 +1000
In-Reply-To: <1407183190-1397-1-git-send-email-andrey.krieger.utkin@gmail.com>
References: <1407183190-1397-1-git-send-email-andrey.krieger.utkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, rcj@linux.vnet.ibm.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 alistair@popple.id.au, joe@perches.com, qiuxishi@huawei.com,
 akpm@linux-foundation.org, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-04 at 23:13 +0300, Andrey Utkin wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=81631
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>

Thanks, I wonder how that managed to remain unnoticed for so long !

Cheers,
Ben.

> ---
>  arch/powerpc/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 3b181b2..d3e9a78 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -611,8 +611,8 @@ static int cpu_numa_callback(struct notifier_block *nfb, unsigned long action,
>  	case CPU_UP_CANCELED:
>  	case CPU_UP_CANCELED_FROZEN:
>  		unmap_cpu_from_node(lcpu);
> -		break;
>  		ret = NOTIFY_OK;
> +		break;
>  #endif
>  	}
>  	return ret;

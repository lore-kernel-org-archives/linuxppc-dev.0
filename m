Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 5A829B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 02:35:22 +1100 (EST)
Date: Fri, 2 Dec 2011 16:35:18 +0100
From: Anatolij Gustschin <agust@denx.de>
To: acrux <acrux_it@libero.it>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
Message-ID: <20111202163518.7d7f0a74@wker>
In-Reply-To: <20111202154833.72c75615.acrux_it@libero.it>
References: <20111127173748.9f235741.acrux_it@libero.it>
 <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
 <20111128205655.fc4d3249.acrux_it@libero.it>
 <20111128212224.2bd66125@wker>
 <20111202154833.72c75615.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2 Dec 2011 15:48:33 +0100
acrux <acrux_it@libero.it> wrote:
...
> This little hack fix my problem:
> --- a/inlcude/linux/sm501.h	2011-12-02 01:11:04.000000000 +0100
> +++ b/include/linux/sm501.h	2011-12-02 01:11:09.000000000 +0100
> @@ -174,8 +174,8 @@
>  };
>  
>  #if defined(CONFIG_PPC32)
> -#define smc501_readl(addr)		ioread32be((addr))
> -#define smc501_writel(val, addr)	iowrite32be((val), (addr))
> +#define smc501_readl(addr)		ioread32((addr))
> +#define smc501_writel(val, addr)	iowrite32((val), (addr))
>  #else
>  #define smc501_readl(addr)		readl(addr)
>  #define smc501_writel(val, addr)	writel(val, addr)
> 
> 
> but instead, why am I obliged to read it as little endian to have the correct value? 

The SM502 registers are in little endian format, you access them
over PCI interface, that is the reason. The commit introduced
a regression, I'll try to fix it this weekend. IIRC, there is
a flag to switch to big-endian register format in SM502, but
I'm not sure if it will also affect frame buffer data format.

Anatolij

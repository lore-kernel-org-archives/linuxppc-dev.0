Return-Path: <acrux_it@libero.it>
Received: from outrelay07.libero.it (outrelay07.libero.it [212.52.84.111])
 by ozlabs.org (Postfix) with ESMTP id 53F56B6F64
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 01:48:41 +1100 (EST)
Date: Fri, 2 Dec 2011 15:48:33 +0100
From: acrux <acrux_it@libero.it>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
Message-Id: <20111202154833.72c75615.acrux_it@libero.it>
In-Reply-To: <20111128212224.2bd66125@wker>
References: <20111127173748.9f235741.acrux_it@libero.it>
 <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
 <20111128205655.fc4d3249.acrux_it@libero.it>
 <20111128212224.2bd66125@wker>
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

On Mon, 28 Nov 2011 21:22:24 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> On Mon, 28 Nov 2011 20:56:55 +0100
> acrux <acrux_it@libero.it> wrote:
> ...
> > it seems to be an endianess issue but i didn't find when it was
> > introduced.  Really strange this kind of issue was never noticed
> > bumping from 2.6.38.x to 2.6.39.x .
> 
> Look at commit bf5f0019046d596d613caf74722ba4994e153899
> (video, sm501: add I/O functions for use on powerpc).
> This is the issue, I think. Especially changes in
> include/linux/sm501.h by this commit. Since CONFIG_PPC32 is defined
> for canyonlands, ioread32be() is used to access the registers at PCI
> space which is wrong. The patch was tested on tqm5200 with sm501
> connected on localbus, so using ioread32be() worked there. Your sm502
> is on PCI bus I suppose. This issue needs to be fixed.
> 


well, the commit suggested is this one:
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=bf5f0019046d596d613caf74722ba4994e153899


This little hack fix my problem:
--- a/inlcude/linux/sm501.h	2011-12-02 01:11:04.000000000 +0100
+++ b/include/linux/sm501.h	2011-12-02 01:11:09.000000000 +0100
@@ -174,8 +174,8 @@
 };
 
 #if defined(CONFIG_PPC32)
-#define smc501_readl(addr)		ioread32be((addr))
-#define smc501_writel(val, addr)	iowrite32be((val), (addr))
+#define smc501_readl(addr)		ioread32((addr))
+#define smc501_writel(val, addr)	iowrite32((val), (addr))
 #else
 #define smc501_readl(addr)		readl(addr)
 #define smc501_writel(val, addr)	writel(val, addr)


but instead, why am I obliged to read it as little endian to have the correct value? 

thanks for your help,
--nico
-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/

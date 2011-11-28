Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id C835D1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:32:16 +1100 (EST)
Date: Mon, 28 Nov 2011 21:22:24 +0100
From: Anatolij Gustschin <agust@denx.de>
To: acrux <acrux_it@libero.it>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
Message-ID: <20111128212224.2bd66125@wker>
In-Reply-To: <20111128205655.fc4d3249.acrux_it@libero.it>
References: <20111127173748.9f235741.acrux_it@libero.it>
 <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
 <20111128205655.fc4d3249.acrux_it@libero.it>
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

On Mon, 28 Nov 2011 20:56:55 +0100
acrux <acrux_it@libero.it> wrote:
...
> it seems to be an endianess issue but i didn't find when it was
> introduced.  Really strange this kind of issue was never noticed
> bumping from 2.6.38.x to 2.6.39.x .

Look at commit bf5f0019046d596d613caf74722ba4994e153899
(video, sm501: add I/O functions for use on powerpc).
This is the issue, I think. Especially changes in include/linux/sm501.h
by this commit. Since CONFIG_PPC32 is defined for canyonlands,
ioread32be() is used to access the registers at PCI space which
is wrong. The patch was tested on tqm5200 with sm501 connected
on localbus, so using ioread32be() worked there. Your sm502 is on
PCI bus I suppose. This issue needs to be fixed.

HTH,
Anatolij

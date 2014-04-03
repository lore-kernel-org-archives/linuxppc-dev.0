Return-Path: <zyjzyj2000@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBB8B1400DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 20:57:58 +1100 (EST)
Received: by mail-pd0-f173.google.com with SMTP id z10so1551164pdj.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Apr 2014 02:57:55 -0700 (PDT)
Message-ID: <533D30A1.1060509@gmail.com>
Date: Thu, 03 Apr 2014 17:57:53 +0800
From: zhuyj <zyjzyj2000@gmail.com>
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
Subject: Re: on kernel 2.6.34.15, vlan and raw packets can not be received
 with gfar-enet nic
References: <53310F4E.4080104@gmail.com> <533D25D4.4000607@gmail.com>
 <20140403092727.GD16158@1wt.eu>
In-Reply-To: <20140403092727.GD16158@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Yang, Zhangle \(Eric\)" <Zhangle.Yang@windriver.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com,
 linuxppc-dev@lists.ozlabs.org, guang.yang@windriver.com,
 linux-kernel@vger.kernel.org, yongjun_wei@trendmicro.com.cn,
 sandeep.kumar@freescale.com, Claudiu Manoil <claudiu.manoil@freescale.com>,
 "Tao, Yue" <Yue.Tao@windriver.com>, joe@perches.com, festevam@gmail.com,
 clarocq@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2014 05:27 PM, Willy Tarreau wrote:
> Hi Zhu,
>
> On Thu, Apr 03, 2014 at 05:11:48PM +0800, zhuyj wrote:
>> Hi, Claudiu
>>
>> Please help to review this patch. This patch is for kernel 2.6.x. Thanks
>> a lot.
>>
>> Hi, Willy
>>
>> Please help to merge this patch to longterm: 2.6.32.61 since this
>> problem also occurs on this kernel. Thanks a lot.
> Could you please send the reference to the equivalent mainline commit (the one
> which disables the tx vlan feature I'm assuming) ? I'll happily queue it for
> 2.6.32.62.
>
> Thanks,
> Willy
>
>
Hi, Willy

I reference the following 2 mainline commits. These 2 commits are based 
on the current kernel 3.x and ethtool.
If we only backport these 2 commits on kernel 2.6.x, this problem will 
not be fixed yet.

Best Regards!
Zhu Yanjun

1. commit 87c288c6e9aa31720b72e2bc2d665e24e1653c3e
Author: Jiri Pirko <jpirko@redhat.com>
Date:   Wed Jul 20 04:54:19 2011 +0000

     gianfar: do vlan cleanup

     - unify vlan and nonvlan rx path
     - kill priv->vlgrp and gfar_vlan_rx_register
     - allow to turn on/off rx/tx vlan accel via ethtool

     Signed-off-by: Jiri Pirko <jpirko@redhat.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

  drivers/net/gianfar.c |   55 
++++++++++++++++++++++++++-----------------------
  1 file changed, 29 insertions(+), 26 deletions(-)

2.commit b852b720877e6b8e12b95a7cb4e00ea351b8cbfc
Author: Sebastian Pöhn <sebastian.belden@googlemail.com>
Date:   Tue Jul 26 00:03:13 2011 +0000

     gianfar: fix bug caused by 87c288c6e9aa31720b72e2bc2d665e24e1653c3e

     commit 87c288c6e9aa31720b72e2bc2d665e24e1653c3e "gianfar: do vlan 
cleanup" has two issues:
     # permutation of rx and tx flags
     # enabling vlan tag insertion by default (this leads to unusable 
connections on some configurations)

     If VLAN insertion is requested (via ethtool) it will be set at an 
other point ...

     Signed-off-by: Sebastian Poehn <sebastian.poehn@belden.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

  drivers/net/gianfar.c |    6 +-----
  1 file changed, 1 insertion(+), 5 deletions(-)

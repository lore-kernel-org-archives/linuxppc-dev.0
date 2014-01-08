Return-Path: <lravich@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7BD4A2C00B8
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jan 2014 19:25:02 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <lravich@gmail.com>) id 1W0oRf-0003Fm-PT
 for linuxppc-dev@ozlabs.org; Wed, 08 Jan 2014 00:24:59 -0800
Date: Wed, 8 Jan 2014 00:24:59 -0800 (PST)
From: ravich <lravich@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1389169499473-79160.post@n7.nabble.com>
In-Reply-To: <1383059241779-77605.post@n7.nabble.com>
References: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
 <CAPWoNkLTC+1ba3vwY0xiJVmmebvuXZBTwiyH5HAFfE8mRReaRQ@mail.gmail.com>
 <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
 <CAErSpo49ZLfxkEanmrrwwiqHR8koiCakqe9h8My2Mu1yA4R1Ww@mail.gmail.com>
 <1383059241779-77605.post@n7.nabble.com>
Subject: Re: PCIE device errors after linux kernel upgrade
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Finally I found the problem causing the sudden system reset :

our setup :

P2020<====>PCI Bridge <=====> FPGA

The reset occurs when we allocating skb and giving the Fpga dma addr of
skb->data of this skb and when the FPGA tries to reach this address we are
having a hardware reset. 

To fixed it we used GFP_DMA flag on skb allocations.

If you can explain me few thinks I will be more  then happy :
1) how come we managed to work in 2.6.32 kernel without this flag.
2) Ok gave you a bad dma address why reset the system without  any warning. 

Thanks for your time and support

Leonid Ravich





--
View this message in context: http://linuxppc.10917.n7.nabble.com/Re-PCIE-device-errors-after-linux-kernel-upgrade-tp74563p79160.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

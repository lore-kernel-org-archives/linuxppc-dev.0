Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0156.outbound.protection.outlook.com [207.46.163.156])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A0652C00C4
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jan 2014 08:07:40 +1100 (EST)
Message-ID: <1389215251.25654.22.camel@snotra.buserror.net>
Subject: Re: PCIE device errors after linux kernel upgrade
From: Scott Wood <scottwood@freescale.com>
To: ravich <lravich@gmail.com>
Date: Wed, 8 Jan 2014 15:07:31 -0600
In-Reply-To: <1389169499473-79160.post@n7.nabble.com>
References: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
 <CAPWoNkLTC+1ba3vwY0xiJVmmebvuXZBTwiyH5HAFfE8mRReaRQ@mail.gmail.com>
 <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
 <CAErSpo49ZLfxkEanmrrwwiqHR8koiCakqe9h8My2Mu1yA4R1Ww@mail.gmail.com>
 <1383059241779-77605.post@n7.nabble.com>
 <1389169499473-79160.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 00:24 -0800, ravich wrote:
> Finally I found the problem causing the sudden system reset :
> 
> our setup :
> 
> P2020<====>PCI Bridge <=====> FPGA
> 
> The reset occurs when we allocating skb and giving the Fpga dma addr of
> skb->data of this skb and when the FPGA tries to reach this address we are
> having a hardware reset. 
> 
> To fixed it we used GFP_DMA flag on skb allocations.
> 
> If you can explain me few thinks I will be more  then happy :
> 1) how come we managed to work in 2.6.32 kernel without this flag.

Maybe you got lucky, allocation patterns changed, etc?

> 2) Ok gave you a bad dma address why reset the system without  any warning. 

If you write to random addresses arbitrary things can happen.

-Scott

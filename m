Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 6968ADDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 12:42:20 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-76.bayarea.dialup.o1.com [66.81.71.76])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m991ever057293
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2008 18:42:12 -0700 (PDT)
Message-ID: <48ED60F9.1010908@hypersurf.com>
Date: Wed, 08 Oct 2008 18:40:10 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
CC: linuxppc-dev@ozlabs.org
Subject: Re: 8600 serial support
References: <48ED0F30.7080103@hypersurf.com> <1223498711.8157.90.camel@pasglop>
In-Reply-To: <1223498711.8157.90.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-08 at 12:51 -0700, Kevin Diggs wrote:
> 
>>Hi,
>>
>>	I thought I might take a whack at fixing the 2.6 serial driver
>>for my 8600. At the top of pmac_zilog.c (2.6.26) there is a todo for DMA.
>>A quick glance at macserial.c (2.4.31) suggests it has dbdma support for
>>receive. Anyone know of any pitfalls for adding dbdma support for
>>pmac_zilog.c?
> 
> 
> Yes, it's not totally trivial and I wouldn't recommend using the weirdo
> code in macserial (it does things that I don't understand how they work
> with the dbdma engine).
> 
> The best way I see is to start from scratch with two different
> mechanisms:
> 
>  - For Tx, that's the easiest, the fire off DMA's for outgoing chars,
> maybe queue up a few descriptors to let data accumulate.
> 
>  - For Rx, one descriptor per byte. That sucks but I think that's also
> what Apple does. No need to have a huge Rx buffer anyway. That gives you
> precise Rx status to the byte.
> 
> Ben.
> 
> 

Does the 8530 (as implemented in the PowerMac ASICs) have a receive
buffer like the 16550? Any pointers to some "good" dbdma example code?
Anyone know where one might find some 8530 docs?

This driver "should" work for ppp without receive dma, right?

One descriptor per byte???

kevin

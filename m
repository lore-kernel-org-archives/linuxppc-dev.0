Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 937D0B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 08:10:11 +1000 (EST)
Message-ID: <4AB16292.9020704@embeddedarm.com>
Date: Wed, 16 Sep 2009 15:11:30 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC PCI bus registers
References: <4A9F0377.1070606@embeddedarm.com>	
	<1251972032.15089.30.camel@pasglop>
	<4AB13550.1070506@embeddedarm.com>
	<1253138086.8375.290.camel@pasglop>
In-Reply-To: <1253138086.8375.290.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin,

> Out of order execution != out of order storage. ioremap() will give you
> guarded space which means it cannot be speculatively accessed for
> example, and you do get -some- guarantees but not that your stores are
> going to hit the device in order, nor that your loads are going to be
> performed until the CPU actually use the result of the load, which can
> be delayed beyond a store.

Interesting. So IIUC if I were to use ioremap and then bit bang bus cycles using 
readN() / writeN() I would need to add memory barrier to ensure the order of the 
load and store operations does not change. Is my understanding correct? If so 
what are the recommended macros/functions for adding memory barriers, or are 
there preferred functions to use in place of ioremap() and readN()/writeN?

PS I've looked in Documentation/ in the 2.6.30 Linux kernel tree for more 
information, but I was unable to find any. If there are any example drivers or 
documentation that you know of on this topic I'd be quite interested if you 
could point me to it.

Thanks for your patience and time you've been quite helpful.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

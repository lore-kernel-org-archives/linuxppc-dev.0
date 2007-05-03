Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CE806DE017
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:51:46 +1000 (EST)
Message-ID: <463A2192.6020308@ru.mvista.com>
Date: Thu, 03 May 2007 21:53:22 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
References: <20070501051804.GB3881@localhost.localdomain>	<4639CBD8.6010205@ru.mvista.com>	<20070503123055.GE26659@localhost.localdomain>	<4639DDE1.40904@ru.mvista.com>	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com>
In-Reply-To: <463A1941.3090608@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>Now for ROM/flash/NVRAM, nodes _can_ appear directly
>>under the root, but only if that is where they belong
>>on your platform (i.e., they sit directly on the "system
>>bus" (whatever that means on your platform); on most
>>platforms though, such devices are connected via some
>>I/O busses, so the nodes should appear under their
>>respective controllers.

>     Yeah, you're right here, and I've probably misunderstood what "memory" 
> node was. In fact, the flash in my system resides on the same local bus as 
> RAM, so the proper place would be behind the "lbc" (or whatever -- it doesn't 
> exist as yet) node on the "soc" bus.  Do you think I need to go and document 
> it as well for such cause? :-]

    No, that probably won't do. MPC85xx SoC bus has ranges = <e0000000 
00100000> and the NOR flash is mapped at 0xff000000, so it seems that it can't 
be located under the "soc" bus (unless that latter has "ranges" prop extended?).

>>Segher

WBR, Sergei

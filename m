Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A454FB70D8
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Aug 2010 09:44:44 +1000 (EST)
Subject: Re: help with kernel panics in task swapper on 460ex
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20100813203636.GA11899@crust.elkhashab.com>
References: <20100813203636.GA11899@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 14 Aug 2010 09:44:31 +1000
Message-ID: <1281743071.2987.411.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-08-13 at 15:36 -0500, Ayman El-Khashab wrote:
> 
> The exact details (though I don't think they are too useful are as follows.
> The one interesting item if I read it correctly, is that the CPU was 
> trying to get instructions from c002xxxx address.  However, this board only
> has 512MB of memory so it seems that the address (if it is physical) isn't 
> valid.  

Actually this is a perfectly valid virtual address. The kernel maps
memory at 0xc0000000 (at least the first 768M of it, the rest is
dynamically mapped in/out).

> Are there any tricks we can use to analyze this problem?  Or is there any
> information we can collect to help pinpoint where this issue might lie?

Well, xmon is your friend ...

Ben.

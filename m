Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 13 Jul 2011 10:41:16 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: [PATCH] 4xx: Add check_link to struct ppc4xx_pciex_hwops
Message-ID: <20110713004116.GF20597@ozlabs.org>
References: <20110701064424.GE13483@ozlabs.org>
	<20110712174007.GA26664@crust.elkhashab.com>
	<20110712180404.GC4203@zod.rchland.ibm.com>
	<20110712221338.GA30666@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110712221338.GA30666@crust.elkhashab.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 05:13:38PM -0500, Ayman El-Khashab wrote:

> Ok, so let me ask the following ... will it cause trouble if
> I swap the sequence of the calls to the following in xxx_port_init
> 
> ppc4xx_pciex_port_init_mapping(...)
> 
> and
> 
> if (ppc4xx_pciex_hwops->check_link)...
> 
> The reason is that at least on the 460SX, the link check is
> done via registers in the config space.  But the init_mapping is 
> needed to setup some of the DCRs to make the config space work.  
> In my check_link, i map the config space do the link checks
> and then unmap since a superset of the space could be mapped
> later.

This is also what I do.  IIRC ppc4xx_pciex_port_init_mapping() required
things that are setup between the 2 calls.

The double Mapping is fugly but I think it should be safe.

Yours Tony

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 999CC67A78
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 14:25:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
In-Reply-To: <16885.13185.849070.479328@alkaid.it.uu.se>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	<16885.13185.849070.479328@alkaid.it.uu.se>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 14:25:14 +1100
Message-Id: <1106623515.6244.11.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-24 at 18:42 +0100, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
>  > 
>  > > I know about this problem, I'm working on a proper fix. Thanks for your
>  > > report.
>  > 
>  > Can you send me the PVR value for both of these CPUs
>  > (cat /proc/cpuinfo) ? I can't find right now why they would lock up
>  > unless the default idle loop is _not_ run properly, that is for some
>  > reason, NAP or DOZE mode end up not beeing enabled. Can you send me
>  > your .config as well ?
> 
> === cpuinfo.emac ===
> processor	: 0
> cpu		: 7447/7457, altivec supported
> clock		: 1249MHz
> revision	: 1.1 (pvr 8002 0101)
> bogomips	: 830.66
> machine		: PowerMac6,4
> motherboard	: PowerMac6,4 MacRISC3 Power Macintosh 
> detected as	: 287 (Unknown Intrepid-based)
> pmac flags	: 00000000
> L2 cache	: 512K unified
> memory		: 256MB
> pmac-generation	: NewWorld

Ok, it's normal that the Beige G3 doesn't do NAP, and the 7455 cannot do
DOZE, so I suspect it's all normal and my patch fixes it.

However, the eMac should have been doing NAP. Can you check what's up in
arch/ppc/plaform/pmac_feature.c with powersave_nap ? is it set at all ?
It should be visible from userland at /proc/sys/kernel/powersave-nap
and should be set to 1 by default on your machine... unless your cpu
node in the device-tree has the "flush-on-lock" property...
 
Ben.

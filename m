Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] EMAC "powerpc" port
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1166595738.19254.140.camel@localhost.localdomain>
References: <1166595738.19254.140.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 15:13:37 +1100
Message-Id: <1166760817.6673.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-20 at 17:22 +1100, Benjamin Herrenschmidt wrote:

>  - Locking. Cell is SMP, 46x is SMP, so we need SMP (and I've heard some
> of the -rt folks having problem in that area too). I haven't triple
> checked what I've done, it's rather simplistic, so feel free to propose
> something better, and I still have a race with the multicast stuff that
> I need to fix, but the base idea is that "hard" work and PHY polling are
> all done at task level so we can use mutexes for most things (zmii,
> rgmii, mdio accesses, etc...) and no big latencies.

I've fixed the race with the multicast stuff and updated the patch, it's
now:

http://gate.crashing.org/~benh/powerpc-emac-new-20061222.diff

Note that porting to the generic PHY layer might be a problem due to the
locking done by it (it basically calls back the MDIO access routines
with locks held or from timer interrupts while I'm using mutexes to
handle arbitration at the MDIO and ZMII/RGMII level). I'm not trying to
change the generic PHY layer but that might take some time.

I've tested it a bit more, running all sorts of data overnight through
an SSH link (good to detect data corruption) and it held firm without
apparent race or memory leak, but it could certainly be tortured more.
I'll do that once I've added support for dma unmapping, so I can test it
with the cell iommu active, as using an iommu is a very good way to
catch problems like runaway DMA etc...

Ben.

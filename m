Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60F3EB6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 12:58:02 +1000 (EST)
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>, linville@tuxdriver.com
In-Reply-To: <alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 12:57:47 +1000
Message-ID: <1306983467.29297.51.camel@pasglop>
Mime-Version: 1.0
Cc: zajec5@gmail.com, linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-01 at 17:16 -0700, Christian Kujau wrote:
> On Tue, 31 May 2011 at 16:50, Christian Kujau wrote:
> > trying to boot 3.0-rc1 on powerpc32 only progresses until:
> > 
> >   > Kernel virtual memory layout:
> >   >   * 0xfffcf000..0xfffff000  : fixmap
> 
> After hours (and hours!) of git-bisecting, it said:
> 
> -----------------------
> ccc7c28af205888798b51b6cbc0b557ac1170a49 is the first bad commit
> commit ccc7c28af205888798b51b6cbc0b557ac1170a49
> Author: Rafał Miłecki <zajec5@gmail.com>
> Date:   Fri Apr 1 13:26:52 2011 +0200
> 
>     ssb: pci: implement serdes workaround
>     
>     Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>     Signed-off-by: John W. Linville <linville@tuxdriver.com>
> -----------------------

Ok, thanks a lot, It looks rather trivial actually: That new workaround
is PCIe specific but is called unconditionally, and will do bad things
non-PCIe implementations.

John, care to send the patch below to Linus ASAP ? I could reproduce and
verify it fixes it. Thanks !

ssb: pci: Don't call PCIe specific workarounds on PCI cores

Otherwise it can/will crash....

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
index 82feb34..eddf1b9 100644
--- a/drivers/ssb/driver_pcicore.c
+++ b/drivers/ssb/driver_pcicore.c
@@ -540,7 +540,8 @@ void ssb_pcicore_init(struct ssb_pcicore *pc)
 		ssb_pcicore_init_clientmode(pc);
 
 	/* Additional always once-executed workarounds */
-	ssb_pcicore_serdes_workaround(pc);
+	if (dev->id.coreid == SSB_DEV_PCIE)
+		ssb_pcicore_serdes_workaround(pc);
 	/* TODO: ASPM */
 	/* TODO: Clock Request Update */
 }

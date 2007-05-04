Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 33C3EDDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 May 2007 01:36:20 +1000 (EST)
Message-ID: <463B5422.6030105@ru.mvista.com>
Date: Fri, 04 May 2007 19:41:22 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: zImage.elf loads but does not start
References: <10079346.post@talk.nabble.com>
	<10142161.post@talk.nabble.com>	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>	<10165159.post@talk.nabble.com>
	<10323147.post@talk.nabble.com>
In-Reply-To: <10323147.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mirek23 wrote:
> I came to the point with my kernel 2.6 (patched by Grant)  struggle on ml403
> that it reaches the 
> stage to mount nfs root file system from the computer which is on another
> segment  of the network:
> 
> [    2.565946] eth%d: XTemac: PHY detected at address 3.
> [    2.629348] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5020000,rq=1
> [    2.713113] eth0: XTemac id 1.0f, block id 5, type 8
> [    2.774335] mice: PS/2 mouse device common for all mice
> [    2.837152] TCP cubic registered
> [    2.876220] NET: Registered protocol family 1
> [    2.928569] NET: Registered protocol family 17
> [    3.485990] eth0: XTemac: Options: 0xb8f2
> [    7.517827] eth0: XTemac: We renegotiated the speed to: 100
> [    7.584504] eth0: XTemac: speed set to 100Mb/s
> [    8.652764] IP-Config: Unable to set interface netmask (-22).
> [    8.724733] Looking up port of RPC 100003/2 on 129.129.130.106
> 
> It cannot however go through the gateway because the macaddress is not
> properly set (ie. it is set to 00:00:00:00).
> My command line argument looks like:
> 
> CONFIG_CMDLINE="console=ttyUL0,9600 root=/dev/nfs rw
> nfsroot=129.129.130.106:/opt/eldk41/ppc_4xx,tcp macaddr=00:50:c2:46:d8:01
> ip=129.129.129.29:129.129.130.106:129.129.129.1:255.255.255.0:ML403:eth0:off
> panic=1"
> 
> Does somebody know why the macaddress is not taken into account.
> 
> Mirek
> 

Not sure how "macaddr=" in the cmdline is processed,
but here is what I've used to play with TEMAC (this is
essentially a copy from 2.4 kernels). The patch is
few month old, and could not apply cleanly. Especially
now when the Xilinx Virtex boards has been switched to the
u-boot's bd_t structure (a very recent change by
Grant Likely; probably not yet in the tree you are using).
So this patch is rather an illustration.

Thanks,
Andrei

--- linux-2.6.20.orig/arch/ppc/boot/simple/embed_config.c
+++ linux-2.6.20/arch/ppc/boot/simple/embed_config.c
@@ -778,6 +778,20 @@ embed_config(bd_t ** bdp)
         bd->bi_intfreq = XPAR_CORE_CLOCK_FREQ_HZ;
         bd->bi_busfreq = XPAR_PLB_CLOCK_FREQ_HZ;
         bd->bi_pci_busfreq = XPAR_PCI_0_CLOCK_FREQ_HZ;
+
+       /* Set the address to Xilinx's preferred default.
+        * However, first to eliminate a compiler warning
+        * because we don't really use def_enet_addr,
+        * we'll reference it. The compiler
+        * optimizes it away so no harm done. */
+       bd->bi_enetaddr[0] = def_enet_addr[0];
+       bd->bi_enetaddr[0] = 0x00;
+       bd->bi_enetaddr[1] = 0x0A;
+       bd->bi_enetaddr[2] = 0x35;
+       bd->bi_enetaddr[3] = 0x00;
+       bd->bi_enetaddr[4] = 0x22;
+       bd->bi_enetaddr[5] = 0x00;
+
         timebase_period_ns = 1000000000 / bd->bi_tbfreq;
         /* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
  }

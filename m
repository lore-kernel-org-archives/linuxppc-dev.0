Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 1A5B8DDE16
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:56:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linuxppc-dev Digest, Vol 40, Issue 57
Date: Thu, 6 Dec 2007 09:52:59 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A766F@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.414.1196916416.10024.linuxppc-dev@ozlabs.org>
References: <mailman.414.1196916416.10024.linuxppc-dev@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Bala,

I don't think the ioremap issues are related with low memory offset
mode. But again, I am not sure if you (system by default does not do it)
are reserving that area (from 256 to 512 which is low memory offset
region). Further, where do you get this 504 number specifically?

If you want, I can try out your code on my 8641D board.

Thanks
Siva


Date: Wed, 5 Dec 2007 17:45:01 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
Subject: Re: Regarding MPC8641D
To: linuxppc-dev@ozlabs.org
Message-ID: <14184891.post@talk.nabble.com>
Content-Type: text/plain; charset=3Dus-ascii


Hi,
           We need only SMP mode, asper ur idea let me disable the Low
memory offset mode. We face some issues when ioremap in the kernel, we
guess
the problem is related to Low memory offset mode so only we go for that.
Consider now the Low memory offset is disable the bootargs
(root=3D/dev/ram
console=3DttyS0, mem=3D504M). When mem=3D504 or greater than  we are not =
able
to
ioremap, if mem is less than 500 there was no issues on ioremap. We
can't
understand why ioremap was failed for 504M?

Thanks and Regards
S.Balamurugan


Siva Prasad-3 wrote:
>=20
> Hi,
>=20
> If you want to use SMP, do not enable low memory offset mode. That is
> only and only for AMP, not for SMP. All the exception vectors go into
a
> different address range for core1, once you enable that, resulting in
a
> need for entirely different copy of OS (be it Linux, or any other OS).
>=20
> You are in the right path. Just don't enable low memory offset mode,
> unless you are looking for Assymetric multi-processing.
>=20
> - siva
>=20
>=20
>=20
>=20
> Message: 6
> Date: Wed, 5 Dec 2007 16:45:31 -0800 (PST)
> From: sivaji <rameshmrm@gmail.com>
> Subject: Re: Regarding MPC8641D
> To: linuxppc-dev@ozlabs.org
> Message-ID: <14184234.post@talk.nabble.com>
> Content-Type: text/plain; charset=3Dus-ascii
>=20
>=20
> Hai,
>              The kernel was compiled in SMP mode. The low memory
offset
> mode
> is only for AMP mode means, then how we test both the core 0 and 1 in
> the
> linux kernel ?. Asper my understanding if we enable the Low Memory
> Offset
> mode, then only the core1 translation is enabled. If we disalbed the
Low
> Memory offset mode, Only Core 0  will work in SMP mode and Core 1 will
> idle.
> If we want to test the efficient of Dual core means we need to enable
> both
> the core and Low Memory Offset Mode. For this configuration linux
kernel
> was
> not up.
> ( Please correct me if I am wrong )
>=20
> Thanks and Regards
> Sivaji
>=20
>=20
> Chris Fester wrote:
>>=20
>> On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:
>>>             We have designed  a MPC8641D based AMC card. We are
using
> the
>>> kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1
Low
>>> Memory
>>> offset mode the kernel was up and when we enable this core1 Low
> Memory
>>> offset mode kernel was not up, It was hang after MPIC
initialization.
>> [snip!]
>>>                      After this the kernel was hang, i want to know
> why
>>> kernel was hang when we enalbe Low memory Offset mode. Please help
me
> to
>>> fix
>>> this issue.
>>=20
>> Have you compiled your kernel for SMP mode?  I believe the Low memory
>> offset mode is only for AMP mode (vxworks can use this, probably
other
>> OSes).  I don't know if the kernel has support for any
multiprocessing
>> mode other than SMP.
>>=20
>> Hope that helps,
>> Chris
>>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20

--=20
View this message in context:
http://www.nabble.com/Regarding-MPC8641D-tf4948004.html#a14184891
Sent from the linuxppc-dev mailing list archive at Nabble.com.



------------------------------

Message: 2
Date: Wed, 5 Dec 2007 20:55:05 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Link up/down messages from 5200 ethernet driver
To: "Grant Likely" <grant.likely@secretlab.ca>, 	"Domen Puncer"
	<domen.puncer@telargo.com>, 	"PowerPC dev list"
	<Linuxppc-dev@ozlabs.org>
Message-ID:
	<9e4733910712051755l76c0403bo4a60834928a35c2@mail.gmail.com>
Content-Type: text/plain; charset=3DUTF-8

Why does the fec5200 driver sometimes not print 'PHY' correctly?

phyCORE-MPC5200B-tiny login: T?V? f0003000:10 - Link is Down
T?Y: f0003000:10 - Link is Up - 100/Full
T?Y: f0003000:10 - Link is Down
PHY: f0003000:10 - Link is Up - 100/Full

--=20
Jon Smirl
jonsmirl@gmail.com

------------------------------

Message: 3
Date: Thu, 6 Dec 2007 13:07:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: dtc: Remove space from flex command line
To: Jon Loeliger <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Message-ID: <20071206020750.GE17577@localhost.localdomain>
Content-Type: text/plain; charset=3Dus-ascii

Author: Geoff Levand <geoffrey.levand@am.sony.com>

Apparently some versions of flex don't correctly parse the -o
parameter, if there's a space between the -o and its argument.  So,
this patch removes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- dtc.orig/Makefile	2007-12-06 13:03:41.000000000 +1100
+++ dtc/Makefile	2007-12-06 13:03:45.000000000 +1100
@@ -206,7 +206,7 @@
=20
 %.lex.c: %.l
 	@$(VECHO) LEX $@
-	$(LEX) -o $@ $<
+	$(LEX) -o$@ $<
=20
 %.tab.c %.tab.h %.output: %.y
 	@$(VECHO) BISON $@

--=20
David Gibson			| I'll have my music baroque, and my
code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson


------------------------------

Message: 4
Date: Thu, 6 Dec 2007 13:39:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] [POWERPC] iommu_free_table doesn't need the
	device_node
To: paulus@samba.org
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Message-ID: <20071206133919.9c609f17.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=3DUS-ASCII

It only needs the iommu_table address.  It also makes use of the node
name to print error messages.  So just pass it the things it needs.
This reduces the places that know about the pci_dn by one.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/iommu.c            |    8 +++-----
 arch/powerpc/platforms/pseries/iommu.c |    2 +-
 include/asm-powerpc/iommu.h            |    3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2d0c9ef..47c3fe5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -526,16 +526,14 @@ struct iommu_table *iommu_init_table(struct
iommu_table *tbl, int nid)
 	return tbl;
 }
=20
-void iommu_free_table(struct device_node *dn)
+void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
-	struct pci_dn *pdn =3D dn->data;
-	struct iommu_table *tbl =3D pdn->iommu_table;
 	unsigned long bitmap_sz, i;
 	unsigned int order;
=20
 	if (!tbl || !tbl->it_map) {
 		printk(KERN_ERR "%s: expected TCE map for %s\n",
__FUNCTION__,
-				dn->full_name);
+				node_name);
 		return;
 	}
=20
@@ -544,7 +542,7 @@ void iommu_free_table(struct device_node *dn)
 	for (i =3D 0; i < (tbl->it_size/64); i++) {
 		if (tbl->it_map[i] !=3D 0) {
 			printk(KERN_WARNING "%s: Unexpected TCEs for
%s\n",
-				__FUNCTION__, dn->full_name);
+				__FUNCTION__, node_name);
 			break;
 		}
 	}
diff --git a/arch/powerpc/platforms/pseries/iommu.c
b/arch/powerpc/platforms/pseries/iommu.c
index be17d23..d4e9d85 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -556,7 +556,7 @@ static int iommu_reconfig_notifier(struct
notifier_block *nb, unsigned long acti
 	case PSERIES_RECONFIG_REMOVE:
 		if (pci && pci->iommu_table &&
 		    of_get_property(np, "ibm,dma-window", NULL))
-			iommu_free_table(np);
+			iommu_free_table(pci->iommu_table,
np->full_name);
 		break;
 	default:
 		err =3D NOTIFY_DONE;
diff --git a/include/asm-powerpc/iommu.h b/include/asm-powerpc/iommu.h
index 4a82fdc..7a3cef7 100644
--- a/include/asm-powerpc/iommu.h
+++ b/include/asm-powerpc/iommu.h
@@ -69,10 +69,9 @@ struct iommu_table {
 };
=20
 struct scatterlist;
-struct device_node;
=20
 /* Frees table for an individual device node */
-extern void iommu_free_table(struct device_node *dn);
+extern void iommu_free_table(struct iommu_table *tbl, const char
*node_name);
=20
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
--=20
1.5.3.7



------------------------------

Message: 5
Date: Thu, 6 Dec 2007 13:40:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] [POWERPC] pSeries: remove dependency on pci_dn
	bussubno
To: paulus@samba.org
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Message-ID: <20071206134029.af8c291d.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=3DUS-ASCII


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pseries/iommu.c
b/arch/powerpc/platforms/pseries/iommu.c
index d4e9d85..ebb9313 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -296,11 +296,12 @@ static void iommu_table_setparms(struct
pci_controller *phb,
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      const void *dma_window)
+				      const void *dma_window,
+				      int bussubno)
 {
 	unsigned long offset, size;
=20
-	tbl->it_busno  =3D PCI_DN(dn)->bussubno;
+	tbl->it_busno  =3D bussubno;
 	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset,
&size);
=20
 	tbl->it_base   =3D 0;
@@ -420,17 +421,10 @@ static void pci_dma_bus_setup_pSeriesLP(struct
pci_bus *bus)
 	    pdn->full_name, ppci->iommu_table);
=20
 	if (!ppci->iommu_table) {
-		/* Bussubno hasn't been copied yet.
-		 * Do it now because iommu_table_setparms_lpar needs it.
-		 */
-
-		ppci->bussubno =3D bus->number;
-
 		tbl =3D kmalloc_node(sizeof(struct iommu_table),
GFP_KERNEL,
 				   ppci->phb->node);
-
-		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
dma_window);
-
+		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
dma_window,
+			bus->number);
 		ppci->iommu_table =3D iommu_init_table(tbl,
ppci->phb->node);
 		DBG("  created table: %p\n", ppci->iommu_table);
 	}
@@ -523,14 +517,10 @@ static void pci_dma_dev_setup_pSeriesLP(struct
pci_dev *dev)
=20
 	pci =3D PCI_DN(pdn);
 	if (!pci->iommu_table) {
-		/* iommu_table_setparms_lpar needs bussubno. */
-		pci->bussubno =3D pci->phb->bus->number;
-
 		tbl =3D kmalloc_node(sizeof(struct iommu_table),
GFP_KERNEL,
 				   pci->phb->node);
-
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
dma_window);
-
+		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
dma_window,
+			pci->phb->bus->number);
 		pci->iommu_table =3D iommu_init_table(tbl,
pci->phb->node);
 		DBG("  created table: %p\n", pci->iommu_table);
 	} else {
--=20
1.5.3.7



------------------------------

Message: 6
Date: Thu, 06 Dec 2007 14:22:27 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with
	64b	resources
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
Message-ID: <1196911347.7033.15.camel@pasglop>
Content-Type: text/plain


On Wed, 2007-12-05 at 17:40 +1100, Benjamin Herrenschmidt wrote:
> The current pci_assign_unassigned_resources() code doesn't work
properly
> on 32 bits platforms with 64 bits resources. The main reason is the
use
> of unsigned long in various places instead of resource_size_t.
>=20
> This fixes it, along with some tricks to avoid casting to 64 bits on
> platforms that don't need it in every printk around.
>=20
> This is a pre-requisite for making powerpc use the generic code
instead of
> its own half-useful implementation.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> This version fixes some stupid warnings when using 32 bits resources

 ... and has warnings on 64 bits platforms... GRRRR

This whole issue of printk vs. resource_size_t is a terrible mess :-(

Part of the problem is that resource_size_t can be either u32 or u64..

that is  it can be either unsigned int, unsigned long or unsigned long
long... and we have no way to reliably printk that.

Any clever idea before I start pushing filthy macros up linux/types.h ?

Cheers,
Ben.




------------------------------

Message: 7
Date: Thu, 6 Dec 2007 14:32:47 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Use SLB size from the device tree
To: Michael Neuling <mikey@neuling.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,	Will
	Schmidt <will_schmidt@vnet.ibm.com>
Message-ID: <18263.27999.950921.122870@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=3Dus-ascii

Michael Neuling writes:

> Currently we hardwire the number of SLBs but the PAPR says we export
an
> ibm,slb-size property to specify the number of SLB entries.  This
patch
> uses this property instead of assuming 64 always.  If no property is
> found, we assume 64 entries as before.

On 32-bit platforms (e.g. powermac) I get:

/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c: In function
'check_cpu_slb_size':
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error:
'mmu_slb_size' undeclared (first use in this function)
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error: (Each
undeclared identifier is reported only once
/home/paulus/kernel/powerpc/arch/powerpc/kernel/prom.c:592: error: for
each function it appears in.)
make[2]: *** [arch/powerpc/kernel/prom.o] Error 1

Paul.


------------------------------

Message: 8
Date: Thu, 06 Dec 2007 14:48:18 +1100
From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: drivers/net/iseries_veth.c dubious sysfs usage
To: Greg KH <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org, linux-kernel@vger.kernel.org,	David Gibson
	<dwg@au1.ibm.com>
Message-ID: <1196912898.14754.13.camel@concordia>
Content-Type: text/plain; charset=3D"us-ascii"

On Wed, 2007-12-05 at 13:41 -0800, Greg KH wrote:
> On Wed, Dec 05, 2007 at 10:10:31PM +1100, Michael Ellerman wrote:
> > On Wed, 2007-12-05 at 01:30 -0800, Greg KH wrote:
> > > In doing a massive kobject cleanup of the kernel tree, I ran
across the
> > > iseries_veth.c driver.
> > >=20
> > > It looks like the driver is creating a number of subdirectories
under
> > > the driver sysfs directory.  This is odd and probably wrong.  You
want
> > > these virtual connections to show up in the main sysfs device
tree, not
> > > under the driver directory.
> > >=20
> > > I'll be glad to totally guess and try to move it around in the
sysfs
> > > tree, but odds are I'll get it all wrong as I can't really test
this
> > > out :)
> > >=20
> > > Any hints on what this driver is trying to do in this sysfs
directories?
> >=20
> > I wrote the code, I think, but it's been a while - I'll have a look
at
> > it tomorrow.
>=20
> Yes, can you send me the sysfs tree output of the driver directory,
and
> what exactly the different files in there are supposed to be used for?

Sure. My version of tar (1.15.1) doesn't seem to be able to tar up /sys,
so hopefully this is sufficient:

igoeast:~# cd /sys/class/net/eth1/
igoeast:/sys/class/net/eth1# ls -la
total 0
drwxr-xr-x  4 root root    0 Dec  6 10:22 .
drwxr-xr-x  6 root root    0 Dec  6 10:21 ..
-r--r--r--  1 root root 4096 Dec  6 10:30 addr_len
-r--r--r--  1 root root 4096 Dec  6 10:30 address
-r--r--r--  1 root root 4096 Dec  6 10:30 broadcast
-r--r--r--  1 root root 4096 Dec  6 10:30 carrier
lrwxrwxrwx  1 root root    0 Dec  6 10:22 device ->
../../../devices/vio/3
-r--r--r--  1 root root 4096 Dec  6 10:30 dormant
-r--r--r--  1 root root 4096 Dec  6 10:30 features
-rw-r--r--  1 root root 4096 Dec  6 10:30 flags
-r--r--r--  1 root root 4096 Dec  6 10:30 ifindex
-r--r--r--  1 root root 4096 Dec  6 10:30 iflink
-r--r--r--  1 root root 4096 Dec  6 10:30 link_mode
-rw-r--r--  1 root root 4096 Dec  6 10:30 mtu
-r--r--r--  1 root root 4096 Dec  6 10:30 operstate
drwxr-xr-x  2 root root    0 Dec  6 10:30 statistics
lrwxrwxrwx  1 root root    0 Dec  6 10:30 subsystem ->
../../../class/net
-rw-r--r--  1 root root 4096 Dec  6 10:30 tx_queue_len
-r--r--r--  1 root root 4096 Dec  6 10:30 type
-rw-r--r--  1 root root 4096 Dec  6 10:30 uevent
drwxr-xr-x  2 root root    0 Dec  6 10:30 veth_port

Each net device has a port structure associated with it, the fields
should be fairly self explanatory, they're all read only I think.

igoeast:/sys/class/net/eth1# find veth_port/
veth_port/
veth_port/mac_addr
veth_port/lpar_map
veth_port/stopped_map
veth_port/promiscuous
veth_port/num_mcast


igoeast:/sys/class/net/eth1# cd device/driver

igoeast:/sys/class/net/eth1/device/driver# ls -l
total 0
lrwxrwxrwx  1 root root    0 Dec  6 10:21 2 -> ../../../../devices/vio/2
lrwxrwxrwx  1 root root    0 Dec  6 10:21 3 -> ../../../../devices/vio/3
--w-------  1 root root 4096 Dec  6 10:21 bind
drwxr-xr-x  2 root root    0 Dec  6 10:21 cnx00
drwxr-xr-x  2 root root    0 Dec  6 10:21 cnx02
drwxr-xr-x  2 root root    0 Dec  6 10:21 cnx03
drwxr-xr-x  2 root root    0 Dec  6 10:21 cnx04
lrwxrwxrwx  1 root root    0 Dec  6 10:21 module ->
../../../../module/iseries_veth
--w-------  1 root root 4096 Dec  6 10:21 uevent
--w-------  1 root root 4096 Dec  6 10:21 unbind

The driver has a connection to all the other lpars, this is entirely
independent of the net devices.

igoeast:/sys/class/net/eth1/device/driver# find cnx00/
cnx00/
cnx00/outstanding_tx
cnx00/remote_lp
cnx00/num_events
cnx00/reset_timeout
cnx00/last_contact
cnx00/state
cnx00/src_inst
cnx00/dst_inst
cnx00/num_pending_acks
cnx00/num_ack_events
cnx00/ack_timeout


> > Why is it "odd and probably wrong" to create subdirectories under
the
> > driver in sysfs?
>=20
> Because a driver does not have "devices" under it in the sysfs tree.
> All devices liven in the /sys/devices/ tree so we can properly manage
> them that way.  A driver will then bind to a device, and the driver
core
> will set up the linkages in sysfs properly so that everthing looks
> uniform.

OK. They're not "devices" that we create under the driver, they're just
attributes of the driver, and they happen to be in groups so I put them
in subdirectories.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url :
http://ozlabs.org/pipermail/linuxppc-dev/attachments/20071206/f7bfe206/a
ttachment-0001.pgp=20

------------------------------

Message: 9
Date: Wed, 5 Dec 2007 21:46:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Link up/down messages from 5200 ethernet driver
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,	Domen Puncer
	<domen.puncer@telargo.com>
Message-ID:
	<fa686aa40712052046s5887c9fewa61c2921a22f5c80@mail.gmail.com>
Content-Type: text/plain; charset=3DUTF-8

On 12/5/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Why does the fec5200 driver sometimes not print 'PHY' correctly?
>
> phyCORE-MPC5200B-tiny login: T?V? f0003000:10 - Link is Down
> T?Y: f0003000:10 - Link is Up - 100/Full
> T?Y: f0003000:10 - Link is Down
> PHY: f0003000:10 - Link is Up - 100/Full

Weird; that line comes from drivers/net/phy/phy.c in
phy_print_status(), and it's just a a pr_info statement.  I suppose it
might be a stack overrun, but I'd expect more severe symptoms if that
was the case.

That *looks* like a serial stream corruption.  Is that the output of
your serial port?  Does dmesg show the same corruption?

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

------------------------------

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

End of Linuxppc-dev Digest, Vol 40, Issue 57
********************************************

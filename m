Message-ID: <38B38AA3.8D4ECC2C@pop.agri.ch>
Date: Wed, 23 Feb 2000 08:22:17 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: rboder@grn.georet.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerMac G4 and pcmcia flash cards
References: <38B341A7.9F6E5DEC@grn.georet.net>
Content-Type: multipart/mixed;
 boundary="------------DE83C4160FFF4D2A6213B650"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------DE83C4160FFF4D2A6213B650
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Ryan Boder wrote:
>
> Hi,
>
> need to write a little boot prom and I would like to use my G4 to put it
> on a flash card. I have tried using pcmcia card services by David Hinds
> and it won't even install. This is no surprise since he claims in the
> HOWTO that Macs are not supproted yet. How you guys been using pcmcia
> devices and does anyone know if I can do it on my G4?

For the basic services I can run he latest 3.1.11 package from David
with minor patching. It works well at least for Modems. A bit more
tweaking on the kernel side and I get CardBus services to run, e.g my
Xircom CBEM56G Modem/ethernet card. This is done on a Wallstreet I.
How about G4? I don't know, I suppose they don't have a PCI-TO-CARDBUS
bridge or even PCMCIA unless you add a card reader.

For the kernel patches, if you need them, they come later since I'm on work.

Andreas
--------------DE83C4160FFF4D2A6213B650
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="522A6368";
 name="pcmcia-cs-ppc.patch"
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="pcmcia-cs-ppc.patch"
Content-Transfer-Encoding: 7bit

diff -u --recursive pcmcia-cs-3.1.9/etc/config pcmcia-cs-3.1.9.orig/etc/config
--- pcmcia-cs-3.1.9/etc/config	Tue Jan 25 20:44:19 2000
+++ pcmcia-cs-3.1.9.orig/etc/config	Mon Jan 24 19:01:10 2000
@@ -40,7 +40,7 @@
   class "ftl" module "ftl_cs"

 device "serial_cs"
-  class "serial" module "serial_cs"
+  class "serial" module "misc/serial", "serial_cs"

 device "parport_cs"
   class "parport" module "parport_cs"
diff -u --recursive pcmcia-cs-3.1.9/etc/config.opts pcmcia-cs-3.1.9.orig/etc/config.opts
--- pcmcia-cs-3.1.9/etc/config.opts	Tue Jan 25 20:44:19 2000
+++ pcmcia-cs-3.1.9.orig/etc/config.opts	Mon Jan 24 18:59:31 2000
@@ -1,52 +1,20 @@
 #
 # Local PCMCIA Configuration File
 #
-#----------------------------------------------------------------------
-
 # System resources available for PCMCIA devices
-
-include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
-include memory 0xc0000-0xfffff
-include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
-
-# High port numbers do not always work...
-# include port 0x1000-0x17ff
-
-# Extra port range for IBM Token Ring
-include port 0xa00-0xaff
-
+#
+include port 0x0-0xfff
+include memory 0x90000000-0x90ffffff
 # Resources we should not use, even if they appear to be available
-
-# First built-in serial port
-exclude irq 4
-# Second built-in serial port
-#exclude irq 3
-# First built-in parallel port
-exclude irq 7
-
-#----------------------------------------------------------------------
-
+#
+#
 # Examples of options for loadable modules
-
+#
 # To fix sluggish network with IBM ethernet adapter...
 #module "pcnet_cs" opts "mem_speed=600"
-
-# Options for IBM Token Ring adapters
-#module "ibmtr_cs" opts "mmiobase=0xd0000 srambase=0xd4000"
-
-# Options for Raylink/WebGear driver: uncomment only one line...
-# Generic ad-hoc network
-module "ray_cs" opts "pc_debug=1 essid=ADHOC_ESSID hop_dwell=128 beacon_period=256 translate=1"
-# Infrastructure network for older cards
-#module "ray_cs" opts "pc_debug=1 net_type=1 essid=ESSID1"
-# Infrastructure network for WebGear
-#module "ray_cs" opts "pc_debug=1 net_type=1 essid=ESSID1 translate=1 hop_dwell=128 beacon_period=256"
-
-# Options for WaveLAN/IEEE driver (AccessPoint mode)...
-#module "wvlan_cs" opts "station_name=MY_PC"
-# Options for WaveLAN/IEEE driver (ad-hoc mode)...
-#module "wvlan_cs" opts "port_type=3 channel=1 station_name=MY_PC"
-
+#
 # Options for Xircom Netwave driver...
 #module "netwave_cs" opts "domain=0x100 scramble_key=0x0"
-
+#
+# Options for IBM Token Ring adapters
+#module "ibmtr_cs" opts "mmiobase=0xd0000 srambase=0xd4000"
\ No newline at end of file
diff -u --recursive pcmcia-cs-3.1.9/modules/cs.c pcmcia-cs-3.1.9.orig/modules/cs.c
--- pcmcia-cs-3.1.9/modules/cs.c	Tue Jan 25 20:44:19 2000
+++ pcmcia-cs-3.1.9.orig/modules/cs.c	Mon Jan 24 18:57:54 2000
@@ -457,6 +457,10 @@
     /* Blank out the socket state */
     s->state &= SOCKET_PRESENT|SOCKET_SETUP_PENDING;
     init_socket(s);
+#ifdef __powerpc__
+    s->socket.flags |= SS_EJECTION;
+    s->ss_entry(s->sock, SS_SetSocket, &s->socket);
+#endif
     s->irq.AssignedIRQ = s->irq.Config = 0;
     s->functions = 0;
     s->lock_count = 0;
diff -u --recursive pcmcia-cs-3.1.9/modules/i82365.c pcmcia-cs-3.1.9.orig/modules/i82365.c
--- pcmcia-cs-3.1.9/modules/i82365.c	Tue Jan 25 20:44:19 2000
+++ pcmcia-cs-3.1.9.orig/modules/i82365.c	Mon Jan 24 19:18:42 2000
@@ -58,6 +58,12 @@
 #include <asm/system.h>
 #endif

+#ifdef __powerpc__
+#include <asm/prom.h>
+#include <asm/adb.h>
+#include <asm/pmu.h>
+#endif /* __powerpc__ */
+
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
 #include <pcmcia/ss.h>
@@ -238,6 +244,12 @@
     u_char		cache, pmcs;
     u_int		cb_phys;
     char		*cb_virt;
+
+#ifdef __powerpc__
+    int			pmu_socket;
+    struct 		adb_request	pmu_req;
+#endif /* __powerpc__ */
+
 #endif
     union {
 	cirrus_state_t		cirrus;
@@ -1543,6 +1555,32 @@
 	}
 #endif
     }
+#ifdef __powerpc__
+    /* work out the mapping to PMU socket number */
+    {
+	struct device_node *np;
+	for (i = 0; i < ns; ++i) {
+	    s[i].pmu_socket = 0;
+	    s[i].pmu_req.complete = 1;
+	}
+	for (np = find_type_devices("pccard"); np != NULL; np = np->next) {
+	    int *reg = (int *) get_property(np, "reg", NULL);
+	    int *ps = (int *) get_property(np, "AAPL,pmu-socket-number", NULL);
+	    int bus, devfn;
+	    if (reg == NULL || ps == NULL)
+		continue;
+	    bus = (reg[0] >> 16) & 0xff;
+	    devfn = (reg[0] >> 8) & 0xff;
+	    for (i = 0; i < ns; ++i) {
+		if (s[i].bus == bus && s[i].devfn == devfn) {
+		    s[i].pmu_socket = *ps;
+		    DEBUG(2, ("socket %d is pmu socket %d\n", i, *ps));
+		    break;
+		}
+	    }
+	}
+    }
+#endif

 } /* add_pcic */

@@ -2156,6 +2194,16 @@
     }
     i365_set(s, I365_CSCINT, reg);
     i365_get(s, I365_CSC);
+
+
+#ifdef __powerpc__
+    if (state->flags & SS_EJECTION) {
+	if (s->pmu_socket != 0 && s->pmu_req.complete)
+	    pmu_request(&s->pmu_req, NULL, 2, PMU_PCEJECT, s->pmu_socket);
+	state->flags &= ~SS_EJECTION;
+    }
+#endif
+
 #ifdef CONFIG_PCI
     if (s->flags & IS_CARDBUS) {
 	if (s->cs_irq || (pci_csc && s->cap.pci_irq))
@@ -2357,6 +2405,15 @@
     DEBUG(1, "yenta: GetSocket(%d) = flags %#3.3x, Vcc %d, Vpp %d, "
 	  "io_irq %d, csc_mask %#2.2x\n", s-socket, state->flags,
 	  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
+
+#ifdef __powerpc__
+    if (state->flags & SS_EJECTION) {
+	if (s->pmu_socket != 0 && s->pmu_req.complete)
+	    pmu_request(&s->pmu_req, NULL, 2, PMU_PCEJECT, s->pmu_socket);
+	state->flags &= ~SS_EJECTION;
+    }
+#endif
+
     return 0;
 } /* cb_get_socket */

--------------DE83C4160FFF4D2A6213B650--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <flylist@linuxkernel.net>
Received: from sarang.flyduck.com (c-24-6-74-43.client.comcast.net
	[24.6.74.43]) by ozlabs.org (Postfix) with ESMTP id 6D3F82BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 11:52:03 +1100 (EST)
Message-Id: <200501130009.j0D09vra020125@sarang.flyduck.com>
From: "Ho Lee" <flylist@linuxkernel.net>
To: "'linuxppc'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 12 Jan 2005 16:14:49 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <F9865C8B04ED3A4D8D793FCE19368854F2FBDF@EXCHANGE01.corp.skystream.com>
Cc: 'Steffen Rumler' <Steffen.Rumler@siemens.com>
Subject: RE: Kernel boot hangs by parallel flood pings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I met the same problem in CPM driver, and there could be many 
solutions. I think the right place to fix is the fec driver. 
The fec driver registers interrupt handler during the 
initialization not when the device is opened, so it may
receive packets even the device is not up and running (also 
before the network subsystem is initialized) My fix was to 
ignore the received packets if the driver is not opened. 

--- linux-2.4.26.orig/arch/ppc/8xx_io/fec.c
+++ linux-2.4.26/arch/ppc/8xx_io/fec.c 
@@ -587,6 +587,9 @@
                goto rx_processing_done;
        }
 
+       if (!netif_running(dev))
+           goto rx_processing_done;
+
        /* Process the incoming frame.
         */
        fep->stats.rx_packets++;


Regards,
Ho

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Rune Torgersen
Sent: Wednesday, January 12, 2005 7:32 AM
To: Steffen Rumler; linuxppc
Subject: RE: Kernel boot hangs by parallel flood pings

--- Kernel.old/net/ipv4/ip_output.c     Thu Jun  5 09:00:39 2003
+++ Kernel/net/ipv4/ip_output.c Thu Jun  5 09:00:28 2003
@@ -1087,11 +1087,11 @@

 void __init ip_init(void)
 {
-       dev_add_pack(&ip_packet_type);
-
        ip_rt_init();
        inet_initpeers();

+       dev_add_pack(&ip_packet_type);
+
 #ifdef CONFIG_IP_MULTICAST
        proc_net_create("igmp", 0, ip_mc_procinfo);
 #endif
>>

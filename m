From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel Panic while building IP or TCP hash tables
Date: Wed, 18 Jun 2003 16:04:44 +0200
Message-ID: <000001c335a2$9767eb50$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After many days of tests, I can say that the system does not crash anymore
with the patch installed.

The most difficult thing is to determine the frames which generate the
kernel panic.
I can exclude arp broadcast frames and ip unicast frames.
It seems that the multicast frames are the origin of the system crash but I
can't say
if it is the only case.

The system runs in any case with the patch. Use it !!!

Thanks to Jean-Denis Boyer

Gérard Guével


-----Message d'origine-----
De : Jean-Denis Boyer [mailto:jdboyer@m5t.com]
Envoyé : jeu. 5 juin 2003 14:09
À : Gérard Guével
Cc : linuxppc-embedded@lists.linuxppc.org
Objet : RE: Kernel Panic while building IP or TCP hash tables



I experienced a similar problem with my system, I was not sure if it was
specific to my implementation. Can you try the following patch and tell us
if it helps?

It registers the IPv4 handling functions AFTER initializing the IP routing
stuff. Early packets could enter the stack and crash the system.

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


Salutations,

--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

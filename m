Mime-Version: 1.0
Message-Id: <p05101000b7fe0531e893@[10.0.0.42]>
In-Reply-To: <3BD82792.49CDFF62@mandrakesoft.com>
References: <20011023211459.NUPA19597.tomts17-srv.bellnexxia.net@there>
 <3BD60FF5.24C4B841@mandrakesoft.com>
 <20011025134153.EDVF12483.tomts13-srv.bellnexxia.net@there>
 <3BD82792.49CDFF62@mandrakesoft.com>
Date: Thu, 25 Oct 2001 16:30:50 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: tulip (was Re: any easy way to force 10/100 nics to 10?)
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:54 AM -0400 10/25/01, Jeff Garzik wrote:
>"Kevin B. Hendricks" wrote:
>>
>>  Hi,
>>
>>  One other question:
>>
>>  Why are we advertising more than our capabilities and what is 100baseT4?
>>
>>  >   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>>  >   advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD
>
>Looks like a bug...

Speaking of tulip and PPC, I think I sent you the attached endianness fix
for ADMTek Comet chips a while back, but it doesn't appear to have gotten
into any trees yet.  The first and last parts fix problems where the
ethernet MAC address would get mangled during the process of reading &
writing the hardware MAC address registers.  The middle part does the same
for the write to the multicast hash filter registers (which appear to be
similar to the MAC address registers).  I don't know how to test multicast
so I don't know if that part of the patch is necessary, but the MAC address
fix is necessary to get the chip working properly on PPC (& other BE cpus).

I still have problems with poor Tx performance on PPC.  In an x86 notebook,
the card can transmit with full 100 Mbps throughput, but in two different
PPC notebooks it only manages ~20-30 Mbps.  Both architectures receive at
100 Mbps.  Haven't figured out what's going on there.

What's really needed for accessing the MAC and multicast hash registers are
nonswapping forms of outl and inl.  I looked at insl_ns and outsl_ns but
they appeared to be enough different in implementation from outl and inl
that I didn't want to risk using them (the calculation of the I/O address
appeared to be different, at least on PPC).


--- tulip_core.c.orig	Mon Sep 24 02:55:16 2001
+++ tulip_core.c	Thu Oct  4 22:27:09 2001
@@ -306,7 +306,7 @@
  	}
  	if (tp->flags & MC_HASH_ONLY) {
  		u32 addr_low = cpu_to_le32(get_unaligned((u32
*)dev->dev_addr));
-		u32 addr_high = cpu_to_le32(get_unaligned((u16
*)(dev->dev_addr+4)));
+		u32 addr_high = cpu_to_le32(get_unaligned((u32
*)(dev->dev_addr+4)));
  		if (tp->chip_id == AX88140) {
  			outl(0, ioaddr + CSR13);
  			outl(addr_low,  ioaddr + CSR14);
@@ -1175,12 +1175,12 @@
  				;				/* No
change. */
  			else if (tp->flags & IS_ASIX) {
  				outl(2, ioaddr + CSR13);
-				outl(mc_filter[0], ioaddr + CSR14);
+				outl(cpu_to_le32(mc_filter[0]),
ioaddr + CSR14);
  				outl(3, ioaddr + CSR13);
-				outl(mc_filter[1], ioaddr + CSR14);
+				outl(cpu_to_le32(mc_filter[1]),
ioaddr + CSR14);
  			} else if (tp->flags & COMET_MAC_ADDR) {
-				outl(mc_filter[0], ioaddr + 0xAC);
-				outl(mc_filter[1], ioaddr + 0xB0);
+				outl(cpu_to_le32(mc_filter[0]), ioaddr + 0xAC);
+				outl(cpu_to_le32(mc_filter[1]), ioaddr + 0xB0);
  			}
  			tp->mc_filter[0] = mc_filter[0];
  			tp->mc_filter[1] = mc_filter[1];
@@ -1551,8 +1551,8 @@
  		}
  	} else if (chip_idx == COMET) {
  		/* No need to read the EEPROM. */
-		put_unaligned(inl(ioaddr + 0xA4), (u32 *)dev->dev_addr);
-		put_unaligned(inl(ioaddr + 0xA8), (u16 *)(dev->dev_addr + 4));
+		put_unaligned(le32_to_cpu(inl(ioaddr + 0xA4)), (u32
*)dev->dev_addr);
+		put_unaligned(le32_to_cpu(inl(ioaddr + 0xA8)), (u32
*)(dev->dev_addr + 4));
  		for (i = 0; i < 6; i ++)
  			sum += dev->dev_addr[i];
  	} else {

--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECC4C688B3
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Dec 2005 08:36:37 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id CF2A7E9E3
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2005 22:36:32 +0100 (CET)
Date: Sat, 10 Dec 2005 22:36:32 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051210213632.GA21561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: ARCH=powerpc doesnt boot on 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My 7200 doesnt boot if the kernel runs at 32MB. It dies somewhere after turn_on_mmu().
It boots ok if it runs at 7MB.  2.6.14 and earlier booted ok with 32MB.
Any idea how to fix this? What does ARCH=powerpc different in this regard?

0 > boot file: 1.1.1.3,coffloading XCOFF
tsize=4E08 dsize=1547BC bsize=BC80 entry=500000
SECTIONS:
.text    00500000 00500000 00004E08 000000FC
.data    00505000 00505000 001547BC 00004F04
.bss     0065A000 0065A000 0000BC80 00000000
.note.GN 00000000 00000000 00000000 00000000
loading .text, done..
loading .data, done..
clearing .bss, done..

zImage starting: loaded at 0x00500000 (sp: 0x003fff00)
Allocating 0x4b4660 bytes for kernel ...
OF version = 'Open Firmware, 1.0.5'
old OF detected
gunzipping (0x700000 <- 0x505c44:0x6597bb)...done 0x29d618 bytes
entering kernel at 0x00710000(deadbeef/deadbeef/ff8099b8)
OF stdout device is: /bandit@F2000000/gc@10/escc@13000/ch-a@13020
command line:
root_addr_cells: 00000001
root_size_cells: 00000001
scanning memory:
  node /memory@0 :
    00000000 04800000
memory layout at init:
  memory_limit : 00000000 (16 MB aligned)
  alloc_bottom : 00bb9000
  alloc_top    : 04800000
  alloc_top_hi : 04800000
  rmo_top      : 04800000
  ram_top      : 04800000
Looking for displays
found display   : /bandit@F2000000/IMS,tt128mb8@F, opening ... done
found display   : /platinum@F8000000, opening ... failed
copying OF device tree ...
starting device tree allocs at 00bb9000
alloc_up(00100000, 00001000)
    trying: 0x00bb9000
 -> 00bb9000
  alloc_bottom : 00bb9000
  alloc_top    : 04800000
  alloc_top_hi : 04800000
  rmo_top      : 04800000
  ram_top      : 04800000
Building dt strings...
Building dt structure...
reserved memory map:
  00bb9000 - 00010000
Device tree strings 0x00bba000 -> 0x00bba4bf
Device tree struct  0x00bbb000 -> 0x00bc9000
Calling quiesce ...
returning from prom_init
->dt_header_start=0x00bb9000
 -> early_init_devtree()
...

--- /dev/shm/k_good.txt 2005-12-10 22:03:33.221815504 +0100
+++ /dev/shm/k_bad.txt  2005-12-10 22:04:12.027916080 +0100
@@ -7,7 +7,7 @@
     00000000 04800000
 memory layout at init:
   memory_limit : 00000000 (16 MB aligned)
-  alloc_bottom : 00bb9000
+  alloc_bottom : 024b9000
   alloc_top    : 04800000
   alloc_top_hi : 04800000
   rmo_top      : 04800000
@@ -16,11 +16,14 @@
 found display   : /bandit@F2000000/IMS,tt128mb8@F, opening ... done
 found display   : /platinum@F8000000, opening ... failed
 copying OF device tree ...
-starting device tree allocs at 00bb9000
+starting device tree allocs at 024b9000
 alloc_up(00100000, 00001000)
-    trying: 0x00bb9000
- -> 00bb9000
-  alloc_bottom : 00bb9000
+    trying: 0x024b9000
+CLAIM failed    trying: 0x025b9000
+CLAIM failed    trying: 0x026b9000
+CLAIM failed    trying: 0x027b9000
+ -> 027b9000
+  alloc_bottom : 027b9000
   alloc_top    : 04800000
   alloc_top_hi : 04800000
   rmo_top      : 04800000
@@ -28,23 +31,22 @@
 Building dt strings...
 Building dt structure...
 reserved memory map:
-  00bb9000 - 00010000
-Device tree strings 0x00bba000 -> 0x00bba4bf
-Device tree struct  0x00bbb000 -> 0x00bc9000
+  027b9000 - 00010000
+Device tree strings 0x027ba000 -> 0x027ba4bf
+Device tree struct  0x027bb000 -> 0x027c9000
 Calling quiesce ...
 returning from prom_init
-->dt_header_start=0x00bb9000
+->dt_header_start=0x027b9000

-- 
short story of a lazy sysadmin:
 alias appserv=wotan

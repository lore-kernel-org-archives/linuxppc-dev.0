Message-ID: <3BF52F0C.7020608@humboldt.co.uk>
Date: Fri, 16 Nov 2001 15:21:48 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Allow small areas in io_block_mapping
Content-Type: multipart/mixed;
 boundary="------------050005070500070601060905"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050005070500070601060905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch stops io_block_mapping() from attempting to use BATs
for areas too small to fit in a BAT.  (On the port I'm currently
developing, the board uses high-order address lines to distinguish
between register groups, and I'm trying to allocate a page for each group.)

--
Adrian Cox   http://www.humboldt.co.uk/

--------------050005070500070601060905
Content-Type: text/plain;
 name="pgtable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pgtable.patch"

===== arch/ppc/mm/pgtable.c 1.7 vs edited =====
--- 1.7/arch/ppc/mm/pgtable.c	Sun Nov  4 18:54:46 2001
+++ edited/arch/ppc/mm/pgtable.c	Fri Nov 16 15:12:48 2001
@@ -242,7 +242,7 @@
 	/*
 	 * Use a BAT for this if possible...
 	 */
-	if (io_bat_index < 2 && is_power_of_2(size)
+	if (io_bat_index < 2 && is_power_of_2(size) && size >= 0x20000
 	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
 		setbat(io_bat_index, virt, phys, size, flags);
 		++io_bat_index;

--------------050005070500070601060905--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

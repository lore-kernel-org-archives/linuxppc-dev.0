Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 807FE67A61
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 11:21:45 +1100 (EST)
Message-ID: <42016E92.50905@mvista.com>
Date: Wed, 02 Feb 2005 17:21:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
References: <42016E33.9070804@mvista.com>
In-Reply-To: <42016E33.9070804@mvista.com>
Content-Type: multipart/mixed; boundary="------------030901020404010204080804"
Cc: Brian Waite <waite@skycomputers.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] fix locking bugs in mv64x60 code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------030901020404010204080804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And with the patch this time...
--
Mark A. Greer wrote:

> [Original patch slightly edited by mgreer]
>
> This patch fixes 2 SMP deadlocks. The first is that mv64x60_read() was 
> returning before the unlock. The second was mv64x60_modify() locks the 
> spin lock and calls mv64x60_read() and mv64x60_write() which also lock 
> the same spin lock.
>
> Please apply.
>
> Signed-Off-By: Brian Waite <waite@skycomputers.com>
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
>
>


--------------030901020404010204080804
Content-Type: text/plain;
 name="mv_smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv_smp.patch"

diff -Nru a/arch/ppc/syslib/mv64x60.c b/arch/ppc/syslib/mv64x60.c
--- a/arch/ppc/syslib/mv64x60.c	2005-02-02 17:15:26 -07:00
+++ b/arch/ppc/syslib/mv64x60.c	2005-02-02 17:15:26 -07:00
@@ -32,7 +32,7 @@
 
 
 u8		mv64x60_pci_exclude_bridge = 1;
-spinlock_t	mv64x60_lock; /* Only really used by PIC code once init done */
+spinlock_t	mv64x60_lock = SPIN_LOCK_UNLOCKED;
 
 static phys_addr_t 	mv64x60_bridge_pbase = 0;
 static void 		*mv64x60_bridge_vbase = 0;
diff -Nru a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h	2005-02-02 17:15:26 -07:00
+++ b/include/asm-ppc/mv64x60.h	2005-02-02 17:15:26 -07:00
@@ -254,10 +254,12 @@
 extern inline u32
 mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
 	ulong	flags;
+	u32     reg;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
-	return in_le32(bh->v_base + offset);
+	reg = in_le32(bh->v_base + offset);
 	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	return reg;
 }
 
 extern inline void
@@ -267,9 +269,9 @@
 	ulong	flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
-	reg = mv64x60_read(bh, offs) & (~mask); /* zero bits we care about */
-	reg |= data & mask; /* set bits from the data */
-	mv64x60_write(bh, offs, reg);
+	reg = in_le32(bh->v_base + offs) & (~mask);
+	reg |= data & mask;
+	out_le32(bh->v_base + offs, reg);
 	spin_unlock_irqrestore(&mv64x60_lock, flags);
 }
 

--------------030901020404010204080804--

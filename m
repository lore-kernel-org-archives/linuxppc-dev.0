Date: Tue, 29 Jul 2003 08:15:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kalpesh Jasapara <kjasapara@yahoo.com>
Cc: tliang@yahoo.com, Matt Porter <mporter@kernel.crashing.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: "alloc_area_pte: page already exists"
Message-ID: <20030729081526.A26346@home.com>
References: <20030729062348.20980.qmail@web14601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030729062348.20980.qmail@web14601.mail.yahoo.com>; from kjasapara@yahoo.com on Mon, Jul 28, 2003 at 11:23:48PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 28, 2003 at 11:23:48PM -0700, Kalpesh Jasapara wrote:
> Hello,
>
> >From the code it appears that iounmap() or vfree() of
> any virtual address that maps physical address beyond
> the 32 bit address space, especially in case of PPC
> 440 (where pte_t is defined as unsigned long long ),
> free_area_pte() will return without completely
> clearing out the pte.
>
> If the pte has not completely been cleaned up (all 64
> bits) during the iounmap(or vfree) is it possible that
> pte_none() would complain and you see the messages ?
>
> Matt, do you think it is a bug ?
> the FIXME suggests that this needs to be cleaned up.

Yes it is...good catch. :)  The FIXME comment in pte_update()
is really suggesting that the interface isn't suitable for
64-bit PTE.  We can fix this by providing a suitable
_PTE_NONE_MASK, it's intended to be used in PTEs where everything
isn't cleared.

It would be interesting to hear if the following patch solves
the original problem.  It helps me.

-Matt

===== include/asm-ppc/pgtable.h 1.41 vs edited =====
--- 1.41/include/asm-ppc/pgtable.h      Wed Jul 16 18:38:55 2003
+++ edited/include/asm-ppc/pgtable.h    Tue Jul 29 06:25:15 2003
@@ -220,6 +220,9 @@
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD       (~PAGE_MASK)

+/* ERPN in a PTE never gets cleared, ignore it */
+#define _PTE_NONE_MASK 0xffffffff00000000ULL
+
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT  0x0001  /* Page is valid */

--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

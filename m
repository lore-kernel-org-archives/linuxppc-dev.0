From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 16:08:49 -0700
To: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030304230849.GB4683@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E650AAF.7060804@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 08:21:03PM +0000, Dan Malek wrote:
> Well, one option that may be the easiest is to just change all
> of the linux head.S files to have the three nops again.  When we
> split these file apart a while back, we just removed everything that
> wasn't necessary.  Just put a note in those files why they are
> present.  They don't cost anything since these are exception vector
> locations or temporary storage locations for special purposes.

What about this approach?

The problem is that on some systems, the cpu 1 runs at
__secondary_hold before cpu 0 runs at _start and __secondary_hold
overwrites the nop at 0x4.

If we branch around the the the word at 0x4, the kernel can start
at 0 and we don't need to modify the other head.S files.

The following patch works on my SMP system.

Thanks,
-Dale

===== head.S 1.80 vs edited =====
--- 1.80/arch/ppc/kernel/head.S	Thu Feb 27 12:40:15 2003
+++ edited/head.S	Tue Mar  4 15:52:24 2003
@@ -88,8 +88,13 @@
 	 * but we're always started by some kind of bootloader now.
 	 *  -- Cort
 	 */
-	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
-	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
+	/*
+	 * The first two words are used by __secondary_hold on SMP systems.
+	 * The second word may be overwritten before the first cpu runs
+	 * here, so we branch around it.
+	 */
+	b	__start
+	nop
 	nop

 /* PMAC

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

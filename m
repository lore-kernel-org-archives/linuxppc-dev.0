Date: Thu, 27 Mar 2003 13:25:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Fix memory size not being passed to kernel from prep boot loader
Message-ID: <20030327202554.GH31771@ip68-0-152-218.tc.ph.cox.net>
References: <63228.213.107.143.228.1048441818.squirrel@www.solinno.co.uk> <20030327201313.GG31771@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030327201313.GG31771@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 27, 2003 at 01:13:13PM -0700, Tom Rini wrote:
>
> On Sun, Mar 23, 2003 at 05:50:18PM -0000, Leigh Brown wrote:
>
> > Current linuxppc_2_4 doesn't work on my 140 because the boot loader isn't
> > passing in the memory size.  This patch fixes that.
>
> Paul broke it in the massive merge of other PReP changes.  Can you try
> just adding the BI_MEM_SIZE record code in?  The rest of those changes
> should be superfluous.  Thanks.

Ah, I think not.  How about the following patch?  I didn't want to
remove the 'residual = hold_residual' line due to SMP things
referencing both.  Troy, can you explain why it's not consistenly
referencing 'hold_residual' ?

===== arch/ppc/boot/prep/misc.c 1.10 vs edited =====
--- 1.10/arch/ppc/boot/prep/misc.c	Tue Feb 11 13:37:28 2003
+++ edited/arch/ppc/boot/prep/misc.c	Thu Mar 27 13:23:19 2003
@@ -129,7 +129,8 @@
 #endif
 	extern unsigned long start;
 	char *cp;
-	unsigned long TotalMemory;
+	/* Default to 32MiB memory. */
+	unsigned long TotalMemory = 0x02000000;
 	int dev_handle;
 	int mem_info[2];
 	int res, size;
@@ -217,13 +218,14 @@
 				start_multi = 1;
 		}
 		memcpy(hold_residual,residual,sizeof(RESIDUAL));
+
+		/* Copy the memory info. */
+		if (residual->TotalMemory)
+			TotalMemory = residual->TotalMemory;
 	} else {
 		/* Tell the user we didn't find anything. */
 		puts("No residual data found.\n");

-		/* Assume 32M in the absence of more info... */
-		TotalMemory = 0x02000000;
-
 		/*
 		 * This is a 'best guess' check.  We want to make sure
 		 * we don't try this on a PReP box without OF
@@ -255,8 +257,6 @@
 			TotalMemory = mem_info[1];
 			break;
 		}
-
-		hold_residual->TotalMemory = TotalMemory;
 		residual = hold_residual;

 		/* Enforce a sane MSR for booting. */
@@ -379,6 +379,11 @@

 		rec->tag = BI_FIRST;
 		rec->size = sizeof(struct bi_record);
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
+		rec->tag = BI_MEMSIZE;
+		rec->data[0] = TotalMemory;
+		rec->size = sizeof(struct bi_record) + sizeof(unsigned long);
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);

 		rec->tag = BI_BOOTLOADER_ID;

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

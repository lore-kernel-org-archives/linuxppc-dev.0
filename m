Date: Tue, 19 Nov 2002 11:19:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
Message-ID: <20021119181943.GE779@opus.bloom.county>
References: <3DD3C747.8B7EE5CD@opensource.se> <20021114174807.GC605@opus.bloom.county> <3DD4E271.16FA374A@opensource.se> <20021119181107.GD779@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021119181107.GD779@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 19, 2002 at 11:11:07AM -0700, Tom Rini wrote:

[snip]
> Yeah, I'm sure too.  Here's an untested patch vs current
> linuxppc_2_4_devel, which will relocate the initrd if needed.  The

And here it actually is.

===== arch/ppc/boot/common/misc-simple.c 1.24 vs edited =====
--- 1.24/arch/ppc/boot/common/misc-simple.c	Fri Oct 25 17:26:48 2002
+++ edited/arch/ppc/boot/common/misc-simple.c	Tue Nov 19 11:03:16 2002
@@ -82,6 +82,7 @@
 	char *cp, ch;
 	struct bi_record *rec, *birecs;
 	unsigned long TotalMemory = 0;
+	unsigned long initrd_loc;

 	serial_fixups();
 	com_port = serial_init(0, NULL);
@@ -145,6 +146,18 @@
 		puts("initrd at:     ");
 		puthex((unsigned long)(&__ramdisk_begin));
 		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
+		/* Make sure we don't put the bi_recs inside the initrd. */
+		if ((_ALIGN((unsigned long)(zimage_size) + (1 << 20) - 1,
+						(1 << 20))) <=
+				(unsigned long)(&__ramdisk_end)) {
+			initrd_loc = _ALIGN((unsigned long)(initrd_size) +
+					(2 << 20) - 1, (2 << 20));
+			memcpy(&initrd_loc, &__ramdisk_end, initrd_size);
+			puts("relocated to:  "); puthex(initrd_loc);
+			puts(" "); puthex(initrd_loc + initrd_size);
+			puts("\n");
+		} else
+			initrd_loc = (unsigned long)(&__ramdisk_begin);
 	}

 	avail_ram = (char *)0x00400000;
@@ -234,7 +247,7 @@

 	if ( initrd_size ) {
 		rec->tag = BI_INITRD;
-		rec->data[0] = (unsigned long)(&__ramdisk_begin);
+		rec->data[0] = initrd_loc;
 		rec->data[1] = initrd_size;
 		rec->size = sizeof(struct bi_record) + 2 *
 			sizeof(unsigned long);

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

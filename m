Date: Wed, 28 Nov 01 09:05:56 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111281705.AA27318@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: A little fix
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom,

I think you've goofed a little bit again:

ChangeSet@1.699, 2001-11-27 15:44:22-07:00, trini@opus.bloom.county
  'bootinfo' is wrong, 'bi_record' is right, whoops.

  arch/ppc/boot/common/misc-simple.c
    1.12 01/11/27 15:44:21 trini@opus.bloom.county +3 -5
    struct bootinfo -> struct bi_record.

After this change misc-simple.c doesn't compile due to a missing semicolon, and
even if it compiled it would return the wrong address (we need the start of
bi_recs, not the end). The fix is below.

MS

diff --minimal -Nru a/arch/ppc/boot/common/misc-simple.c b/arch/ppc/boot/common/misc-simple.c
--- a/arch/ppc/boot/common/misc-simple.c	Wed Nov 28 08:53:35 2001
+++ b/arch/ppc/boot/common/misc-simple.c	Wed Nov 28 08:53:35 2001
@@ -63,7 +63,8 @@
 {
 	int timer = 0;
 	char *cp, ch;
-	struct bi_record *rec
+	struct bi_record *rec;
+	struct bi_record *birecs;

 	setup_legacy();
 	com_port = serial_init(0, NULL);
@@ -159,6 +160,7 @@
 	 */
 	rec = (struct bi_record *)_ALIGN((unsigned long)(zimage_size) +
 			(1 << 20) - 1, (1 << 20));
+	birecs = rec;

 	rec->tag = BI_FIRST;
 	rec->size = sizeof(struct bi_record);
@@ -184,5 +186,5 @@
 	rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	puts("Now booting the kernel\n");

-	return rec;
+	return birecs;
 }

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

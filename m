From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup 
In-reply-to: Your message of "Sun, 26 Aug 2001 20:04:04 MST."
             <20010826200404.E1481@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 13:45:51 +1000
Message-ID: <22437.998883951@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Please check that this patch against modutils 2.4.7 works.  It puts the
ftr fixup data in the archdata section of PPC modules.  Use
"insmod -nm -o blob module_name" to get a map and check that the
generated blob contains an archdata section containing the ftr fixup
pointers.  Pick any module from 2.4.8-ac12 that contains ftr data,
something using get_cycles will do.

The kernel does not do anything with the ppc archdata from modules yet,
that is a separate patch.


Index: 8.5/obj/obj_ppc.c
--- 8.5/obj/obj_ppc.c Fri, 05 Jan 2001 12:45:19 +1100 kaos (modutils-2.4/c/11_obj_ppc.c 1.1 644)
+++ 8.5(w)/obj/obj_ppc.c Mon, 27 Aug 2001 13:38:47 +1000 kaos (modutils-2.4/c/11_obj_ppc.c 1.1 644)
@@ -249,7 +249,25 @@ arch_finalize_section_address(struct obj
 }

 int
-arch_archdata (struct obj_file *fin, struct obj_section *sec)
+arch_archdata (struct obj_file *f, struct obj_section *archdata_sec)
 {
+  struct archdata {
+    unsigned tgt_long __start___ftr_fixup;
+    unsigned tgt_long __stop___ftr_fixup;
+  } *ad;
+  struct obj_section *sec;
+
+  if (archdata_sec->contents)
+    free(archdata_sec->contents);
+  archdata_sec->header.sh_size = 0;
+  sec = obj_find_section(f, "__ftr_fixup");
+  if (sec) {
+    ad = (struct archdata *) (archdata_sec->contents) = xmalloc(sizeof(*ad));
+    memset(ad, 0, sizeof(*ad));
+    archdata_sec->header.sh_size = sizeof(*ad);
+    ad->__start___ftr_fixup = sec->header.sh_addr;
+    ad->__stop___ftr_fixup = sec->header.sh_addr + sec->header.sh_size;
+  }
+
   return 0;
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

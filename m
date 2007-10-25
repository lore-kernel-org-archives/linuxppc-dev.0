Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 14:29:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Remove un-const-safe fdt_set_header macro
Message-ID: <20071025042938.GD24856@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The fdt_set_header() macro casts an arbitrary pointer into (struct
fdt_header *) to set fdt header fields.  While we need to change the
type, so that we can use this macro on the usual (void *) used to
represent a device tree blob, the current macro also casts away any
const on the input pointer, which loses an important check.

This patch replaces the fdt_set_header() macro with a set of inline
functions, one for each header field which do a similar thing, but
which won't silently remove const from a given pointer.  This approach
is also more in keeping with the individual accessor macros we use for
reading fdt header fields.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-25 14:15:30.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-25 14:25:07.000000000 +1000
@@ -149,8 +149,23 @@
 #define fdt_size_dt_strings(fdt) 	(fdt_get_header(fdt, size_dt_strings))
 #define fdt_size_dt_struct(fdt)		(fdt_get_header(fdt, size_dt_struct))
 
-#define fdt_set_header(fdt, field, val) \
-	((struct fdt_header *)(fdt))->field = cpu_to_fdt32(val)
+#define __fdt_set_hdr(name) \
+	static inline void fdt_set_##name(void *fdt, uint32_t val) \
+	{ \
+		struct fdt_header *fdth = fdt; \
+		fdth->name = cpu_to_fdt32(val); \
+	}
+__fdt_set_hdr(magic);
+__fdt_set_hdr(totalsize);
+__fdt_set_hdr(off_dt_struct);
+__fdt_set_hdr(off_dt_strings);
+__fdt_set_hdr(off_mem_rsvmap);
+__fdt_set_hdr(version);
+__fdt_set_hdr(last_comp_version);
+__fdt_set_hdr(boot_cpuid_phys);
+__fdt_set_hdr(size_dt_strings);
+__fdt_set_hdr(size_dt_struct);
+#undef __fdt_set_hdr
 
 /**
  * fdt_check_header - sanity check a device tree or possible device tree
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-25 14:15:30.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2007-10-25 14:24:09.000000000 +1000
@@ -109,8 +109,8 @@
 	err = _blob_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
 	if (err)
 		return err;
-	fdt_set_header(fdt, off_dt_struct, fdt_off_dt_struct(fdt) + delta);
-	fdt_set_header(fdt, off_dt_strings, fdt_off_dt_strings(fdt) + delta);
+	fdt_set_off_dt_struct(fdt, fdt_off_dt_struct(fdt) + delta);
+	fdt_set_off_dt_strings(fdt, fdt_off_dt_strings(fdt) + delta);
 	return 0;
 }
 
@@ -123,8 +123,8 @@
 	if ((err = _blob_splice(fdt, p, oldlen, newlen)))
 		return err;
 
-	fdt_set_header(fdt, size_dt_struct, fdt_size_dt_struct(fdt) + delta);
-	fdt_set_header(fdt, off_dt_strings, fdt_off_dt_strings(fdt) + delta);
+	fdt_set_size_dt_struct(fdt, fdt_size_dt_struct(fdt) + delta);
+	fdt_set_off_dt_strings(fdt, fdt_off_dt_strings(fdt) + delta);
 	return 0;
 }
 
@@ -136,7 +136,7 @@
 	if ((err = _blob_splice(fdt, p, 0, newlen)))
 		return err;
 
-	fdt_set_header(fdt, size_dt_strings, fdt_size_dt_strings(fdt) + newlen);
+	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) + newlen);
 	return 0;
 }
 
@@ -349,7 +349,7 @@
 
 	fdt = buf;
 
-	fdt_set_header(fdt, totalsize, bufsize);
+	fdt_set_totalsize(fdt, bufsize);
 
 	/* FIXME: re-order if necessary */
 
@@ -369,6 +369,6 @@
 		return err;
 
 	/* FIXME: pack components */
-	fdt_set_header(fdt, totalsize, _blob_data_size(fdt));
+	fdt_set_totalsize(fdt, _blob_data_size(fdt));
 	return 0;
 }
Index: dtc/libfdt/fdt_sw.c
===================================================================
--- dtc.orig/libfdt/fdt_sw.c	2007-10-25 14:15:30.000000000 +1000
+++ dtc/libfdt/fdt_sw.c	2007-10-25 14:15:35.000000000 +1000
@@ -73,7 +73,7 @@
 	if ((offset + len < offset) || (offset + len > spaceleft))
 		return NULL;
 
-	fdt_set_header(fdt, size_dt_struct, offset + len);
+	fdt_set_size_dt_struct(fdt, offset + len);
 	return fdt_offset_ptr_w(fdt, offset, len);
 }
 
@@ -86,15 +86,15 @@
 
 	memset(buf, 0, bufsize);
 
-	fdt_set_header(fdt, magic, SW_MAGIC);
-	fdt_set_header(fdt, version, FDT_LAST_SUPPORTED_VERSION);
-	fdt_set_header(fdt, last_comp_version, FDT_FIRST_SUPPORTED_VERSION);
-	fdt_set_header(fdt, totalsize, bufsize);
-
-	fdt_set_header(fdt, off_mem_rsvmap, ALIGN(sizeof(struct fdt_header),
-					      sizeof(struct fdt_reserve_entry)));
-	fdt_set_header(fdt, off_dt_struct, fdt_off_mem_rsvmap(fdt));
-	fdt_set_header(fdt, off_dt_strings, bufsize);
+	fdt_set_magic(fdt, SW_MAGIC);
+	fdt_set_version(fdt, FDT_LAST_SUPPORTED_VERSION);
+	fdt_set_last_comp_version(fdt, FDT_FIRST_SUPPORTED_VERSION);
+	fdt_set_totalsize(fdt,  bufsize);
+
+	fdt_set_off_mem_rsvmap(fdt, ALIGN(sizeof(struct fdt_header),
+					  sizeof(struct fdt_reserve_entry)));
+	fdt_set_off_dt_struct(fdt, fdt_off_mem_rsvmap(fdt));
+	fdt_set_off_dt_strings(fdt, bufsize);
 
 	return 0;
 }
@@ -118,7 +118,7 @@
 	re->address = cpu_to_fdt64(addr);
 	re->size = cpu_to_fdt64(size);
 
-	fdt_set_header(fdt, off_dt_struct, offset + sizeof(*re));
+	fdt_set_off_dt_struct(fdt, offset + sizeof(*re));
 
 	return 0;
 }
@@ -181,7 +181,7 @@
 		return 0; /* no more room :( */
 
 	memcpy(strtab + offset, s, len);
-	fdt_set_header(fdt, size_dt_strings, strtabsize + len);
+	fdt_set_size_dt_strings(fdt, strtabsize + len);
 	return offset;
 }
 
@@ -231,7 +231,7 @@
 	oldstroffset = fdt_totalsize(fdt) - fdt_size_dt_strings(fdt);
 	newstroffset = fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
 	memmove(p + newstroffset, p + oldstroffset, fdt_size_dt_strings(fdt));
-	fdt_set_header(fdt, off_dt_strings, newstroffset);
+	fdt_set_off_dt_strings(fdt, newstroffset);
 
 	/* Walk the structure, correcting string offsets */
 	offset = 0;
@@ -252,7 +252,7 @@
 	}
 
 	/* Finally, adjust the header */
-	fdt_set_header(fdt, totalsize, newstroffset + fdt_size_dt_strings(fdt));
-	fdt_set_header(fdt, magic, FDT_MAGIC);
+	fdt_set_totalsize(fdt, newstroffset + fdt_size_dt_strings(fdt));
+	fdt_set_magic(fdt, FDT_MAGIC);
 	return 0;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

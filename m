Subject: Re: mvista.com rsync linuxppc-2.5 --
	drivers/char/drm/drm_memory.h:145: `radeon_mem_stats' undeclared (first use
	in this function)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Miles Lane <miles.lane@attbi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1052296603.15229.172.camel@thor>
References: <3EB869AF.7070202@attbi.com>  <1052296603.15229.172.camel@thor>
Content-Type: multipart/mixed; boundary="=-v/BNXhNjDgVYOnkELHbM"
Message-Id: <1052313427.23044.189.camel@thor>
Mime-Version: 1.0
Date: 07 May 2003 15:17:07 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-v/BNXhNjDgVYOnkELHbM
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Mit, 2003-05-07 at 10:36, Michel Dänzer wrote:
> On Mit, 2003-05-07 at 04:04, Miles Lane wrote:
> >
> >    gcc -Wp,-MD,drivers/char/drm/.radeon_drv.o.d -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
> > -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include
> >     -DKBUILD_BASENAME=radeon_drv -DKBUILD_MODNAME=radeon -c -o
> > drivers/char/drm/radeon_drv.o drivers/char/drm/radeon_drv.c
> > In file included from drivers/char/drm/radeon_drv.c:49:
> > drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp':
> > drivers/char/drm/drm_memory.h:145: `radeon_mem_stats' undeclared (first
> > use in this function)
> > drivers/char/drm/drm_memory.h:145: (Each undeclared identifier is
> > reported only once
> > drivers/char/drm/drm_memory.h:145: for each function it appears in.)
> > drivers/char/drm/drm_memory.h:157: `radeon_mem_lock' undeclared (first
> > use in this function)
> > drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp_free':
> > drivers/char/drm/drm_memory.h:212: `radeon_mem_stats' undeclared (first
> > use in this function)
> > drivers/char/drm/drm_memory.h:216: `radeon_mem_lock' undeclared (first
> > use in this function)
> > make[3]: *** [drivers/char/drm/radeon_drv.o] Error 1
>
> I've fixed this in my local DRI tree and can come up with a patch for
> linuxppc-2.5 if nobody beats me to it.

Voilà.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

--=-v/BNXhNjDgVYOnkELHbM
Content-Disposition: attachment; filename=drm.diff
Content-Type: text/x-patch; name=drm.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -up -r linuxppc-2.5/drivers/char/drm/drm_memory.h linuxppc-2.5.68/drivers/char/drm/drm_memory.h
--- linuxppc-2.5/drivers/char/drm/drm_memory.h	2003-05-06 05:11:19.000000000 +0200
+++ linuxppc-2.5.68/drivers/char/drm/drm_memory.h	2003-05-07 11:45:28.000000000 +0200
@@ -123,6 +123,37 @@ void *DRM(ioremap)(unsigned long offset,
 	return ioremap(offset, size);
 }

+void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
+{
+	return ioremap_nocache(offset, size);
+}
+
+void DRM(ioremapfree)(void *pt, unsigned long size)
+{
+	iounmap(pt);
+}
+
+#if __REALLY_HAVE_AGP
+agp_memory *DRM(alloc_agp)(int pages, u32 type)
+{
+	return DRM(agp_allocate_memory)(pages, type);
+}
+
+int DRM(free_agp)(agp_memory *handle, int pages)
+{
+	return DRM(agp_free_memory)(handle) ? 0 : -EINVAL;
+}
+
+int DRM(bind_agp)(agp_memory *handle, unsigned int start)
+{
+	return DRM(agp_bind_memory)(handle, start);
+}
+
+int DRM(unbind_agp)(agp_memory *handle)
+{
+	return DRM(agp_unbind_memory)(handle);
+}
+
 #ifdef CONFIG_ALL_PPC
 /* PPC specific routine used by ioremap_agp, to be replaced by some
  * more generic implementation
@@ -137,12 +168,7 @@ void *DRM(ioremap_agp)(unsigned long off
 	unsigned int flags = _PAGE_NO_CACHE|_PAGE_KERNEL|_PAGE_PRESENT|_PAGE_RW|_PAGE_DIRTY;
 	int err, i;

-	printk("drm: ioremap_agp, offset: 0x%08lx, size: 0x%08lx\n", offset, size);
-
-#if __REALLY_HAVE_AGP
 	if (!size) {
-		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
-			      "Mapping 0 bytes at 0x%08lx\n", offset);
 		return NULL;
 	}

@@ -154,10 +180,6 @@ void *DRM(ioremap_agp)(unsigned long off
 	 */
 	area = get_vm_area(size, VM_IOREMAP);
 	if (area == 0) {
-		spin_lock(&DRM(mem_lock));
-		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
-		spin_unlock(&DRM(mem_lock));
-		printk("->NULL\n");
 		return NULL;
 	}
 	pt = (void *)VMALLOC_VMADDR(area->addr);
@@ -175,86 +197,26 @@ void *DRM(ioremap_agp)(unsigned long off
                                 break;
 		}
 		if (!agpmem) {
-			printk("drm: not matching AGP page in ioremap_agp\n");
 			err = 1;
 			break;
 		}
 		index = (baddr - agpmem->bound) >> PAGE_SHIFT;
+		get_page(virt_to_page(__va(agpmem->memory->memory[index])));
 		err = map_page(((unsigned long)pt)+i, agpmem->memory->memory[index], flags);
 	}
 	if (err) {
 		vfree((void *)pt);
-		spin_lock(&DRM(mem_lock));
-		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
-		spin_unlock(&DRM(mem_lock));
-		printk("->NULL\n");
 		return NULL;
 	}

-	spin_lock(&DRM(mem_lock));
-	++DRM(mem_stats)[DRM_MEM_MAPPINGS].succeed_count;
-	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_allocated += size;
-	spin_unlock(&DRM(mem_lock));
-	printk("->pt=0x%p\n", pt);
 	return pt;
-#else
-	return NULL;
-#endif
 }

 void DRM(ioremap_agp_free)(void *pt, unsigned long size)
 {
-	int alloc_count;
-	int free_count;
-
-	if (!pt)
-		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
-			      "Attempt to free NULL pointer\n");
-	else
-		vfree(pt);
-
-	spin_lock(&DRM(mem_lock));
-	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_freed += size;
-	free_count  = ++DRM(mem_stats)[DRM_MEM_MAPPINGS].free_count;
-	alloc_count =	DRM(mem_stats)[DRM_MEM_MAPPINGS].succeed_count;
-	spin_unlock(&DRM(mem_lock));
-	if (free_count > alloc_count) {
-		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
-			      "Excess frees: %d frees, %d allocs\n",
-			      free_count, alloc_count);
-	}
+	vfree(pt);
 }
 #endif	/* CONFIG_ALL_PPC */

-void *DRM(ioremap_nocache)(unsigned long offset, unsigned long size)
-{
-	return ioremap_nocache(offset, size);
-}
-
-void DRM(ioremapfree)(void *pt, unsigned long size)
-{
-	iounmap(pt);
-}
-
-#if __REALLY_HAVE_AGP
-agp_memory *DRM(alloc_agp)(int pages, u32 type)
-{
-	return DRM(agp_allocate_memory)(pages, type);
-}
-
-int DRM(free_agp)(agp_memory *handle, int pages)
-{
-	return DRM(agp_free_memory)(handle) ? 0 : -EINVAL;
-}
-
-int DRM(bind_agp)(agp_memory *handle, unsigned int start)
-{
-	return DRM(agp_bind_memory)(handle, start);
-}
-
-int DRM(unbind_agp)(agp_memory *handle)
-{
-	return DRM(agp_unbind_memory)(handle);
-}
 #endif /* agp */
 #endif /* debug_memory */
diff -up -r linuxppc-2.5/drivers/char/drm/drm_memory_debug.h linuxppc-2.5.68/drivers/char/drm/drm_memory_debug.h
--- linuxppc-2.5/drivers/char/drm/drm_memory_debug.h	2003-05-06 05:11:07.000000000 +0200
+++ linuxppc-2.5.68/drivers/char/drm/drm_memory_debug.h	2003-05-07 11:45:28.000000000 +0200
@@ -442,4 +442,105 @@ int DRM(unbind_agp)(agp_memory *handle)
 	}
 	return retcode;
 }
+
+#ifdef CONFIG_ALL_PPC
+/* PPC specific routine used by ioremap_agp, to be replaced by some
+ * more generic implementation
+ */
+extern int map_page(unsigned long va, unsigned long pa, int flags);
+
+void *DRM(ioremap_agp)(unsigned long offset, unsigned long size, drm_device_t *dev)
+{
+	void *pt;
+	struct vm_struct *area;
+	struct drm_agp_mem *agpmem;
+	unsigned int flags = _PAGE_NO_CACHE|_PAGE_KERNEL|_PAGE_PRESENT|_PAGE_RW|_PAGE_DIRTY;
+	int err, i;
+
+	DRM_DEBUG("offset: 0x%08lx, size: 0x%08lx\n", offset, size);
+
+	if (!size) {
+		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
+			      "Mapping 0 bytes at 0x%08lx\n", offset);
+		return NULL;
+	}
+
+	if (!dev->agp || !dev->agp->cant_use_aperture)
+		return DRM(ioremap)(offset, size);
+
+	/* XXX This has to be changed into something more generic
+	 * this implementation is really only valid on PPC
+	 */
+	area = get_vm_area(size, VM_IOREMAP);
+	if (area == 0) {
+		spin_lock(&DRM(mem_lock));
+		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
+		spin_unlock(&DRM(mem_lock));
+		DRM_DEBUG("->NULL\n");
+		return NULL;
+	}
+	pt = (void *)VMALLOC_VMADDR(area->addr);
+	err = 0;
+	for (i = 0; i < size && err == 0; i += PAGE_SIZE) {
+		unsigned long baddr = offset + i;
+		unsigned long index;
+
+                /*
+                 * It's AGP memory - find the real physical page to map
+                 */
+                for(agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next) {
+                        if (agpmem->bound <= baddr &&
+                            agpmem->bound + agpmem->pages * PAGE_SIZE > baddr)
+                                break;
+		}
+		if (!agpmem) {
+			DRM_DEBUG("not matching AGP page in ioremap_agp\n");
+			err = 1;
+			break;
+		}
+		index = (baddr - agpmem->bound) >> PAGE_SHIFT;
+		get_page(virt_to_page(__va(agpmem->memory->memory[index])));
+		err = map_page(((unsigned long)pt)+i, agpmem->memory->memory[index], flags);
+	}
+	if (err) {
+		vfree((void *)pt);
+		spin_lock(&DRM(mem_lock));
+		++DRM(mem_stats)[DRM_MEM_MAPPINGS].fail_count;
+		spin_unlock(&DRM(mem_lock));
+		DRM_DEBUG("->NULL\n");
+		return NULL;
+	}
+
+	spin_lock(&DRM(mem_lock));
+	++DRM(mem_stats)[DRM_MEM_MAPPINGS].succeed_count;
+	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_allocated += size;
+	spin_unlock(&DRM(mem_lock));
+	DRM_DEBUG("->pt=0x%p\n", pt);
+	return pt;
+}
+
+void DRM(ioremap_agp_free)(void *pt, unsigned long size)
+{
+	int alloc_count;
+	int free_count;
+
+	if (!pt)
+		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
+			      "Attempt to free NULL pointer\n");
+	else
+		vfree(pt);
+
+	spin_lock(&DRM(mem_lock));
+	DRM(mem_stats)[DRM_MEM_MAPPINGS].bytes_freed += size;
+	free_count  = ++DRM(mem_stats)[DRM_MEM_MAPPINGS].free_count;
+	alloc_count =	DRM(mem_stats)[DRM_MEM_MAPPINGS].succeed_count;
+	spin_unlock(&DRM(mem_lock));
+	if (free_count > alloc_count) {
+		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
+			      "Excess frees: %d frees, %d allocs\n",
+			      free_count, alloc_count);
+	}
+}
+#endif	/* CONFIG_ALL_PPC */
+
 #endif
diff -up -r linuxppc-2.5/drivers/char/drm/radeon_cp.c linuxppc-2.5.68/drivers/char/drm/radeon_cp.c
--- linuxppc-2.5/drivers/char/drm/radeon_cp.c	2003-05-06 05:11:21.000000000 +0200
+++ linuxppc-2.5.68/drivers/char/drm/radeon_cp.c	2003-05-07 11:45:28.000000000 +0200
@@ -35,9 +35,7 @@
 #include "radeon_drv.h"

 #define RADEON_FIFO_DEBUG	0
-#if __REALLY_HAVE_AGP && defined(CONFIG_ALL_PPC)
-extern unsigned long agp_special_page;
-#endif
+

 /* CP microcode (from ATI) */
 static u32 R200_cp_microcode[][2] = {
@@ -890,14 +888,6 @@ static void radeon_cp_init_ring_buffer(

 #if __REALLY_HAVE_AGP
 	if ( !dev_priv->is_pci ) {
-#if __REALLY_HAVE_AGP && defined(CONFIG_ALL_PPC)
-		if (_machine == _MACH_Pmac) {
-			dev_priv->ring.head = (__volatile__ u32 *) agp_special_page;
-			SET_RING_HEAD( &dev_priv->ring, cur_read_ptr );
-			RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
-				    __pa( dev_priv->ring.head ) );
-		} else
-#endif
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			      dev_priv->ring_rptr->offset
 			      - dev->agp->base

--=-v/BNXhNjDgVYOnkELHbM--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

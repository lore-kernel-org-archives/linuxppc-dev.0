Mime-Version: 1.0 (Apple Message framework v613)
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-23--551219023
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 10:59:56 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-23--551219023
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

In the process of reworking my Generic DMA core for the 2.6 kernel, I
noticed that dma_alloc_coherent() returns NULL in all cases on a
cache-coherent platform.  Instead, I think it would be better if this
routine returned a block of contiguous memory (not cache-inhibited), as
pci_alloc_consistent() does.

To that end, I am submitting the attached patch which modifies
dma_alloc_coherent() and dma_free_coherent() to do just this for
cache-coherent platforms.
I was going to add a check for dev->dma_mask in dma_alloc_coherent()
(to add GFP_DMA to the flags), but the dma_supported() macro always
returns 1, which would indicate that this is superfluous.

John


--- dma-mapping.h.orig	2004-04-01 10:38:33.000000000 -0500
+++ dma-mapping.h	2004-04-01 10:49:32.000000000 -0500
@@ -35,7 +35,18 @@
  		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
  #endif

-	return consistent_alloc(flag, size, dma_handle);
+#ifdef CONFIG_NOT_COHERENT_CACHE
+    return consistent_alloc(flag, size, dma_handle);
+#else
+	void *ret;
+
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		*dma_handle = virt_to_bus(ret);
+	}
+
+    return ret;
+#endif /* CONFIG_NOT_COHERENT_CACHE */
  }

  static inline void
@@ -49,7 +60,11 @@
  	}
  #endif

-	consistent_free(vaddr);
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	consistent_free(vaddr, size);
+#else
+	free_pages((unsigned long)vaddr, get_order(size));
+#endif
  }

  static inline dma_addr_t



--Apple-Mail-23--551219023
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="dma-mapping.h.patch"
Content-Disposition: attachment;
	filename=dma-mapping.h.patch

--- dma-mapping.h.orig	2004-04-01 10:38:33.000000000 -0500
+++ dma-mapping.h	2004-04-01 10:49:32.000000000 -0500
@@ -35,7 +35,18 @@
 		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
 #endif

-	return consistent_alloc(flag, size, dma_handle);
+#ifdef CONFIG_NOT_COHERENT_CACHE
+    return consistent_alloc(flag, size, dma_handle);
+#else
+	void *ret;
+
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		*dma_handle = virt_to_bus(ret);
+	}
+
+    return ret;
+#endif /* CONFIG_NOT_COHERENT_CACHE */
 }

 static inline void
@@ -49,7 +60,11 @@
 	}
 #endif

-	consistent_free(vaddr);
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	consistent_free(vaddr, size);
+#else
+	free_pages((unsigned long)vaddr, get_order(size));
+#endif
 }

 static inline dma_addr_t

--Apple-Mail-23--551219023--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

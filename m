Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-26--549400491
Message-Id: <DAA3135C-83F9-11D8-9FF0-000A95A07384@sands-edge.com>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 11:30:14 -0500
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-26--549400491
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Whoops.  I accidentally had some previous changes in the patch I
submitted.  Here is the cleaned up version.

--- dma-mapping.h.orig	2004-04-01 10:38:33.000000000 -0500
+++ dma-mapping.h	2004-04-01 11:27:44.000000000 -0500
@@ -35,7 +35,18 @@
  		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
  #endif

+#ifdef CONFIG_NOT_COHERENT_CACHE
  	return consistent_alloc(flag, size, dma_handle);
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

+#ifdef CONFIG_NOT_COHERENT_CACHE
  	consistent_free(vaddr);
+#else
+	free_pages((unsigned long)vaddr, get_order(size));
+#endif
  }

  static inline dma_addr_t



--Apple-Mail-26--549400491
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="dma-mapping.h.patch"
Content-Disposition: attachment;
	filename=dma-mapping.h.patch

--- dma-mapping.h.orig	2004-04-01 10:38:33.000000000 -0500
+++ dma-mapping.h	2004-04-01 11:27:44.000000000 -0500
@@ -35,7 +35,18 @@
 		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
 #endif

+#ifdef CONFIG_NOT_COHERENT_CACHE
 	return consistent_alloc(flag, size, dma_handle);
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

+#ifdef CONFIG_NOT_COHERENT_CACHE
 	consistent_free(vaddr);
+#else
+	free_pages((unsigned long)vaddr, get_order(size));
+#endif
 }

 static inline dma_addr_t

--Apple-Mail-26--549400491--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

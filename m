Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] kdump: don't call __ioremap() for pfn = 0
From: Michael Ellerman <michael@ellerman.id.au>
To: paulus@samba.org
In-Reply-To: <451216EE.8010404@in.ibm.com>
References: <451216EE.8010404@in.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 21:02:37 +1000
Message-Id: <1158836557.7062.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>,
	"Sachin P. Sant" <sachinp@in.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-21 at 10:07 +0530, Sachin P. Sant wrote:
> Hi
> 
> While using dd command to retrive the dump from /dev/oldmem, there comes
> a rare case where pfn value is zero. In this case the __ioremap() call 
> returns
> NULL and hence copying fails.
> 
> # dd if=/dev/oldmem of=/dev/null
> dd: reading `/dev/oldmem': Bad address
> 0+0 records in
> 0+0 records out
> 0 bytes (0 B) copied, 0.000121 seconds, 0.0 kB/s
> 
> Attached is a patch to fix this problem. During such rare cases don't call
> __ioremap() to do the address translation, instead use __va() .

It's not really rare, it's just when we're reading /dev/oldmem directly.

We can actually use the __va() trick for the whole linear mapping rather
than just pfn 0, which saves the ioremap. We also shouldn't really be
trying to iounmap(__va(0)).

So perhaps something more like this? Although it's a bit ugly because of
the need to conditionally call iounmap().

Paul you said we shouldn't be using ioremap(), but I really can't find
an alternative - map_vm_area() looks close but it requires struct pages
which we don't have. And I think your main objection was a cacheable
mapping, which we're not doing anyway by calling __ioremap().

...

Fix /dev/oldmem for kdump

A change to __ioremap() broke reading /dev/oldmem because we're no
longer able to ioremap pfn 0 (d177c207ba16b1db31283e2d1fee7ad4a863584b).

We actually don't need to ioremap for anything that's part of the linear
mapping, so just read it directly.

Also make sure we're only reading one page or less at a time.

Index: to-merge/arch/powerpc/kernel/crash_dump.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash_dump.c
+++ to-merge/arch/powerpc/kernel/crash_dump.c
@@ -80,6 +80,20 @@ static int __init parse_savemaxmem(char 
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
+
+static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
+				unsigned long offset, int userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, (vaddr + offset), csize);
+
+	return csize;
+}
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -101,16 +115,16 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!csize)
 		return 0;
 
-	vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+	csize = min(csize, PAGE_SIZE);
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, (vaddr + offset), csize);
+	if (pfn < max_pfn) {
+		vaddr = __va(pfn << PAGE_SHIFT);
+		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+	} else {
+		vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+		iounmap(vaddr);
+	}
 
-	iounmap(vaddr);
 	return csize;
 }

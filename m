Return-Path: <achim.machura@berghof.com>
Received: from mail123.messagelabs.com (mail123.messagelabs.com [85.158.136.3])
	by ozlabs.org (Postfix) with SMTP id A13EA6801D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 00:19:42 +1000 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Kunkel, Ulrich'" <Ulrich.Kunkel@hbm.com>
Date: Mon, 22 Aug 2005 16:12:52 +0200
Message-ID: <002e01c5a723$9669d7a0$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <D3524C0FFDC6A54F9D7B6BBEECD341D505618A78@hbmntx0.da.hbm.com>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: MPC5200 mmap, ioremap
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Ulrich,

> mem =12 M
i think it means the kernel knows about 12 MB

This code below works fine at our board, but we use only a few kb in the
protected ram.
I don't Know whats happen if size is bigger as one page.

int asi_common_mmap(struct file *filp, struct vm_area_struct *vma)
{
//	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
	unsigned long physical = ASI_IOMEM_BASE;
	unsigned long vsize = vma->vm_end - vma->vm_start;
//	unsigned long psize = ASI_IOMEM_SIZE - off;

//	rt_printk("start : 0x%08lX\n", vma->vm_start);
//	rt_printk("end   : 0x%08lX\n", vma->vm_end);
//	rt_printk("offset: 0x%08lX\n", off);
//	rt_printk("phys  : 0x%08lX\n", physical);
//	rt_printk("vsize : 0x%08lX\n", vsize);
//	rt_printk("psize : 0x%08lX\n", psize);

	if (filp->f_flags & O_SYNC)
	{
//		rt_printk("I/O-Mem");
		vma->vm_flags |= VM_IO;
	}
	vma->vm_flags |= VM_RESERVED;
	//if (vsize > psize) return -EINVAL; /* spans too high */
	if(remap_page_range(vma->vm_start, physical, vsize, vma->vm_page_prot))
	{
		return -EAGAIN;
	}
	return(0);
}

Achim

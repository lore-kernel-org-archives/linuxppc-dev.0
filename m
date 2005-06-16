Return-Path: <egoforth@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id 70F5D67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 07:40:25 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so647739wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 14:40:24 -0700 (PDT)
Message-ID: <75b39f0105061614333199ec37@mail.gmail.com>
Date: Thu, 16 Jun 2005 17:33:44 -0400
From: Ed Goforth <egoforth@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: mmap on 440gx
Reply-To: Ed Goforth <egoforth@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've been struggling with implementing mmap on a 440gx-based custom
board.  I have been able to use ioremap(), but we really need a mmap()
for our software.  The kernel is 2.4.18 (TimeSys 4.0).

I'm trying to access one of our FPGA's located at 0x50000000.  Offsets
0x00000000 thru
0x000FFFFF are control and status registers.  Offsets 0x01000000 thru
0x017FFFFF are the QDR SRAM on the FPGA.

Using ioremap_nocache(0x50000000, bytes_to_map) works (so long as
bytes_to_map isn't too large).  I can then use in_be32() and
out_be32() to read/write the registers and the SRAM.  However, trying
to implement mmap() causes the board to lock up hard.  I have tried
iterations both where the driver first does an ioremap(), and where it
doesn't do the ioremap().  Some bits:

In driver module:
static struct file_operations test_mmap_fops =3D {
  read : test_mmap_read,
  mmap : test_mmap_mmap,
  open : test_mmap_open,
  release : test_mmap_release,
};

static int test_mmap_mmap (struct file *filp, struct vm_area_struct *vma) {
  vma->vm_flags |=3D (VM_SHM | VM_LOCKED | VM_IO | VM_RESERVED);

  if (remap_page_range(vma->vm_start, 0x50000000, 4096, vma->vm_page_prot))
    return(-EAGAIN);

  return(0);

} /* test_mmap_mmap() */


When the test code calls mmap():
  unsigned long *mmap_region;
  unsigned long data;
  mmap_region =3D mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
it seems to work.  However, dereferencing mmap_region, either thru
  data =3D *mmap_region;
or
  data =3D mmap_region[0];
causes the board to lock hard.

I would appreciate any suggestions or hints.

Thanks,
Ed

Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.241])
	by ozlabs.org (Postfix) with ESMTP id E77BFDDE98
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 08:54:02 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so3424237hsz.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 14:54:00 -0700 (PDT)
Message-ID: <fa686aa40803131453w1ebf8debsf41a7c17812e60ca@mail.gmail.com>
Date: Thu, 13 Mar 2008 15:53:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Hans-J=FCrgen_Koch?=" <hjk@linutronix.de>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Linux UIO driver cache problem in PowerPC (fix)
In-Reply-To: <20080313081932.4edee290@dilbert.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0803121222h5fca9cdal5af873cd2a700f4d@mail.gmail.com>
	<20080313081932.4edee290@dilbert.local>
Cc: Jean-Samuel Chenard <jsamch@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 13, 2008 at 1:19 AM, Hans-J=FCrgen Koch <hjk@linutronix.de> wro=
te:
> Am Wed, 12 Mar 2008 15:22:59 -0400
>  schrieb "Jean-Samuel Chenard" <jsamch@gmail.com>:
>
>  > Hi,
>
>  Hi Jean-Samuel,
>  thanks for your report. Please CC LKML if you find bugs like this. I
>  also added Grant Likely (PPC Xilinx Virtex maintainer), as it seems to
>  be a platform specific problem.

Hmmm.  I'm not a memory handling expert so I don't know what's going
on here.  Josh, does this look like anything that would be ppc405
related?

g.

>
>  >
>  > Experimenting with your userspace I/O driver on a Xilinx FPGA (PowerPC
>  > 405), I was having problems when reading hardware device registers
>  > mapped on my platform using the user-space mmap() call.
>  >
>  > After some investigation (looking at the driver/char/mspec.c file), I
>  > found that preventing caching of the page in uio_mmap_physical fixed
>  > my issues with userspace mmap() reading messed-up values.
>
>  Hm, we already mark the page with VM_IO. That's sufficient on x86 and
>  arm. I'm not sure whether this is a bug in PPC memory handling. Why do
>  they cache VM_IO pages?
>
>  >
>  > This patch is against your initial commit of the UIO driver in the
>  > mainline kernel tree.
>  >
>  > =3D=3D=3D=3D
>  > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
>  > index 865f32b..36e1123 100644
>  > --- a/drivers/uio/uio.c
>  > +++ b/drivers/uio/uio.c
>  > @@ -22,6 +22,7 @@
>  >  #include <linux/string.h>
>  >  #include <linux/kobject.h>
>  >  #include <linux/uio_driver.h>
>  > +#include <asm/pgtable.h>
>  >
>  >  #define UIO_MAX_DEVICES 255
>  >
>  > @@ -447,6 +448,8 @@ static int uio_mmap_physical(struct
>  > vm_area_struct *vma)
>  >
>  >         vma->vm_flags |=3D VM_IO | VM_RESERVED;
>  >
>  > +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
>  > +
>  >         return remap_pfn_range(vma,
>  >                                vma->vm_start,
>  >                                idev->info->mem[mi].addr >> PAGE_SHIFT,
>  > =3D=3D=3D=3D
>  >
>  > I am a bit unsure if this will break something in any of your uses of
>  > the UIO driver (on other platforms than ppc), but it really fixes
>  > things for me.
>
>  It should be OK, but unneccesary on other platforms. I have no
>  objections, but I fear in 6 months we'll see a patch removing that
>  line again because it's not needed...
>
>  > Let me know if you need more details on what was
>  > happening on my platform before I added this statement.
>
>  I'd like to hear the opinion of people really involved in PPC memory
>  handling.
>
>  >
>  > Thanks for the great driver for user-space I/O, it will save me lots
>  > of time in my research.
>  >
>  > Regards,
>  >
>  > Jean-Samuel
>
>  Thanks,
>  Hans
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

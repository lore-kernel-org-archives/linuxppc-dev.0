Return-Path: <xenidis@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65B932C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2012 12:53:34 +1100 (EST)
Received: by mail-gg0-f179.google.com with SMTP id q1so1187574gge.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2012 17:53:31 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: [RFC] Add IBM Blue Gene/Q Platform
Date: Thu, 6 Dec 2012 19:53:27 -0600
Message-Id: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <kumar.gala@gmail.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Cc: Jay Bryant <jsbryant@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Todd Inglett <tinglett@us.ibm.com>, Andrew T Tauferner <ataufer@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than flood the mailing list with the patches, I've arranged for a =
git repo to hold the changesets.
You can find the repo here:
  <https://github.com/jimix/linux-bgq>

They are against GregKH's linux-stable.git long-term 3.4.y (y=3D22) =
branch.
The first 9 (6e58088f..) effect common code and the rest are BGQ =
specific.

Here is a are the summary logs:

$ git log --reverse linux-stable/linux-3.4.y..
commit 5a8edb2bdd914597693eed299119ff4c2e6d31f2
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Fri Nov 9 09:26:00 2012 -0600

    powerpc: Fix cputable #ifdef where CONFIG_PPC_A2 is used for =
CONFIG_PPC_BOOK3E_64
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit ea51920d7035c8d23801d6de46261e7d0a537dfd
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Fri Nov 9 08:58:27 2012 -0600

    powerpc/book3e: Remove config for PPC_A2_DD2 since there is no =
reference to it
   =20
    This must have been leftover from early DD1 days which is not
    present in any current kernel code.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 08151401a5db4ff0d441a1b7bf8ad92bd92b14c5
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Mon Nov 5 09:38:01 2012 -0600

    powerpc/dcr: Some native DCR fixes
   =20
    The following fixes have been made:
     - dcr_read/write_native() must use the indexed version of the
       m[ft]dcrx since the non-indexed version only allows a 10-bit
       numerical space, but the C interface allows a full 32-bits.
     - C bindings for m[ft]dcrx, and the "table" versions, should use
       "unsigned long" so that they are 64/32 bit neutral.
     - The "table" versions (__m[ft]cdr) should obtain the table address
       with LOAD_REG_ADDR(), this will also make it 64/32bit neutral.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit c8320a5daaceed03992d763302020834ea8e17dd
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Mon Nov 5 09:12:00 2012 -0600

    powerpc/dcr: Add 64-bit DCR access methods.
   =20
    This patch adds the ability to make 64-bit Device Control Register
    (DCR) accesses.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit a763b3f8453b3bd83d7dded8c6644939863af430
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Thu Nov 29 12:49:24 2012 -0500

    powerpc/boot: Add a "spin_threads" hook to platform_ops
   =20
    It is useful for the boot program to arrange for all secondary cpus
    and threads to enter the kernel in a "kexec" fashion.  This hook =
makes
    it possible.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 391e43393380b514d4d02a42d059619542c7597b
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Thu Nov 29 13:01:23 2012 -0500

    powerpc/kexec: Add kexec "hold" support for Book3e processors
   =20
    This patch add two items:
    1) Book3e requires that GPR4 survive the "hold" process, so we make
       sure that happens.
    2) Book3e has no real mode, and the hold code exploits this.  Since
       these processors ares always translated, we arrange for the =
kexeced
       threads to enter the hold code using the normal kernel linear =
mapping.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Wed Dec 5 13:41:25 2012 -0500

    powerpc: Remove unecessary VSX symbols
   =20
    The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0.  =
Its
    presence causes build issues with more complex configurations.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 4e817bb42ec8e3d3689877528dd97c4286a870eb
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Tue Nov 20 10:10:52 2012 -0600

    Blue Gene/Q wicked optimizing compiler does not know the rfdi =
instruction yet
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 2071aa58b2f3b33d97c94e3a127f7c5d4ffaeb34
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Tue Nov 20 10:14:22 2012 -0600

    Blue Gene/Q wicked optimizing compiler does not know the mfdcrx =
instruction yet
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 6e58088fabedbb2d724637b539ba180c03ed8b68
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Wed Oct 31 16:33:21 2012 -0500

    powerpc/book3e: IBM Blue Gene/Q Boot
   =20
    This patch specifically deals with the initial program load
    environment so that a boot image (dtbImage.bgq) can be loaded by the
    BGQ management tools.  The boot code is a little odd because it has =
to
    deal with the following issues:
     - Linux boot image wrappers are 32-bit programs
     - BGQ Tools only load 64bit ELF programs
     - BGQ Firmware information is typically loaded at an address > 4G
     - BGQ FW information contains 64-bit ABI function pointers (which =
are
       actually function descriptors) to access firmware methods
     - BGQ FW methods must be called in 64-bit mode
   =20
    Includes code contributed from:
      Andrew Tauferner <ataufer@us.ibm.com>
      Todd Inglett <tinglett@us.ibm.com>
      Eric Van Hensbergen <ericvh@gmail.com>
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 3bc841935eb4955ce2b2db69bff16f7928464597
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Wed Oct 31 22:36:54 2012 -0500

    powerpc/book3e: IBM Blue Gene/Q Platform and SMP
   =20
    This patch introduces BGQ as a platform and adds SMP functionality
   =20
    Includes code contributed from:
      Andrew Tauferner <ataufer@us.ibm.com>
      Todd Inglett <tinglett@us.ibm.com>
      Eric Van Hensbergen <ericvh@gmail.com>
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 279c0615917b959a652e81f4ad0d886e2d426d85
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Wed Dec 5 13:43:22 2012 -0500

    powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
   =20
    This enables kernel support for the QPX extention and is intended =
for
    processors that support it, usually an IBM Blue Gene processor.
    Turning it on does not effect other processors but it does add code
    and will quadruple the per thread save and restore area for the FPU
    (hense the name).  If you have enabled VSX it will only double the
    space.
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 6ff45170ab0463fb34d7011e08c7e47c396f0fd7
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Fri Nov 23 14:52:14 2012 -0600

    powerpc/book3e: IBM Blue Gene/Q HVC Based Firmware Console
   =20
    New HVC device that uses the Blue Gene Firmware methods to erad and
    write to console.
   =20
        Includes code contributed from:
          Andrew Tauferner <ataufer@us.ibm.com>
          Todd Inglett <tinglett@us.ibm.com>
          Eric Van Hensbergen <ericvh@gmail.com>
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit e4ddc0c2ad8b3f0260d15d73e153095e95da84ac
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Thu Nov 29 15:52:04 2012 -0500

    powerpc/book3e: IBM Blue Gene/Q PCIe and MSI
   =20
    The following patch adds support for the BG/Q PCIe bridge and MSI =
interrupts.
   =20
    Includes code contributed from:
      Jay S. Bryant <jsbryant@us.ibm.com>
      Eric Van Hensbergen <ericvh@gmail.com>
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 9fc0b6f729f7bd7e31338283640a718fa4b1693b
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Wed Dec 5 07:01:49 2012 -0500

    powerpc/book3e: IBM Blue Gene/Q Character Drivers
   =20
    The following patch adds support for user and administration
    applications to access the BG/Q control system.
   =20
    Includes code contributed from:
      Jay S. Bryant <jsbryant@us.ibm.com>
      Eric Van Hensbergen <ericvh@gmail.com>
   =20
    Signed-off-by: Jimi Xenidis <jimix@pobox.com>

commit 9df2c4dfde0ac75f8b2bfcf565f78c2b7382b031
Author: Jimi Xenidis <jimix@pobox.com>
Date:   Thu Dec 6 18:07:16 2012 -0500

    Linux 3.4.22-BGQ-rc1

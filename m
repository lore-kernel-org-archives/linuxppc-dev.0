Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems building 2.4.10-ac11?  Am I missing a ppc specific patches
Date: Fri, 12 Oct 2001 08:50:33 -0400
MIME-Version: 1.0
Message-Id: <20011012124823.GGKC27994.tomts14-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I seem to have trouble building Alan's 2.4.10-ac11.

First pc_keyb.c is missing the follwoing line:

#include <linux/pm.h>


Once that is fixed, vmlinux builds.  But then during make modules we seem
to be missing cache flushing code (according to the error message).

I compared this with Ben's version of agpgart_be.c and the ac version
seems to be missing a lot of ppc specific pieces that are in Ben's tree.

make[3]: Entering directory `/home/kbhend/acox/linux/drivers/char/agp'
gcc -D__KERNEL__ -I/home/kbhend/acox/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE
-DMODVERSIONS -include /home/kbhend/acox/linux/include/linux/modversions.h
  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:84: #error "Please define flush_cache."
agpgart_be.c:398: warning: `agp_generic_agp_enable' defined but not used
agpgart_be.c:524: warning: `agp_generic_create_gatt_table' defined but not
used agpgart_be.c:642: warning: `agp_generic_suspend' defined but not used
agpgart_be.c:647: warning: `agp_generic_resume' defined but not used
agpgart_be.c:651: warning: `agp_generic_free_gatt_table' defined but not
used
agpgart_be.c:699: warning: `agp_generic_insert_memory' defined but not used
agpgart_be.c:757: warning: `agp_generic_remove_memory' defined but not used
agpgart_be.c:774: warning: `agp_generic_alloc_by_type' defined but not used
agpgart_be.c:779: warning: `agp_generic_free_by_type' defined but not used
agpgart_be.c:797: warning: `agp_generic_alloc_page' defined but not used
agpgart_be.c:811: warning: `agp_generic_destroy_page' defined but not used
make[3]: *** [agpgart_be.o] Error 1


So what is the solution here.  I really want a STABLE 2.4.X kernel so that
I can work on testing radeon drivers.  I don't want VM trouble (been there
done that).  But I do need to get the latest kernel video drivers.

Is there a ppc specific version of the AC tree anyplace, that I should be
grabbing?  Or have the stability issues in the VM in the Linus tree been
fixed?  I noticed that Linus was already at 2.4.12 and even that needed
patches.

Will someone please point me to where I should be grabbing source code
from?  If I don't want to be an experimental kernel guinea pig, should I
grab a 2.4.9 kernel and then backport all of the video drivers?

Thanks!

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

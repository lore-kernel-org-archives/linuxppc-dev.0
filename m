Return-Path: <anton@ozlabs.org>
Date: Fri, 26 Feb 2010 17:18:46 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: powerpc: bump SECTION_SIZE_BITS from 16MB to 256MB
Message-ID: <20100226061846.GE475@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The current setting for SECTION_SIZE_BITS is quite small compared to
everyone else:

arch/powerpc/include/asm/sparsemem.h:#define SECTION_SIZE_BITS  24

arch/sparc/include/asm/sparsemem.h:#define SECTION_SIZE_BITS    30
arch/ia64/include/asm/sparsemem.h:#define SECTION_SIZE_BITS     (30)
arch/s390/include/asm/sparsemem.h:#define SECTION_SIZE_BITS     28
arch/x86/include/asm/sparsemem.h:# define SECTION_SIZE_BITS     27 

And it has proven to be an issue during boot on very large machines.
If hotplug memory is enabled, drivers/base/memory.c does this:

       for (i = 0; i < NR_MEM_SECTIONS; i++) {
                if (!present_section_nr(i))
                        continue;
                err = add_memory_block(0, __nr_to_section(i), MEM_ONLINE,
                                        0, BOOT);
                if (!ret)
                        ret = err;
        }

Which creates a sysfs directory for every 16MB of memory. As a result
I'm seeing up to 30 minutes spent here during boot:

c000000000248ee0 .__sysfs_add_one+0x28/0x128
c0000000002492a8 .sysfs_add_one+0x38/0x188
c000000000249c88 .create_dir+0x70/0x138
c000000000249d98 .sysfs_create_dir+0x48/0x78
c00000000032bad8 .kobject_add_internal+0x140/0x308
c00000000032beb4 .kobject_init_and_add+0x4c/0x68
c00000000046c2c0 .sysdev_register+0xa0/0x220
c00000000047b1dc .add_memory_block+0x124/0x1e8
c0000000008d1f28 .memory_dev_init+0xf4/0x168
c0000000008d1b64 .driver_init+0x50/0x64
c000000000890378 .do_basic_setup+0x40/0xd4

I assume there are some O(n^2) issues in sysfs as we add all the memory
nodes. Bumping SECTION_SIZE_BITS to 256 MB drops the time to about 10
seconds and results in a much smaller /sys.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

--- linux-2.6.33/arch/powerpc/include/asm/sparsemem.h~	2010-02-25 22:53:54.000000000 -0600
+++ linux-2.6.33/arch/powerpc/include/asm/sparsemem.h	2010-02-25 22:54:06.000000000 -0600
@@ -8,7 +8,7 @@
  * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
-#define SECTION_SIZE_BITS       24
+#define SECTION_SIZE_BITS       28
 
 #define MAX_PHYSADDR_BITS       44
 #define MAX_PHYSMEM_BITS        44

Date: Wed, 24 Apr 2002 02:54:57 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Problems with AGP Apple UniNorth support in 2.4.19-pre7-ben0 kernel
Message-Id: <20020424025457.7b323ff0.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

There seems to be problems with AGP Apple UniNorth support in the latest
2.4.19-pre7-ben0 kernel.  First you can't select it in make menuconfig.
I fixed that with this simple patch:

--- drivers/char/.orig/Config.in        Sat Apr 20 19:06:15 2002
+++ drivers/char/.mod/Config.in Wed Apr 24 02:15:28 2002
@@ -263,7 +263,7 @@
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
    dep_bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1 $CONFIG_IA64
-   dep_bool '  Apple UniNorth support' CONFIG_AGP_UNINORTH CONFIG_ALL_PPC
+   dep_bool '  Apple UniNorth support' CONFIG_AGP_UNINORTH $CONFIG_ALL_PPC
 fi

 bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM

But then I just get the following fatal error compiling agpgart_be.c:

gcc -D__KERNEL__ -I/usr/src/linux-2.4-benh-19pre7/include -Wall -Wstrict-prototy
pes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -D_
_powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmult
iple -mstring   -nostdinc -I /usr/lib/gcc-lib/ppc-yellowdog-linux/2.95.4/include
 -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:88: #error "Please define flush_cache."
agpgart_be.c: In function `agp_generic_agp_enable':
agpgart_be.c:404: warning: unused variable `cap_id'
agpgart_be.c: In function `uninorth_insert_memory':
agpgart_be.c:3924: warning: passing arg 1 of `flush_dcache_range' makes integer
from pointer without a cast
agpgart_be.c:3924: warning: passing arg 2 of `flush_dcache_range' makes integer
from pointer without a cast
agpgart_be.c: In function `agp_find_supported_device':
agpgart_be.c:4622: warning: unused variable `scratch'
agpgart_be.c:4622: warning: unused variable `cap_id'
agpgart_be.c: At top level:
agpgart_be.c:402: warning: `agp_generic_agp_enable' defined but not used
agpgart_be.c:495: warning: `agp_generic_create_gatt_table' defined but not used
agpgart_be.c:623: warning: `agp_generic_free_gatt_table' defined but not used
agpgart_be.c:671: warning: `agp_generic_insert_memory' defined but not used

The relevant code in agpgart_be.c is:

static inline void flush_cache(void)
{
#if defined(__i386__) || defined(__x86_64__)
        asm volatile ("wbinvd":::"memory");
#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__)
        /* ??? I wonder if we'll really need to flush caches, or if the
           core logic can manage to keep the system coherent.  The ARM
           speaks only of using `cflush' to get things in memory in
           preparation for power failure.

           If we do need to call `cflush', we'll need a target page,
           as we can only flush one page at a time.

           Ditto for IA-64. --davidm 00/08/07 */
        mb();
#else
#error "Please define flush_cache."
#endif
}

When this worked in the 2.4.18-ben0 kernel, the line with defined
__alpha__ or __ia64__ or __sparc__ had an extra "|| defined (__powerpc__)",
which is now missing, hence the fatal compilation error.

Any comments?  Is it safe just to add back in the "|| defined (__powerpc__)"?

						-Thanks

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

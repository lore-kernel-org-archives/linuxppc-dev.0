Date: Mon, 2 Jul 2001 05:34:44 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Current state of the 2_4_devel tree
Message-ID: <Pine.LNX.3.95.1010702051131.4368C-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Knowing that there were comprehensive changes under way to the bootup code
in the devel kernel, I stopped updating my source tree a few weeks ago-
the plan was to wait until the dust hd settled and then migrate to the new
scheme. I've not heard any new screams about bi_recs lately, so I decided
this morning to download the latest devel tree and hand patch it with the
various changes I've made to the old trees to get my board working. Most
of these changes were idential between the new and the old; the only
substantial changes were in my board_setup.c file, changing board_init()
to platform_init()(), and adding a board_set_bat() function. I made no
changes to the arch/ppc/mm code.

Cautiously pessemistic, I then did a make config; make clean; make dep;
make zImage.initrd. The compile wen smoothly until near the end- there
were problems in arch/ppc/mm, compiling init.c. The errors are below.

I didn't touch either init.c, or mmu_decl.h, so I would assume that there
should be no errors, unless the current stae of the source tree is
uncompilable :)

Anyhow, the errors are below:

powerpc-linux-gcc -D__KERNEL__
-I/home/ghurwitz/glast/linuxppc_2_4_devel-latest/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe
-ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o init.o init.c
In file included from init.c:59:
mmu_decl.h: In function `setbat':
mmu_decl.h:33: storage class specified for parameter `__map_without_bats'
mmu_decl.h:34: storage class specified for parameter `end_of_DRAM'
mmu_decl.h:35: storage class specified for parameter `ioremap_base'
mmu_decl.h:36: storage class specified for parameter `ioremap_bot'
mmu_decl.h:37: storage class specified for parameter `rtas_data'
mmu_decl.h:37: storage class specified for parameter `rtas_size'
mmu_decl.h:39: storage class specified for parameter `total_memory'
mmu_decl.h:40: storage class specified for parameter `total_lowmem'
mmu_decl.h:41: storage class specified for parameter `ram_phys_base'
mmu_decl.h:42: storage class specified for parameter `mem_init_done'
init.c:65: redeclaration of `end_of_DRAM'
mmu_decl.h:34: `end_of_DRAM' previously declared here
init.c:66: redeclaration of `total_memory'
mmu_decl.h:39: `total_memory' previously declared here
init.c:67: redeclaration of `total_lowmem'
mmu_decl.h:40: `total_lowmem' previously declared here
init.c:68: redeclaration of `ram_phys_base'
mmu_decl.h:41: `ram_phys_base' previously declared here
init.c:69: redeclaration of `mem_init_done'
mmu_decl.h:42: `mem_init_done' previously declared here
init.c:76: storage class specified for parameter `swapper_pg_dir'
init.c:77: storage class specified for parameter `_start'
init.c:77: storage class specified for parameter `_end'
init.c:78: storage class specified for parameter `etext'
init.c:78: storage class specified for parameter `_stext'
init.c:79: storage class specified for parameter `__init_begin'
init.c:79: storage class specified for parameter `__init_end'
init.c:80: storage class specified for parameter `__prep_begin'
init.c:80: storage class specified for parameter `__prep_end'
init.c:81: storage class specified for parameter `__chrp_begin'
init.c:81: storage class specified for parameter `__chrp_end'
init.c:82: storage class specified for parameter `__pmac_begin'
init.c:82: storage class specified for parameter `__pmac_end'
init.c:83: storage class specified for parameter `__apus_begin'
init.c:83: storage class specified for parameter `__apus_end'
init.c:84: storage class specified for parameter `__openfirmware_begin'
init.c:84: storage class specified for parameter `__openfirmware_end'
init.c:85: storage class specified for parameter `num_memory'
init.c:86: storage class specified for parameter `memory'
init.c:87: storage class specified for parameter `boot_infos'
init.c:100: storage class specified for parameter `current_set'
init.c:102: parameter `klimit' is initialized
init.c:110: redeclaration of `__map_without_bats'
mmu_decl.h:33: `__map_without_bats' previously declared here
init.c:115: parameter `__max_low_memory' is initialized
init.c:118: parse error before `{'
mmu_decl.h:33: parm types given both in parmlist and separately
init.c:120: `high' undeclared (first use in this function)
init.c:120: (Each undeclared identifier is reported only once
init.c:120: for each function it appears in.)
init.c:130: `low' undeclared (first use in this function)
init.c:132: warning: `return' with a value, in function returning void
init.c: In function `si_meminfo':
init.c:214: `totalram_pages' undeclared (first use in this function)
init.c:218: `totalhigh_pages' undeclared (first use in this function)
init.c: In function `free_initmem':
init.c:247: `__init_begin' undeclared (first use in this function)
init.c:247: `__init_end' undeclared (first use in this function)
init.c:249: `__pmac_begin' undeclared (first use in this function)
init.c:249: `__pmac_end' undeclared (first use in this function)
init.c:251: `__chrp_begin' undeclared (first use in this function)
init.c:251: `__chrp_end' undeclared (first use in this function)
init.c:253: `__prep_begin' undeclared (first use in this function)
init.c:253: `__prep_end' undeclared (first use in this function)
init.c:255: `__apus_begin' undeclared (first use in this function)
init.c:255: `__apus_end' undeclared (first use in this function)
init.c:257: `__openfirmware_begin' undeclared (first use in this function)
init.c:257: `__openfirmware_end' undeclared (first use in this function)
init.c: In function `free_initrd_mem':
init.c:271: `totalram_pages' undeclared (first use in this function)
init.c: In function `MMU_setup':
init.c:287: `__map_without_bats' undeclared (first use in this function)
init.c:308: `__max_memory' undeclared (first use in this function)
init.c: In function `MMU_init':
init.c:329: `total_memory' undeclared (first use in this function)
init.c:331: `__max_memory' undeclared (first use in this function)
init.c:333: `total_lowmem' undeclared (first use in this function)
init.c:334: `__max_low_memory' undeclared (first use in this function)
init.c:340: `end_of_DRAM' undeclared (first use in this function)
init.c:341: warning: implicit declaration of function `set_phys_avail'
init.c: In function `early_get_page':
init.c:384: `init_bootmem_done' undeclared (first use in this function)
init.c: In function `do_init_bootmem':
init.c:410: `phys_avail' undeclared (first use in this function)
init.c:422: `boot_mapsize' undeclared (first use in this function)
init.c:423: `total_lowmem' undeclared (first use in this function)
init.c:433: `init_bootmem_done' undeclared (first use in this function)
init.c: In function `paging_init':
init.c:454: `total_lowmem' undeclared (first use in this function)
init.c: In function `mem_init':
init.c:486: `totalram_pages' undeclared (first use in this function)
init.c:511: `end_of_DRAM' undeclared (first use in this function)
init.c:515: `etext' undeclared (first use in this function)
init.c:518: `__init_begin' undeclared (first use in this function)
init.c:518: `__init_end' undeclared (first use in this function)
init.c:520: `klimit' undeclared (first use in this function)
init.c:545: `totalhigh_pages' undeclared (first use in this function)
init.c:546: `mem_init_done' undeclared (first use in this function)
init.c: At top level:
init.c:555: warning: type mismatch with previous implicit declaration
init.c:341: warning: previous implicit declaration of `set_phys_avail'
init.c:555: warning: `set_phys_avail' was previously implicitly declared
to return `int'
init.c: In function `set_phys_avail':
init.c:563: `phys_avail' undeclared (first use in this function)
init.c:572: `_stext' undeclared (first use in this function)
init.c:573: `klimit' undeclared (first use in this function)
init.c: In function `set_pte':
init.c:623: `total_memory' undeclared (first use in this function)
make[2]: *** [init.o] Error 1
make[2]: Leaving directory
`/home/ghurwitz/glast/linuxppc_2_4_devel-latest/arch/ppc/mm'


It looks like there is some problem in mmu_decl.h- I must admit to having
no idea what the "Storage class specified" errors mean, but I am willing
to bet that if they are fixed, the rest will follow.

Thanks,
--Gus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

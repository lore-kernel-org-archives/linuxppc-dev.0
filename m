Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17827.25684.483221.376125@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 20:45:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

There are an assortment of bug fixes there (most of which fix
potential oopses or compile failures), plus documentation and
defconfig updates.  I have included the full log messages below.

Thanks,
Paul.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    4 
 arch/powerpc/Kconfig                               |    4 
 arch/powerpc/boot/dts/lite5200.dts                 |    4 
 arch/powerpc/boot/dts/lite5200b.dts                |    4 
 arch/powerpc/configs/ppc64_defconfig               |  251 ++++++++++++++++----
 arch/powerpc/kernel/asm-offsets.c                  |    3 
 arch/powerpc/kernel/entry_64.S                     |   13 -
 arch/powerpc/mm/hugetlbpage.c                      |    8 -
 arch/powerpc/platforms/52xx/lite5200.c             |    1 
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |    7 -
 arch/powerpc/platforms/iseries/lpevents.c          |    4 
 arch/powerpc/platforms/iseries/mf.c                |    4 
 arch/powerpc/platforms/iseries/proc.c              |   11 +
 arch/powerpc/platforms/iseries/setup.c             |    3 
 arch/powerpc/platforms/iseries/viopath.c           |    4 
 arch/powerpc/platforms/maple/setup.c               |    1 
 arch/powerpc/platforms/pasemi/setup.c              |    1 
 arch/powerpc/platforms/pseries/hvCall.S            |    9 -
 arch/powerpc/platforms/pseries/hvCall_inst.c       |    4 
 arch/powerpc/platforms/pseries/xics.c              |    5 
 arch/powerpc/sysdev/Makefile                       |    2 
 drivers/serial/mpc52xx_uart.c                      |    2 
 include/asm-powerpc/bug.h                          |   27 ++
 include/asm-powerpc/hvcall.h                       |    2 
 include/asm-powerpc/mpc52xx.h                      |    1 
 25 files changed, 282 insertions(+), 97 deletions(-)

commit dc40127ca5c6e1da48d2b5f9d0c65b5795faac12
Author: Anton Blanchard <anton@samba.org>
Date:   Tue Jan 9 02:43:02 2007 +1100

    [POWERPC] Fix bugs in the hypervisor call stats code
    
    There were a few issues with the HCALL_STATS code:
    
    - PURR cpu feature checks were backwards
    - We iterated one entry off the end of the hcall_stats array
    - Remove dead update_hcall_stats() function prototype
    
    I noticed one thing while debugging, and that is we call H_ENTER (to set
    up the MMU hashtable in early init) before we have done the cpu fixups.
    This means we will execute the PURR SPR reads even on a CPU that isnt
    capable of it. I wonder if we can move the CPU feature fixups earlier.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ab87e8dc88a7cae341c403547cea6b022f5ac023
Author: Anton Blanchard <anton@samba.org>
Date:   Tue Jan 9 02:37:16 2007 +1100

    [POWERPC] Fix corruption in hcall9
    
    It looks to me like we are corrupting r12 in the hcall9 function.
    Although we have r0 free we cant use offsets against it, so save
    away r12 in there instead.  r12 holds the ninth return value from
    the hypervisor call, so without this fix, the caller will see the
    wrong value for the ninth element in the array that gets the return
    values.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e75b171768b8b98ec5fd57acb3e87a30c97c9472
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 4 17:06:21 2007 +1100

    [POWERPC] iSeries: fix setup initcall
    
    Clearing the progress indicator should only be done if we are running
    on legacy iSeries.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e9966ff85013be0ef56d3c76f3b4d5c02488d964
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 4 17:05:13 2007 +1100

    [POWERPC] iSeries: fix viopath initialisation
    
    /proc/iSeries/config should only be created if we are running on legacy
    iSeries.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 13d2c9bbb09e37e8a231a36b279a97861d6d5407
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 4 17:04:21 2007 +1100

    [POWERPC] iSeries: fix lpevents initialisation
    
    /proc/iSeries/lpevents should only be created if we are running
    on legacy iSeries.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8404e654300cb807428b839d5ae56fd45b5acb92
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 4 17:03:16 2007 +1100

    [POWERPC] iSeries: fix proc/iSeries initialisation
    
    These proc files should only be created if we are running on legacy
    iSeries.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d9523aa157e9fbb93467dcd0d1bed9604153bf7f
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 4 17:01:51 2007 +1100

    [POWERPC] iSeries: fix mf proc initialisation
    
    This proc file should only be created if we are running on legacy
    iSeries.  Since we can now run the same kernel on legacy iSeries and
    other machines, we currently get the /proc/iSeries directory and the
    files in it on non-iSeries machines, and accessing them causes an oops
    in some cases.  This and the following patches make sure that these
    files are not created on non-iSeries machines, thus avoiding the oops.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 7232846b8d682a56407839e3774d03be0c7806c8
Author: Olaf Hering <olaf@aepfle.de>
Date:   Wed Jan 3 18:33:56 2007 +0100

    [POWERPC] disable PReP and EFIKA during make oldconfig
    
    New boards should not be enabled per default.
    Disable EFIKA and PReP per default.
    Anyone who really needes the new code can enable it during make oldconfig.
    
    Signed-off-by: Olaf Hering <olaf@aepfle.de>
    Acked-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c98750c2eb07b0bf49db0630cb5017ede005ce14
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Jan 2 15:45:37 2007 -0700

    [POWERPC] Fix mpc52xx serial driver to work for arch/ppc again
    
    The mpc52xx_uart_of_enumerate() function was added when adding 52xx
    support to arch/powerpc, but it must not be called for arch/ppc.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 9b3a6f4ab98809c93ac57fa5e11dff0575046efc
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Jan 2 15:45:29 2007 -0700

    [POWERPC] Don't include powerpc/sysdev/rom.o for arch/ppc builds
    
    sysdev/rom.c is for arch/powerpc only.  Don't compile it when building
    an arch/ppc kernel.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Acked-by: Sylvain Munaut <tnt@246tNt.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit a5b6ad6691763ee5eba46665d014d5abfe433df2
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Jan 2 15:44:44 2007 -0700

    [POWERPC] Fix mpc52xx fdt to use correct device_type for sound devices
    
    This corrects the documented interface for mpc52xx device trees.
    Sound devices should be using 'sound' for the device_type field, not
    the type of sound interface.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Acked-by: Sylvain Munaut <tnt@246tNt.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5c334eed6ecd66cebfbc80267149e755510d8bc8
Author: Sylvain Munaut <tnt@246tNt.com>
Date:   Tue Jan 2 23:29:53 2007 +0100

    [POWERPC] 52xx: Don't use device_initcall to probe of_platform_bus
    
    Using device_initcall makes it happen for every platform that
    compiles this file in. This is really bad, for obvious reasons.
    
    Instead, we use the .init field of the machine description. If
    the platform needs the hook to do something specific it can provides
    its own function and call mpc52xx_declare_of_platform_devices from
    there. If not, the mpc52xx_declare_of_platform_devices function can
    directly be used as the init hook.
    
    Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
    Acked-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 56c336cb05d58991f3e9d5f0ec098ba0f219a15e
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jan 2 16:13:50 2007 +1100

    [POWERPC] Add legacy iSeries to ppc64_defconfig
    
    Since we can now boot legacy iSeries and other machines with the same
    config, enable legacy iSeries in ppc64_defconfig.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 338e997d94840baca115fb35dcf82867b1f3dc32
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jan 2 16:11:09 2007 +1100

    [POWERPC] Update ppc64_defconfig
    
    Enabled new netfilter stuff corresponding to what was enabled before
    under different names, and turned on the gxt4500 video driver;
    otherwise just took the defaults.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 007d88d042d7b71aa2c9fc615aef97888e20ddf3
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Jan 1 18:45:34 2007 +0000

    [POWERPC] Fix manual assembly WARN_ON() in enter_rtas().
    
    When we switched over to the generic BUG mechanism we forgot to change
    the assembly code which open-codes a WARN_ON() in enter_rtas(), so the
    bug table got corrupted.
    
    This patch provides an EMIT_BUG_ENTRY macro for use in assembly code,
    and uses it in entry_64.S. Tested with CONFIG_DEBUG_BUGVERBOSE on ppc64
    but not without -- I tried to turn it off but it wouldn't go away; I
    suspect Aunt Tillie probably needed it.
    
    This version gets __FILE__ and __LINE__ right in the assembly version --
    rather than saying include/asm-powerpc/bug.h line 21 every time which is
    a little suboptimal.
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 673aeb76d07f49f2b07792f813bc2a9fee212ab7
Author: Michal Ostrowski <mostrows@watson.ibm.com>
Date:   Wed Dec 20 07:29:40 2006 -0600

    [POWERPC] Avoid calling get_irq_server() with a real, not virtual irq.
    
    We can use default_server when masking an interrupt vector.
    get_irq_server() assumes a virtual irq, so badness may happen if we
    give it a real one.
    
    Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5e264a5215e4b703b1bbeb2910ea4441886be8d7
Author: Nathan Lynch <ntl@pobox.com>
Date:   Tue Jan 2 16:37:06 2007 -0600

    [POWERPC] Fix unbalanced uses of of_node_put
    
    The (maple|pasemi)_init_IRQ functions call of_node_put(root) once more
    than they should, causing the refcount of the root node to underflow,
    which triggers the WARN_ON in kref_get.
    
    Signed-off-by: Nathan Lynch <ntl@pobox.com>
    Acked-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6aa3e1e9447134ccda8b04b91c4ba8182274a78e
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri Dec 22 09:23:03 2006 +1100

    [POWERPC] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
    
    The powerpc specific version of hugetlb_get_unmapped_area() makes some
    unwarranted assumptions about what checks have been made to its
    parameters by its callers.  This will lead to a BUG_ON() if a 32-bit
    process attempts to make a hugepage mapping which extends above
    TASK_SIZE (4GB).
    
    I'm not sure if these assumptions came about because they were valid
    with earlier versions of the get_unmapped_area() path, or if it was
    always broken.  Nonetheless this patch fixes the logic, and removes
    the crash.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

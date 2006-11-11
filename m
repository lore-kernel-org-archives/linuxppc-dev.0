Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17749.46275.200100.465103@cargo.ozlabs.ibm.com>
Date: Sat, 11 Nov 2006 22:32:19 +1100
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

to get some more PowerPC bugfixes, as listed below.  I have included
the full commit messages this time.

Thanks,
Paul.

 arch/powerpc/Kconfig                    |    2 +
 arch/powerpc/boot/wrapper               |    4 +--
 arch/powerpc/boot/zImage.lds.S          |    5 +++
 arch/powerpc/kernel/rtas_flash.c        |   47 ++++++++++++++++++++++++-------
 arch/powerpc/platforms/cell/spu_base.c  |   41 ++++++++++++++++++++++-----
 drivers/serial/cpm_uart/cpm_uart.h      |    2 +
 drivers/serial/cpm_uart/cpm_uart_core.c |   16 +++++------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 +
 8 files changed, 88 insertions(+), 31 deletions(-)

commit 36b600f2649e3be49039efe31edeeb64277dbd99
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Thu Nov 2 21:08:45 2006 -0800

    [POWERPC] cell: set ARCH_SPARSEMEM_DEFAULT in Kconfig
    
    The current cell processor support needs sparsemem, so set it as
    the default memory model.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ab56dbddc8a23ff3f4602855aaf0fcb3c814118b
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Nov 10 15:11:20 2006 +1100

    [POWERPC] Fix cell "new style" mapping and add debug
    
    This fixes a typo in the "new style" code for mapping SPE resources,
    which causes it to try to map the same resource 4 times.
    
    It also adds some pr_debug's that are useful to track down issues with
    the firmware when bringinh up new machines.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ae883cab9457aad0fb3342249e1207873d3b64de
Author: John Rose <johnrose@austin.ibm.com>
Date:   Wed Nov 8 10:07:30 2006 -0600

    [POWERPC] pseries: Force 4k update_flash block and list sizes
    
    The enablement of 64k pages on pseries platforms exposed a bug in
    the RTAS mechanism for updating firmware.  RTAS assumes 4k for flash
    block and list sizes, and use of any other sizes results in a failure,
    even though PAPR does not specify any such requirement.
    
    This patch changes the rtas_flash module to force the use of 4k memory
    block and list sizes when preparing and sending a firmware image to
    RTAS.  The rtas_flash function now uses a slab cache of 4k blocks with
    4k alignment, rather than get_zeroed_page(), to allocate the memory for
    the flash blocks and lists.  The 4k alignment requirement is specified
    in PAPR.
    
    Signed-off-by: John Rose <johnrose@austin.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 0091cf5a6ae6e52fc95ceb53200975ef2c81c206
Author: Kalle Pokki <kalle.pokki@iki.fi>
Date:   Wed Nov 1 15:08:13 2006 +0200

    [POWERPC] CPM_UART: Fix non-console initialisation
    
    The cpm_uart driver is initialised incorrectly, if there is a frame buffer
    console, and CONFIG_SERIAL_CPM_CONSOLE is defined. The driver fails to
    call cpm_uart_init_portdesc() and set_lineif() in this case.
    
    Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 599540a85595bd5950354bd95f5ebf9c6e07c971
Author: Kalle Pokki <kalle.pokki@iki.fi>
Date:   Wed Nov 1 09:52:41 2006 +0200

    [POWERPC] CPM_UART: Fix non-console transmit
    
    The SMC and SCC hardware transmitter is enabled at the wrong
    place. Simply writing twice to the non-console port, like
    
    $ echo asdf > /dev/ttyCPM1
    $ echo asdf > /dev/ttyCPM1
    
    puts the shell into endless uninterruptible sleep, since the
    transmitter is stopped after the first write, and is not enabled
    before the shutdown function of the second write. Thus the transmit
    buffers are never emptied.
    
    Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 621da0f8af228525e4b40390e36fbdc44a587cf1
Author: Paul Mackerras <paulus@samba.org>
Date:   Thu Nov 9 16:00:06 2006 +1100

    [POWERPC] Make sure initrd and dtb sections get into zImage correctly
    
    The "wrapper" script was using the wrong names for the initrd and
    dtb (device-tree blob) sections.  This fixes it, and also ensures
    the symbols for the start and end of the dtb get defined correctly.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

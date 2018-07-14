Return-Path: <noring@nocrew.org>
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41SbVq28jxzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jul 2018 02:59:14 +1000 (AEST)
Date: Sat, 14 Jul 2018 18:49:08 +0200
From: Fredrik Noring <noring@nocrew.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Geoff Levand <geoff@infradead.org>
Subject: Improvements for the PS3
Message-ID: <20180714164906.GQ23412@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I just checked out the latest "ps3-queue" branch

https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git/log/?h=ps3-queue

to upgrade my OtherOS boot kernel. I essentially started out with

$ make ARCH=powerpc ps3_defconfig
$ make ARCH=powerpc dtbImage.ps3

to obtain an image to install. The first problem was its size, which is
around 20 MB by default and therefore uninstallable. It seems the main
sections causing size problems in the ELF are (sizes in leftmost column):

	0x400000 OBJECT LOCAL  DEFAULT 37 stack_trace
	0x29feb0 OBJECT LOCAL  DEFAULT 37 lock_classes
	0x200000 OBJECT GLOBAL DEFAULT 37 lock_chains
	0x200000 OBJECT LOCAL  DEFAULT 37 list_entries
	 0xa0000 OBJECT LOCAL  DEFAULT 37 chain_hlocks
	 0x40000 OBJECT LOCAL  DEFAULT 37 chainhash_table
	 0x20000 OBJECT LOCAL  DEFAULT 37 __log_buf

I modified arch/powerpc/boot/wrapper to make the size error more apparent:

--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -550,5 +550,10 @@ ps3)
     bld="otheros.bld"
     [ $size -le 16777216 ] || bld="otheros-too-big.bld"
     gzip -n --force -9 --stdout "$ofile.bin" > "$odir/$bld"
+    if [ $size -gt 16777216 ]
+    then
+	    echo "ERROR: Image size $size bytes is too large for 16 MiB limit" >&2
+	    exit 1
+    fi
     ;;
 esac

I then proceeded with disabling STACKTRACE_SUPPORT and LOCKDEP_SUPPORT,
which reduced the size to about 8 MB, well below the 16 MiB limit. Perhaps
disabling these entirely is a bit heavy-handed? Is there a smarter way?

Trying to start the kernel results in a completely black screen. Nothing
happens. To have a chance of seeing anything I had configured:

CONFIG_FB_PS3=y
CONFIG_FB_PS3_DEFAULT_SIZE_M=9
CONFIG_CMDLINE="video=ps3fb:mode:10"

I decided to proceed by using lv1_panic to bisect the PowerPC boot process.
It either froze, in which case the call to lv1_panic was not reached, or it
rebooted. Interestingly, it turned out that ps3fb_probe was actually called,
so I added a sleep with

--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -1178,6 +1179,8 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
 
 	ps3fb.task = task;
 
+	msleep(10000);
+
 	return 0;
 
 err_unregister_framebuffer:

et voilà, the screen came alive and the kernel panic was revealed! It seems
the kernel panics so fast that the PS3 frame buffer is unprepared. This is,
of course, very unfortunate because trying to debug the boot process without
a screen or any other means of obtaining console text is quite difficult.

[ In this case the panic was caused by a missing CONFIG_DEVTMPFS=y, where
"Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100",
is helpful to actually see in text. ]

I suppose the problem is that it relies on interrupts for ps3fb_sync_image
to regularly copy the image, hence without them the screen isn't updated to
show kernel panics, etc. Perhaps one way to fix that is to implement the
struct fb_tile_ops API, so that the console is synchronously updated? Would
that be acceptable?

Fredrik

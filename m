Return-Path: <cbanu@ixiacom.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0086.outbound.protection.outlook.com [157.56.110.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB4751A02D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:26:17 +1100 (AEDT)
From: Cosmin Banu <cbanu@ixiacom.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: enable kdump capture kernel functionality
Date: Tue, 9 Feb 2016 14:11:47 +0000
Message-ID: <CO2PR0601MB0967A94882D932E8E4155456B6D60@CO2PR0601MB0967.namprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am trying to rebuild the kernel for one of our powerpc devices to include=
 kdump capture kernel functionality, but I'm having trouble getting it to l=
oad for use on panic.
I'm running Linux 3.14.60 on e500v2 (COMX-P2020 module).

I've tried following the documentation at https://www.kernel.org/doc/Docume=
ntation/kdump/kdump.txt:
CONFIG_KEXEC=3Dy
CONFIG_CRASH_DUMP=3Dy
CONFIG_NONSTATIC_KERNEL=3Dy
CONFIG_PROC_VMCORE=3Dy
CONFIG_RELOCATABLE=3Dy
CONFIG_RELOCATABLE_PPC32=3Dy

These are the parameters I'm using to boot the kernel:
> cat /proc/cmdline
root=3D/dev/mmcblk0p2 rw rootdelay=3D15 ip=3D10.215.181.92::10.215.180.1:25=
5.255.254.0:XSTREAM-DEV2:eth0 loglevel=3D0 mfgstring=3D1:XF40-LB-SSSSSS-MMD=
DYY console=3DttyS0,115200 ramdisk_size=3D700000 cache-sram-size=3D0x10000 =
crashkernel=3D0x04000000@0x04000000 slub_debug=3DFPZ

Running the following command:
> kexec -l /boot/uImage -t uImage-ppc --dtb=3D/boot/comx.dtb --initrd=3D/bo=
ot/initramfs_data.cpio --command-line=3D"root=3D/dev/mmcblk0p2 3 maxcpus=3D=
1 irqpoll noirqdistrib reset_devices rw rootdelay=3D15 ip=3D10.215.181.92::=
10.215.180.1:255.255.254.0:XSTREAM-DEV2:eth0 loglevel=3D0 mfgstring=3D1:XF4=
0-LB-SSSSSS-MMDDYY console=3DttyS0,115200 ramdisk_size=3D700000 cache-sram-=
size=3D0x10000"
Returns:
Can't add kernel to addr 0x00000000 len 0
Cannot load /boot/uImage

I'm not sure what mechanism is used to load the kernel and where this can b=
e configured. I assumed that the crashkernel parameter from the cmdline is =
the actual setting.
Where should I set this value? Also, how can I ensure that the two kernel i=
mages don't overlap?

Thanks in advance,
Cosmin

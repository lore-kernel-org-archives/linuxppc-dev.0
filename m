From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Date: Tue, 26 Oct 1999 23:41:28 +0200
Message-Id: <199910262141.XAA06091@bogomips.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems compiling ppc kernels.
In-Reply-To: <19991026134728.A25022@alice.realminfo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In lists.linuxppc.dev, you wrote:
> 
> I have been having some real weird problems with compiling 
> kernels for my iMAC.  I have tried kernel versions 2.2.12, 2.3.23, 2.3.21
> And have goten pretty much the same results.

I got 2.3.23 sorta working on my iMac (rev B).  "grep ^C .config" is attached
at the end of this mail.  There are alot of gliches:

  * needs some careful tuning of the config options to get a kernel which
    compiles and links without errors.
  * hfs does'nt compile.
  * other filesystems don't work as modules.
  * usb keyboard needs a (trivial) patch, see below.
  * usb keyboard works only if ADB_KEYBOARD is compiled in too.
  * I have a few keys which don't work at all because they are
    not mapped by usb_kbd_map (that's why the debug printk in the
    patch).
  * I could'nt make the usb mouse work.  usb mouse driver is listed
    in /proc/bus/usb/drivers, the (logitech) mouse is listed in
    /proc/bus/usb/devices, but /proc/misc has no entry for usb mouse.
    gpm does'nt work too.
  * The kernel does'nt survive a "make clean && make vmlinux".
    Starts swapping, gets slower and slower over time.

vger is still at 2.3.18.  usb keyboard does'nt work at all for me.

My default kernel is still 2.2.6 with the old uubsd stack patched in.

  Gerd

------------------------ cut here ---------------------------
diff -u 2.3.23/drivers/usb/keyboard.c my-2.3.23/drivers/usb/keyboard.c
--- 2.3.23/drivers/usb/keyboard.c	Tue Oct 26 23:25:39 1999
+++ my-2.3.23/drivers/usb/keyboard.c	Sun Oct 24 11:50:09 1999
@@ -66,13 +66,15 @@
     int scancode = (int) usb_kbd_map[key];
     if(scancode)
     {
-#ifndef CONFIG_MAC_KEYBOARD
+#ifndef CONFIG_ADB_KEYBOARD
         if(scancode & PCKBD_NEEDS_E0)
         {
             handle_scancode(0xe0, 1);
         }
-#endif /* CONFIG_MAC_KEYBOARD */
+#endif /* CONFIG_ADB_KEYBOARD */
         handle_scancode((scancode & ~PCKBD_NEEDS_E0), down);
+    } else {
+	printk("usb-keyboard: key=%d (0x%x) not found in usb_kbd_map\n",key,key);
     }
 }
 
------------------------ cut here ---------------------------
CONFIG_PPC=y
CONFIG_6xx=y
CONFIG_PMAC=y
CONFIG_MACH_SPECIFIC=y
CONFIG_6xx=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_PCI=y
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_FB=y
CONFIG_PMAC_PBOOK=y
CONFIG_MAC_SERIAL=y
CONFIG_ADB=y
CONFIG_ADB_CUDA=y
CONFIG_ADB_MACIO=y
CONFIG_ADB_PMU=y
CONFIG_ADB_KEYBOARD=y
CONFIG_PROC_DEVICETREE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_IDEDMA_PMAC_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PARIDE_PARPORT=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_IP_ALIAS=y
CONFIG_SKB_LARGE=y
CONFIG_KHTTPD=m
CONFIG_ATALK=m
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_SCSI_NCR53C8XX_IOMAPPED=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_BMAC=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_OF=y
CONFIG_FB_ATY=y
CONFIG_FB_VIRTUAL=m
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_MAC=m
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN12x22=y
CONFIG_FONT_6x11=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_BUSMOUSE=y
CONFIG_ADBMOUSE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=y
CONFIG_USB=y
CONFIG_USB_OHCI=y
CONFIG_USB_PROC=y
CONFIG_USB_HUB=y
CONFIG_USB_MOUSE=y
CONFIG_USB_KBD=y
CONFIG_AUTOFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_SOUND=m
CONFIG_DMASOUND=m

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: RE: Driver on Linux
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 27 Jun 2003 13:18:06 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED703039D@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: <Christophe.LINDHEIMER@fr.thalesgroup.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I thought I could make fd=open("/dev/visu", 0) in init of the
> driver 2 but I
> get ooops.

To open a device from kernel mode, you need to:

  /* Bypass argument validity check in FS calls. See <asm/uaccess.h> */
  mm_segment_t oldfs = get_fs();
  set_fs(KERNEL_DS);
  fd=open("/dev/visu", 0)

  /* Restore argument validity check */
  set_fs(oldfs);


> I also need to make something like ioctl(fd, IO_Special...
> )but the function
> ioctl is unknown in the kernel.

To have the ioctl, you should add to the beginning of your source file:

#include <linux/unistd.h>
/* Declare "ioctl" system call */
static inline _syscall3(int,ioctl,int,fd,int,request,void*,arg1)


Regards,
--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

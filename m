Date: Fri, 9 Jul 2004 09:37:07 -0700
Message-Id: <200407091637.i69Gb7525493@sierra.gdatech.com>
From: "Augustine Nebu Philips" <nebu@gdatech.com>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: nebu@gdatech.com
Subject: driver ERRNO problem on E500 / GLIBC environment
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having an MPC8540-board that runs

 * U-Boot-1.1.1
 * Kernel 2.4.27
 * from-scratch ramdisk.

My toolchain was created with the crosstool.sh script for the E500 core,
with GCC-3.3.2/GLIBC-2.3.2.I have an application and related drivers
that talk to a network device through PCI-X.

Problem:
--------
1. The return value of an ioctl (that is expected to fail) called from
the application, NEVER sets the value of the 'errno' variable. To be
more specific,

*this is what is expected:
 -------------------------
 retVal = ioctl(....);
 retVal = -1, errno = 1049

*this is what happens:
 ---------------------
 retVal = -1049, errno = 0

The driver returns value -1049 to the kernel (arch/ppc/kerne/entry.S)
and r3 has this value. But from here back to the application through the
LIBC macros, these values DONT change.

Going through the LIBC code, from
sysdeps/unix/sysv/linux/powerpc/powerpc32/sysdep.h, it seems that the
code block that sets the retVal and errno values are not getting
executed coz of the R0 value...? [_sc_err & 0x10000000]

I'm doing an insmod of my driver. Normal IOCTLS (for e.g., ifconfig etc)
seem to work perfectly.

I'm sort of stuck up on how to go about debugging this R0 register value
(if at all).. who sets it.. etc...? Is the driver supposed to store the
correct value in R0..?

Please advise..
Regards
Nebu

*************************************************************
GDA Technologies, Inc.
1010 Rincon Circle
San Jose CA, 95131
Phone	(408) 432-3090
Fax	(408) 432-3091

Accelerate Your Innovation
**************************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

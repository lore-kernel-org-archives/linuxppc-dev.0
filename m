Message-ID: <01C18705.8C0C5810.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Writing to PCI Bridge in User Space - Problem
Date: Mon, 17 Dec 2001 14:17:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a "resident" driver which reads and writes a PLX PCI Bridge
chip, which is mapped into 0x2000.0000 in MMU_init() (for the mpc860).

The driver controls an LED, attached to the PLX chip, by writing to the
one of the PLX chip regs whenever its ioctl() fops func is called.

The kernel space, of course, is mapped in at 0xc000.0000.


Immediately before executing  - execve("/sbin/init") -  in init(),
to get the app going, the kernel code can call the same func, say,
led_onOff(), that the driver's ioctl() calls to turn the LED on and OFF.
This works fine.

But when my app executes an ioctl(), and then the driver's ioctl() func
calls the same func, led_onOff(),  the LED doesn't turn ON and OFF
(doesn't do anything).  There are no addr exceptions errors.  The code
in led_onOff executes printk()'s OK.

This func, led_onOff() uses get_user() and put_user() to access the
non-kernel-space address 0x2000.0000 + PLX_reg_offset.


So, why does it work fine just before starting the app, from the non-driver
kernel code, but not from the driver's ioctl fops func?


"Thanks for your help  "
"my fellow linuxonians!"
     /
  \O/
   \/	<---- Steven
 _/\_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 19 Dec 2001 21:23:37 +0100
From: BURJAN Gabor <burjang@elte.hu>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel panic at boot [3c59x]
Message-ID: <20011219202337.GA30003@csoma.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I hope this will be the appropriate forum for this.

Perhaps you've read this on linux-kernel list too.  I have a problem
with booting 2.4.17-rc1 on a RS/6000 (43P-140), when Vortex support is
compiled into the kernel.  Andrew Morton helped me in debugging the
problem.

He suspects that the problem is around the `EL3WINDOW(0);' statement in
the 3c59x driver.  He wrote this:

"My guess would be that something has gone wrong with the PPC emulation
of `outw' to this PCI device's IO space."

I recompiled the kernel with the modifications suggested by him:

--- 3c59x.c     Sat Nov 24 02:06:05 2001
+++ 3c59x.c.changed     Wed Dec 19 21:09:31 2001
@@ -1111,7 +1111,9 @@
        vp->force_fd = vp->full_duplex;
        vp->options = option;
        /* Read the station address from the EEPROM. */
+       printk("(1) ioaddr=%lx\n", ioaddr);
        EL3WINDOW(0);
+       printk("(2) ioaddr=%lx\n", ioaddr);
        {
                int base;

The first printk showed the right ioaddress which belonged to the device
(shown by `lspci -v').  The second printk was not executed because the
kernel paniced before it.  He wrote it's definitely a platform issue.
Any suggestions are welcome.

Related URLs:

oops message run through ksymoops:
        http://www.csoma.elte.hu/~burjang/oops.2.4.17-rc1.2001-12-17.ksymoops
full objdump of the related driver:
        http://www.csoma.elte.hu/~burjang/objdump-2001-12-18.out
thread on the LKML:
        http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/0191.html

Thanks,

	buga

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

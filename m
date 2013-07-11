Return-Path: <cbf123@mail.usask.ca>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51D2E2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 06:55:35 +1000 (EST)
Message-ID: <51DF1BBB.5060904@mail.usask.ca>
Date: Thu, 11 Jul 2013 14:55:23 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>,
 <kexec@lists.infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: visible memory seems wrong in kexec crash dump kernel
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system with 8GB of memory.  (It's an embedded system and I can't do much about the fact that it's using older software.)

I booted the original kernel with "crashkernel=224M@32M" in the boot args.  I then loaded the crash kernel with:

./kexec -p vmlinux.kontron.strip --append="root=/dev/mtdblock0 rw rootfstype=jffs2 panic=5 1 maxcpus=1 noirqdistrib reset_devices"

Then I triggered a crash:

echo 1 > /proc/sys/kernel/sysrq
echo c > /proc/sysrq-trigger


When the crash kernel came up, it had "elfcorehdr=48392K savemaxmem=8192M" in the kernel boot args, and "free" showed the system as having 7908652 KB of total memory instead of the expected 224MB.

Do I need to manually specify some options to kexec in order to preserve the memory of the original system?  I seem to recall that kexec did this automatically on x86 systems.

Thanks,
Chris

Mime-Version: 1.0
Message-Id: <p06020429bc3df88e63e3@[10.0.1.2]>
Date: Wed, 28 Jan 2004 16:59:29 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Greg Watson <gwatson@lanl.gov>
Subject: Boot code stack size
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm working on the PPC LinuxBIOS project and have recently managed to
boot the Sandpoint (Altimus 7410 PMC) using the latest
linuxppc_2_4_devel kernel (2.4.24-pre2).

However while getting Linux to run on this machine, I hit a problem
with this and earlier kernels running out of stack while
uncompressing the kernel image. The symptom I see is that inflate
returns -3 (FFFFFFFD). To get around the problem, I have to modify
arch/ppc/boot/common/relocate.S and increase the stack size from 8K
(4096*2) to 28K (4096*7). The kernel image is 792890 bytes compressed
and 1734312 bytes uncompressed. The Sandpoint boots reliably with the
increased stack size.

I'm wondering a) if anyone has seen this problem while booting other
PPC based systems, and b) if it would be worth adding a configuration
option that allows this early stack size to be specified, rather than
hard-coding it in relocate.S.

Regards,

Greg

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

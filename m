Message-ID: <3DD3C747.8B7EE5CD@opensource.se>
Date: Thu, 14 Nov 2002 16:54:47 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bi_record and initrd
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

The 2.4.19 kernel and the current rsync kernel from
source.mvista.com::linuxppc_2_4 does not work with large initrds.

The bi_record setup code in linux/arch/ppc/boot/simple/misc-embedded.c
doesn't care about the initrd size. So, if you are using a initrd that
crosses a megabyte-boundary you will have your initrd overwritten with
the bi_record. This results in crc error when unpacking the initrd.

The quick fix is to add a offset to the boot-code and to
arch/ppc/kernel/setup.c.

So, what's the long term solution?
Passing a pointer to the kernel?

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

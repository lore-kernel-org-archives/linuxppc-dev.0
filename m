Date: Mon, 7 Oct 2002 22:48:50 +0100 (BST)
From: Leigh Brown <leigh@solinno.co.uk>
To: trini@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Minor command line fix
Message-ID: <Pine.LNX.4.44.0210072246560.4630-100000@micro.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I think it's a bug, and I think this fixes it.

Cheers,

Leigh.

diff -urNX /home/leigh/.diffex linuxppc_2_4_devel-prev/arch/ppc/kernel/setup.c linuxppc_2_4_devel-local/arch/ppc/kernel/setup.c
--- linuxppc_2_4_devel-prev/arch/ppc/kernel/setup.c	Sun Sep  8 18:38:47 2002
+++ linuxppc_2_4_devel-local/arch/ppc/kernel/setup.c	Sun Sep  8 18:39:26 2002
@@ -471,7 +471,8 @@
 		ulong *data = rec->data;
 		switch (rec->tag) {
 		case BI_CMD_LINE:
-			memcpy(cmd_line, (void *)data, rec->size);
+			memcpy(cmd_line, (void *)data, rec->size -
+						      sizeof(struct bi_record));
 			break;
 		case BI_SYSMAP:
 			sysmap = (char *)((data[0] >= (KERNELBASE)) ? data[0] :


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

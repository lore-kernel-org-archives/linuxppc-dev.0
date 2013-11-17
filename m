Return-Path: <anton@samba.org>
Date: Sun, 17 Nov 2013 11:39:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/pseries: duplicate dtl entries sometimes sent to
 userspace
Message-ID: <20131117113905.32d0b8d1@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When reading from the dispatch trace log (dtl) userspace interface, I
sometimes see duplicate entries. One example:

# hexdump -C dtl.out

00000000  07 04 00 0c 00 00 48 44  00 00 00 00 00 00 00 00 
00000010  00 0c a0 b4 16 83 6d 68  00 00 00 00 00 00 00 00
00000020  00 00 00 00 10 00 13 50  80 00 00 00 00 00 d0 32

00000030  07 04 00 0c 00 00 48 44  00 00 00 00 00 00 00 00
00000040  00 0c a0 b4 16 83 6d 68  00 00 00 00 00 00 00 00
00000050  00 00 00 00 10 00 13 50  80 00 00 00 00 00 d0 32

The problem is in scan_dispatch_log() where we call dtl_consumer()
but bail out before incrementing the index.

To fix this I moved dtl_consumer() after the timebase comparison.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---

Index: b/arch/powerpc/kernel/time.c
===================================================================
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -213,8 +213,6 @@ static u64 scan_dispatch_log(u64 stop_tb
 	if (i == be64_to_cpu(vpa->dtl_idx))
 		return 0;
 	while (i < be64_to_cpu(vpa->dtl_idx)) {
-		if (dtl_consumer)
-			dtl_consumer(dtl, i);
 		dtb = be64_to_cpu(dtl->timebase);
 		tb_delta = be32_to_cpu(dtl->enqueue_to_dispatch_time) +
 			be32_to_cpu(dtl->ready_to_enqueue_time);
@@ -227,6 +225,8 @@ static u64 scan_dispatch_log(u64 stop_tb
 		}
 		if (dtb > stop_tb)
 			break;
+		if (dtl_consumer)
+			dtl_consumer(dtl, i);
 		stolen += tb_delta;
 		++i;
 		++dtl;

Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
MIME-Version: 1.0
Subject: [PATCH] dtc: fix endian issue when reading blobs
Date: Fri, 07 Jul 2006 15:53:10 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060707055313.E6FC067A2E@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The reserve mem regions are screwy if you read a blob on x86.  I'm
guessing there may be a few more of these lurking in the code. 

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
This now gives clean diffs between running on big and little endian machines.

 flattree.c |    2 ++
 1 file changed, 2 insertions(+)

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c
+++ dtc/flattree.c
@@ -619,6 +619,8 @@ static struct reserve_info *flat_read_me
 	p = inb->ptr;
 	while (1) {
 		flat_read_chunk(inb, &re, sizeof(re));
+		re.address  = cpu_to_be64(re.address);
+		re.size = cpu_to_be64(re.size);
 		if (re.size == 0)
 			break;
 

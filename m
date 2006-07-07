Return-Path: <mikey@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] dtc: fix endian issue when reading blobs 
In-reply-to: <20060707055313.E6FC067A2E@ozlabs.org> 
References: <20060707055313.E6FC067A2E@ozlabs.org>
Date: Fri, 07 Jul 2006 23:28:10 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060707132811.B1A4267B55@ozlabs.org>
Cc: Jon Loeliger <jdl@jdl.com>, miltonm@bga.com
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
Oops.. wrong way around.. thanks Milton.

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
+		re.address  = be64_to_cpu(re.address);
+		re.size = be64_to_cpu(re.size);
 		if (re.size == 0)
 			break;
 

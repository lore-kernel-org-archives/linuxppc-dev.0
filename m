Return-Path: <tmusta@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC4222C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 00:26:10 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tmusta@us.ibm.com>;
 Thu, 22 Aug 2013 08:26:05 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 887B519D803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:25:47 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7MEPo05129730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:25:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7MEPktm007856
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:25:46 -0600
Received: from d27mc101.rchland.ibm.com (d27mc101.rchland.ibm.com
 [9.10.229.51])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r7MEPj55007673
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:25:46 -0600
Subject: [PATCH] powerpc: Unaligned stores and stmw are broken in PowerISA
 emulation code
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OF355BAB01.27F99E7D-ON86257BCF.004EC768-86257BCF.004F3C8F@us.ibm.com>
From: Tom Musta <tmusta@us.ibm.com>
Date: Thu, 22 Aug 2013 09:25:28 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF15CDFDD41F88f9e8a93df938690918c09BBF15CDFDD41F8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF15CDFDD41F88f9e8a93df938690918c09BBF15CDFDD41F8
Content-type: text/plain; charset=US-ASCII


To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Unaligned stores and stmw are broken in PowerISA
emulation code
From: Tom Musta <tmusta@us.ibm.com>

The stmw instruction was incorrectly decoded as an update form instruction
and thus the RA
register was being clobbered.

Also, the utility routine to write memory to unaligned addresses breaks the
operation into
smaller aligned accesses but was incorrectly incrementing the address by
only one; it needs
to increment the address by the size of the smaller aligned chunk.

Signed-off-by: Tom Musta <tmusta@us.ibm.com>

---
arch/powerpc/lib/sstep.c |    9 ++++++---
1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9a52349..d220b88 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -100,8 +100,10 @@ static unsigned long __kprobes dform_ea(unsigned int
instr, struct pt_regs *regs
 	ea = (signed short) instr;		/* sign-extend */
 	if (ra) {
 		ea += regs->gpr[ra];
-		if (instr & 0x04000000)		/* update forms */
-			regs->gpr[ra] = ea;
+		if (instr & 0x04000000) {		/* update forms */
+			if ((instr>>26) != 47) 		/* stmw is not an update
form */
+				regs->gpr[ra] = ea;
+		}
 	}

 	return truncate_if_32bit(regs->msr, ea);
@@ -279,7 +281,7 @@ static int __kprobes write_mem_unaligned(unsigned long
val, unsigned long ea,
 		err = write_mem_aligned(val >> (nb - c) * 8, ea, c);
 		if (err)
 			return err;
-		++ea;
+		ea += c;
 	}
 	return 0;
 }

Tom Musta (tmusta@us.ibm.com)
Senior Software Engineer
Blue Gene Kernel Development
IBM Rochester
(507) 253-4119   (T/L 553-4119)
--0__=09BBF15CDFDD41F88f9e8a93df938690918c09BBF15CDFDD41F8
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font size="2" face="Courier New">To: linuxppc-dev@lists.ozlabs.org</font><br>
<font size="2" face="Courier New">Subject: [PATCH] powerpc: Unaligned stores and stmw are broken in PowerISA emulation code</font><br>
<font size="2" face="Courier New">From: Tom Musta &lt;tmusta@us.ibm.com&gt;</font><br>
<br>
<font size="2" face="Courier New">The stmw instruction was incorrectly decoded as an update form instruction and thus the RA</font><br>
<font size="2" face="Courier New">register was being clobbered.</font><br>
<br>
<font size="2" face="Courier New">Also, the utility routine to write memory to unaligned addresses breaks the operation into </font><br>
<font size="2" face="Courier New">smaller aligned accesses but was incorrectly incrementing the address by only one; it needs </font><br>
<font size="2" face="Courier New">to increment the address by the size of the smaller aligned chunk.</font><br>
<br>
<font size="2" face="Courier New">Signed-off-by: Tom Musta &lt;tmusta@us.ibm.com&gt;</font><br>
<br>
<font size="2" face="Courier New">---</font><br>
<font size="2" face="Courier New">arch/powerpc/lib/sstep.c | &nbsp; &nbsp;9 ++++++---</font><br>
<font size="2" face="Courier New">1 files changed, 6 insertions(+), 3 deletions(-)</font><br>
<br>
<font size="2" face="Courier New">diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c</font><br>
<font size="2" face="Courier New">index 9a52349..d220b88 100644</font><br>
<font size="2" face="Courier New">--- a/arch/powerpc/lib/sstep.c</font><br>
<font size="2" face="Courier New">+++ b/arch/powerpc/lib/sstep.c</font><br>
<font size="2" face="Courier New">@@ -100,8 +100,10 @@ static unsigned long __kprobes dform_ea(unsigned int instr, struct pt_regs *regs</font><br>
<font size="2" face="Courier New">&nbsp;	ea = (signed short) instr;		/* sign-extend */</font><br>
<font size="2" face="Courier New">&nbsp;	if (ra) {</font><br>
<font size="2" face="Courier New">&nbsp;		ea += regs-&gt;gpr[ra];</font><br>
<font size="2" face="Courier New">-		if (instr &amp; 0x04000000)		/* update forms */</font><br>
<font size="2" face="Courier New">-			regs-&gt;gpr[ra] = ea;</font><br>
<font size="2" face="Courier New">+		if (instr &amp; 0x04000000) {		/* update forms */</font><br>
<font size="2" face="Courier New">+			if ((instr&gt;&gt;26) != 47) 		/* stmw is not an update form */</font><br>
<font size="2" face="Courier New">+				regs-&gt;gpr[ra] = ea;</font><br>
<font size="2" face="Courier New">+		}</font><br>
<font size="2" face="Courier New">&nbsp;	}</font><br>
<font size="2" face="Courier New">&nbsp;</font><br>
<font size="2" face="Courier New">&nbsp;	return truncate_if_32bit(regs-&gt;msr, ea);</font><br>
<font size="2" face="Courier New">@@ -279,7 +281,7 @@ static int __kprobes write_mem_unaligned(unsigned long val, unsigned long ea,</font><br>
<font size="2" face="Courier New">&nbsp;		err = write_mem_aligned(val &gt;&gt; (nb - c) * 8, ea, c);</font><br>
<font size="2" face="Courier New">&nbsp;		if (err)</font><br>
<font size="2" face="Courier New">&nbsp;			return err;</font><br>
<font size="2" face="Courier New">-		++ea;</font><br>
<font size="2" face="Courier New">+		ea += c;</font><br>
<font size="2" face="Courier New">&nbsp;	}</font><br>
<font size="2" face="Courier New">&nbsp;	return 0;</font><br>
<font size="2" face="Courier New">&nbsp;}</font><br>
<br>
<font size="2" face="sans-serif">Tom Musta (tmusta@us.ibm.com)<br>
Senior Software Engineer<br>
Blue Gene Kernel Development<br>
IBM Rochester<br>
(507) 253-4119 &nbsp; (T/L 553-4119)<br>
</font></body></html>
--0__=09BBF15CDFDD41F88f9e8a93df938690918c09BBF15CDFDD41F8--

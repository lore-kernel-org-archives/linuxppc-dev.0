Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 389C968070
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 04:06:05 +1000 (EST)
Message-ID: <4304CE06.6080202@varma-el.com>
Date: Thu, 18 Aug 2005 22:05:58 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Content-Type: multipart/mixed; boundary="------------000208050109070704000401"
Cc: linuxppc-embedded@ozlabs.org
Subject: [RFC] MPC5200 BestComm microcode [en]/[de]coding draft
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000208050109070704000401
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello Sylvain,

This a draft of Documentation/powerpc/bestcomm.txt,
it was born since I couldn't find DRD/LCD description and
"... graphical task builder are currently in development"
(quotation from AN2604) :(, so I try write doco by myself.
Here result of my reverse engineering.

If you or somebody have more information or found some
bugs, please, fix/expand my text, especially places marked by "?".

-- 
Regards
Andrey Volkov

--------------000208050109070704000401
Content-Type: text/plain;
 name="bestcomm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bestcomm.diff"

Draft

---
commit 8a3ea9eb0933e43b8fad1f50ef566b6145202e25
tree 7d9356ec710b68c159c8ad95c49ea1c2439beb74
parent 825f973a6a6e12ff0c9d5bc10a74b4cae3687db5
author Andrey Volkov <avolkov@varma-el.com> Thu, 18 Aug 2005 21:58:24 +0400
committer Andrey Volkov <avolkov@varma-el.com> Thu, 18 Aug 2005 21:58:24 +0400

 Documentation/powerpc/bestcomm.txt |  143 ++++++++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/bestcomm.txt b/Documentation/powerpc/bestcomm.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/powerpc/bestcomm.txt
@@ -0,0 +1,143 @@
+             Microcode description of MPC5200 Bestcomm DMA
+=====================================================================
+
+Please mail me (Andrey Volkov, avolkov@varma-el.com) if you have 
+questions, comments or corrections.
+
+All instructions of Bestcomm microcode are divided on 
+two main types: LCD (Loop Control Descriptor) and 
+DRD (Data Routing Descriptor). Any Task must started from 
+LCD[EX] instruction and finished by DRD instruction (usually NOP).
+Each of instruction types, in one's turn, are divided on two 
+and three subtypes accordingly, which are described below:
+
+1) DRD1A - load/store data, and, optionally, made some operation 
+on it (depend on what loaded to FDT). Here is fields description
+of this DRD:
+
+Bits num.  Name          Desc.
+[31:29]    		Reserved, must be 0 
+[28:28]    MORE		?????, if set then idx/var
+			dst/src fields are changed. I.e. 
+			[16:10] contain SOURCE, 
+			and [09:03] contain DESTINATION.
+[27:27]	   TFD		Transfer Frame Done. Assert frame 
+			done Transfer Frame Done line of 
+			selected (in INIT field) periphery.
+[26:26]	   INT 		Interrupt. If set to 1, 
+			then generate core interrupt
+[25:21]	   INIT		Initiator (aka requestor) number.
+[20:19]	   RS		Read Size (0 - 32bit word, 1 - byte,
+			2 - 16 bit word, 3 - dynamic/reserved??
+			(masked in real	time?))
+[18:17]	   WS		Write Size (see above)
+[16:16]			??????????????
+[15:15]	   		Destination index prefix, 
+			if set (i.e. =1), then bitfield [13:10]
+			contain index number, and [14:14] have 
+			meaning of indirect addressing flag.
+			If this field cleared then field 
+			[14:10] contain	index of VARIABLE.
+[14:14]			Indirect addressing by idx, 
+			(and only by idx) flag, or high bit of
+			variable index.
+[13:10]			index of DESTINATION/SOURCE idx/var.
+
+[09:09]			???? For some cases 1, for another 0.????
+
+[08:08]			Same as in [14:10], but for source.
+[07:03]			Same as in [14:10], but for source.
+[02:00]	   EU3		Number of function, which will execute
+			on EU#3.
+Note: For DRD1A exist special case, aka NOP, which act as 
+task terminator. Fields, in this case, have next meanings:
+
+[31:28]			Reserved must be 0.
+[27:27]	  TFD		Transfer Frame Done. 
+[26:26]	  INT 		Interrupt.
+[25:21]	  INIT		Initiator (aka requestor) number. Usually 0,
+			or ALWAYS INITIATOR.
+[16:00]	  NOP code	Must be 0x1f8 
+
+Ex. Please, pay attention to first two lines: since MORE is set,
+codes for idx2 and var13 are in different fields, then for case
+where MORE is not set (var4 = var2).:
+ 0x10601010 -- DRD1A: var4 = var2; FN=0 MORE init=3 WS=0 RS=0
+ 0x00008868 -- DRD1A: idx2 = var13; FN=0 init=0 WS=0 RS=0
+ 0x0404c999 -- DRD1A: *idx2 = EU3(); FN=1 INT init=0 WS=2 RS=0
+ 0x000001f8 -- DRD1A: NOP
+ 0x040001f8 -- DRD1A: INT init=0
+
+Next two DRDs are ALWAYS coupled, i.e it is impossible to using 
+DRD2B1 without preceded DRD2A, but any (?fixme?) number DRD2B1 
+may followed by DRD2A.
+
+2) DRD2A - setup bestcomm Execution Unit (EU)
+Bitfields encodings:
+
+Bits num.  Name          Desc
+[31:31]    MORE		?????????
+[30:29]    EXT		must be always initialized 
+			by 3 (binary 11)
+[27:27]	   TFD		Transfer Frame Done.
+[26:21]	   INIT		Initiator number.
+[20:19]	   RS		Read Size 
+[18:17]	   WS		Write Size
+[16:04]			reserved, must be 0
+[03:00]	   EU3		Number of function, which will execute
+			on EU#3 at DRD2B1 time.
+Ex:
+ 0x60140002 -- DRD2A: EU3=2 EXT init=0 WS=2 RS=2
+
+3) DRD2B1 - execute function and store result of it. 
+
+Bits num.  Name          Desc
+[31:28]			Reserved must be 0.
+
+[27:22]	   DST		Result destination (var/idx/*idx).
+			See description of field [15:10] of DRD1A
+			section.
+[21:20]	   WS		?? Write Size for dst ??
+[19:18]	   EU#		Since MPC5200 have only EU#3, this filed 
+			always must contain 3
+[17:12]			???? (Reserved, must be 0x0f), 
+			may be encoded operands sizes????
+[11:06]	   OP1		operand 1 of EU#3
+			See description of field [15:10] in DRD1A
+			section.
+[05:00]	   OP2		operand 2 of EU#3
+			See description of field [15:10] in DRD1A
+			section, or, if for EU#3 function needed 
+			only one operand (like CRC), then this field
+			must contain 0x1f
+
+Ex:
+ 0x0d0cf247 -- DRD2B1: *idx4 = EU3(); EU3(var9,var7)
+ 0x0c8cfc5f -- DRD2B1: *idx2 = EU3(); EU3(*idx1)
+
+4) LCD - run followed loop microcode, or may be used for checking
+some conditions. LCD may be nested (only two levels are supported).
+
+Bits num.  Name          Desc
+[31:31]	   LOOP		Loop prefix, always 1
+[30:30]			???????????????????
+[29:23]	   INIT1	???Initializition part of first init expression.???
+[22:11]			???????????????????
+[10:06]	   CMP_VAR	Variable to which idx compared. Part of
+			Termination control.
+[05:03]	   INC1		increment1 
+[02:00]	   INC2		increment2, if unsused may be any value 
+
+5) LCDEXT - If in yours loop used more then 2 indexes, then 
+this record MUST PRECEDED LCD. Also loop end condition MAY pointed HERE,
+then it not pointed in LCD. 
+
+Bits num.  Name          Desc
+[31:31]	   LOOP		Loop prefix, always 1
+[30:30]			???????????????????
+[29:23]	   INIT1	???Initializition part of first init expression.???
+[22:11]			???????????????????
+[10:06]	   CMP_VAR	Variable to which idx compared. Part of
+			Termination control.
+[05:03]	   INC1		increment1 
+[02:00]	   INC2		increment2, if unsused may be any value 

--------------000208050109070704000401--

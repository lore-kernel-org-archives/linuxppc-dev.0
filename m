Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id E151D67D19
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 23:52:39 +1000 (EST)
Message-ID: <20050727135233.7367.qmail@web15803.mail.cnb.yahoo.com>
Date: Wed, 27 Jul 2005 21:52:33 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: custom ads8272 board PCI interrupt no response
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

A PCI interrupt probelm confused me when porting
2.6.13-rc3 on a custom 8248 board. There was a 
Gb ethernet RTL8110S on board with IDSEL AD25 and
IRQ3. So I made some changes as follows:

--- linux-2.6.13-rc3/arch/ppc/platforms/pq2ads.h
+++ linux-2.6.13-rc3-sam/arch/ppc/platforms/pq2ads.h
@@ -74,11 +78,11 @@
-#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ3

--- linux-2.6.13-rc3/arch/ppc/syslib/m82xx_pci.c
+++ linux-2.6.13-rc3-sam/arch/ppc/syslib/m82xx_pci.c
@@ -60,12 +60,20 @@
      * 	  A      B      C      D
      */
      {
+#if 0
    { PIRQA, PIRQB, PIRQC, PIRQD },/* IDSEL 22 - PCI 
slot 0 */
    { PIRQD, PIRQA, PIRQB, PIRQC }, /* IDSEL 23 - PCI 
slot 1 */
    { PIRQC, PIRQD, PIRQA, PIRQB }, /* IDSEL 24 - PCI 
slot 2 */
+#else  
+ {22, 22, 22, 22},/* IDSEL 22/IRQ4-PCI slot 0-USB */
+ {23, 23, 23, 23},/* IDSEL 23/IRQ5-PCI slot 1-IDE */
+ {24, 24, 0,   0},/* IDSEL 24 - PCI slot # - NULL */
+ {25, 25, 25, 25},/* IDSEL 25/IRQ3-PCI slot 2- Gb */
+
+#endif
    };
- const long min_idsel = 22, max_idsel = 24, 
irqs_per_slot = 4;
+ const long min_idsel = 22, max_idsel = 25, 
irqs_per_slot = 4;

Then got a interrupt map:
# cat /proc/interrupts
        CPU0
 21:     0   CPM2 SIU  Level    PQ2 PCI cascade
 25:     0   CPM2 SIU  Level    eth0
 40:    14   CPM2 SIU  Level    cpm_uart
 BAD:    2

Gb interrupt remained unchangable in the whole test
process. I could ping target itself but not for 
outside machine. So I suspect this result was due to
PCI interrupt setting but don't know where the probelm
is. Any idea?

Thanks in advance,

Sam


	

	
		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰
http://cn.mail.yahoo.com/?id=77071

Message-ID: <38B1183A.AC6214E0@cnet.francetelecom.fr>
Date: Mon, 21 Feb 2000 11:49:30 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
CC: Benjamin Herrenschmidt <bh40@calva.net>,
        "paulus@linuxcare.com" <paulus@linuxcare.com>
Subject: Patch for optimize context switch
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The aim of this patch is to optimize context switch on PPC.
It permit to optimize pipeline and reduce near 30 instructions per
context switch.
I'm using it on my computer and it work well, please test it !

The patch is taken from kernel 2.2.15pre7 and modify _switch
and set_context on arch/ppc/kernel/heas.S.
On kernel 2.3.X only set_context need ot be modified.

Jean-Philippe

--- head.S      Mon Feb 21 10:16:41 2000
+++ arch/ppc/kernel/head.S      Mon Feb 21 11:31:38 2000
@@ -2335,13 +2335,29 @@
        /* Set up segment registers for new task */
        rlwinm  r5,r5,4,8,27    /* VSID = context << 4 */
        addis   r5,r5,0x6000    /* Set Ks, Ku bits */
-       li      r0,12           /* TASK_SIZE / SEGMENT_SIZE */
-       mtctr   r0
-       li      r9,0
-3:     mtsrin  r5,r9
-       addi    r5,r5,1         /* next VSID */
-       addis   r9,r9,0x1000    /* address of next segment */
-       bdnz    3b
+       addi    r9,r5,1
+       mtsr    SR0,r5          /* update SR0 ..
SR[TASK_SIZE/SEGMENT_SIZE-1] */
+       addi    r5,r9,1
+       mtsr    SR1,r9
+       addi    r9,r5,1
+       mtsr    SR2,r5
+       addi    r5,r9,1
+       mtsr    SR3,r9
+       addi    r9,r5,1
+       mtsr    SR4,r5
+       addi    r5,r9,1
+       mtsr    SR5,r9
+       addi    r9,r5,1
+       mtsr    SR6,r5
+       addi    r5,r9,1
+       mtsr    SR7,r9
+       addi    r9,r5,1
+       mtsr    SR8,r5
+       addi    r5,r9,1
+       mtsr    SR9,r9
+       addi    r9,r5,1
+       mtsr    SR10,r5
+       mtsr    SR11,r9
 #else
 /* On the MPC8xx, we place the physical address of the new task
  * page directory loaded into the MMU base register, and set the
@@ -2500,13 +2516,29 @@
 _GLOBAL(set_context)
        rlwinm  r3,r3,4,8,27    /* VSID = context << 4 */
        addis   r3,r3,0x6000    /* Set Ks, Ku bits */
-       li      r0,12           /* TASK_SIZE / SEGMENT_SIZE */
-       mtctr   r0
-       li      r4,0
-3:     mtsrin  r3,r4
-       addi    r3,r3,1         /* next VSID */
-       addis   r4,r4,0x1000    /* address of next segment */
-       bdnz    3b
+       addi    r4,r3,1
+       mtsr    SR0,r3          /* update SR0 ..
SR[TASK_SIZE/SEGMENT_SIZE-1] */
+       addi    r3,r4,1
+       mtsr    SR1,r4
+       addi    r4,r3,1
+       mtsr    SR2,r3
+       addi    r3,r4,1
+       mtsr    SR3,r4
+       addi    r4,r3,1
+       mtsr    SR4,r3
+       addi    r3,r4,1
+       mtsr    SR5,r4
+       addi    r4,r3,1
+       mtsr    SR6,r3
+       addi    r3,r4,1
+       mtsr    SR7,r4
+       addi    r4,r3,1
+       mtsr    SR8,r3
+       addi    r3,r4,1
+       mtsr    SR9,r4
+       addi    r4,r3,1
+       mtsr    SR10,r3
+       mtsr    SR11,r4
        SYNC
        blr



--
--------------------------------------------------------------------------
Jean-Philippe FASSINO  Tel :  04 76 76 45 52
CNET : DTL/ASR         mailto:jeanphilippe.fassino@cnet.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

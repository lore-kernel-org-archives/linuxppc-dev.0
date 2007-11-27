Return-Path: <dell.query@yahoo.com>
Received: from n2a.bullet.mail.tp2.yahoo.com (n2a.bullet.mail.tp2.yahoo.com
	[203.188.202.96]) by ozlabs.org (Postfix) with SMTP id 98407DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 09:41:58 +1100 (EST)
Date: Tue, 27 Nov 2007 02:47:45 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1391738889-1196160465=:53699"
Message-ID: <409454.53699.qm@web45615.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1391738889-1196160465=:53699
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I am creating a simple program which will try to read the board ID of the PPC440EPx thru BCSR but when I load it, it gives me "Data Read PLB Error". 

I am not sure if I missed out something.

I would really appreciate it if somebody could help me on this.

I have posted the source code below, as well as the complete message.

Many thanks!

SOURCE CODE:
----------------------------------------------------------------------
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <asm/irq.h>
#include <asm/io.h>
#include <linux/i2c.h>
#include <linux/i2c-id.h>
#include <asm/ocp.h>
#include <asm/ibm4xx.h>

MODULE_LICENSE("GPL");

#define BCSR_BASE   0xC0002000
#define BCSR0       0
#define BCSR1       1
#define BCSR2       2

#define USER_LED    0x2
#define SIZE_TO_MAP 10

#define LED_ON      0

uint __iomem *bcsrbase = NULL;

static int __init initFunction(void) {
   uint tmp;
   printk("<1> Calling init function.\n");
   printk("<1> bcsrbase value %p...\n",bcsrbase);
   printk("<1> Remapping %x...\n",BCSR_BASE);
   /*map*/
   bcsrbase = ioremap(BCSR_BASE, SIZE_TO_MAP);
   printk("<1> bcsrbase new value %p...\n",bcsrbase);
   /*read value*/
   /*based on PPC440EPx document, BCSR0 is BoardID*/
   tmp = in_be32(bcsrbase + BCSR0 /* BCSR0 */);
   printk("<1> BCSR0 %x...\n",tmp);
   /*try to output something*/
   //out_be32(bcsrbase , /*LED_ON*/);
   return 0;
}
static void __exit cleanupFunction(void) {
   printk("<1> Calling cleanup function.\n");
   /*unmap*/
   iounmap(bcsrbase);
}

module_init(initFunction);
module_exit(cleanupFunction);
----------------------------------------------------------------------
ERROR MESSAGE:
----------------------------------------------------------------------
/mnt/flash_fs/var/ftp # insmod bcsr.ko
 Calling init function.
 bcsrbase value 00000000...
 Remapping c0002000...
 bcsrbase new value d50fe000...
Machine check in kernel mode.
Data Read PLB Error
OPB to PLB3: BSTAT= 0x00000000
PLB3 to PLB4: BEAR=0xffffffffffff7fff BESR0=0x00000000 BESR1=0x00000000
PLB4 to PLB3: BEAR=0xfd7fffffffffffff BESR0=0x00000000 BESR1=0x00000000
PLB3 to OPB: BEAR=0xffffffff BESR0=0x00000000 BESR1=0x00000000
PLB3 arbiter: BEAR=0xbfffffef ACR=0x90000000 BESR=0x00000000
PLB4 to OPB1: BEAR=0x0000000efffbfffb BESR0=0x00000000 BESR1=0x00000000
PLB40 Arbiter: BEAR=0x00000000c0002000 ACR=0xde000000 BESR0=0x0f000000
PLB41 Arbiter: BEAR=0xfffffffffffffffa ACR=0xdf000000 BESR0=0x00000000
POB0: BEAR=0xc27e3194ffffffff BESR0=0x00000000 BESR1=0x00000000
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
Oops: machine check, sig: 7 [#1]
NIP: D50FC07C LR: D50FC070 CTR: 00000000
REGS: c02bcf50 TRAP: 0202   Not tainted  (2.6.21-rc4)
MSR: 00029000 <EE,ME>  CR: 24004022  XER: 00000000
TASK = c05fe490[115] 'insmod' THREAD: cdc6c000
GPR00: D50FC070 CDC6DE80 C05FE490 00000023 0A00C100 00000001 00000000 00000031
GPR08: 00000000 D50FE000 000017E4 C0290000 04004022 1016F458 00000000 00000000
GPR16: 00000000 00000000 00000030 00000030 00000124 D51132BC 00000000 C0035E2C
GPR24: 00000022 D5108000 00000022 D50F7500 CF68A21C D50F0000 CF68A000 C0279CEC
NIP [D50FC07C] initFunction+0x7c/0x128 [bcsr]
LR [D50FC070] initFunction+0x70/0x128 [bcsr]
Call Trace:
[CDC6DE80] [D50FC070] initFunction+0x70/0x128 [bcsr] (unreliable)
[CDC6DEA0] [C003731C] sys_init_module+0xe4/0x1458
[CDC6DF40] [C0001AC4] ret_from_syscall+0x0/0x3c
Instruction dump:
60842000 38600000 48000065 7c601b78 3c60d50f 7c040378 386370e8 901d76a0
4800003d 813d76a0 7c0004ac 80890000 <0c040000> 4c00012c 3c60d50f 38637108
Bus error
----------------------------------------------------------------------

       
---------------------------------
Be a better pen pal. Text or chat with friends inside Yahoo! Mail. See how.
--0-1391738889-1196160465=:53699
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I am creating a simple program which will try to read the board ID of the PPC440EPx thru BCSR but when I load it, it gives me "Data Read PLB Error". <br><br>I am not sure if I missed out something.<br><br>I would really appreciate it if somebody could help me on this.<br><br>I have posted the source code below, as well as the complete message.<br><br>Many thanks!<br><br>SOURCE CODE:<br>----------------------------------------------------------------------<br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/kernel.h&gt;<br>#include &lt;linux/ioport.h&gt;<br>#include &lt;linux/delay.h&gt;<br>#include &lt;linux/init.h&gt;<br>#include &lt;linux/interrupt.h&gt;<br>#include &lt;linux/platform_device.h&gt;<br>#include &lt;asm/irq.h&gt;<br>#include &lt;asm/io.h&gt;<br>#include &lt;linux/i2c.h&gt;<br>#include &lt;linux/i2c-id.h&gt;<br>#include &lt;asm/ocp.h&gt;<br>#include &lt;asm/ibm4xx.h&gt;<br><br>MODULE_LICENSE("GPL");<br><br>#define BCSR_BASE&nbsp;&nbsp;
 0xC0002000<br>#define BCSR0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>#define BCSR1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>#define BCSR2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br><br>#define USER_LED&nbsp;&nbsp;&nbsp; 0x2<br>#define SIZE_TO_MAP 10<br><br>#define LED_ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br>uint __iomem *bcsrbase = NULL;<br><br>static int __init initFunction(void) {<br>&nbsp;&nbsp; uint tmp;<br>&nbsp;&nbsp; printk("&lt;1&gt; Calling init function.\n");<br>&nbsp;&nbsp; printk("&lt;1&gt; bcsrbase value %p...\n",bcsrbase);<br>&nbsp;&nbsp; printk("&lt;1&gt; Remapping %x...\n",BCSR_BASE);<br>&nbsp;&nbsp; /*map*/<br>&nbsp;&nbsp; bcsrbase = ioremap(BCSR_BASE, SIZE_TO_MAP);<br>&nbsp;&nbsp; printk("&lt;1&gt; bcsrbase new value %p...\n",bcsrbase);<br>&nbsp;&nbsp; /*read value*/<br>&nbsp;&nbsp; /*based on PPC440EPx document, BCSR0 is BoardID*/<br>&nbsp;&nbsp; tmp = in_be32(bcsrbase + BCSR0 /* BCSR0 */);<br>&nbsp;&nbsp; printk("&lt;1&gt; BCSR0
 %x...\n",tmp);<br>&nbsp;&nbsp; /*try to output something*/<br>&nbsp;&nbsp; //out_be32(bcsrbase , /*LED_ON*/);<br>&nbsp;&nbsp; return 0;<br>}<br>static void __exit cleanupFunction(void) {<br>&nbsp;&nbsp; printk("&lt;1&gt; Calling cleanup function.\n");<br>&nbsp;&nbsp; /*unmap*/<br>&nbsp;&nbsp; iounmap(bcsrbase);<br>}<br><br>module_init(initFunction);<br>module_exit(cleanupFunction);<br>----------------------------------------------------------------------<br>ERROR MESSAGE:<br>----------------------------------------------------------------------<br>/mnt/flash_fs/var/ftp # insmod bcsr.ko<br>&nbsp;Calling init function.<br>&nbsp;bcsrbase value 00000000...<br>&nbsp;Remapping c0002000...<br>&nbsp;bcsrbase new value d50fe000...<br>Machine check in kernel mode.<br>Data Read PLB Error<br>OPB to PLB3: BSTAT= 0x00000000<br>PLB3 to PLB4: BEAR=0xffffffffffff7fff BESR0=0x00000000 BESR1=0x00000000<br>PLB4 to PLB3: BEAR=0xfd7fffffffffffff BESR0=0x00000000 BESR1=0x00000000<br>PLB3 to OPB:
 BEAR=0xffffffff BESR0=0x00000000 BESR1=0x00000000<br>PLB3 arbiter: BEAR=0xbfffffef ACR=0x90000000 BESR=0x00000000<br>PLB4 to OPB1: BEAR=0x0000000efffbfffb BESR0=0x00000000 BESR1=0x00000000<br>PLB40 Arbiter: BEAR=0x00000000c0002000 ACR=0xde000000 BESR0=0x0f000000<br>PLB41 Arbiter: BEAR=0xfffffffffffffffa ACR=0xdf000000 BESR0=0x00000000<br>POB0: BEAR=0xc27e3194ffffffff BESR0=0x00000000 BESR1=0x00000000<br>OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000<br>Oops: machine check, sig: 7 [#1]<br>NIP: D50FC07C LR: D50FC070 CTR: 00000000<br>REGS: c02bcf50 TRAP: 0202&nbsp;&nbsp; Not tainted&nbsp; (2.6.21-rc4)<br>MSR: 00029000 &lt;EE,ME&gt;&nbsp; CR: 24004022&nbsp; XER: 00000000<br>TASK = c05fe490[115] 'insmod' THREAD: cdc6c000<br>GPR00: D50FC070 CDC6DE80 C05FE490 00000023 0A00C100 00000001 00000000 00000031<br>GPR08: 00000000 D50FE000 000017E4 C0290000 04004022 1016F458 00000000 00000000<br>GPR16: 00000000 00000000 00000030 00000030 00000124 D51132BC 00000000 C0035E2C<br>GPR24:
 00000022 D5108000 00000022 D50F7500 CF68A21C D50F0000 CF68A000 C0279CEC<br>NIP [D50FC07C] initFunction+0x7c/0x128 [bcsr]<br>LR [D50FC070] initFunction+0x70/0x128 [bcsr]<br>Call Trace:<br>[CDC6DE80] [D50FC070] initFunction+0x70/0x128 [bcsr] (unreliable)<br>[CDC6DEA0] [C003731C] sys_init_module+0xe4/0x1458<br>[CDC6DF40] [C0001AC4] ret_from_syscall+0x0/0x3c<br>Instruction dump:<br>60842000 38600000 48000065 7c601b78 3c60d50f 7c040378 386370e8 901d76a0<br>4800003d 813d76a0 7c0004ac 80890000 &lt;0c040000&gt; 4c00012c 3c60d50f 38637108<br>Bus error<br>----------------------------------------------------------------------<br><p>&#32;
      <hr size=1>Be a better pen pal. 
Text or chat with friends inside Yahoo! Mail. <a href="http://us.rd.yahoo.com/evt=51732/*http://overview.mail.yahoo.com/">See how.</a>
--0-1391738889-1196160465=:53699--

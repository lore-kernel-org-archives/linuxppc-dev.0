Return-Path: <hangtoo@163.com>
Received: from m5-85.163.com (m5-85.163.com [202.108.5.85])
	by ozlabs.org (Postfix) with SMTP id 57845DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 17:48:31 +1000 (EST)
Date: Mon, 16 Apr 2007 15:33:47 +0800
From: "tony" <hangtoo@163.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: it8212F pci card problem in ppc405ep bubinga board
Message-ID: <200704161533464688533@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon412412788126_====="
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

--=====003_Dragon412412788126_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Dear all
        This days I came to a problem like this:
        Environment:linux kernel 2.6.20, PPC 405EP bubinga demo board.
        We have tested two PCI2IDE cards in this board,A)silicon Image's (cpu:cmd649);B)IT8212F's.The A card with a harddisk,which is well recognised by the demo board;but the same harddisk in B card, can't be recognised by the board,only recognised the PCI card.We trace the kernel,found something different in this funtion in the file linux-2.6.20/drivers/ide/ide-iops.c:
++++++++++++++++++++++++++++++++++++++++++
int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
{
 u8 stat = 0;
 u8 i = 0;
 while(timeout--) {
  /*
   * Turn this into a schedule() sleep once I'm sure
   * about locking issues (2.5 work ?).
   * hwif->io_ports[IDE_STATUS_OFFSET] = 0xFFEF
   */
  mdelay(1);
  
  stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
  printk(KERN_INFO "hwif->io_ports[IDE_STATUS_OFFSET] ==> %4x, 222222STAT ==> %4x\n",hwif->io_ports[IDE_STATUS_OFFSET],stat);
  if ((stat & BUSY_STAT) == 0){
   printk(KERN_INFO "BUSYING................\n");
   return 0;
  }
  /*
   * Assume a value of 0xff means nothing is connected to
   * the interface and it doesn't implement the pull-down
   * resistor on D7.n        isa_io_base = e7fee000
   */
  if (stat == 0xff){
   printk(KERN_INFO "NODEV................  \n");
   return -ENODEV;
  }
  touch_softlockup_watchdog();
  touch_nmi_watchdog();
 }
 return -EBUSY;
}
+++++++++++++++++++++++++++++++++++++++++++++++++++
stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
  printk(KERN_INFO "hwif->io_ports[IDE_STATUS_OFFSET] ==> %4x, 222222STAT ==> %4x\n",hwif->io_ports[IDE_STATUS_OFFSET],stat);
By printing this two parameters, we found that the former parameter is the same in two cards,but the value of "stat" varies between the two 
cards.A card,stat equals to 0x50;B card,stat equals to 0xFF,and it keeps the same,won't change.
        I'm puzzled about this.Is it about the driver of IT821x.c in the kernel?or something else?
        Any advise is welcomed.Thank you.




Sincerely
Tony

               

--=====003_Dragon412412788126_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3059" name=GENERATOR></HEAD>
<BODY>
<DIV>Dear <SPAN id=_FoxTONAME>all</SPAN></DIV>
<DIV><SPAN>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; This days I came to a problem 
like this:</SPAN></DIV>
<DIV><SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Environment:linux kernel 
2.6.20, PPC 405EP bubinga demo board.</SPAN></DIV>
<DIV><SPAN>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; We have tested two PCI2IDE 
cards in this board,A)silicon Image's (cpu:cmd649);B)IT8212F's.The A card with a 
harddisk,which is well recognised by the demo </SPAN><SPAN>board;but the same 
harddisk in B card, can't be recognised by the board,only recognised the PCI 
card.We trace the kernel,found something different </SPAN><SPAN>in this funtion 
in the file linux-2.6.20/drivers/ide/ide-iops.c:</SPAN></DIV>
<DIV><SPAN>++++++++++++++++++++++++++++++++++++++++++</SPAN></DIV>
<DIV><SPAN>int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long 
timeout)<BR>{<BR>&nbsp;u8 stat = 0;<BR>&nbsp;u8 i = 0;<BR>&nbsp;while(timeout--) 
{<BR>&nbsp;&nbsp;/*<BR>&nbsp;&nbsp; * Turn this into a schedule() sleep once I'm 
sure<BR>&nbsp;&nbsp; * about locking issues (2.5 work ?).<BR>&nbsp;&nbsp; * 
hwif-&gt;io_ports[IDE_STATUS_OFFSET] = 0xFFEF<BR>&nbsp;&nbsp; 
*/<BR>&nbsp;&nbsp;mdelay(1);<BR>&nbsp;&nbsp;<BR>&nbsp;&nbsp;stat = 
hwif-&gt;INB(hwif-&gt;io_ports[IDE_STATUS_OFFSET]);<BR>&nbsp;&nbsp;printk(KERN_INFO 
"hwif-&gt;io_ports[IDE_STATUS_OFFSET] ==&gt; %4x, 222222STAT ==&gt; 
%4x\n",hwif-&gt;io_ports[IDE_STATUS_OFFSET],stat);<BR>&nbsp;&nbsp;if ((stat 
&amp; BUSY_STAT) == 0){<BR>&nbsp;&nbsp;&nbsp;printk(KERN_INFO 
"BUSYING................\n");<BR>&nbsp;&nbsp;&nbsp;return 
0;<BR>&nbsp;&nbsp;}<BR>&nbsp;&nbsp;/*<BR>&nbsp;&nbsp; * Assume a value of 0xff 
means nothing is connected to<BR>&nbsp;&nbsp; * the interface and it doesn't 
implement the pull-down<BR>&nbsp;&nbsp; * resistor on 
D7.n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isa_io_base = 
e7fee000<BR>&nbsp;&nbsp; */<BR>&nbsp;&nbsp;if (stat == 
0xff){<BR>&nbsp;&nbsp;&nbsp;printk(KERN_INFO "NODEV................&nbsp; 
\n");<BR>&nbsp;&nbsp;&nbsp;return 
-ENODEV;<BR>&nbsp;&nbsp;}<BR>&nbsp;&nbsp;touch_softlockup_watchdog();<BR>&nbsp;&nbsp;touch_nmi_watchdog();<BR>&nbsp;}<BR>&nbsp;return 
-EBUSY;<BR>}</SPAN></DIV>
<DIV><SPAN>+++++++++++++++++++++++++++++++++++++++++++++++++++</SPAN></DIV>
<DIV>stat = 
hwif-&gt;INB(hwif-&gt;io_ports[IDE_STATUS_OFFSET]);<BR>&nbsp;&nbsp;printk(KERN_INFO 
"hwif-&gt;io_ports[IDE_STATUS_OFFSET] ==&gt; %4x, 222222STAT ==&gt; 
%4x\n",hwif-&gt;io_ports[IDE_STATUS_OFFSET],stat);</DIV>
<DIV>By printing this two parameters, we found that the former parameter is the 
same in two cards,but the value of "stat" varies between the two </DIV>
<DIV>cards.A card,stat equals to 0x50;B card,stat equals to 0xFF,and it keeps 
the same,won't change.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; I'm puzzled about this.Is it about 
the driver of IT821x.c in the kernel?or something else?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Any advise is welcomed.Thank 
you.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Sincerely</DIV>
<DIV>Tony</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV></BODY></HTML>

--=====003_Dragon412412788126_=====--

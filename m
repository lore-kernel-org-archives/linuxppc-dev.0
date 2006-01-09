Return-Path: <lcsquare2@yahoo.com.hk>
Received: from web53713.mail.yahoo.com (web53713.mail.yahoo.com
	[206.190.39.62]) by ozlabs.org (Postfix) with SMTP id 3D88068949
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 03:56:22 +1100 (EST)
Message-ID: <20060109164942.62300.qmail@web53713.mail.yahoo.com>
Date: Tue, 10 Jan 2006 00:49:42 +0800 (CST)
From: Lo Chun Chung <lcsquare2@yahoo.com.hk>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-529339483-1136825382=:60647"
Subject: Enable a PCMCIA Bluetooth card in custom MPC860 system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-529339483-1136825382=:60647
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Dear all,
   
  I am a student from Hong Kong. Now I am doing a project about enabling a Bluetooth PCMCIA card (Billionton PCBTC1A-B) in a custom MPC860PC.
   
  (The custom MPC860 system is constructed by a MPC860 Processor Card and a custom made PCB to adding a PCMCIA interface to the processor Card.)
   
  Now my stage is: the LINUX (Linux Kernel 2.4.25 from ELDK 3.1 for powerpc) can recognise the card by cardctl, and here are the screen dump:
   
  / # cardctl ident
Socket 0:
  product info: "PCMCIA", "Bluetooth Card", "", ""
  manfid: 0x0279, 0x950b
  function: 2 (serial)
/ # cardctl status
Socket 0:
  5V 16-bit PC Card
  function 0: [ready], [bat dead], [bat low]
/ # cardctl info
PRODID_1="PCMCIA"
PRODID_2="Bluetooth Card"
PRODID_3=""
PRODID_4=""
MANFID=0279,950b
FUNCID=2
/ # cardctl config
Socket 0:
  Vcc 5.0V  Vpp1 5.0V  Vpp2 5.0V
   
  but after I load all the modules needed (should be these?)
   
  / # lsmod
Module                  Size  Used by    Not tainted
hci_uart               14836   0 (unused)
l2cap                  22956   0 (unused)
bluez                  43856   0 [hci_uart l2cap]
ds                      8060   0
m8xx_pcmcia             5164   1
pcmcia_core            39520   0 [ds m8xx_pcmcia]
   
  my bluetooth still cannot get working ... 
   
  then I try to insert "serial_cs" as my bluetooth card is a uart base card. but some message given out:
   
  / # insmod serial_cs
Using /lib/modules/2.4.25/serial_cs.o
insmod: unresolved symbol unregister_serial
insmod: unresolved symbol register_serial
   
  so I realize that I should also insert "serial.o" into the linux, but crashes ...
   
  / # insmod serial
Using /lib/modules/2.4.25/serial.o
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ enabled
Machine check in kernel mode.
Caused by (from SRR1=1032): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C3040078 XER: 00000000 LR: C3044724 SP: C1CC1D60 REGS: c1cc1cb0 TRAP: 0200    No
t tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1cc0000[33] 'busybox' Last syscall: 128
last math 00000000 last altivec 00000000
GPR00: 00000000 C1CC1D60 C1CC0000 C1CC1D70 00000004 00000001 00000B4B C015378B
GPR08: 00000000 800003FC 00000003 C1CC1C70 C0170000 10084438 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 1016EDB0 C1D3A000 C1CC1EA0
GPR24: C1F6B760 00000006 C304973C C1CC1D70 C3040000 00000000 00000000 C3046348
Call backtrace:
C3044718 C3045188 C0012440 C00043BC 10080000 10021DF0 100238CC
1000457C 100041A0 1000436C 1000457C 100041A0 0FE70EF4 00000000
   
  I only knows when i insert the serial.o, this driver will try to access the standard uart which is not available in my system (my system only has one uart by SMC1), then the system will crash each time the driver wants to access the registers does not available ... 
   
  The project deadline is near ... so I ask here ... 
   
  can anyone helps me or give me some clues? 
   
  Thanks all
   
   


Best regards,
Chung
_______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-529339483-1136825382=:60647
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Dear all,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am a student from Hong Kong. Now I am doing a project about enabling a Bluetooth PCMCIA card (Billionton PCBTC1A-B) in a custom MPC860PC.</DIV>  <DIV>&nbsp;</DIV>  <DIV>(The custom MPC860 system is constructed by a MPC860 Processor Card and a custom made PCB to adding a PCMCIA interface to the processor Card.)</DIV>  <DIV>&nbsp;</DIV>  <DIV>Now my stage is: the LINUX (Linux Kernel 2.4.25 from ELDK 3.1 for powerpc) can recognise the card by cardctl, and here are the screen dump:</DIV>  <DIV>&nbsp;</DIV>  <DIV>/ # cardctl ident<BR>Socket 0:<BR>&nbsp; product info: "PCMCIA", "Bluetooth Card", "", ""<BR>&nbsp; manfid: 0x0279, 0x950b<BR>&nbsp; function: 2 (serial)<BR>/ # cardctl status<BR>Socket 0:<BR>&nbsp; 5V 16-bit PC Card<BR>&nbsp; function 0: [ready], [bat dead], [bat low]<BR>/ # cardctl info<BR>PRODID_1="PCMCIA"<BR>PRODID_2="Bluetooth Card"<BR>PRODID_3=""<BR>PRODID_4=""<BR>MANFID=0279,950b<BR>FUNCID=2<BR>/ # cardctl
 config<BR>Socket 0:<BR>&nbsp; Vcc 5.0V&nbsp; Vpp1 5.0V&nbsp; Vpp2 5.0V</DIV>  <DIV>&nbsp;</DIV>  <DIV>but after I load all the modules needed (should be these?)</DIV>  <DIV>&nbsp;</DIV>  <DIV>/ # lsmod<BR>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by&nbsp;&nbsp;&nbsp; Not tainted<BR>hci_uart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14836&nbsp;&nbsp; 0 (unused)<BR>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22956&nbsp;&nbsp; 0 (unused)<BR>bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43856&nbsp;&nbsp; 0 [hci_uart l2cap]<BR>ds&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8060&nbsp;&nbsp;
 0<BR>m8xx_pcmcia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5164&nbsp;&nbsp; 1<BR>pcmcia_core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39520&nbsp;&nbsp; 0 [ds m8xx_pcmcia]</DIV>  <DIV>&nbsp;</DIV>  <DIV>my bluetooth still cannot get working ... </DIV>  <DIV>&nbsp;</DIV>  <DIV>then I try to insert "serial_cs" as my bluetooth card is a uart base card. but some message given out:</DIV>  <DIV>&nbsp;</DIV>  <DIV>/ # insmod serial_cs<BR>Using /lib/modules/2.4.25/serial_cs.o<BR>insmod: unresolved symbol unregister_serial<BR>insmod: unresolved symbol register_serial</DIV>  <DIV>&nbsp;</DIV>  <DIV>so I realize that I should also insert "serial.o" into the linux, but crashes ...</DIV>  <DIV>&nbsp;</DIV>  <DIV>/ # insmod serial<BR>Using /lib/modules/2.4.25/serial.o<BR>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ enabled<BR>Machine check in kernel mode.<BR>Caused by (from SRR1=1032): Transfer error ack signal<BR>Oops:
 machine check, sig: 7<BR>NIP: C3040078 XER: 00000000 LR: C3044724 SP: C1CC1D60 REGS: c1cc1cb0 TRAP: 0200&nbsp;&nbsp;&nbsp; No<BR>t tainted<BR>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<BR>TASK = c1cc0000[33] 'busybox' Last syscall: 128<BR>last math 00000000 last altivec 00000000<BR>GPR00: 00000000 C1CC1D60 C1CC0000 C1CC1D70 00000004 00000001 00000B4B C015378B<BR>GPR08: 00000000 800003FC 00000003 C1CC1C70 C0170000 10084438 00000000 00000000<BR>GPR16: 00000000 00000000 00000000 00000000 00009032 1016EDB0 C1D3A000 C1CC1EA0<BR>GPR24: C1F6B760 00000006 C304973C C1CC1D70 C3040000 00000000 00000000 C3046348<BR>Call backtrace:<BR>C3044718 C3045188 C0012440 C00043BC 10080000 10021DF0 100238CC<BR>1000457C 100041A0 1000436C 1000457C 100041A0 0FE70EF4 00000000</DIV>  <DIV>&nbsp;</DIV>  <DIV>I only knows when i insert the serial.o, this driver will try to access the standard uart which is not available in my system (my system only has one uart by SMC1), then the system will crash each
 time&nbsp;the driver&nbsp;wants to access the registers does not available ... </DIV>  <DIV>&nbsp;</DIV>  <DIV>The project deadline is near ... so I ask here ... </DIV>  <DIV>&nbsp;</DIV>  <DIV>can anyone helps me or give me some clues? </DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks all</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV><BR><BR>Best regards,<br>Chung<p>_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-529339483-1136825382=:60647--

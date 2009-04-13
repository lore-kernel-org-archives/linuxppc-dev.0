Return-Path: <sunwx2001@hotmail.com>
Received: from bay0-omc1-s11.bay0.hotmail.com (bay0-omc1-s11.bay0.hotmail.com
	[65.54.246.83]) by ozlabs.org (Postfix) with ESMTP id 3E421DDFAB
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2009 22:10:59 +1000 (EST)
Message-ID: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_5649d2b7-8944-41ed-ad9e-a2ab744953e4_"
From: SunNeo <sunwx2001@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Help!Some memory doesn't work on PPC405Ex based board!
Date: Mon, 13 Apr 2009 12:05:53 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_5649d2b7-8944-41ed-ad9e-a2ab744953e4_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi, All,
I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC "Kilauea" evb.

 

In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot Linux-2.6.29, the kernel hangs somewhere. What interesting is, if I configured the system to use only 512MB memory at U-Boot, the Linux can boot normally.

 

The following is some error info I dumped:

 

<6>Using Kilauea machine description
<5>Linux version 2.6.29.1 (root@localhost.localdomain) (gcc version 4.2.2) #4 Mon Apr 13 19:26:57 CST 2009
<4>Found initrd at 0xeedaa000:0xeffff8f3
<7>Found legacy serial port 0 for /plb/opb/serial@ef600200
<7>  mem=ef600200, taddr=ef600200, irq=0, clk=7407407, speed=0
<7>Found legacy serial port 1 for /plb/opb/serial@ef600300
<7>  mem=ef600300, taddr=ef600300, irq=0, clk=7407407, speed=0
<7>Top of RAM: 0x40000000, Total RAM: 0x40000000
<7>Memory hole size: 0MB
<4>Zone PFN ranges:
<4>  DMA      0x00000000 -> 0x00030000
<4>  Normal   0x00030000 -> 0x00030000
<4>  HighMem  0x00030000 -> 0x00040000
<4>Movable zone start PFN for each node
<4>early_node_map[1] active PFN ranges
<4>    0: 0x00000000 -> 0x00040000
<7>On node 0 totalpages: 262144
<7>free_area_init_node: node 0, pgdat c03304a0, node_mem_map c07fd000
<7>  DMA zone: 1536 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 195072 pages, LIFO batch:31
<7>  HighMem zone: 512 pages used for memmap
<7>  HighMem zone: 65024 pages, LIFO batch:15
<6>MMU: Allocated 1088 bytes of context maps for 255 contexts
<4>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
<5>Kernel command line: ramdisk_size=65536 root=/dev/ram rw ip=10.204.29.214:10.204.29.153:10.204.28.1:255.255.252.0:obs600:eth0:off panic=1 console=ttyS0,115200
<4>UIC0 (32 IRQ sources) at DCR 0xc0
<4>UIC1 (32 IRQ sources) at DCR 0xd0
<4>UIC2 (32 IRQ sources) at DCR 0xe0
<4>PID hash table entries: 4096 (order: 12, 16384 bytes)
<7>time_init: decrementer frequency = 400.000000 MHz
<7>time_init: processor frequency   = 400.000000 MHz
<6>clocksource: timebase mult[a00000] shift[22] registered
<7>clockevent: decrementer mult[6666] shift[16] cpu[0]
<6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<6>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>High memory: 262144k
<6>Memory: 1016784k/1048576k available (3136k kernel code, 31244k reserved, 136k data, 140k bss, 144k init)
<6>SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
<6>Calibrating delay loop... 798.72 BogoMIPS (lpj=1597440)
<4>Mount-cache hash table entries: 512
<4>Instruction machine check in kernel mode.
<4>Oops: Machine check, sig: 7 [#1]
<4>Kilauea
<4>Modules linked in:
<4>NIP: c000c63c LR: c000eb44 CTR: ee82a000
<4>REGS: eeda7f50 TRAP: 0202   Not tainted  (2.6.29.1)
<4>MSR: 00021030 <ME,CE,IR,DR>  CR: 90029030  XER: c0000060
<4>TASK = ee82a3e0[2] 'kthreadd' THREAD: ee82e000
<6>GPR00: 3ffa80dc 3ffae128 ee82a3e0 3ffae138 88000000 00000000 00000000 c023d0ac 
<6>GPR08: c0342e54 c000eb44 00021032 c000c63c c035d000 00000000 3ffb2f00 00000000 
<6>GPR16: 3ffa80dc 3ffae1e8 00000000 00000000 00000000 00000000 00000000 00000000 
<6>GPR24: c03153d0 ee82ffb8 c00350f4 c031544c c0315458 ee82df08 c00350f4 ee82dee4 
<4>NIP [c000c63c] program_check_exception+0x0/0x59c
<4>LR [c000eb44] ret_from_except_full+0x0/0x4c
<4>Call Trace:
<4>Instruction dump:
<4>3920000b 409eff88 4bffff90 813f0080 7fe3fb78 39290004 913f0080 80010014 
<4>83e1000c 7c0803a6 38210010 4bffff14 <9421ffe0> 7c0802a6 7d800026 bfc10018 
<4>---[ end trace 31fd0ba7d8756001 ]---
<4>Oops: Exception in kernel mode, sig: 4 [#2]
<4>Kilauea
<4>Modules linked in:
<4>NIP: ee82ff80 LR: ee82ffb0 CTR: ee82a000
<4>REGS: ee835f50 TRAP: c03153d0   Tainted: G      D     (2.6.29.1)
<4>MSR: c0312318 <FP,DE,DR>  CR: 00029030  XER: c02368e0
<4>TASK = ee82a7c0[3] 'kthreadd' THREAD: ee834000
<6>GPR00: 3ffa80dc ee836000 ee82a7c0 00000000 ee82ffb0 00029030 00000000 ee82ff80 
<6>GPR08: c0312318 00000000 00000000 c0312318 c033b260 00000000 3ffb2f00 00000000 
<6>GPR16: 3ffa80dc 3ffae1e8 00000000 00000000 00000000 00000000 00000000 00000000 
<6>GPR24: c03153d0 ee82ffb8 c00350f4 c031544c c0315458 ee82df08 c00350f4 ee82dee4 
<4>NIP [ee82ff80] 0xee82ff80
<4>LR [ee82ffb0] 0xee82ffb0
<4>Call Trace:
<4>Instruction dump:
<4>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
<4>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
<4>---[ end trace 31fd0ba7d8756002 ]---

 

Please help,

 

Best Regards,

Sun

 

_________________________________________________________________
Messenger安全保护中心，免费修复系统漏洞，保护Messenger安全！
http://im.live.cn/safe/
--_5649d2b7-8944-41ed-ad9e-a2ab744953e4_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Hi, All,<BR>I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC "Kilauea" evb.<BR>
&nbsp;<BR>
In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot Linux-2.6.29, the kernel hangs somewhere. What interesting is, if I configured the system to use only 512MB memory at U-Boot, the Linux can boot normally.<BR>
&nbsp;<BR>
The following is some error info I dumped:<BR>
&nbsp;<BR>
&lt;6&gt;Using Kilauea machine description<BR>&lt;5&gt;Linux version 2.6.29.1 (<A href="mailto:root@localhost.localdomain">root@localhost.localdomain</A>) (gcc version 4.2.2) #4 Mon Apr 13 19:26:57 CST 2009<BR>&lt;4&gt;Found initrd at 0xeedaa000:0xeffff8f3<BR>&lt;7&gt;Found legacy serial port 0 for <A>/plb/opb/serial@ef600200</A><BR>&lt;7&gt;&nbsp; mem=ef600200, taddr=ef600200, irq=0, clk=7407407, speed=0<BR>&lt;7&gt;Found legacy serial port 1 for <A>/plb/opb/serial@ef600300</A><BR>&lt;7&gt;&nbsp; mem=ef600300, taddr=ef600300, irq=0, clk=7407407, speed=0<BR>&lt;7&gt;Top of RAM: 0x40000000, Total RAM: 0x40000000<BR>&lt;7&gt;Memory hole size: 0MB<BR>&lt;4&gt;Zone PFN ranges:<BR>&lt;4&gt;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; 0x00030000<BR>&lt;4&gt;&nbsp; Normal&nbsp;&nbsp; 0x00030000 -&gt; 0x00030000<BR>&lt;4&gt;&nbsp; HighMem&nbsp; 0x00030000 -&gt; 0x00040000<BR>&lt;4&gt;Movable zone start PFN for each node<BR>&lt;4&gt;early_node_map[1] active PFN ranges<BR>&lt;4&gt;&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; 0x00040000<BR>&lt;7&gt;On node 0 totalpages: 262144<BR>&lt;7&gt;free_area_init_node: node 0, pgdat c03304a0, node_mem_map c07fd000<BR>&lt;7&gt;&nbsp; DMA zone: 1536 pages used for memmap<BR>&lt;7&gt;&nbsp; DMA zone: 0 pages reserved<BR>&lt;7&gt;&nbsp; DMA zone: 195072 pages, LIFO batch:31<BR>&lt;7&gt;&nbsp; HighMem zone: 512 pages used for memmap<BR>&lt;7&gt;&nbsp; HighMem zone: 65024 pages, LIFO batch:15<BR>&lt;6&gt;MMU: Allocated 1088 bytes of context maps for 255 contexts<BR>&lt;4&gt;Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 260096<BR>&lt;5&gt;Kernel command line: ramdisk_size=65536 root=/dev/ram rw ip=10.204.29.214:10.204.29.153:10.204.28.1:255.255.252.0:obs600:eth0:off panic=1 console=ttyS0,115200<BR>&lt;4&gt;UIC0 (32 IRQ sources) at DCR 0xc0<BR>&lt;4&gt;UIC1 (32 IRQ sources) at DCR 0xd0<BR>&lt;4&gt;UIC2 (32 IRQ sources) at DCR 0xe0<BR>&lt;4&gt;PID hash table entries: 4096 (order: 12, 16384 bytes)<BR>&lt;7&gt;time_init: decrementer frequency = 400.000000 MHz<BR>&lt;7&gt;time_init: processor frequency&nbsp;&nbsp; = 400.000000 MHz<BR>&lt;6&gt;clocksource: timebase mult[a00000] shift[22] registered<BR>&lt;7&gt;clockevent: decrementer mult[6666] shift[16] cpu[0]<BR>&lt;6&gt;Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)<BR>&lt;6&gt;Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)<BR>&lt;7&gt;High memory: 262144k<BR>&lt;6&gt;Memory: 1016784k/1048576k available (3136k kernel code, 31244k reserved, 136k data, 140k bss, 144k init)<BR>&lt;6&gt;SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1<BR>&lt;6&gt;Calibrating delay loop... 798.72 BogoMIPS (lpj=1597440)<BR>&lt;4&gt;Mount-cache hash table entries: 512<BR>&lt;4&gt;Instruction machine check in kernel mode.<BR>&lt;4&gt;Oops: Machine check, sig: 7 [#1]<BR>&lt;4&gt;Kilauea<BR>&lt;4&gt;Modules linked in:<BR>&lt;4&gt;NIP: c000c63c LR: c000eb44 CTR: ee82a000<BR>&lt;4&gt;REGS: eeda7f50 TRAP: 0202&nbsp;&nbsp; Not tainted&nbsp; (2.6.29.1)<BR>&lt;4&gt;MSR: 00021030 &lt;ME,CE,IR,DR&gt;&nbsp; CR: 90029030&nbsp; XER: c0000060<BR>&lt;4&gt;TASK = ee82a3e0[2] 'kthreadd' THREAD: ee82e000<BR>&lt;6&gt;GPR00: 3ffa80dc 3ffae128 ee82a3e0 3ffae138 88000000 00000000 00000000 c023d0ac <BR>&lt;6&gt;GPR08: c0342e54 c000eb44 00021032 c000c63c c035d000 00000000 3ffb2f00 00000000 <BR>&lt;6&gt;GPR16: 3ffa80dc 3ffae1e8 00000000 00000000 00000000 00000000 00000000 00000000 <BR>&lt;6&gt;GPR24: c03153d0 ee82ffb8 c00350f4 c031544c c0315458 ee82df08 c00350f4 ee82dee4 <BR>&lt;4&gt;NIP [c000c63c] program_check_exception+0x0/0x59c<BR>&lt;4&gt;LR [c000eb44] ret_from_except_full+0x0/0x4c<BR>&lt;4&gt;Call Trace:<BR>&lt;4&gt;Instruction dump:<BR>&lt;4&gt;3920000b 409eff88 4bffff90 813f0080 7fe3fb78 39290004 913f0080 80010014 <BR>&lt;4&gt;83e1000c 7c0803a6 38210010 4bffff14 &lt;9421ffe0&gt; 7c0802a6 7d800026 bfc10018 <BR>&lt;4&gt;---[ end trace 31fd0ba7d8756001 ]---<BR>&lt;4&gt;Oops: Exception in kernel mode, sig: 4 [#2]<BR>&lt;4&gt;Kilauea<BR>&lt;4&gt;Modules linked in:<BR>&lt;4&gt;NIP: ee82ff80 LR: ee82ffb0 CTR: ee82a000<BR>&lt;4&gt;REGS: ee835f50 TRAP: c03153d0&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp;&nbsp; (2.6.29.1)<BR>&lt;4&gt;MSR: c0312318 &lt;FP,DE,DR&gt;&nbsp; CR: 00029030&nbsp; XER: c02368e0<BR>&lt;4&gt;TASK = ee82a7c0[3] 'kthreadd' THREAD: ee834000<BR>&lt;6&gt;GPR00: 3ffa80dc ee836000 ee82a7c0 00000000 ee82ffb0 00029030 00000000 ee82ff80 <BR>&lt;6&gt;GPR08: c0312318 00000000 00000000 c0312318 c033b260 00000000 3ffb2f00 00000000 <BR>&lt;6&gt;GPR16: 3ffa80dc 3ffae1e8 00000000 00000000 00000000 00000000 00000000 00000000 <BR>&lt;6&gt;GPR24: c03153d0 ee82ffb8 c00350f4 c031544c c0315458 ee82df08 c00350f4 ee82dee4 <BR>&lt;4&gt;NIP [ee82ff80] 0xee82ff80<BR>&lt;4&gt;LR [ee82ffb0] 0xee82ffb0<BR>&lt;4&gt;Call Trace:<BR>&lt;4&gt;Instruction dump:<BR>&lt;4&gt;XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <BR>&lt;4&gt;XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <BR>&lt;4&gt;---[ end trace 31fd0ba7d8756002 ]---<BR>
&nbsp;<BR>
Please help,<BR>
&nbsp;<BR>
Best Regards,<BR>
Sun<BR>
&nbsp;<BR><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://im.live.cn/messenger.aspx' target='_new'>立刻下载！</a></body>
</html>
--_5649d2b7-8944-41ed-ad9e-a2ab744953e4_--

Return-Path: <pradeepsampath@yahoo.com>
Received: from web83204.mail.mud.yahoo.com (web83204.mail.mud.yahoo.com
	[216.252.101.48]) by ozlabs.org (Postfix) with SMTP id D3E4267E63
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 16:37:59 +1000 (EST)
Message-ID: <20061006063757.69144.qmail@web83204.mail.mud.yahoo.com>
Date: Thu, 5 Oct 2006 23:37:57 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
To: Ameet Patil <ammubhai@gmail.com>
In-Reply-To: <4524C290.3090702@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1799099701-1160116677=:68561"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1799099701-1160116677=:68561
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ameet,
  I was able to get the system to work today with your Sysace driver patch and was able to boot the ML403 with the correct 'root=' option. But the kernel crashes with a "Oops: machine check, sig: 7 [#1]". (I have 'nt applied the TEMAC patches yet)
  It appears that the xparamater definition file genearted using EDK 8.1 does not map correctly with the driver and it looks like i need to further downgrade the EDK to 7.1 and re-generate the BSP. I am attaching the console logs and xparamater file. please ignore my earlier reply.
   
  thanks
  Pradeep
  
Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace2
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.1 (psampath@psampath-test) (gcc version 3.4.
1) #3 Thu Oct 5 21:00:20 PDT 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 root=/dev/xsysace2
[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000186] Console: colour dummy device 80x25
[    0.001812] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.004864] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.059900] Memory: 257408k available (1672k kernel code, 584k data, 84k init
, 0k highmem)
[    0.248261] Security Framework v1.0.0 initialized
[    0.248329] SELinux:  Disabled at boot.
[    0.248476] Mount-cache hash table entries: 512
[    0.254185] NET: Registered protocol family 16
[    0.262854] NET: Registered protocol family 2
[    0.316504] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.317597] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.318204] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.318515] TCP: Hash tables configured (established 8192 bind 4096)
[    0.318547] TCP reno registered
[    0.325066] audit: initializing netlink socket (disabled)
[    0.325217] audit(0.324:1): initialized
[    0.326741] VFS: Disk quotas dquot_6.5.1
[    0.326987] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.327684] Initializing Cryptographic API
[    0.327761] io scheduler noop registered
[    0.327854] io scheduler anticipatory registered (default)
[    0.327923] io scheduler deadline registered
[    0.328152] io scheduler cfq registered
[    0.948467] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
[    0.957267] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450
[    3.007825] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc
ksize
[    3.097865] Data machine check in kernel mode.
[    3.150765] Oops: machine check, sig: 7 [#1]
[    3.201802] NIP: C011E58C LR: C011DD00 CTR: C021D308
[    3.261169] REGS: c0224f50 TRAP: 0202   Not tainted  (2.6.17.1)
[    3.331981] MSR: 00029030 <EE,ME,IR,DR>  CR: 95000053  XER: E000007F
[    3.408018] TASK = c0489b40[1] 'swapper' THREAD: c04a0000
[    3.470498] GPR00: 00000001 C04A1D20 C0489B40 D1020000 00000101 000005C7 FDFE
D000 C0484BD8
[    3.570483] GPR08: C05C0C20 C011E014 00000000 C0206AEC 00000000 3BB7E7AD FFFF
FFFF FFFFFFFF
[    3.670467] GPR16: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 00503FFC FFFF
FFFF FFFFFFFF
[    3.770450] GPR24: FFFFFFFF FFFFFFFF FFFFFFFF 2F646576 00000000 C0220000 0000
0000 C0240C60
[    3.872519] NIP [C011E58C] XSysAce_RegWrite16+0x8/0x1c
[    3.933968] LR [C011DD00] XSysAce_Initialize+0x8c/0xe8
[    3.995416] Call Trace:
[    4.024581] [C04A1D20] [FFFFFFFF] 0xffffffff (unreliable)
[    4.089156] [C04A1D40] [C021D358] xsysace_init+0x50/0x330
[    4.153726] [C04A1F90] [C0002448] init+0xa4/0x27c
[    4.209968] [C04A1FF0] [C000509C] kernel_thread+0x44/0x60
[    4.274536] Instruction dump:
[    4.309949] 5480c63e 98030001 7c0006ac 5480863e 98030002 7c0006ac 5484463e 98
830003
[    4.402641] 7c0006ac 4e800020 5480063e 98030000 <7c0006ac> 5484c23e 98830001
7c0006ac
[    4.498278] Kernel panic - not syncing: Attempted to kill init!
[    4.568293]  <0>Rebooting in 180 seconds..
  

Ameet Patil <ammubhai@gmail.com> wrote:
  Pradeep,
What you have pasted is only part of the messages displayed. I can't 
tell anything from this apart from you 'root=' option. It would be nice 
if you could paste the entire log of the boot messages right from 
'loaded at: xxxxxxx xxxxxxxx' to 'Kernel Rebooting in 150 seconds'.

-Ameet

Pradeep Sampath wrote:
> Ameet,
> 
> loaded at: 00400000 0051513C
> board data at: 00513124 0051313C
> relocated to: 004050E8 00405100
> zimage at: 004057FD 0051230A
> avail ram: 00516000 04000000
> Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2
> Uncompressing Linux...done.
> Now booting the kernel
>
>
> Please could send me all the boot messages until the point where it
> stops. This will help me better identify the problem.
>
> Thanks,
> -Ameet
>
>



--0-1799099701-1160116677=:68561
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Ameet,</div>  <div>I was able to get the system to work today with your Sysace driver patch and was able to boot the ML403 with the correct 'root=' option. But the kernel crashes with a "Oops: machine check, sig: 7 [#1]". (I have 'nt applied the TEMAC patches yet)</div>  <div>It appears that the xparamater definition file genearted using EDK 8.1 does not map correctly with the driver and it looks like i need to further downgrade the EDK to 7.1 and re-generate the BSP. I am attaching the console logs and xparamater file. please ignore my earlier reply.</div>  <div>&nbsp;</div>  <div>thanks</div>  <div>Pradeep</div>  <div><BR>Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace2<BR>Uncompressing Linux...done.<BR>Now booting the kernel<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.17.1 (<A href="mailto:psampath@psampath-test">psampath@psampath-test</A>) (gcc version 3.4.<BR>1) #3 Thu Oct 5 21:00:20 PDT 2006<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML403 Reference
 System (Virtex-4 FX)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=ttyS0,9600 root=/dev/xsysace2<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0<BR>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.000186] Console: colour dummy device 80x25<BR>[&nbsp;&nbsp;&nbsp; 0.001812] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.004864] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.059900] Memory: 257408k available (1672k kernel code, 584k data, 84k init<BR>, 0k highmem)<BR>[&nbsp;&nbsp;&nbsp; 0.248261] Security Framework v1.0.0 initialized<BR>[&nbsp;&nbsp;&nbsp; 0.248329] SELinux:&nbsp; Disabled at boot.<BR>[&nbsp;&nbsp;&nbsp; 0.248476] Mount-cache hash table entries: 512<BR>[&nbsp;&nbsp;&nbsp; 0.254185] NET: Registered protocol family
 16<BR>[&nbsp;&nbsp;&nbsp; 0.262854] NET: Registered protocol family 2<BR>[&nbsp;&nbsp;&nbsp; 0.316504] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.317597] TCP established hash table entries: 8192 (order: 3, 32768 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.318204] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.318515] TCP: Hash tables configured (established 8192 bind 4096)<BR>[&nbsp;&nbsp;&nbsp; 0.318547] TCP reno registered<BR>[&nbsp;&nbsp;&nbsp; 0.325066] audit: initializing netlink socket (disabled)<BR>[&nbsp;&nbsp;&nbsp; 0.325217] audit(0.324:1): initialized<BR>[&nbsp;&nbsp;&nbsp; 0.326741] VFS: Disk quotas dquot_6.5.1<BR>[&nbsp;&nbsp;&nbsp; 0.326987] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.327684] Initializing Cryptographic API<BR>[&nbsp;&nbsp;&nbsp; 0.327761] io scheduler noop registered<BR>[&nbsp;&nbsp;&nbsp; 0.327854] io scheduler anticipatory registered
 (default)<BR>[&nbsp;&nbsp;&nbsp; 0.327923] io scheduler deadline registered<BR>[&nbsp;&nbsp;&nbsp; 0.328152] io scheduler cfq registered<BR>[&nbsp;&nbsp;&nbsp; 0.948467] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing<BR>enabled<BR>[&nbsp;&nbsp;&nbsp; 0.957267] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450<BR>[&nbsp;&nbsp;&nbsp; 3.007825] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc<BR>ksize<BR>[&nbsp;&nbsp;&nbsp; 3.097865] Data machine check in kernel mode.<BR>[&nbsp;&nbsp;&nbsp; 3.150765] Oops: machine check, sig: 7 [#1]<BR>[&nbsp;&nbsp;&nbsp; 3.201802] NIP: C011E58C LR: C011DD00 CTR: C021D308<BR>[&nbsp;&nbsp;&nbsp; 3.261169] REGS: c0224f50 TRAP: 0202&nbsp;&nbsp; Not tainted&nbsp; (2.6.17.1)<BR>[&nbsp;&nbsp;&nbsp; 3.331981] MSR: 00029030 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 95000053&nbsp; XER: E000007F<BR>[&nbsp;&nbsp;&nbsp; 3.408018] TASK = c0489b40[1] 'swapper' THREAD: c04a0000<BR>[&nbsp;&nbsp;&nbsp; 3.470498] GPR00:
 00000001 C04A1D20 C0489B40 D1020000 00000101 000005C7 FDFE<BR>D000 C0484BD8<BR>[&nbsp;&nbsp;&nbsp; 3.570483] GPR08: C05C0C20 C011E014 00000000 C0206AEC 00000000 3BB7E7AD FFFF<BR>FFFF FFFFFFFF<BR>[&nbsp;&nbsp;&nbsp; 3.670467] GPR16: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 00503FFC FFFF<BR>FFFF FFFFFFFF<BR>[&nbsp;&nbsp;&nbsp; 3.770450] GPR24: FFFFFFFF FFFFFFFF FFFFFFFF 2F646576 00000000 C0220000 0000<BR>0000 C0240C60<BR>[&nbsp;&nbsp;&nbsp; 3.872519] NIP [C011E58C] XSysAce_RegWrite16+0x8/0x1c<BR>[&nbsp;&nbsp;&nbsp; 3.933968] LR [C011DD00] XSysAce_Initialize+0x8c/0xe8<BR>[&nbsp;&nbsp;&nbsp; 3.995416] Call Trace:<BR>[&nbsp;&nbsp;&nbsp; 4.024581] [C04A1D20] [FFFFFFFF] 0xffffffff (unreliable)<BR>[&nbsp;&nbsp;&nbsp; 4.089156] [C04A1D40] [C021D358] xsysace_init+0x50/0x330<BR>[&nbsp;&nbsp;&nbsp; 4.153726] [C04A1F90] [C0002448] init+0xa4/0x27c<BR>[&nbsp;&nbsp;&nbsp; 4.209968] [C04A1FF0] [C000509C] kernel_thread+0x44/0x60<BR>[&nbsp;&nbsp;&nbsp; 4.274536] Instruction
 dump:<BR>[&nbsp;&nbsp;&nbsp; 4.309949] 5480c63e 98030001 7c0006ac 5480863e 98030002 7c0006ac 5484463e 98<BR>830003<BR>[&nbsp;&nbsp;&nbsp; 4.402641] 7c0006ac 4e800020 5480063e 98030000 &lt;7c0006ac&gt; 5484c23e 98830001<BR>7c0006ac<BR>[&nbsp;&nbsp;&nbsp; 4.498278] Kernel panic - not syncing: Attempted to kill init!<BR>[&nbsp;&nbsp;&nbsp; 4.568293]&nbsp; &lt;0&gt;Rebooting in 180 seconds..</div>  <div><BR><BR><B><I>Ameet Patil &lt;ammubhai@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Pradeep,<BR>What you have pasted is only part of the messages displayed. I can't <BR>tell anything from this apart from you 'root=' option. It would be nice <BR>if you could paste the entire log of the boot messages right from <BR>'loaded at: xxxxxxx xxxxxxxx' to 'Kernel Rebooting in 150 seconds'.<BR><BR>-Ameet<BR><BR>Pradeep Sampath wrote:<BR>&gt; Ameet,<BR>&gt; <BR>&gt; loaded at: 00400000
 0051513C<BR>&gt; board data at: 00513124 0051313C<BR>&gt; relocated to: 004050E8 00405100<BR>&gt; zimage at: 004057FD 0051230A<BR>&gt; avail ram: 00516000 04000000<BR>&gt; Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2<BR>&gt; Uncompressing Linux...done.<BR>&gt; Now booting the kernel<BR>&gt;<BR>&gt;<BR>&gt; Please could send me all the boot messages until the point where it<BR>&gt; stops. This will help me better identify the problem.<BR>&gt;<BR>&gt; Thanks,<BR>&gt; -Ameet<BR>&gt;<BR>&gt;<BR><BR></BLOCKQUOTE><BR>
--0-1799099701-1160116677=:68561--

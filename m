Return-Path: <junijoseph@yahoo.co.in>
Received: from web8408.mail.in.yahoo.com (web8408.mail.in.yahoo.com
	[202.43.219.156]) by ozlabs.org (Postfix) with SMTP id 4640E67B66
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 04:47:14 +1000 (EST)
Message-ID: <20060925184712.65041.qmail@web8408.mail.in.yahoo.com>
Date: Mon, 25 Sep 2006 19:47:12 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: linux-2.6 system ACE driver - need help
To: Ameet Patil <ammubhai@gmail.com>
In-Reply-To: <45179FF7.3000400@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-600444433-1159210032=:64976"
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

--0-600444433-1159210032=:64976
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ameet,
   
  Thanks so much for your reply.
   
  ISSUE Details :
   
  We are currently debugging System driver in 2.6.16-2 kernel in interrupt mode, for AMCC440SPe based custom board.
   
  We got the kernel and applied patch for Xilinx System ACE driver.
   
  We are using powerpc-eabi-  toolachain to compile the kernel and NOT EDK.
   
  We have done changes in the driver in regard to –
   
    
   System ACE Controller register configuration - BASE address is 64-bit and hence done ioremap64(SYSTEMACE_BASEADRESS).- adapter.c  
   Endianess (Xsysace_l.c)  
   IRQ - xsysace_intr.c; arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h ;  arch/ppc/syslib/ppc4xx_pic.c;  
   Kernel configuration to support FAT file system  
    Format the Compact Flash with FAT16 filesystem using ‘mkdosfs’, since  System ACE supports only FAT16
   
  With all these changes, we are able to communicate with the system ACE controller, register the interrupt, create block device using the driver, format and partition the Compact Flash.
   
  But we see issues while mounting the compact flash – Meaning, mounting shows inconsistent results.
   
  When we are able to mount the CF successfully, we are able to read/write to the compact flash. And when it fails, it throws a kernel Oops sometimes or complains that it’s a ‘bogus’ filesystem. Please see the screen-dump for success and failure cases:
  
  
   
  We are looking for inputs to attack this issue. Please advice.
   
  Note : we have worked on System ACE driver on 2.4 kernel on a different platform and were successful.
   
  Thanks very much
  Junita
   
  SCREEN DUMP:
   
  CASE 1 : Success:
   
  BusyBox v(null) ((null)) Built-in shell (msh)
  Enter 'help' for a list of built-in commands.
   
  # ### Application running ...
   
  #
  # cat /proc/interrupts
             CPU0
   33:          0  UIC1 Level     MAL SERR
   34:          0  UIC1 Level     MAL TX DE
   35:          0  UIC1 Level     MAL RX DE
   38:          0  UIC1 Level     MAL TX EOB
   39:          0  UIC1 Level     MAL RX EOB
   89:          0  UIC2 Level     System ACE
  BAD:          0
   
  # mknod /dev/xsysace b 254 0
   
  # mkdir /mnt
   
  # mkdir /mnt/sysace
   
  # mount -t msdos /dev/xsysace /mnt/sysace/
   
  # ls
  bin      etc      home     linuxrc  proc     sbin     usr
  dev      ftp      lib      mnt      root     tmp      var
   
  # ls /mnt/sysace/
  rev0.ace
  # cp /sbin/ifconfig /mnt/sysace/
   
  # ls /mnt/sysace/
  ifconfig  rev0.ace
  #
   
   
  CASE : 2 – Failure – Kernel Oops.
   
   
   # mount -t msdos /dev/xsysace /root/cf # cd /root/
   > Oops: kernel access of bad area, sig: 11 [#1]
   > NIP: C00556B8 LR: C00557E4 CTR: 00000000
   > REGS: dfeb1e08 TRAP: 0300   Not tainted  (2.6.16.2)
   > MSR: 00021000 <ME>  CR: 227A8728  XER: 00000000
   > DAR: 00000000, DSISR: 00800000
   > TASK = dff6c030[4] 'events/0' THREAD: dfeb0000
   > GPR00: 00100100 DFEB1EB8 DFF6C030 C025AC60 DFF7BE10 00000018
  DFD96000
   > C0258D60
   > GPR08: 00000000 00200200 DFD96154 00000000 227A8788 800823E2
  1FFB9600
   > 00000000
   > GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540 1FF63920
  1FFCEE78
   > C01F0000
   > GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018
  00000000
   > C025AC60
   > NIP [C00556B8] free_block+0xa8/0x148 LR [C00557E4] 
   > drain_array_locked+0x8c/0xd8 Call Trace:
   > [DFEB1EB8] [DFED53F0] 0xdfed53f0 (unreliable) [DFEB1ED8] [C00557E4] 
   > drain_array_locked+0x8c/0xd8 [DFEB1EF0] [C0056F80] 
   > cache_reap+0x74/0x18c [DFEB1F28] [C002B578] run_workqueue+0x9c/0x110 
   > [DFEB1F48] [C002B6E4] worker_thread+0xf8/0x13c [DFEB1FC0] [C002F6F0] 
   > kthread+0xf4/0x130 [DFEB1FF0] [C000413C] kernel_thread+0x44/0x60 
   > Instruction dump:
   > 7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14
  80c9001c
   > 3d200020 61290200 81060004 81660000 <91680000> 910b0004 3966001c
  90060000
   > BUG: events/0/4, lock held at task exit time!
   >  [c01f5d60] {cache_chain_mutex}
   > .. held by:          events/0:    4 [dff6c030, 110]
   > ... acquired at:               cache_reap+0x1c/0x18c
   >
   
   
    

Ameet Patil <ammubhai@gmail.com> wrote:

  agnel juni wrote:
> Hi Ameet
>
> I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.
>
> We are working on a AMCC 440SPe based custom board.
>
> We applied the patch from
> //http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
> //and applied against 2.6.16-2 kernel.
>
> We are trying to make the driver work in interrupt mode.
>
> First, I would like to know if the driver tested in interrupt mode.
>
> We are able to mount the CF, but it is very inconsistent.
>
> Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.//
> //
> Are we missing to apply the right patch? Please let us know your 
> inputs to go forward.
> Looking forwards for your reply.
>
> Thanks
> Junita
>
> /*************** Screen dump ********************/
> # fdisk /dev/xsysace
> 1. sector = 0 xsa_cur_req->sector=0
> System ACE: Error 0 when reading sector 2.
> 2. sector = 2 xsa_cur_req->sector=16
> end_request: I/O error, System ACE: Error 0 when reading sectoru dev 
> xsa, sector 16
> Buffer I/O error on device xsa, logical block 2
> 1. sector = 184 xsa_cur_req->sector=184
> 
> Command (m for help): p
> 
> Disk /dev/xsysace: 524 MB, 524869632 bytes
> 17 heads, 59 sectors/track, 1022 cylinders
> Units = cylinders of 1003 * 512 = 513536 bytes
> 
> Device Boot Start End Blocks Id System
> /dev/xsysace1 1 1022 512503+ 6 FAT16
> 
> Command (m for help): q
> And for 'mount'
> #
> #
> # mount -t msdos /dev/xsysace /root/cf
> 1. sector = 0 xsa_cur_req->sector=0
> 1. sector = 503 xsa_cur_req->sector=503
> 1. sector = 504 xsa_cur_req->sector=504
> 1. sector = 506 xsa_cur_req->sector=506
> 1. sector = 508 xsa_cur_req->sector=508
> 1. sector = 510 xsa_cur_req->sector=510
> # cd /root/cf
> < Here Prints Some Symbols like + - etc, which i am
> not able to capture/copy -------------ERROR
> b: No such file or directory--------------------------------ERROR
> pci.h
> #
> Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#
> # cp pci.h /root/
> # cd ../
> # ls
> app cf hello1 pci.h
> #
> #/root
> /dev/xsysace /root/cf
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev xsa.
> mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument
> #
> 
>
>
> //
>
>
>
> //
>
> ------------------------------------------------------------------------
> Find out what India is talking about on - Yahoo! Answers India 
> 
> Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. 
> Get it NOW 
> 


Hi Agnel,
The driver was last tested with 2.6.17 kernel and till date works 
fine in the interrupt mode. I have been using it since the last 4 months 
now. It should also work on 2.6.16-2 kernel I think, but I have not 
tested this. Have you made any changes to the driver? If so... please 
give the details so I can give you better feedback as to where things 
might have gone wrong. When time permits I shall try my patch on the 
2.6.16-2 kernel and let you know if it works for me.

Thanks,
-Ameet




 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-600444433-1159210032=:64976
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Ameet,</div>  <div>&nbsp;</div>  <div>Thanks so much for your reply.</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p><STRONG><U>ISSUE Details :</U></STRONG></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">We are currently debugging System driver in 2.6.16-2 kernel in interrupt mode, for AMCC440SPe based custom board.</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p></o:p></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in
 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">We got the kernel&nbsp;and applied patch for Xilinx System ACE driver.</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p></o:p></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>We are using powerpc-eabi-&nbsp; toolachain to compile the kernel and <STRONG>NOT EDK.</STRONG></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p></o:p></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">We have done changes in the driver in regard to –<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <OL
 style="MARGIN-TOP: 0in" type=1>  <LI class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-list: l1 level1 lfo1; tab-stops: list .5in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">System ACE Controller register configuration - BASE address is 64-bit and hence done ioremap64(SYSTEMACE_BASEADRESS).- adapter.c</SPAN></LI>  <LI class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-list: l1 level1 lfo1; tab-stops: list .5in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Endianess (Xsysace_l.c)</SPAN></LI>  <LI class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-list: l1 level1 lfo1; tab-stops: list .5in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">IRQ - xsysace_intr.c; arch/ppc/platforms/4xx/xparameters/xparameters_ml300.h ;&nbsp; arch/ppc/syslib/ppc4xx_pic.c;</SPAN></LI>  <LI class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-list: l1 level1 lfo1; tab-stops: list .5in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Kernel configuration to support FAT file system</SPAN></LI> 
 <LI class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-list: l1 level1 lfo1; tab-stops: list .5in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-fareast-font-family: Arial"><SPAN style="mso-list: Ignore"><SPAN style="FONT: 7pt 'Times New Roman'">&nbsp;</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Format the Compact Flash with FAT16 filesystem using ‘mkdosfs’, since <SPAN style="mso-spacerun: yes">&nbsp;</SPAN>System ACE supports only FAT16<o:p></o:p></SPAN></LI></OL>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt 0.25in"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">With all these changes, we are able to communicate with the system ACE controller, register the interrupt, create block device using the driver, format and partition the Compact Flash.<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN:
 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">But we see issues while mounting the compact flash – Meaning, mounting shows inconsistent results.<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">When we are able to mount the CF successfully, we are able to read/write to the compact flash. And when it fails, it throws a kernel Oops sometimes or complains that it’s a ‘bogus’ filesystem. Please see the screen-dump for success and failure cases:<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN:
 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">We are looking for inputs to attack this issue. Please advice.</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><STRONG>Note</STRONG> : we have worked on System ACE driver on 2.4 kernel on a different platform and were successful.</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks very
 much</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Junita</SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><B style="mso-bidi-font-weight: normal"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">SCREEN DUMP:<o:p></o:p></SPAN></B></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><B style="mso-bidi-font-weight: normal"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">CASE 1 : Success:<o:p></o:p></SPAN></B></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt;
 FONT-FAMILY: Arial">BusyBox v(null) ((null)) Built-in shell (msh)<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Enter 'help' for a list of built-in commands.<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># ### Application running ...<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">#<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># cat /proc/interrupts<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN:
 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>CPU0<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>33:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC1 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>MAL SERR<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>34:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC1 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>MAL TX DE<o:p></o:p></SPAN></div> 
 <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>35:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC1 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>MAL RX DE<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>38:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC1 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>MAL TX EOB<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>39:<SPAN style="mso-spacerun:
 yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC1 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>MAL RX EOB<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>89:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>UIC2 Level<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>System ACE<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">BAD:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>0<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div
 class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># <B style="mso-bidi-font-weight: normal">mknod /dev/xsysace b 254 0<o:p></o:p></B></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># mkdir /mnt<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># mkdir /mnt/sysace<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># <B
 style="mso-bidi-font-weight: normal">mount -t msdos /dev/xsysace /mnt/sysace</B>/<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># ls<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">bin<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>etc<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>home<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>linuxrc<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>proc<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>sbin<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>usr<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt;
 FONT-FAMILY: Arial">dev<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>ftp<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>lib<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>mnt<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>root<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>tmp<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>var<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># <B style="mso-bidi-font-weight: normal">ls /mnt/sysace/<o:p></o:p></B></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">rev0.ace<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN
 style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># <B style="mso-bidi-font-weight: normal">cp /sbin/ifconfig /mnt/sysace/<o:p></o:p></B></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><B style="mso-bidi-font-weight: normal"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></B></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"># ls /mnt/sysace/<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">ifconfig<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>rev0.ace<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">#<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt;
 FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><B style="mso-bidi-font-weight: normal"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">CASE : 2 – Failure – Kernel Oops.<o:p></o:p></SPAN></B></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN># mount -t msdos /dev/xsysace /root/cf # cd /root/<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; Oops: kernel access of bad
 area, sig: 11 [#1]<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; NIP: C00556B8 LR: C00557E4 CTR: 00000000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; REGS: dfeb1e08 TRAP: 0300<SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Not tainted<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>(2.6.16.2)<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; MSR: 00021000 &lt;ME&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CR: 227A8728<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>XER:
 00000000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; DAR: 00000000, DSISR: 00800000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; TASK = dff6c030[4] 'events/0' THREAD: dfeb0000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; GPR00: 00100100 DFEB1EB8 DFF6C030 C025AC60 DFF7BE10 00000018<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'">DFD96000<o:p></o:p></SPAN></div>  <div
 class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; C0258D60<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; GPR08: 00000000 00200200 DFD96154 00000000 227A8788 800823E2<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'">1FFB9600<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; 00000000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt;
 FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540 1FF63920<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'">1FFCEE78<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; C01F0000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier
 New'">00000000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; C025AC60<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; NIP [C00556B8] free_block+0xa8/0x148 LR [C00557E4] <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; drain_array_locked+0x8c/0xd8 Call Trace:<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; [DFEB1EB8] [DFED53F0]
 0xdfed53f0 (unreliable) [DFEB1ED8] [C00557E4] <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; drain_array_locked+0x8c/0xd8 [DFEB1EF0] [C0056F80] <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; cache_reap+0x74/0x18c [DFEB1F28] [C002B578] run_workqueue+0x9c/0x110 <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; [DFEB1F48] [C002B6E4] worker_thread+0xf8/0x13c [DFEB1FC0] [C002F6F0] <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN
 style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; kthread+0xf4/0x130 [DFEB1FF0] [C000413C] kernel_thread+0x44/0x60 <o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; Instruction dump:<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; 7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'">80c9001c<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY:
 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; 3d200020 61290200 81060004 81660000 &lt;91680000&gt; 910b0004 3966001c<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'">90060000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; BUG: events/0/4, lock held at task exit time!<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt;<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>[c01f5d60] {cache_chain_mutex}<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt;
 FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; .. held by:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>events/0:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>4 [dff6c030, 110]<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt; ... acquired at:<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>cache_reap+0x1c/0x18c<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: 'Courier New'"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>&gt;<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY:
 Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div>  <div><BR><BR><B><I>Ameet Patil &lt;ammubhai@gmail.com&gt;</I></B> wrote:</div></div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">agnel juni wrote:<BR>&gt; Hi Ameet<BR>&gt;<BR>&gt; I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.<BR>&gt;<BR>&gt; We are working on a AMCC 440SPe based custom board.<BR>&gt;<BR>&gt; We applied the patch from<BR>&gt; //http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch<BR>&gt; //and applied against 2.6.16-2 kernel.<BR>&gt;<BR>&gt; We are trying to make the driver work in interrupt mode.<BR>&gt;<BR>&gt; First, I would like to know if the driver tested in interrupt mode.<BR>&gt;<BR>&gt; We are able to mount the CF, but it is very
 inconsistent.<BR>&gt;<BR>&gt; Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.//<BR>&gt; //<BR>&gt; Are we missing to apply the right patch? Please let us know your <BR>&gt; inputs to go forward.<BR>&gt; Looking forwards for your reply.<BR>&gt;<BR>&gt; Thanks<BR>&gt; Junita<BR>&gt;<BR>&gt; /*************** Screen dump ********************/<BR>&gt; # fdisk /dev/xsysace<BR>&gt; 1. sector = 0 xsa_cur_req-&gt;sector=0<BR>&gt; System ACE: Error 0 when reading sector 2.<BR>&gt; 2. sector = 2 xsa_cur_req-&gt;sector=16<BR>&gt; end_request: I/O error, System ACE: Error 0 when reading sectoru dev <BR>&gt; xsa, sector 16<BR>&gt; Buffer I/O error on device xsa, logical block 2<BR>&gt; 1. sector = 184 xsa_cur_req-&gt;sector=184<BR>&gt; <BR>&gt; Command (m for help): p<BR>&gt; <BR>&gt; Disk /dev/xsysace: 524 MB, 524869632 bytes<BR>&gt; 17 heads, 59 sectors/track, 1022 cylinders<BR>&gt; Units = cylinders of 1003 * 512 = 513536
 bytes<BR>&gt; <BR>&gt; Device Boot Start End Blocks Id System<BR>&gt; /dev/xsysace1 1 1022 512503+ 6 FAT16<BR>&gt; <BR>&gt; Command (m for help): q<BR>&gt; And for 'mount'<BR>&gt; #<BR>&gt; #<BR>&gt; # mount -t msdos /dev/xsysace /root/cf<BR>&gt; 1. sector = 0 xsa_cur_req-&gt;sector=0<BR>&gt; 1. sector = 503 xsa_cur_req-&gt;sector=503<BR>&gt; 1. sector = 504 xsa_cur_req-&gt;sector=504<BR>&gt; 1. sector = 506 xsa_cur_req-&gt;sector=506<BR>&gt; 1. sector = 508 xsa_cur_req-&gt;sector=508<BR>&gt; 1. sector = 510 xsa_cur_req-&gt;sector=510<BR>&gt; # cd /root/cf<BR>&gt; &lt; Here Prints Some Symbols like + - etc, which i am<BR>&gt; not able to capture/copy -------------ERROR<BR>&gt; b: No such file or directory--------------------------------ERROR<BR>&gt; pci.h<BR>&gt; #<BR>&gt;
 Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#<BR>&gt; # cp pci.h /root/<BR>&gt; # cd ../<BR>&gt; # ls<BR>&gt; app cf hello1 pci.h<BR>&gt; #<BR>&gt; #/root<BR>&gt; /dev/xsysace /root/cf<BR>&gt; FAT: bogus number of reserved sectors<BR>&gt; VFS: Can't find a valid FAT filesystem on dev xsa.<BR>&gt; mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument<BR>&gt; #<BR>&gt; <BR>&gt;<BR>&gt;<BR>&gt; //<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; //<BR>&gt;<BR>&gt; ------------------------------------------------------------------------<BR>&gt; Find out what India is talking about on - Yahoo! Answers India <BR>&gt; <HTTP: in.answers.yahoo.com *http: yanswers in mail us.rd.yahoo.com /><BR>&gt; Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <BR>&gt;
 Get it NOW <BR>&gt; <HTTP: *http: in mail us.rd.yahoo.com in.messenger.yahoo.com messengertagline><BR><BR><BR>Hi Agnel,<BR>The driver was last tested with 2.6.17 kernel and till date works <BR>fine in the interrupt mode. I have been using it since the last 4 months <BR>now. It should also work on 2.6.16-2 kernel I think, but I have not <BR>tested this. Have you made any changes to the driver? If so... please <BR>give the details so I can give you better feedback as to where things <BR>might have gone wrong. When time permits I shall try my patch on the <BR>2.6.16-2 kernel and let you know if it works for me.<BR><BR>Thanks,<BR>-Ameet<BR></BLOCKQUOTE><BR><BR><BR><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-600444433-1159210032=:64976--

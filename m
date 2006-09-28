Return-Path: <junijoseph@yahoo.co.in>
Received: from web8410.mail.in.yahoo.com (web8410.mail.in.yahoo.com
	[202.43.219.158]) by ozlabs.org (Postfix) with SMTP id 4067967BE5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 08:51:53 +1000 (EST)
Message-ID: <20060928225151.20255.qmail@web8410.mail.in.yahoo.com>
Date: Thu, 28 Sep 2006 23:51:51 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: mount-  crashes with sig-11 error - linux-2.6.16.2
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <45179FF7.3000400@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-622152221-1159483911=:13838"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-622152221-1159483911=:13838
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi
 
 We are using linux-2.6.16.2. We are trying to mount the compact flash (64MB) with FAT16 filesystem, using system ACE driver.
 
 We are able to run filesystem check, partition the CF etc, but the issue is with mount.
 
 'Mount' shows inconsistent results, meaning mount crashes with sig-11 error. Sametime when it succeeds we are able to copy/read/ and remove files from the CF.
 
 Please find the screen-dump of the kernel oops below:
 
 Any help is greatly appreciated.
 
 /******************* screen-dump*******************/
 Oops: kernel access of bad area, sig: 11 [#1]
 NIP: C004AD4C LR: C004CF98 CTR: 0FF050A0
 REGS: dfd8ddf8 TRAP: 0300   Not tainted  (2.6.16.2)
 MSR: 00029000 <EE,ME>  CR: 84004024  XER: 20000000
 DAR: 00000008, DSISR: 00000000
 TASK = dfc93450[620] 'exe' THREAD: dfd8c000
 GPR00: C004CF98 DFD8DEA8 DFC93450 DFD610CC DFF7D000 00000000 00029000 DFD8C000
 GPR08: C024D1F4 00000004 00000007 DFF7D090 24004022 10062C0C 00000000 00000000
 GPR16: 00000000 7FE73BA0 10060000 10060000 1006F650 10060000 1006F520 00000000
 GPR24: 1005AC48 10036970 00000005 1003EE68 DFC93450 00000000 00000000 DFD610CC
 NIP [C004AD4C] remove_vma+0x24/0x9c
 LR [C004CF98] exit_mmap+0xb4/0xec
 Call Trace:
 [DFD8DEA8] [C004ADA0] remove_vma+0x78/0x9c (unreliable)
 [DFD8DEB8] [C004CF98] exit_mmap+0xb4/0xec
 [DFD8DED8] [C0016CEC] mmput+0x50/0xd4
 [DFD8DEE8] [C001B2D8] exit_mm+0x120/0x1a0
 [DFD8DF00] [C001B914] do_exit+0x11c/0x77c
 [DFD8DF38] [C001BFB0] do_group_exit+0x0/0x80
 [DFD8DF40] [C0001BC4] ret_from_syscall+0x0/0x3c
 Instruction dump:
 4d9e0020 80a40080 4bffff58 7c0802a6 9421fff0 bfc10008 7c7f1b78 90010014
 81230044 83c3000c 2f890000 419e0010 <80090004> 2f800000 409e0064 807f004c
 Fixing recursive fault but reboot is needed!
 Oops: kernel access of bad area, sig: 11 [#2]
 NIP: C00556B8 LR: C00557E4 CTR: 00000000
 REGS: dfdbfe08 TRAP: 0300   Not tainted  (2.6.16.2)
 MSR: 00021000 <ME>  CR: 22008028  XER: 00000000
 DAR: 00000000, DSISR: 00800000
 TASK = dff6c030[4] 'events/0' THREAD: dfdbe000
 GPR00: 00100100 DFDBFEB8 DFF6C030 C0258D20 DFF7D010 00000018 DFD61000 C0256E20
 GPR08: 00000000 00200200 DFD61EE4 C0256E28 C0220000 10062C0C 1FFB9700 00000000
 GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78 C01F0000
 GPR24: C0240000 00100100 C0240000 00000000 DFF7D010 00000018 00000002 C0258D20
 NIP [C00556B8] free_block+0xa8/0x148
 LR [C00557E4] drain_array_locked+0x8c/0xd8
 Call Trace:
 [DFDBFEB8] [C0055338] kmem_freepages+0x98/0xdc (unreliable)
 [DFDBFED8] [C00557E4] drain_array_locked+0x8c/0xd8
 [DFDBFEF0] [C0056F80] cache_reap+0x74/0x18c
 [DFDBFF28] [C002B578] run_workqueue+0x9c/0x110
 [DFDBFF48] [C002B6E4] worker_thread+0xf8/0x13c
 [DFDBFFC0] [C002F6F0] kthread+0xf4/0x130
 [DFDBFFF0] [C000413C] kernel_thread+0x44/0x60
 Instruction dump:
 7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14 80c9001c
 3d200020 61290200 81060004 81660000 <91680000> 910b0004 3966001c 90060000
 BUG: events/0/4, lock held at task exit time!
  [c01f5d60] {cache_chain_mutex}
 .. held by:          events/0:    4 [dff6c030, 110]
 ... acquired at:               cache_reap+0x1c/0x18c
 
 
 Thanks
 Junita
 
 
 
 
Ameet Patil <ammubhai@gmail.com> wrote: agnel juni wrote:
> Hi Ameet
>
> I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.
>
> We are working on a AMCC 440SPe based custom board.
>
> We applied the patch from
> //http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
>  //and applied against 2.6.16-2 kernel.
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
>        Device Boot      Start         End      Blocks   Id  System
> /dev/xsysace1               1        1022      512503+   6  FAT16
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
>   not able to capture/copy -------------ERROR
> b: No such file or directory--------------------------------ERROR
> pci.h
> #
> Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#
> # cp pci.h /root/
> # cd ../
> # ls
> app     cf      hello1  pci.h
> #
> #/root
>  /dev/xsysace /root/cf
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
--0-622152221-1159483911=:13838
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hi<br> <br> We are using linux-2.6.16.2. We are trying to mount the compact flash (64MB) with FAT16 filesystem, using system ACE driver.<br> <br> We are able to run filesystem check, partition the CF etc, but the issue is with mount.<br> <br> 'Mount' shows inconsistent results, meaning mount crashes with sig-11 error. Sametime when it succeeds we are able to copy/read/ and remove files from the CF.<br> <br> Please find the screen-dump of the kernel oops below:<br> <br> Any help is greatly appreciated.<br> <br> /******************* screen-dump*******************/<br> Oops: kernel access of bad area, sig: 11 [#1]<br> NIP: C004AD4C LR: C004CF98 CTR: 0FF050A0<br> REGS: dfd8ddf8 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.2)<br> MSR: 00029000 &lt;EE,ME&gt;&nbsp; CR: 84004024&nbsp; XER: 20000000<br> DAR: 00000008, DSISR: 00000000<br> TASK = dfc93450[620] 'exe' THREAD: dfd8c000<br> GPR00: C004CF98 DFD8DEA8 DFC93450 DFD610CC DFF7D000 00000000 00029000 DFD8C000<br> GPR08:
 C024D1F4 00000004 00000007 DFF7D090 24004022 10062C0C 00000000 00000000<br> GPR16: 00000000 7FE73BA0 10060000 10060000 1006F650 10060000 1006F520 00000000<br> GPR24: 1005AC48 10036970 00000005 1003EE68 DFC93450 00000000 00000000 DFD610CC<br> NIP [C004AD4C] remove_vma+0x24/0x9c<br> LR [C004CF98] exit_mmap+0xb4/0xec<br> Call Trace:<br> [DFD8DEA8] [C004ADA0] remove_vma+0x78/0x9c (unreliable)<br> [DFD8DEB8] [C004CF98] exit_mmap+0xb4/0xec<br> [DFD8DED8] [C0016CEC] mmput+0x50/0xd4<br> [DFD8DEE8] [C001B2D8] exit_mm+0x120/0x1a0<br> [DFD8DF00] [C001B914] do_exit+0x11c/0x77c<br> [DFD8DF38] [C001BFB0] do_group_exit+0x0/0x80<br> [DFD8DF40] [C0001BC4] ret_from_syscall+0x0/0x3c<br> Instruction dump:<br> 4d9e0020 80a40080 4bffff58 7c0802a6 9421fff0 bfc10008 7c7f1b78 90010014<br> 81230044 83c3000c 2f890000 419e0010 &lt;80090004&gt; 2f800000 409e0064 807f004c<br> Fixing recursive fault but reboot is needed!<br> Oops: kernel access of bad area, sig: 11 [#2]<br> NIP: C00556B8 LR: C00557E4
 CTR: 00000000<br> REGS: dfdbfe08 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.2)<br> MSR: 00021000 &lt;ME&gt;&nbsp; CR: 22008028&nbsp; XER: 00000000<br> DAR: 00000000, DSISR: 00800000<br> TASK = dff6c030[4] 'events/0' THREAD: dfdbe000<br> GPR00: 00100100 DFDBFEB8 DFF6C030 C0258D20 DFF7D010 00000018 DFD61000 C0256E20<br> GPR08: 00000000 00200200 DFD61EE4 C0256E28 C0220000 10062C0C 1FFB9700 00000000<br> GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78 C01F0000<br> GPR24: C0240000 00100100 C0240000 00000000 DFF7D010 00000018 00000002 C0258D20<br> NIP [C00556B8] free_block+0xa8/0x148<br> LR [C00557E4] drain_array_locked+0x8c/0xd8<br> Call Trace:<br> [DFDBFEB8] [C0055338] kmem_freepages+0x98/0xdc (unreliable)<br> [DFDBFED8] [C00557E4] drain_array_locked+0x8c/0xd8<br> [DFDBFEF0] [C0056F80] cache_reap+0x74/0x18c<br> [DFDBFF28] [C002B578] run_workqueue+0x9c/0x110<br> [DFDBFF48] [C002B6E4] worker_thread+0xf8/0x13c<br> [DFDBFFC0] [C002F6F0]
 kthread+0xf4/0x130<br> [DFDBFFF0] [C000413C] kernel_thread+0x44/0x60<br> Instruction dump:<br> 7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14 80c9001c<br> 3d200020 61290200 81060004 81660000 &lt;91680000&gt; 910b0004 3966001c 90060000<br> BUG: events/0/4, lock held at task exit time!<br> &nbsp;[c01f5d60] {cache_chain_mutex}<br> .. held by:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; events/0:&nbsp;&nbsp;&nbsp; 4 [dff6c030, 110]<br> ... acquired at:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache_reap+0x1c/0x18c<br> <br> <br> Thanks<br> Junita<br> <br> <br> <br> <br><b><i>Ameet Patil &lt;ammubhai@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> agnel juni wrote:<br>&gt; Hi Ameet<br>&gt;<br>&gt; I have posted a few messages regarding Ssytem ACE driver for Linux-2.6.<br>&gt;<br>&gt; We are working on a AMCC 440SPe
 based custom board.<br>&gt;<br>&gt; We applied the patch from<br>&gt; //http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch<br>&gt;  //and applied against 2.6.16-2 kernel.<br>&gt;<br>&gt; We are trying to make the driver work in interrupt mode.<br>&gt;<br>&gt; First, I would like to know if the driver tested in interrupt mode.<br>&gt;<br>&gt; We are able to mount the CF, but it is very inconsistent.<br>&gt;<br>&gt; Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.//<br>&gt; //<br>&gt; Are we missing to apply the right patch? Please let us know your <br>&gt; inputs to go forward.<br>&gt; Looking forwards for your reply.<br>&gt;<br>&gt; Thanks<br>&gt; Junita<br>&gt;<br>&gt; /*************** Screen dump ********************/<br>&gt; # fdisk /dev/xsysace<br>&gt; 1. sector = 0 xsa_cur_req-&gt;sector=0<br>&gt; System ACE: Error 0 when reading sector 2.<br>&gt; 2. sector = 2
 xsa_cur_req-&gt;sector=16<br>&gt; end_request: I/O error, System ACE: Error 0 when reading sectoru dev <br>&gt; xsa, sector 16<br>&gt; Buffer I/O error on device xsa, logical block 2<br>&gt; 1. sector = 184 xsa_cur_req-&gt;sector=184<br>&gt;  <br>&gt; Command (m for help): p<br>&gt;  <br>&gt; Disk /dev/xsysace: 524 MB, 524869632 bytes<br>&gt; 17 heads, 59 sectors/track, 1022 cylinders<br>&gt; Units = cylinders of 1003 * 512 = 513536 bytes<br>&gt;  <br>&gt;        Device Boot      Start         End      Blocks   Id  System<br>&gt; /dev/xsysace1               1        1022      512503+   6  FAT16<br>&gt;  <br>&gt; Command (m for help): q<br>&gt; And for 'mount'<br>&gt; #<br>&gt; #<br>&gt; # mount -t msdos /dev/xsysace /root/cf<br>&gt; 1. sector = 0 xsa_cur_req-&gt;sector=0<br>&gt; 1. sector = 503 xsa_cur_req-&gt;sector=503<br>&gt; 1. sector = 504 xsa_cur_req-&gt;sector=504<br>&gt; 1. sector = 506 xsa_cur_req-&gt;sector=506<br>&gt; 1. sector = 508
 xsa_cur_req-&gt;sector=508<br>&gt; 1. sector = 510 xsa_cur_req-&gt;sector=510<br>&gt; # cd /root/cf<br>&gt; &lt; Here Prints Some Symbols like + - etc, which i am<br>&gt;   not able to capture/copy -------------ERROR<br>&gt; b: No such file or directory--------------------------------ERROR<br>&gt; pci.h<br>&gt; #<br>&gt; Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.n0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.0Minicom2.00.d#<br>&gt; # cp pci.h /root/<br>&gt; # cd ../<br>&gt; # ls<br>&gt; app     cf      hello1  pci.h<br>&gt; #<br>&gt; #/root<br>&gt;  /dev/xsysace /root/cf<br>&gt; FAT: bogus number of reserved sectors<br>&gt; VFS: Can't find a valid FAT filesystem on dev xsa.<br>&gt; mount: Mounting /dev/xsysace on /root/cf failed: Invalid argument<br>&gt; #<br>&gt;  <br>&gt;<br>&gt;<br>&gt;
 //<br>&gt;<br>&gt;<br>&gt;<br>&gt; //<br>&gt;<br>&gt; ------------------------------------------------------------------------<br>&gt; Find out what India is talking about on - Yahoo! Answers India <br>&gt; <http:><br>&gt; Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <br>&gt; Get it NOW <br>&gt; <http:> <br><br><br>Hi Agnel,<br>    The driver was last tested with 2.6.17 kernel and till date works <br>fine in the interrupt mode. I have been using it since the last 4 months <br>now. It should also work on 2.6.16-2 kernel I think, but I have not <br>tested this. Have you made any changes to the driver? If so... please <br>give the details so I can give you better feedback as to where things <br>might have gone wrong. When time permits I shall try my patch on the <br>2.6.16-2 kernel and let you know if it works for me.<br><br>Thanks,<br>-Ameet<br></http:></http:></blockquote><br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-622152221-1159483911=:13838--

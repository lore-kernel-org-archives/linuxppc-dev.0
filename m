Return-Path: <junijoseph@yahoo.co.in>
Received: from web8415.mail.in.yahoo.com (web8415.mail.in.yahoo.com
	[202.43.219.103]) by ozlabs.org (Postfix) with SMTP id 0218067C23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 07:48:23 +1000 (EST)
Message-ID: <20061013214821.71914.qmail@web8415.mail.in.yahoo.com>
Date: Fri, 13 Oct 2006 22:48:21 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Eeek! page_mapcount(page) went negative! (-1) -2.6.16.2 kernel
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-438049822-1160776101=:71210"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-438049822-1160776101=:71210
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all,
 
 We are working on System ACE driver ported for AMCC44x based custom platform, on linux kernel-2.6.16.2
 
 We have formatted the flash with FAT16 filesystem as System ACE supports only that.
 
 We are able to run all the filessytem commands except that 'mount' shows inconsisten behaviour.
 
 I have turned off the "Use full SLAB allocator" option under kernel configuration.
 
 With this, when mount fails I see Kernel throwing Oops sometimes.
 
 Any suggestions to debug this are greatly appreciated.
 
 ################# Kernel Oops #######################
 
 
 # mount -t msdos /dev/xsysace /mnt/
 Bad pte = df452f3cdf452f3c, process = exe, vm_flags = 75, vaddr = fe11a64
 Call Trace:
 [DFF97DE8] [C000958C] show_stack+0x48/0x194 (unreliable)
 [DFF97E18] [C00470CC] print_bad_pte+0x44/0x54
 [DFF97E20] [C0049694] __handle_mm_fault+0x900/0x930
 [DFF97E78] [C000A174] do_page_fault+0x268/0x4fc
 [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80
 VM: killing process exe
 swap_free: Bad swap file entry 62696e2f
 swap_free: Bad swap file entry 026f7800
 swap_free: Bad swap file entry 30c070c3
 swap_free: Bad swap file entry b8df44b2
 swap_free: Bad swap file entry c0df44b2
 Bad pte = 5800000001, process = ???, vm_flags = 75, vaddr = fe12000
 Call Trace:
 [DFF97D28] [C000958C] show_stack+0x48/0x194 (unreliable)
 [DFF97D58] [C00470CC] print_bad_pte+0x44/0x54
 [DFF97D60] [C0047168] vm_normal_page+0x8c/0x94
 [DFF97D68] [C004794C] unmap_vmas+0x424/0x5c8
 [DFF97DF8] [C004CAC8] exit_mmap+0x60/0xec
 [DFF97E18] [C0016C3C] mmput+0x50/0xd4
 [DFF97E28] [C001B228] exit_mm+0x120/0x1a0
 [DFF97E40] [C001B864] do_exit+0x11c/0x77c
 [DFF97E78] [C000A2A4] do_page_fault+0x398/0x4fc
 [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80
 Eeek! page_mapcount(page) went negative! (-1)
   page->flags = 400
   page->count = 1
   page->mapping = 00000000
 kernel BUG in page_remove_rmap at mm/rmap.c:560!
 Oops: Exception in kernel mode, sig: 5 [#1]
 NIP: C004E620 LR: C004E698 CTR: 00000000
 REGS: dff97ca8 TRAP: 0700   Not tainted  (2.6.16.2)
 MSR: 00029000 <EE,ME>  CR: 24022022  XER: 00000000
 TASK = df463000[610] 'exe' THREAD: dff96000
 GPR00: C004E698 DFF97D58 DF463000 0000001E 00000FBC FFFFFFFF C0240000 C01F0C0C
 GPR08: C01F0000 00000001 00000000 C0240000 00000000 10065ABC DFC46D10 0FF08FFF
 GPR16: C0243C18 00000000 FFFFFFFF FFFFFFFF 00000000 0FF09000 DFD2AA50 DF4821FC
 GPR24: 00000000 DFF97D74 A1FF0000 00000001 0FF09000 C0259000 0FE13000 C0259000
 NIP [C004E620] page_remove_rmap+0x68/0xe4
 LR [C004E698] page_remove_rmap+0xe0/0xe4
 Call Trace:
 [DFF97D58] [C004E698] page_remove_rmap+0xe0/0xe4 (unreliable)
 [DFF97D68] [C004799C] unmap_vmas+0x474/0x5c8
 [DFF97DF8] [C004CAC8] exit_mmap+0x60/0xec
 [DFF97E18] [C0016C3C] mmput+0x50/0xd4
 [DFF97E28] [C001B228] exit_mm+0x120/0x1a0
 [DFF97E40] [C001B864] do_exit+0x11c/0x77c
 [DFF97E78] [C000A2A4] do_page_fault+0x398/0x4fc
 [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80
 Instruction dump:
 83e1000c 38210010 7c0803a6 4e800020 801f0008 3c60c01c 3863d5e0 35200001
 41800034 813f0008 39290001 55290ffe <0f090000> 38600010 3880ffff 4bff07b1
 Fixing recursive fault but reboot is needed!
 
 
Thanks
 Junita

 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-438049822-1160776101=:71210
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all,<br> <br> We are working on System ACE driver ported for AMCC44x based custom platform, on linux kernel-2.6.16.2<br> <br> We have formatted the flash with FAT16 filesystem as System ACE supports only that.<br> <br> We are able to run all the filessytem commands except that 'mount' shows inconsisten behaviour.<br> <br> I have turned off the "Use full SLAB allocator" option under kernel configuration.<br> <br> With this, when mount fails I see Kernel throwing Oops sometimes.<br> <br> Any suggestions to debug this are greatly appreciated.<br> <br> ################# Kernel Oops #######################<br> <br> <br> # mount -t msdos /dev/xsysace /mnt/<br> Bad pte = df452f3cdf452f3c, process = exe, vm_flags = 75, vaddr = fe11a64<br> Call Trace:<br> [DFF97DE8] [C000958C] show_stack+0x48/0x194 (unreliable)<br> [DFF97E18] [C00470CC] print_bad_pte+0x44/0x54<br> [DFF97E20] [C0049694] __handle_mm_fault+0x900/0x930<br> [DFF97E78] [C000A174] do_page_fault+0x268/0x4fc<br>
 [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80<br> VM: killing process exe<br> swap_free: Bad swap file entry 62696e2f<br> swap_free: Bad swap file entry 026f7800<br> swap_free: Bad swap file entry 30c070c3<br> swap_free: Bad swap file entry b8df44b2<br> swap_free: Bad swap file entry c0df44b2<br> Bad pte = 5800000001, process = ???, vm_flags = 75, vaddr = fe12000<br> Call Trace:<br> [DFF97D28] [C000958C] show_stack+0x48/0x194 (unreliable)<br> [DFF97D58] [C00470CC] print_bad_pte+0x44/0x54<br> [DFF97D60] [C0047168] vm_normal_page+0x8c/0x94<br> [DFF97D68] [C004794C] unmap_vmas+0x424/0x5c8<br> [DFF97DF8] [C004CAC8] exit_mmap+0x60/0xec<br> [DFF97E18] [C0016C3C] mmput+0x50/0xd4<br> [DFF97E28] [C001B228] exit_mm+0x120/0x1a0<br> [DFF97E40] [C001B864] do_exit+0x11c/0x77c<br> [DFF97E78] [C000A2A4] do_page_fault+0x398/0x4fc<br> [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80<br> Eeek! page_mapcount(page) went negative! (-1)<br> &nbsp; page-&gt;flags = 400<br> &nbsp;
 page-&gt;count = 1<br> &nbsp; page-&gt;mapping = 00000000<br> kernel BUG in page_remove_rmap at mm/rmap.c:560!<br> Oops: Exception in kernel mode, sig: 5 [#1]<br> NIP: C004E620 LR: C004E698 CTR: 00000000<br> REGS: dff97ca8 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.2)<br> MSR: 00029000 &lt;EE,ME&gt;&nbsp; CR: 24022022&nbsp; XER: 00000000<br> TASK = df463000[610] 'exe' THREAD: dff96000<br> GPR00: C004E698 DFF97D58 DF463000 0000001E 00000FBC FFFFFFFF C0240000 C01F0C0C<br> GPR08: C01F0000 00000001 00000000 C0240000 00000000 10065ABC DFC46D10 0FF08FFF<br> GPR16: C0243C18 00000000 FFFFFFFF FFFFFFFF 00000000 0FF09000 DFD2AA50 DF4821FC<br> GPR24: 00000000 DFF97D74 A1FF0000 00000001 0FF09000 C0259000 0FE13000 C0259000<br> NIP [C004E620] page_remove_rmap+0x68/0xe4<br> LR [C004E698] page_remove_rmap+0xe0/0xe4<br> Call Trace:<br> [DFF97D58] [C004E698] page_remove_rmap+0xe0/0xe4 (unreliable)<br> [DFF97D68] [C004799C] unmap_vmas+0x474/0x5c8<br> [DFF97DF8] [C004CAC8]
 exit_mmap+0x60/0xec<br> [DFF97E18] [C0016C3C] mmput+0x50/0xd4<br> [DFF97E28] [C001B228] exit_mm+0x120/0x1a0<br> [DFF97E40] [C001B864] do_exit+0x11c/0x77c<br> [DFF97E78] [C000A2A4] do_page_fault+0x398/0x4fc<br> [DFF97F40] [C0001FE0] handle_page_fault+0xc/0x80<br> Instruction dump:<br> 83e1000c 38210010 7c0803a6 4e800020 801f0008 3c60c01c 3863d5e0 35200001<br> 41800034 813f0008 39290001 55290ffe &lt;0f090000&gt; 38600010 3880ffff 4bff07b1<br> Fixing recursive fault but reboot is needed!<br> <br> <br><b><i></i></b>Thanks<br> Junita<br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-438049822-1160776101=:71210--

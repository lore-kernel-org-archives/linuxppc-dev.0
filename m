Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 822B167BDC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Oct 2006 20:08:27 +1000 (EST)
Message-ID: <4520E511.7080706@gmail.com>
Date: Mon, 02 Oct 2006 11:08:17 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: linux-2.6 system ACE driver - need help
References: <20060921235929.70623.qmail@web8410.mail.in.yahoo.com>
In-Reply-To: <20060921235929.70623.qmail@web8410.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

agnel juni wrote:
> Jeff,
>
> I forgot to mention onething.
>
> The System ACE Base Address register is a 64-bit address.
>
> So we have done ioremap64, like
> ioremap64(0x4E0000000ULL, remap_size);
>
> Could this be a cause for the segmentation fault we are seeing ????
>
> Screen-dump from one  of our trials.
>
> # mount -t msdos /dev/xsysace1 /mnt/sysace/
> swap_dup: Bad swap file entry 7c0ff1f0
> VM: killing process exe
> swap_free: Bad swap file entry 6c0ff019
> swap_free: Bad swap file entry c80ff1ef
> swap_free: Bad swap file entry a80ff1f3
> swap_free: Bad swap file entry d00ff1ef
>
> thanks
> Junita
>
>
>
> */agnel juni <junijoseph@yahoo.co.in>/* wrote:
>
>     Hi Jeff,
>
>     Thanks for your reply.
>
>     > Does it work for you in polling mode? If not, you probably have a
>     problem with the way you are accessing the system ace - cache,
>     endianess, byte alignment, etc. If it does work in polling, the usual
>     suspects are interrupt masking errors or some low level problems with
>     your IRQ signals. Since you know the size of a sector and the size of
>     the sysace buffers, how many interrupts do you get per sector read? Do
>     you see extras or not enough?
>
>     I heard from Ameet Patil that this driver is not tested in
>     poilling mode and it failed when we tried also.
>     Thats when we moved to interrupt mode.
>
>     I did check for the endianess...byte alignment etc.It looks ok to me.
>
>     I am using a 64 MB flash. And the sector sice is 512K.When the
>     kernel boots up I see 128 interrupts getting registered. (I think
>     its from alloc_disk(16) function in adapter.c )
>
>     Seems like the driver has issues with completing the request.
>
>     We are having issues while mouting the device. It is erratic, that
>     sometimes we are able to mount/list files, copy files.
>
>     But sometimes the kernel crashes and gives a Ooops message like :
>
>     /*********************************************************/
>
>     # ls /mnt/Oops: kernel access of bad area, sig: 11 [#1]
>     NIP: C00556B8 LR: C00557E4 CTR: 00000000
>     REGS: dfec1e08 TRAP: 0300   Not tainted  (2.6.16.2)
>     MSR: 00021000 <ME>  CR: 22128828  XER: 00000000
>     DAR: 30303030, DSISR: 00800000
>     TASK = dff6c030[4] 'events/0' THREAD: dfec0000
>     GPR00: 00100100 DFEC1EB8 DFF6C030 C0258C60 DFF7BE10 00000018
>     DF4E9000 C0256D60
>     GPR08: 30303030 00200200 DF4E9154 30303030 22128888 00100400
>     1FFB9700 00000000
>     GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0
>     1FFCEF78 C01F0000
>     GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018
>     00000000 C0258C60
>     NIP [C00556B8] free_block+0xa8/0x148
>     LR [C00557E4] drain_array_locked+0x8c/0xd8
>     Call Trace:
>     [DFEC1EB8] [DFCA9490] 0xdfca9490 (unreliable)
>     [DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8
>     [DFEC1EF0] [C0056F80] cache_reap+0x74/0x18c
>     [DFEC1F28] [C002B578] run_workqueue+0x9c/0x110
>     [DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c
>     [DFEC1FC0] [C002F6F0] kthread+0xf4/0x130
>     [DFEC1FF0] [C000413C] kernel_thread+0x44/0x60
>     Instruction dump:
>     7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14
>     80c9001c
>     3d200020 61290200 81060004 81660000 <91680000> 910b0004 3966001c
>     90060000
>     BUG: events/0/4, lock held at task exit time!
>      [c01f5d60] {cache_chain_mutex}
>     .. held by:          events/0:    4 [dff6c030, 110]
>     ... acquired at:               cache_reap+0x1c/0x18c
>     /*******************************************************************/
>
>
>     We are able to do this after modiifying the file
>     xsysace_compactflash.c and xsysace_intr.c  to reset the
>     controller( It was commented out by applying the patch).
>
>     The data in the CF looks sane.
>
>     Please advise.
>
>     Thanks for your help.
>
>
>     Thanks
>     Junita
>
>         .
>
>         Does it work for you in polling mode? If not, you probably have a
>         problem with the way you are accessing the system ace - cache,
>         endianess, byte alignment, etc. If it does work in polling,
>         the usual
>         suspects are interrupt masking errors or some low level
>         problems with
>         your IRQ signals. Since you know the size of a sector and the
>         size of
>         the sysace buffers, how many interrupts do you get per sector
>         read? Do
>         you see extras or not enough?
>
>
>
>
>
>         > We are able to mount the CF, but it is very inconsistent.
>
>         Dump the sector data to the screen that you are reading from
>         the CF.
>         Especially look at the results from the initial identify
>         command to
>         verify that they make sense, and because that is the easiest
>         to check.
>
>         > Same is the case with fdisk command. When it fails,we get
>         errors which you could see in the screen-dump below.
>         > Are we missing to apply the right patch? Please let us know your
>         > inputs to go forward.
>         > Looking forwards for your reply.
>
>         >
>         > # mount -t msdos /dev/xsysace /root/cf
>
>         Shouldn't this be /dev/xsysace1? You want to mount a partition
>         not the
>         entire block device.
>
>
>         -- 
>         Jeff Angielski
>         The PTR Group
>
>
>     ------------------------------------------------------------------------
>     Find out what India is talking about on - Yahoo! Answers India
>     <http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/>
>
>     Send FREE SMS to your friend's mobile from Yahoo! Messenger
>     Version 8. Get it NOW
>     <http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com>_______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> ------------------------------------------------------------------------
> Find out what India is talking about on - Yahoo! Answers India 
> <http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/>
> Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. 
> Get it NOW 
> <http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com> 
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
Sorry Junita,
  I am busy with something else at the moment... hard deadline! Haven't 
checked my code yet to give you any feedback. Sorry!

-Ameet

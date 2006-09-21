Return-Path: <junijoseph@yahoo.co.in>
Received: from web8401.mail.in.yahoo.com (web8401.mail.in.yahoo.com
	[202.43.219.149]) by ozlabs.org (Postfix) with SMTP id 3590167B99
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 07:52:41 +1000 (EST)
Message-ID: <20060921215239.13694.qmail@web8401.mail.in.yahoo.com>
Date: Thu, 21 Sep 2006 22:52:38 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: linux-2.6 system ACE driver - need help
To: Jeff Angielski <jeff@theptrgroup.com>
In-Reply-To: <1158755925.8564.19.camel@sumo-jaa>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-162978987-1158875558=:13285"
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

--0-162978987-1158875558=:13285
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Jeff,

Thanks for your reply.

> Does it work for you in polling mode?  If not, you probably have a
problem with the way you are accessing the system ace - cache,
endianess, byte alignment, etc.  If it does work in polling, the usual
suspects are interrupt masking errors or some low level problems with
your IRQ signals.  Since you know the size of a sector and the size of
the sysace buffers, how many interrupts do you get per sector read?  Do
you see extras or not enough?

I heard from Ameet Patil that this driver is not tested in poilling mode and it failed when we tried also.
Thats when we moved to interrupt mode. 

I did check for the endianess...byte alignment etc.It looks ok to me.

I am using a 64 MB flash. And the sector sice is 512K.When the kernel boots up I see 128 interrupts getting registered. (I think its from alloc_disk(16) function in adapter.c )

Seems like the driver has issues with completing the request.

We are having issues while mouting the device. It is erratic, that sometimes we are able to mount/list files, copy files.

But sometimes the kernel crashes and gives a Ooops message like :

/*********************************************************/

# ls /mnt/Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00556B8 LR: C00557E4 CTR: 00000000
REGS: dfec1e08 TRAP: 0300   Not tainted  (2.6.16.2)
MSR: 00021000 <ME>  CR: 22128828  XER: 00000000
DAR: 30303030, DSISR: 00800000
TASK = dff6c030[4] 'events/0' THREAD: dfec0000
GPR00: 00100100 DFEC1EB8 DFF6C030 C0258C60 DFF7BE10 00000018 DF4E9000 C0256D60
GPR08: 30303030 00200200 DF4E9154 30303030 22128888 00100400 1FFB9700 00000000
GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78 C01F0000
GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018 00000000 C0258C60
NIP [C00556B8] free_block+0xa8/0x148
LR [C00557E4] drain_array_locked+0x8c/0xd8
Call Trace:
[DFEC1EB8] [DFCA9490] 0xdfca9490 (unreliable)
[DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8
[DFEC1EF0] [C0056F80] cache_reap+0x74/0x18c
[DFEC1F28] [C002B578] run_workqueue+0x9c/0x110
[DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c
[DFEC1FC0] [C002F6F0] kthread+0xf4/0x130
[DFEC1FF0] [C000413C] kernel_thread+0x44/0x60
Instruction dump:
7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14 80c9001c
3d200020 61290200 81060004 81660000 <91680000> 910b0004 3966001c 90060000
BUG: events/0/4, lock held at task exit time!
 [c01f5d60] {cache_chain_mutex}
.. held by:          events/0:    4 [dff6c030, 110]
... acquired at:               cache_reap+0x1c/0x18c
/*******************************************************************/


We are able to do this after modiifying the file xsysace_compactflash.c and xsysace_intr.c  to reset the controller( It was commented out by applying the patch).

The data in the CF looks sane.

Please advise.

Thanks for your help.


Thanks
Junita
.

Does it work for you in polling mode?  If not, you probably have a
problem with the way you are accessing the system ace - cache,
endianess, byte alignment, etc.  If it does work in polling, the usual
suspects are interrupt masking errors or some low level problems with
your IRQ signals.  Since you know the size of a sector and the size of
the sysace buffers, how many interrupts do you get per sector read?  Do
you see extras or not enough?





> We are able to mount the CF, but it is very inconsistent.

Dump the sector data to the screen that you are reading from the CF.
Especially look at the results from the initial identify command to
verify that they make sense, and because that is the easiest to check.

> Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.
> Are we missing to apply the right patch? Please let us know your
> inputs to go forward.
> Looking forwards for your reply.

> 
> # mount -t msdos /dev/xsysace /root/cf

Shouldn't this be /dev/xsysace1?  You want to mount a partition not the
entire block device.


-- 
Jeff Angielski
The PTR Group



 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-162978987-1158875558=:13285
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Jeff,<br><br>Thanks for your reply.<br><br>&gt; Does it work for you in polling mode?  If not, you probably have a<br>problem with the way you are accessing the system ace - cache,<br>endianess, byte alignment, etc.  If it does work in polling, the usual<br>suspects are interrupt masking errors or some low level problems with<br>your IRQ signals.  Since you know the size of a sector and the size of<br>the sysace buffers, how many interrupts do you get per sector read?  Do<br>you see extras or not enough?<br><br>I heard from Ameet Patil that this driver is not tested in poilling mode and it failed when we tried also.<br>Thats when we moved to interrupt mode. <br><br>I did check for the endianess...byte alignment etc.It looks ok to me.<br><br>I am using a 64 MB flash. And the sector sice is 512K.When the kernel boots up I see 128 interrupts getting registered. (I think its from alloc_disk(16) function in adapter.c )<br><br>Seems like the driver has issues with completing
 the request.<br><br>We are having issues while mouting the device. It is erratic, that sometimes we are able to mount/list files, copy files.<br><br>But sometimes the kernel crashes and gives a Ooops message like :<br><br>/*********************************************************/<br><br># ls /mnt/Oops: kernel access of bad area, sig: 11 [#1]<br>NIP: C00556B8 LR: C00557E4 CTR: 00000000<br>REGS: dfec1e08 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.2)<br>MSR: 00021000 &lt;ME&gt;&nbsp; CR: 22128828&nbsp; XER: 00000000<br>DAR: 30303030, DSISR: 00800000<br>TASK = dff6c030[4] 'events/0' THREAD: dfec0000<br>GPR00: 00100100 DFEC1EB8 DFF6C030 C0258C60 DFF7BE10 00000018 DF4E9000 C0256D60<br>GPR08: 30303030 00200200 DF4E9154 30303030 22128888 00100400 1FFB9700 00000000<br>GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3604 1FF63CE0 1FFCEF78 C01F0000<br>GPR24: C0240000 00100100 C0240000 00000000 DFF7BE10 00000018 00000000 C0258C60<br>NIP [C00556B8] free_block+0xa8/0x148<br>LR
 [C00557E4] drain_array_locked+0x8c/0xd8<br>Call Trace:<br>[DFEC1EB8] [DFCA9490] 0xdfca9490 (unreliable)<br>[DFEC1ED8] [C00557E4] drain_array_locked+0x8c/0xd8<br>[DFEC1EF0] [C0056F80] cache_reap+0x74/0x18c<br>[DFEC1F28] [C002B578] run_workqueue+0x9c/0x110<br>[DFEC1F48] [C002B6E4] worker_thread+0xf8/0x13c<br>[DFEC1FC0] [C002F6F0] kthread+0xf4/0x130<br>[DFEC1FF0] [C000413C] kernel_thread+0x44/0x60<br>Instruction dump:<br>7cfbfa14 3c000010 80e70014 3d2a4000 60000100 5529c9f4 7d295a14 80c9001c<br>3d200020 61290200 81060004 81660000 &lt;91680000&gt; 910b0004 3966001c 90060000<br>BUG: events/0/4, lock held at task exit time!<br>&nbsp;[c01f5d60] {cache_chain_mutex}<br>.. held by:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; events/0:&nbsp;&nbsp;&nbsp; 4 [dff6c030, 110]<br>... acquired at:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 cache_reap+0x1c/0x18c<br>/*******************************************************************/<br><br><br>We are able to do this after modiifying the file xsysace_compactflash.c and xsysace_intr.c&nbsp; to reset the controller( It was commented out by applying the patch).<br><br>The data in the CF looks sane.<br><br>Please advise.<br><br>Thanks for your help.<br><br><br>Thanks<br>Junita<br><b><i></i></b><blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">.<br><br>Does it work for you in polling mode?  If not, you probably have a<br>problem with the way you are accessing the system ace - cache,<br>endianess, byte alignment, etc.  If it does work in polling, the usual<br>suspects are interrupt masking errors or some low level problems with<br>your IRQ signals.  Since you know the size of a sector and the size of<br>the sysace buffers, how many interrupts do you get per sector read?  Do<br>you see extras or not
 enough?<br><br><br><br><br><br>&gt; We are able to mount the CF, but it is very inconsistent.<br><br>Dump the sector data to the screen that you are reading from the CF.<br>Especially look at the results from the initial identify command to<br>verify that they make sense, and because that is the easiest to check.<br><br>&gt; Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.<br>&gt; Are we missing to apply the right patch? Please let us know your<br>&gt; inputs to go forward.<br>&gt; Looking forwards for your reply.<br><br>&gt; <br>&gt; # mount -t msdos /dev/xsysace /root/cf<br><br>Shouldn't this be /dev/xsysace1?  You want to mount a partition not the<br>entire block device.<br><br><br>-- <br>Jeff Angielski<br>The PTR Group<br><br></blockquote><br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-162978987-1158875558=:13285--

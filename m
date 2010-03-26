Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F4A7B7C48
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 20:14:03 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2Q8Scl0023140
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 13:58:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2Q9Dw6k852074
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 14:43:58 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2Q9DvuW022882
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 20:13:58 +1100
Message-ID: <4BAC7AD4.4030309@in.ibm.com>
Date: Fri, 26 Mar 2010 14:43:56 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
In-Reply-To: <20100324121902.GJ15789@amit-x200.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Amit Shah wrote:
> On (Sun) Mar 21 2010 [10:07:25], Amit Shah wrote:
>   
>> On (Sun) Mar 21 2010 [08:04:39], Benjamin Herrenschmidt wrote:
>>     
>>> On Fri, 2010-03-19 at 08:18 -0700, Greg Kroah-Hartman wrote:
>>>       
>>>> From: Amit Shah <amit.shah@redhat.com>
>>>>
>>>> Alan pointed out a race in the code where hvc_remove is invoked. The
>>>> recent virtio_console work is the first user of hvc_remove().
>>>>         
>>> This causes hangs during boot on pseries machines. Haven't had a chance
>>> to track that down yet, but please revert
>>> e74d098c66543d0731de62eb747ccd5b636a6f4c for now.
>>>       
<SNIP>

>
>
> And this suggests that hvc_kick() is called before hvc_task is
> initialised, ie, before hvc_init() is called.
>
> Does this help?
>   
Hi Amit,

I too ran into this issue as reported by Anton. Unfortunately in my
case the following suggested patch does not help boot the powerpc
box successfully. The boot still hangs with following messages

/dev/sda5: clean, 229739/2097152 files, 2485598/8377888 blocks (check in 4 mounts)
fsck succeeded. Mounting root device read-write.
Mounting root /dev/sda5
mount -o rw,acl,user_xattr -t ext3 /dev/sda5 /root
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda5): using internal journal
EXT3-fs (sda5): mounted filesystem with writeback data mode
mount: can't find /root/proc in /etc/fstab or /etc/mtab
/sbin/smart_agetty: can not determine 'console' speed


Just to confirm i too am facing same issue as reported by Anton,
reverted commit e74d098c66543d0731de62eb747ccd5b636a6f4c and that allowed
by box to boot successfully.

Thanks
-Sachin

> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index ba55bba..50ac983 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -285,6 +285,9 @@ EXPORT_SYMBOL_GPL(hvc_instantiate);
>  /* Wake the sleeping khvcd */
>  void hvc_kick(void)
>  {
> +       if (!hvc_task)
> +               return;
> +
>         hvc_kicked = 1;
>         wake_up_process(hvc_task);
>  }
>
> 		Amit
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

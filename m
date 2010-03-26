Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95DC9B7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 22:42:28 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2QBd9Qe026279
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 22:39:09 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2QBaKNf1597564
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 22:36:20 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2QBgQr4013410
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 22:42:27 +1100
Message-ID: <4BAC9D9E.5070901@in.ibm.com>
Date: Fri, 26 Mar 2010 17:12:22 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
	<20100326095821.GA7039@amit-x200.redhat.com>
In-Reply-To: <20100326095821.GA7039@amit-x200.redhat.com>
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
> On (Fri) Mar 26 2010 [14:43:56], Sachin Sant wrote:
>   
>>> And this suggests that hvc_kick() is called before hvc_task is
>>> initialised, ie, before hvc_init() is called.
>>>
>>> Does this help?
>>>   
>>>       
>> Hi Amit,
>>
>> I too ran into this issue as reported by Anton. Unfortunately in my
>> case the following suggested patch does not help boot the powerpc
>> box successfully. The boot still hangs with following messages
>>     
>
> Was the hang you saw before applying this patch at the same place / for
> the same reason?
>   
Yes the machine hangs at the same place with or without the patch.

>> mount: can't find /root/proc in /etc/fstab or /etc/mtab
>> /sbin/smart_agetty: can not determine 'console' speed
>>     
>
> OK, this gets even murkier. I don't know why taking a few krefs modifies
> hvc_console behaviour to such an extent.
>   
Looking at the commit e74d098c66543d0731de62eb747ccd5b636a6f4c,
i see that for every tty_kref_get() there is a corresponding
tty_kref_put() except maybe for the one in the following patch snippet

        spin_lock_irqsave(&hp->lock, flags);
        /* Check and then increment for fast path open. */
        if (hp->count++ > 0) {
+               tty_kref_get(tty);
                spin_unlock_irqrestore(&hp->lock, flags);
                hvc_kick();
                return 0;

I don't know this code very well but we might be missing a
corresponding tty_kref_put() some place ?

If i comment out the above tty_kref_get() call, the machine
boots fine with or without the suggested patch.

Thanks
-Sachin


>   
>> Just to confirm i too am facing same issue as reported by Anton,
>> reverted commit e74d098c66543d0731de62eb747ccd5b636a6f4c and that allowed
>> by box to boot successfully.
>>     
>
> Which module uses hvc_console in your case?
>
> 		Amit
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

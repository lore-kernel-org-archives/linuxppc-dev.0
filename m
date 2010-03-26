Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 8D97AB7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 21:00:45 +1100 (EST)
Date: Fri, 26 Mar 2010 15:28:21 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100326095821.GA7039@amit-x200.redhat.com>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BAC7AD4.4030309@in.ibm.com>
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

On (Fri) Mar 26 2010 [14:43:56], Sachin Sant wrote:
>> And this suggests that hvc_kick() is called before hvc_task is
>> initialised, ie, before hvc_init() is called.
>>
>> Does this help?
>>   
> Hi Amit,
>
> I too ran into this issue as reported by Anton. Unfortunately in my
> case the following suggested patch does not help boot the powerpc
> box successfully. The boot still hangs with following messages

Was the hang you saw before applying this patch at the same place / for
the same reason?

> /dev/sda5: clean, 229739/2097152 files, 2485598/8377888 blocks (check in 4 mounts)
> fsck succeeded. Mounting root device read-write.
> Mounting root /dev/sda5
> mount -o rw,acl,user_xattr -t ext3 /dev/sda5 /root
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (sda5): using internal journal
> EXT3-fs (sda5): mounted filesystem with writeback data mode
> mount: can't find /root/proc in /etc/fstab or /etc/mtab
> /sbin/smart_agetty: can not determine 'console' speed

OK, this gets even murkier. I don't know why taking a few krefs modifies
hvc_console behaviour to such an extent.

> Just to confirm i too am facing same issue as reported by Anton,
> reverted commit e74d098c66543d0731de62eb747ccd5b636a6f4c and that allowed
> by box to boot successfully.

Which module uses hvc_console in your case?

		Amit

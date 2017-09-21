Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyXWn15kZzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 20:13:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Landley <rob@landley.net>, Christophe LEROY <christophe.leroy@c-s.fr>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, mhocko@suse.com, peterz@infradead.org,
 viresh.kumar@linaro.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 mingo@kernel.org, lokeshvutla@ti.com,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linux-input@vger.kernel.org,
 thomas.lendacky@amd.com, lauraa@codeaurora.org, keescook@chromium.org,
 Jiri Kosina <jikos@kernel.org>, rostedt@goodmis.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
In-Reply-To: <d6a5ba05-5de2-24e0-49ae-437058001b37@landley.net>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
 <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
 <87r2z86ykt.fsf@concordia.ellerman.id.au>
 <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
 <3ba5ddc7-d1a2-7f54-0a26-0752f3975226@c-s.fr>
 <d6a5ba05-5de2-24e0-49ae-437058001b37@landley.net>
Date: Thu, 21 Sep 2017 20:13:55 +1000
Message-ID: <878th8cqak.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Landley <rob@landley.net> writes:

> On 09/14/2017 04:17 AM, Christophe LEROY wrote:
>> Le 14/09/2017 =C3=A0 01:51, Rob Landley a =C3=A9crit :
>>> From: Rob Landley <rob@landley.net>
>>>
>>> Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
>>> /dev/console open after devtmpfs mount.
>>>
>>> Add workaround for Debian bug that was copied by Ubuntu.
>>=20
>> Is that a bug only for Debian ? Why ?
>
> Look down, specifically this bit:
>
>>> v2 discussion:
>>> http://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html
>
> That's some discussion of version 2 of this patch, which was merged for
> a while last dev cycle, then backed out again because it triggered the
> same bug in a number of system init scripts:
>
>   http://lkml.iu.edu/hypermail/linux/kernel/1705.2/07072.html
>   http://lkml.iu.edu/hypermail/linux/kernel/1705.3/01182.html
>   http://lkml.iu.edu/hypermail/linux/kernel/1705.3/01505.html
>   http://lkml.iu.edu/hypermail/linux/kernel/1705.3/01320.html
>
> All of whom copied the broken error "recovery" path from debian. If they
> checked whether it was already mounted, or didn't _blank_ the /dev
> directory in response to mounting the exact same filesystem over itself
> giving -EBUSY, the system would work fine. Heck, if you built a kernel
> with a static /dev in initramfs and no devtmpfs configured in, the
> script would break things exactly the same way. The breakage is that
> script takes a hammer to a perfectly functional /dev directory and then
> continues the boot with an empty /dev. That's bonkers.
>
>> Why should a Debian bug be fixed by a workaround in the mainline kernel ?
>
> That was my argument last time, and the answer was "Breaking userspace
> is bad, mmmkay." Even when userspace is doing something REALLY OBVIOUSLY
> STUPID and it is _clearly_ their fault, as long as they got there first
> they've established the status quo and it doesn't matter how silly it is.
>
> This was explicitly stated to me here:
>
>   http://lkml.iu.edu/hypermail/linux/kernel/1705.3/03292.html
>
> I.E. don't argue with me, argue with him. :)

I'm still here. And I'm still right :)

No one wants their system to stop booting because of this obscure
functionality.

Just put it behind a new config option which defaults off. No
workarounds required, no broken systems, no long email threads required.

cheers

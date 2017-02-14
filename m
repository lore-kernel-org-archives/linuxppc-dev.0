Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNK144HxTzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 10:50:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: xinhui.pan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
In-Reply-To: <8ddc4a78-4dd9-40df-2f00-503b4ff204b0@linux.vnet.ibm.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20170214123540.38b995cb@roar.ozlabs.ibm.com>
 <559244cc-dcc0-a477-b51b-7417a61158ed@linux.vnet.ibm.com>
 <8ddc4a78-4dd9-40df-2f00-503b4ff204b0@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 10:50:29 +1100
Message-ID: <87h93wl4ca.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> On 14/02/2017 01:58, Pan Xinhui wrote:
>> =E5=9C=A8 2017/2/14 10:35, Nicholas Piggin =E5=86=99=E9=81=93:
>>> On Mon, 13 Feb 2017 19:00:42 -0200
>>>
>>> xmon state changing after the first sysrq+x violates principle of least
>>> astonishment, so I think that should be fixed.
>>>
>> hi, Nick
>> yes, as long as xmon is disabled during boot, it should still be disable=
d after existing xmon.
>> My patch does not fix that as it need people add one more char 'z' follo=
wing 'x'.
>> I will provide a new patch to fix that.
>>=20
>>> Then the question is, is it worth making it runtime configurable with x=
mon
>>> command or debugfs tunables?
>>>
>> They are options for people to turn xmon features on or off. Maybe peopl=
e needn't this.
>> However I am not a fan  of debugfs this time as I am used to using xmon =
cmds. :)
>>=20
>> Hi, Guilherme
>> So in the end, my thought is that: 1) cmd x|X will exit xmon and keep xm=
on in the original state(indicated by var xmon_off).
>> 2) Then add options to turn some features on/off. And debugfs maybe not =
fit for this. But I am also wondering at same time, are people needing this?
>
> Hi Nick and Xinhui, thanks very much for the feedback.
> I agree, we should keep xmon in the state it was firstly set, on boot
> time - dropping to the debugger using sysrq shouldn't change it.
>
> Now, the use case of the debugfs approach is to allow user to
> enable/disable xmon without need to drop into the debugger itself, or
> reboot the machine.
> Imagine a scenario in which we have a production machine, and:
>
>
> i) For some reason, somebody kept xmon enabled on grub.cfg and now, we
> want to let kdump work in case of crash - how to disable xmon in runtime?
>
> ii) The opposite: xmon wasn't enable on boot time in production machine,
> but we have a super-rare issue and want to drop to xmon next time it
> happens, so we need to enable it. But we don't want to drop into the
> debugger to force it gets enabled, so how do we enable it?

Yep. I think both of those are good reasons to add a debugfs file.

> Regarding the place of the xmon state file, I believe debugfs is the
> right place - where else could we add it? procfs? configfs?

debugfs, under powerpc_debugfs_root.

cheers

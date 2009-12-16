Return-Path: <xtfeng@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 81B15B6F19
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:56:02 +1100 (EST)
Received: by pwi20 with SMTP id 20so463595pwi.9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 22:56:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B279370.5050800@in.ibm.com>
References: <4B2224C7.1020908@in.ibm.com> <1260786122.4165.142.camel@twins>
	<4B261D7A.9040802@in.ibm.com> <1260793182.4165.223.camel@twins>
	<1260825420.2217.40.camel@pasglop> <4B275A6B.9030200@in.ibm.com>
	<1260873827.4165.362.camel@twins> <4B279370.5050800@in.ibm.com>
Date: Wed, 16 Dec 2009 14:56:01 +0800
Message-ID: <7b6bb4a50912152256j58cdc8f6u7fc0f38c60281dc8@mail.gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Xiaotian Feng <xtfeng@gmail.com>
To: Sachin Sant <sachinp@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 15, 2009 at 9:47 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Peter Zijlstra wrote:
>>>
>>> I added some debug statements within the above code. This is a 2 cpu
>>> machine.
>>>
>>> XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_ids =3D 2
>>> XMON dest_cpu =3D 1024 XMON dest_cpu =3D 1024 . dead_cpu =3D 1
>>> XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_ids =3D 2
>>> XMON dest_cpu =3D 1024 XMON dest_cpu =3D 1024 . dead_cpu =3D 1
>>> XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_ids =3D 2
>>> XMON dest_cpu =3D 1024 XMON dest_cpu =3D 1024 . dead_cpu =3D 1
>>>
>>> Seems to me that the control is stuck in an infinite loop and hence the
>>> machine appears to be in hung state. The dest_cpu value is always 1024
>>> and never changes, which result in an infinite loop.
>>>
>>> In working scenario the o/p is something on the following lines
>>>
>>> XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_ids =3D 2
>>> XMON dest_cpu =3D 0 XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_id=
s =3D 2
>>> XMON dest_cpu =3D 0 XMON dest_cpu =3D 1024 . dead_cpu =3D 1 . nr_cpu_id=
s =3D 2
>>> XMON dest_cpu =3D 0
>>> Let me know if i should try to record any specific value ?
>>>
>>
>> Could you possibly print the two masks themselves? cpumask_scnprintf()
>> and friend come in handy for this.
>>
>> The dest_cpu=3D1024 thing seem to suggest the intersection between
>> p->cpus_allowed and cpu_active_mask is empty for some reason, even
>> though we forcefully reset p->cpus_allowed to the full set using
>> cpuset_cpus_allowed_locked().
>>
>
> So here is the data related to the two masks.
>
> cpu_active_mask =3D 00000000,00000000,00000000,00000000,00000000,00000000=
,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000
> XMON dest_cpu =3D 1024
>

How about cpu_online_mask? commit 6ad4c1 switches from cpu_online_mask
to cpu_active_mask.
Is there a mismatch for cpu_online_mask and cpu_active_mask?

> while p->cpus_allowed =3D =C2=A000000000,00000000,00000000,00000000,00000=
000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000001
> XMON dest_cpu =3D 1024
>
> In working scenario the above data looks like
>
> cpu_active_mask =3D 00000000,00000000,00000000,00000000,00000000,00000000=
,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000002
> XMON dest_cpu =3D 1
>
> while p->cpus_allowed =3D =C2=A000000000,00000000,00000000,00000000,00000=
000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,
> 00000000,00000000,00000002
> XMON dest_cpu =3D 1
>
>
> hope i got the data correct.
>
> Thanks
> -Sachin
>
>
> --
>
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

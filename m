Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hgbG1K45zF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 18:44:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
In-Reply-To: <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
 <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
Date: Fri, 03 Aug 2018 18:44:54 +1000
Message-ID: <87pnyzhm9l.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 03/08/2018 =C3=A0 02:42, Murilo Opsfelder Araujo a =C3=A9crit=C2=A0:
>> Hi, Christophe.
>> On Thu, Aug 02, 2018 at 07:26:20AM +0200, Christophe LEROY wrote:
>>> Le 01/08/2018 =C3=A0 23:33, Murilo Opsfelder Araujo a =C3=A9crit=C2=A0:
>>>> show_user_instructions() is a slightly modified version of
>>>> show_instructions() that allows userspace instruction dump.
>>>>
>>>> This will be useful within show_signal_msg() to dump userspace
>>>> instructions of the faulty location.
>>>>
>>>> Here is a sample of what show_user_instructions() outputs:
>>>>
>>>>     pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1f=
ff8 f821ffc1 7c3f0b78 3d22fffe
>>>>     pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <9949=
0000> 39200000 7d234b78 383f0040
>>>>
>>>> The current->comm and current->pid printed can serve as a glue that
>>>> links the instructions dump to its originator, allowing messages to be
>>>> interleaved in the logs.
>>>>
>>>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proce=
ss.c
>>>> index e9533b4d2f08..364645ac732c 100644
>>>> --- a/arch/powerpc/kernel/process.c
>>>> +++ b/arch/powerpc/kernel/process.c
>>>> @@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *r=
egs)
>>>>    	pr_cont("\n");
>>>>    }
>>>> +void show_user_instructions(struct pt_regs *regs)
>>>> +{
>>>> +	int i;
>>>> +	const char *prefix =3D KERN_INFO "%s[%d]: code: ";
>>>> +	unsigned long pc =3D regs->nip - (instructions_to_print * 3 / 4 *
>>>> +					sizeof(int));
>>>> +
>>>> +	printk(prefix, current->comm, current->pid);
>>>
>>> Why not use pr_info() and remove KERN_INFO from *prefix ?
>>=20
>> Because it doesn't compile:
>>=20
>>    arch/powerpc/kernel/process.c:1317:10: error: expected =E2=80=98)=E2=
=80=99 before =E2=80=98prefix=E2=80=99
>>      pr_info(prefix, current->comm, current->pid);
>>              ^
>>    ./include/linux/printk.h:288:21: note: in definition of macro =E2=80=
=98pr_fmt=E2=80=99
>>     #define pr_fmt(fmt) fmt
>>                       ^
>>=20
>> `pr_info(prefix, ...)` expands to `printk("\001" "6" prefix, ...)`,
>> which is an invalid string concatenation.
>>=20
>> `pr_info("%s", ...)` expands to `printk("\001" "6" "%s", ...)`, which is
>> valid.
>
> Then what about using directly:
>
> pr_info("%s[%d]: code: ", ...);

Yeah that's better, I'll fix it up when applying.

>>>> +#if !defined(CONFIG_BOOKE)
>>>> +		/* If executing with the IMMU off, adjust pc rather
>>>> +		 * than print XXXXXXXX.
>>>> +		 */
>>>> +		if (!(regs->msr & MSR_IR))
>>>> +			pc =3D (unsigned long)phys_to_virt(pc);
>>>
>>> Shouldn't this be done outside of the loop, only once ?
>>=20
>> I don't think so.
>>=20
>> pc gets incremented at the bottom of the loop:
>>=20
>>    pc +=3D sizeof(int);
>>=20
>> Adjusting pc is necessary at each iteration.  Leaving this block inside
>> the loop seems correct.
>
> This looks pretty strange.
> The first time, pc is a physical address, that you change to a virtual=20
> address. Then when you increment it it is still a virtual address.
> So when you call phys_to_virt(pc) for the second time, pc is already a=20
> virt address, so what happens indeed ?

Yeah that's a bit fishy.

On 64-bit it works because phys_to_virt() =3D=3D __va() which is:

  #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) | PAGE_OFFSET))

ie. it uses bitwise or, so __va(__va(x)) =3D=3D __va(x).

But it looks like on 32-bit it's going to do the wrong thing. Do we ever
actually hit that case though, I'm not sure?


However for this patch I'll just remove the whole thing, because we
don't expect to be dumping user instructions in realmode.

cheers

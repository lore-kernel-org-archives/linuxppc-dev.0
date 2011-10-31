Return-Path: <santoshkumar.a@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
 [74.125.82.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 35961B6F7C
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 18:38:14 +1100 (EST)
Received: by wyf23 with SMTP id 23so5997851wyf.15
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 00:38:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
 <12144.1320040276@neuling.org>
 <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
Date: Mon, 31 Oct 2011 13:08:09 +0530
Message-ID: <CAJw04pC6ZPpO8xvybjLH0ya9eKBKAkpf8N3gDTMpFnpTuhJs2A@mail.gmail.com>
Subject: Re: powerpc 476, Little-endian, pte fault
From: Santosh Kumar <santoshkumar.a@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not the first user-space instruction. While executing this
process kernel has added two TLB entries with TID(process id) 1. while
trying to map 0x100000fc it is raising pte faults .

Santosh Kumar .A

Vision without Action is a daydream... Action without Vision is a nightmare=
...



On 31 October 2011 12:05, Santosh Kumar <santoshkumar.a@gmail.com> wrote:
> I have built a cross compiler for ppc440 in little endian mode and
> using it to build the kernel.
>
> Yes i am running Linux in Little-Endian. This is the first user space
> process. I wrote the below program and running it as init from
> /sbin/init. I have also set the permissions with chmod +s.
>
> main()
> {
>
> while(1){
> printf("hello world");
> sleep(1);
> =A0}
> }
>
> I have attached the patch.
>
> -
> Santosh Kumar .A
>
> Vision without Action is a daydream... Action without Vision is a nightma=
re...
>
>
>
> On 31 October 2011 11:21, Michael Neuling <mikey@neuling.org> wrote:
>> Adding linuxppc-dev list to the CC
>>
>>> KERNEL: linux 2.6.39.4
>>> POWERPC: 476, little endian.
>>>
>>> I am trying to get linux 2.6.39.4 up on PPC 476 i have done done
>>> Big-endian to little endian Changes in:
>>
>> Can you explain what you are trying to do in more detail? =A0What does "=
i
>> have done Big-endian to little endian Changes" mean?
>>
>>> 1) bitops header file.
>>> 2) while reading the device tree.
>>> 3) the PTE read/computed in head_32.S
>>> 4) added E bit in the TLB entries.
>>>
>>> with all the above changes the kernel_init is done but and inited is
>>> mounted.
>>
>> Can you post your patch?
>>
>> Are you trying to boot the kernel in little endian or just run userspace
>> in little endian?
>>
>>> But while spawning init process the kernel continuously hits pte
>>> faults at address 0x100000fc and never comes out. Please let me know
>>> where i should be looking into.
>>
>> Is this the very first userspace instruction?
>>
>> Mikey
>>
>>
>

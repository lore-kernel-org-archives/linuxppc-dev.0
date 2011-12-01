Return-Path: <jhautbois@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
 [209.85.215.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4A3E8B6F68
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 02:05:22 +1100 (EST)
Received: by eaak13 with SMTP id k13so2515624eaa.15
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2011 07:05:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
References: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
 <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Date: Thu, 1 Dec 2011 16:04:57 +0100
Message-ID: <CAL8zT=gGfBYsLcsKobJPhfhEhNeLcrYMoWh2kv0odT0n0wnZgQ@mail.gmail.com>
Subject: Re: Different behaviour when using "nosmp" parameter on SMP and UP
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/12/1 Kumar Gala <galak@kernel.crashing.org>:
>
> On Dec 1, 2011, at 3:57 AM, Jean-Michel Hautbois wrote:
>
>> Hi,
>>
>> I have a P2020 CPU (powerpc) and I compiled it with two different defcon=
figs.
>> The first one is a SMP, 2 cores, launched with the "nosmp" kernel
>> parameter, the other one is an UP kernel.
>>
>> My driver behaviour is not the same whether launching one or the
>> other. It is hard to explain more precisely, as it deals only with
>> ioctl which only does ioread32/iowrite32 on a PCIe device.
>> But I can tell that it never works the same way when UP (not working
>> correctly), or SMP "nosmp" (working) or even SMP (not working).
>>
>> AFAIK, the "nosmp" parameter should tell the kernel to act the same is
>> if it is an UP kernel, and it disables IO APIC, which is not an issue
>> in my case.
>>
>> Can you think about anything that would explain it, or would help me
>> debugging it ?
>
> This is a bit odd, hard to say w/o more details on what exactly your code=
 is trying to do and wait the failure is.

I understand that it is difficult to give more details, but the driver
is not mine, and I can't give all the code associated.

> The larger differences between SMP & UP build would be setting of memory =
attribute for cache coherency. =C2=A0In UP case we don't set it.
>
> Between SMP 'nosmp' and SMP 'on' cases you seem like you're hitting some =
locking condition.
>
> Guessing your running into a timing & locking issue that you're getting l=
ucky on the SMP 'nosmp' case such that it just happens to work.

Any idea on how to debug this ? I am using a 2.6.35 kernel.

Thanks,
JM

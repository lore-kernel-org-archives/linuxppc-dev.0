Return-Path: <pku.leo@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id CBB45B7C0E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 17:15:06 +1100 (EST)
Received: by pwi5 with SMTP id 5so59241pwi.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Dec 2009 22:15:05 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <0CED0757-67E3-4EAD-A2F7-AB8553559E94@kernel.crashing.org>
References: <1259663450-28790-1-git-send-email-leoli@freescale.com>
	<1259665127.2076.363.camel@pasglop>
	<2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
	<E389CC83-307F-4A7D-B90B-CD928A1D1D1D@kernel.crashing.org>
	<2a27d3730912012225h3deab5dao2211bc404d247192@mail.gmail.com>
	<0CED0757-67E3-4EAD-A2F7-AB8553559E94@kernel.crashing.org>
Date: Thu, 3 Dec 2009 14:15:05 +0800
Message-ID: <2a27d3730912022215t3f575a24uc66e22fd653d8f3c@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: setting mmaped page cache property through
	device tree
From: Li Yang <leoli@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 3, 2009 at 12:15 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>>> The scenario for the first case is that in a multicore system running
>>>> ASMP which means different OS runs on different cores. =C2=A0They migh=
t
>>>> communicate through a shared memory region. =C2=A0The region on every =
OS
>>>> need to be mapped with the same cache perperty to avoid cache paradox.
>>>
>>> This isn't true. =C2=A0In ASMP, you cannot usually do coherency between
>>> the different CPUs at all. =C2=A0Also, in most PowerPC implementations,
>>
>> Coherency can't be achieved with proper configuration and management? =
=C2=A0Why
>> so?
>
> Because different CPUs do not usually speak the same coherency protocol.
>
> However, it occurred to me that what you call ASMP is actually SMP where
> you run different OSes on the various cores?
>

Yup.  There might be some confusion on the ASMP definition.  But with
multi-core common in the market, new ASMP system may run on SMP-like
hardware.

>>> it is fine if one CPU maps a memory range as coherent while another
>>> maps it as non-coherent; sure, you have to be careful or you will
>>
>> But we do want the shared region to be coherent. =C2=A0So mappings shoul=
d
>> have the same cacheability property.
>
> No, they only need WIMG=3Dxx1x on both sides. =C2=A0Of course, IM=3D11 mi=
ght not
> be a valid combination on your particular CPU, and it probably is better
> for performance to have the RAM cacheable anyway.

Agreed.  This patch also makes M bit configurable.

>
>>> So make the memory known to the kernel, just tell the kernel not to
>>> use it. =C2=A0If it's normal system RAM, just put it in the "memory" no=
de
>>> and do a memreserve on it (or do something in your platform code); if
>>> it's some other memory, do a device driver for it, map it there.
>>
>> Your solution is feasible. =C2=A0But the memory allocation is a software
>> configuration. =C2=A0IMHO, it should be better and easier addressed by
>> changing configurations(like mem parameter) rather than the kernel
>> platform code which should address hardware configuration.
>
> Either platform code or some other boot-time code, sure.
>
> The point is, you put the RAM in the device tree, so the kernel can
> know that particular range of physical address space is RAM, even
> if it doesn't use it itself.

If device tree always pass all the memory available, we need to
implement memmap=3D kernel cmdline parameter for powerpc in case the
memory used isn't start at address 0.  Maybe it's better that all
these information be passed with kernel parameter rather than device
tree for cross architecture portability.  What do you think?

- Leo

Return-Path: <pku.leo@gmail.com>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179]) by ozlabs.org (Postfix) with ESMTP id 210FCB7B6A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 17:25:51 +1100 (EST)
Received: by pzk9 with SMTP id 9so4180042pzk.16
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Dec 2009 22:25:47 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <E389CC83-307F-4A7D-B90B-CD928A1D1D1D@kernel.crashing.org>
References: <1259663450-28790-1-git-send-email-leoli@freescale.com>
	<1259665127.2076.363.camel@pasglop>
	<2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
	<E389CC83-307F-4A7D-B90B-CD928A1D1D1D@kernel.crashing.org>
Date: Wed, 2 Dec 2009 14:25:47 +0800
Message-ID: <2a27d3730912012225h3deab5dao2211bc404d247192@mail.gmail.com>
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

On Tue, Dec 1, 2009 at 10:35 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> The scenario for the first case is that in a multicore system running
>> ASMP which means different OS runs on different cores. =C2=A0They might
>> communicate through a shared memory region. =C2=A0The region on every OS
>> need to be mapped with the same cache perperty to avoid cache paradox.
>
> This isn't true. =C2=A0In ASMP, you cannot usually do coherency between
> the different CPUs at all. =C2=A0Also, in most PowerPC implementations,

Coherency can't be achieved with proper configuration and management?  Why =
so?

> it is fine if one CPU maps a memory range as coherent while another
> maps it as non-coherent; sure, you have to be careful or you will

But we do want the shared region to be coherent.  So mappings should
have the same cacheability property.

> read stale data, but things won't wedge.
>
>> The scenario for the second case is to pre-allocate some memory to a
>> certain application or device (probably through mem=3DXXX kernel
>> parameter or limit through device tree). =C2=A0The memory is not known t=
o
>> kernel, but fully managed by the application/device. =C2=A0We need being
>> able to map the region cachable for better performance.
>
> So make the memory known to the kernel, just tell the kernel not to
> use it. =C2=A0If it's normal system RAM, just put it in the "memory" node
> and do a memreserve on it (or do something in your platform code); if
> it's some other memory, do a device driver for it, map it there.

Your solution is feasible.  But the memory allocation is a software
configuration.  IMHO, it should be better and easier addressed by
changing configurations(like mem parameter) rather than the kernel
platform code which should address hardware configuration.

- Leo

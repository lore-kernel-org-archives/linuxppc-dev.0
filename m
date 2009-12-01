Return-Path: <pku.leo@gmail.com>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 7E2C7B6F12
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 22:34:02 +1100 (EST)
Received: by pzk29 with SMTP id 29so3625546pzk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Dec 2009 03:34:01 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1259665127.2076.363.camel@pasglop>
References: <1259663450-28790-1-git-send-email-leoli@freescale.com>
	<1259665127.2076.363.camel@pasglop>
Date: Tue, 1 Dec 2009 19:34:01 +0800
Message-ID: <2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: setting mmaped page cache property through
	device tree
From: Li Yang <leoli@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 1, 2009 at 6:58 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-12-01 at 18:30 +0800, Li Yang wrote:
>> The patch adds the ability for powerpc architecture to set page cache
>> property of mmaped area through device tree. =C2=A0This is useful for tw=
o
>> cases. =C2=A0First, for memory shared with other OS'es to have the same =
cache
>> property to avoid cache paradoxes. =C2=A0Second, enabling application to=
 map
>> memory which is not managed by kernel as cacheable for better performanc=
e.
>
> But that doesn't solve the problem of those same pages being mapped
> cachable as part of the linear mapping does it ?

I think that it doesn't has this problem.  Only regions out of
lmb.memory are configurable through device tree.

>
> Can you tell us more about your precise usage scenario ? What are you

The scenario for the first case is that in a multicore system running
ASMP which means different OS runs on different cores.  They might
communicate through a shared memory region.  The region on every OS
need to be mapped with the same cache perperty to avoid cache paradox.

The scenario for the second case is to pre-allocate some memory to a
certain application or device (probably through mem=3DXXX kernel
parameter or limit through device tree).  The memory is not known to
kernel, but fully managed by the application/device.  We need being
able to map the region cachable for better performance.

> trying to achieve here ? We can find a solution though it might involve
> a specific driver to handle that memory.

Right, but what the user to kernel API should be used?  Is it ok to
use the O_SYNC flag as I previously proposed?

- Leo

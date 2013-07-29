Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F09C2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 09:10:50 +1000 (EST)
Date: Mon, 29 Jul 2013 18:10:36 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
To: Chris Friesen <cbf123@mail.usask.ca>
In-Reply-To: <51E0F41A.20904@mail.usask.ca> (from cbf123@mail.usask.ca on
 Sat Jul 13 01:30:50 2013)
Message-ID: <1375139436.30721.63@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2013 01:30:50 AM, Chris Friesen wrote:
> On 07/12/2013 04:59 PM, Chris Friesen wrote:
>> On 07/12/2013 03:08 PM, Chris Friesen wrote:
>>=20
>>> I turned on the instrumentation in early_init_dt_scan_memory() and =20
>>> got
>>> the following when jumping to the capture kernel:
>>>=20
>>> memory scan node memory, reg size 16, data: 0 0 2 0,
>>> - 0 , 200000000
>>>=20
>>> That 0x200000000 matches the fact that I'm seeing 8GB of memory
>>> available in the recovery kernel.
>>>=20
>>> If I boot the original kernel with "crashkernel=3D224M@32M", should I
>>> expect that only 224MB is marked as "linux,usable-memory" in the
>>> recovery kernel?
>>=20
>> I started looking at the kexec side of things, and I noticed =20
>> something a
>> bit odd. In most places dealing with the device tree in kexec it =20
>> accepts
>> either "memory" or "memory@" for the memory node name. In
>> add_usable_mem_property() in arch/ppc64/fs2dt.c it seems to only =20
>> accept
>> "memory@".
>>=20
>> Is this expected behaviour? It seems to be the same in current git
>> versions of kexec-tools.
>>=20
>> On my system I see "/proc/device-tree/memory".
>>=20
>> If I modify add_usable_mem_property() to also accept "/memory" then =20
>> my
>> recovery kernel boots up with
>>=20
>> physicalMemorySize =3D 0x10000000
>>=20
>> which is 256MB (which is still a bit odd since I specified 224MB for =20
>> the
>> crashkernel).
>>=20
>> However, it then hits the BUG() call at the end of mark_bootmem() in
>> mm/bootmem.c.
>=20
> One final thing and I'll stop replying to myself. :)
>=20
> It looks like the problem is that some board-specific freescale code =20
> was calling lmb_reserve() with a base address in the 4GB range.  It =20
> seems odd that lmb_reserve() didn't throw some kind of error when the =20
> recovery kernel was supposed to be limited to 224MB.
>=20
> Rather than try and fix the bug, I turned off the (unneeded) config =20
> options related to the above lmb_reserve() calls and was able to =20
> successfully access the information I needed via /dev/oldmem.
>=20
> The upshot is that there seems to be a number of things that could be =20
> improved:
>=20
> 1) kexec should accept "/memory" and not just "/memory@"
> 2) lmb_reserve() should really respect the crashkernel memory limit
> 3) the freescale stuff really shouldn't assume it can map things =20
> wherever it feels like

What "board-specific freescale code" are you referring to?

-Scott=

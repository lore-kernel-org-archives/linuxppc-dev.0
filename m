From: "Frank Smith" <smith@amirix.com>
To: <clark@esteem.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PPCBoot memory mapping problems
Message-Id: <00Aug18.231049adt.7303@dragon.appliedmicro.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1.5.4.32.20000819004501.006984e4@pop.esteem.com>
Date: Fri, 18 Aug 2000 23:10:44 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> clark@esteem.com
> Sent: Friday, August 18, 2000 9:49 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: PPCBoot memory mapping problems
>
...
>
>         Our board boots up checks the kernels CRC then uncompresses it. It
> then jumps to 0x0000000C. A little bit later it then jumps to some address
> 0xC000???? and faults.
>
>         Is this what it is supposed to do? Am I supossed to have the RAM

Jump to 0xC000????  Yup.  Fault?  No.

> mapped at 0xC0000000? If it loads at address 0 how do I remap it to
> 0xC0000000 once the kernel starts? Is there any way to force the kernel to

Basically, the kernel boot process should be doing this *for* you.

Part of the kernel boot process is to set up a memory mapping from
virtual C0000000 to physical 00000000, and then enable address translation.
This is done in arch/ppc/kernel/head.S using the BAT registers.

> run in lower memory?

I doubt it.  It shouldn't be necessary, tho.

>
>
>         Thanks in advance for any help.
>
>         Conn Clark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

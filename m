Message-Id: <200105072049.f47Knh628959@stimpy.networkrobots.com>
Date: Mon, 07 May 2001 13:56:08 -0700
To: Freddy Lugo <wilflugo@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
From: Paul White <pwhite@networkrobots.com>
Subject: Re: Can not access memory after turning MMU on
In-Reply-To: <20010507204100.56613.qmail@web9901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Freddy,

What address is it trying to address next?  It needs to be sure its in the
range of the BATS setup by initial_bats, which maps the first 16Meg of
memory to KERNELBASE.
After turning MMU on, it should finish relocating the kernel.  Is this the
part thats failing?

I'm referencing arch/ppc/kernel/head.S above.

Paul W.

At 01:41 PM 5/7/2001 -0700, Freddy Lugo wrote:
>
>Hi,
>
>After turning the MMU (turn_on_mmu) the next memory
>access instruction (stwu) can not be translated, the
>memory can not be accessed and the system halt.  I
>check the list archives and there are references to
>set the Debug Enable Register (DER) to an
>"appropriate" value.  I am working with the MPC750 and
>in the Users Manual I can't find any reference to such
>register.  Also I checked my bdi2000 (in case it was a
>register on the bdi) and I didn't found anything.
>
>This register exists or has its counterpart on the
>MPC750?  Besides the DER value, there are other
>methods to work and find the problem?
>
>Thanks,
>
>Freddy Lugo
>
>
-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

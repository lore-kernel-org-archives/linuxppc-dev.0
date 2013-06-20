Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 139402C00A2
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Jun 2013 05:15:47 +1000 (EST)
Date: Thu, 20 Jun 2013 14:15:37 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: DEBUG_PAGEALLOC on PPC not working (kernels 2.6-25, 3.0-34)
To: perth1415 <saikia.partha@gmail.com>
In-Reply-To: <1371724960184-72625.post@n7.nabble.com> (from
 saikia.partha@gmail.com on Thu Jun 20 05:42:40 2013)
Message-ID: <1371755737.11064.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2013 05:42:40 AM, perth1415 wrote:
> Hi Scott,
>=20
> Thanks for the reply, though a bit disheartening :-)
> My understanding on e500 MMU is not clear. It'd be nice if I could =20
> find some
> way (may be ad-hoc) to debug some use-after-free page corruptions. =20
> SLAB
> debug tells me the page was modified by someone after it was freed but
> DEBUG_PAGEALLOC would have been more specific, as to tell me where =20
> exactly
> it was getting modified.
> Any debugging clues will be much appreciated.

If you know an exact address that's being corrupted, you could set a =20
data breakpoint (by manually setting the registers, and making sure =20
that the exception handler will produce a dump and not ignore it as a =20
spurious event).  You could add code to periodically check for =20
corruption (from a timer, from codepaths which you suspect, =20
before/after IRQ handlers, etc).  If you have specific code that you =20
suspect may be responsible, you can have it check for poison values =20
before writing.  I'm not sure if slab debugging already does this, but =20
if not you could have it record the address of the code that last =20
allocated and freed the corrupted memory chunk.

If you have access to a tool such as Virtutech Simics, you could use =20
reverse execution to find the corruption.

Or you could find a way to separate the code/data needed by exceptions =20
(including page tables, kernel stacks, etc) from everything else, and =20
only pin the former, but that's probably a lot of work.

-Scott=

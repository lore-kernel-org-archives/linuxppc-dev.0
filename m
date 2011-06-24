Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FD79B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jun 2011 19:16:31 +1000 (EST)
Subject: Re: [RFC PATCH 0/1] BPF JIT for PPC64
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E042867.5020902@ozlabs.org>
Date: Fri, 24 Jun 2011 04:16:26 -0500
Message-Id: <750BF3E9-A788-4302-8AA1-4630614E20DC@kernel.crashing.org>
References: <4E042867.5020902@ozlabs.org>
To: Matt Evans <matt@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 24, 2011, at 1:02 AM, Matt Evans wrote:

> Hi,
>=20
>=20
> Inspired by Eric Dumazet's x86-64 compiler for Berkeley Packet Filter =
programs,
> I've written a BPF compiler for 64-bit PowerPC.  Although it hasn't =
finished its
> strenuous testing regime, I'll have intermittent net access for a =
couple of
> weeks so thought I'd post it for feedback now and submit a 'proper' =
version when
> I'm back.
>=20
> It's a fairly simple code generator, following a similar structure to =
the x86
> version.  The filter programs are an array of opcode/constant/branch =
destination
> structs, and can perform arithmetic/logical/comparison operations on =
two virtual
> registers A and X, loads from packet headers/data and accesses to =
local
> variables, M[].  Branching is also supported, but only forwards and =
only within
> the extent of the program.
>=20
> I would probably describe this as more of a "static template binary =
translator"
> than a "JIT" but have kept naming consistent :)
>=20
>=20
> Features include:
>=20
> - Filter code is generated as an ABI-compliant function, stackframe &
>  prologue/epilogue if necessary.
>=20
> - Simple filters (e.g. RET nn) need no stackframe or save/restore code =
so
>  generate into only an li/blr.
>=20
> - Local variables, M[], live in registers
>=20
> - I believe this supports all BPF opcodes, although "complicated" =
loads from
>  negative packet offsets (e.g. SKF_LL_OFF) are not yet supported.
>=20
> Caveats include:  :)
>=20
> - Packet data loads call out to simple helper functions (bpf_jit.S) =
which
>  themselves may fall back to a trampoline to skb_copy_bits.  I haven't =
decided
>  whether (as per comments there) it would be better to generate the =
simple
>  loads inline and only call out in the slow case.
>=20
> - Branches currently generate to "bcc 1f; b <far dest>; 1:" or
>  "bcc <near dest> ; nop" so either case is the same size.  Multiple =
passes of
>  assembly are used (the first gets an idea of how big everything is =
and what
>  features are required), the next generates everything at accurate =
size, the
>  third generates everything with accurate branch destination =
addresses); I
>  intend not to nop-pad the short branch case but changing code size =
may
>  result in more passes and a 'settling-down period'.  Kept simple for =
now.
>=20
> - Anyone running PPC64 little-endian is doing something both =
interesting and
>  unsupported for this work :-)  (There are some trivial endian =
assumptions.)
>=20
> Tested in-situ (tcpdump with varying complexity filters) and with a =
random BPF
> generator; I haven't verified loads from the fall back skb_copy_bits =
path.  Bug
> reports/testing would be very welcome.

Would be nice to get PPC32 support as well.

- k=

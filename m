Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Lazy interrupt disabling for 64-bit machines
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
References: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZOj9iXSvuom/TchrTVGx"
Date: Tue, 26 Sep 2006 15:30:41 +1000
Message-Id: <1159248641.5256.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZOj9iXSvuom/TchrTVGx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-26 at 14:55 +1000, Paul Mackerras wrote:
> This implements a lazy strategy for disabling interrupts.  This means
> that local_irq_disable() et al. just clear the 'interrupts are
> enabled' flag in the paca.  If an interrupt comes along, the interrupt
> entry code notices that interrupts are supposed to be disabled, and
> clears the EE bit in SRR1, clears the 'interrupts are hard-enabled'
> flag in the paca, and returns.  This means that interrupts only
> actually get disabled in the processor when an interrupt comes along.

I saw this once testing kdump, although I haven't hit it again
(3 retries).

Badness in _local_bh_enable at /home/michael/src/auto/git/kernel/softirq.c:=
120
Call Trace:
[C000000009F83B60] [C00000000200F810] .show_stack+0x6c/0x1a0 (unreliable)
[C000000009F83C00] [C0000000020219F0] .program_check_exception+0x19c/0x5d0
[C000000009F83CA0] [C0000000020043D0] program_check_common+0xd0/0x100
--- Exception: 700 at ._local_bh_enable+0x34/0x78
    LR =3D .call_do_softirq+0x14/0x24
[C0000000028FF8B0] [C00000000200C4A8] .do_softirq+0x6c/0xb0
[C0000000028FF940] [C00000000204E550] .irq_exit+0x4c/0x64
[C0000000028FF9C0] [C00000000201FC94] .timer_interrupt+0x3c0/0x3fc
[C0000000028FFA90] [C00000000200354C] decrementer_common+0xcc/0x100
--- Exception: 901 at .__delay+0x8/0x24
    LR =3D .__cpu_up+0x118/0x214
[C0000000028FFD80] [C000000002024C80] .__cpu_up+0xfc/0x214 (unreliable)
[C0000000028FFE10] [C00000000206987C] .cpu_up+0xd4/0x164
[C0000000028FFEC0] [C0000000020093A0] .init+0xd4/0x39c
[C0000000028FFF90] [C000000002022F0C] .kernel_thread+0x4c/0x68


Looks like it's hitting the in_irq() warning:

void _local_bh_enable(void)
{
        WARN_ON_ONCE(in_irq());
        WARN_ON_ONCE(!irqs_disabled());
	...

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ZOj9iXSvuom/TchrTVGx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFGLsAdSjSd0sB4dIRAmw4AJ9DjxOr96JjPegGNlOCn1KvinKklwCdGw4Z
cM3qcM0XRe475OelqRGAXwg=
=JpLX
-----END PGP SIGNATURE-----

--=-ZOj9iXSvuom/TchrTVGx--

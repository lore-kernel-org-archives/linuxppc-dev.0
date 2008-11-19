Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A4FFCDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 20:39:33 +1100 (EST)
Date: Wed, 19 Nov 2008 20:39:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-Id: <20081119203922.0412c041.sfr@canb.auug.org.au>
In-Reply-To: <20081119091628.GT26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__19_Nov_2008_20_39_22_+1100_eLOLMpGIN=TzgPlT"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__19_Nov_2008_20_39_22_+1100_eLOLMpGIN=TzgPlT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 19 Nov 2008 10:16:28 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
>
> Strange, so it gets stuck on the timer lock, very weird. You don't
> happen to have output showing that the other CPU is up to at that point?

Unfortunately, no, but I will see what I can find tomorrow.

Today's linux-next still has a problem, but it is slightly different:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000503030
cpu 0x0: Vector: 300 (Data Access) at [c00000000ffffa40]
    pc: c000000000503030: ._spin_lock_irqsave+0x40/0x110
    lr: c0000000002571f8: .blk_rq_timed_out_timer+0x48/0x190
    sp: c00000000ffffcc0
   msr: 8000000000009032
   dar: 0
 dsisr: 40000000
  current =3D 0xc000000022d31040
  paca    =3D 0xc000000000897300
    pid   =3D 3399, comm =3D ckbcomp
enter ? for help
[c00000000ffffd50] c0000000002571f8 .blk_rq_timed_out_timer+0x48/0x190
[c00000000ffffe00] c00000000006c2f4 .run_timer_softirq+0x1c4/0x2a0
[c00000000ffffed0] c000000000065298 .__do_softirq+0xe8/0x1f0
[c00000000fffff90] c000000000029224 .call_do_softirq+0x14/0x24
[c000000022ad3c80] c00000000000d420 .do_softirq+0xf0/0x140
[c000000022ad3d20] c0000000000654a4 .irq_exit+0x74/0x90
[c000000022ad3da0] c000000000025844 .timer_interrupt+0x134/0x150
[c000000022ad3e30] c000000000003700 decrementer_common+0x100/0x180
--- Exception: 901 (Decrementer) at 000000000ff52440

I am currently bisecting yesterday's linux-next.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__19_Nov_2008_20_39_22_+1100_eLOLMpGIN=TzgPlT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkj3soACgkQjjKRsyhoI8wg6wCdHoz07MoZZyhMV1xf1MEmmJTv
xOMAnRnMait+7FSRYnjmEXLZylHF3SWC
=SWYr
-----END PGP SIGNATURE-----

--Signature=_Wed__19_Nov_2008_20_39_22_+1100_eLOLMpGIN=TzgPlT--

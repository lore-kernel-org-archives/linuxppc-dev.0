Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A9394DDE42
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 23:22:00 +1000 (EST)
Date: Mon, 23 Apr 2007 23:22:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] [v2] powerpc: save trap number in bad_stack
Message-Id: <20070423232217.08e420a6.sfr@canb.auug.org.au>
In-Reply-To: <20070422233821.GB28479@lixom.net>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__23_Apr_2007_23_22_17_+1000_RnN1J6ir=Q/rA/ng"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__23_Apr_2007_23_22_17_+1000_RnN1J6ir=Q/rA/ng
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 22 Apr 2007 18:38:21 -0500 olof@lixom.net (Olof Johansson) wrote:
>
> --- powerpc.orig/include/asm-powerpc/paca.h
> +++ powerpc/include/asm-powerpc/paca.h
> @@ -68,6 +68,7 @@ struct paca_struct {
>  	void *emergency_sp;		/* pointer to emergency stack */
>  	u64 data_offset;		/* per cpu data offset */
>  	s16 hw_cpu_id;			/* Physical processor number */
> +	u16 trap_save;			/* Used when bad stack is encountered */

Please read the comment at the top of the struct:

        /*
         * Because hw_cpu_id, unlike other paca fields, is accessed
         * routinely from other CPUs (from the IRQ code), we stick to
         * read-only (after boot) fields in the first cacheline to
         * avoid cacheline bouncing.
         */

So please move this out of the first cache line.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__23_Apr_2007_23_22_17_+1000_RnN1J6ir=Q/rA/ng
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLLMOFdBgD/zoJvwRAoN1AJ98gDGN5BHct/X5LwXn6A6S661tqgCfWlIT
GSRKJWh9dWa/Sbg8alEUS/E=
=m3xD
-----END PGP SIGNATURE-----

--Signature=_Mon__23_Apr_2007_23_22_17_+1000_RnN1J6ir=Q/rA/ng--

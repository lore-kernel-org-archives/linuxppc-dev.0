Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 78D1467B9F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 12:31:35 +1100 (EST)
Date: Sat, 16 Dec 2006 12:31:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061216123123.ec948516.sfr@canb.auug.org.au>
In-Reply-To: <20061215115902.688f1a34@pb15>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
	<20061215115902.688f1a34@pb15>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__16_Dec_2006_12_31_23_+1100_5nn79vffuMRenEN4"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__16_Dec_2006_12_31_23_+1100_5nn79vffuMRenEN4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Olaf,

On Fri, 15 Dec 2006 11:59:02 -0600 Olof Johansson <olof@lixom.net> wrote:
>
> +static int __init genrtc_rtc_hookup(void)
> +{
> +	/* Don't init if the platform has already set up rtc functions. */
> +	if (ppc_md.get_rtc_time || ppc_md.set_rtc_time)
> +		return -1;

If this is considered not an error, then please return -ENODEV so that if
initcall_debug is set, the kernel won't consider this worth noting.

> +	rtc_dev = rtc_class_open("rtc0");
> +
> +	if (!rtc_dev) {
> +		printk("genrtc_rtc_hookup: Failed to open rtc0\n");

KERN_ERR?

> +		return -1;

init routines should return 0/-<errno number> so that initcall_debug is
useful.  Though what Evalue is appropriate here I don't know.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__16_Dec_2006_12_31_23_+1100_5nn79vffuMRenEN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFg0xtFdBgD/zoJvwRApjcAJ9HCBLuuGOV0hChBEKc1BDIttWwaQCgiJo1
FVWQIShHJix/mkj9DVFk8yk=
=Nikr
-----END PGP SIGNATURE-----

--Signature=_Sat__16_Dec_2006_12_31_23_+1100_5nn79vffuMRenEN4--

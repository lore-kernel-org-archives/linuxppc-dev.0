Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7F70A67C02
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 15:31:03 +1100 (EST)
Date: Fri, 17 Nov 2006 15:31:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-Id: <20061117153105.edca0777.sfr@canb.auug.org.au>
In-Reply-To: <20061117033638.0E24B67BCE@ozlabs.org>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__17_Nov_2006_15_31_05_+1100_b3YwrG8jDf7EG/13"
Cc: ego@in.ibm.com, linuxppc-dev@ozlabs.org, srinivasa@in.ibm.com,
	Anton Blanchard <anton@samba.org>, ntl@pobox.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__17_Nov_2006_15_31_05_+1100_b3YwrG8jDf7EG/13
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

One small nit ...

On Fri, 17 Nov 2006 14:36:35 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> +static int __init pseries_cpu_hotplug_init(void)
> +{
> +	rtas_stop_self_args.token = rtas_token("stop-self");
> +	qcss_tok = rtas_token("query-cpu-stopped-state");
> +
> +	if (rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE ||
> +			qcss_tok == RTAS_UNKNOWN_SERVICE)
> +		return 1;

initcall fucntions should return 0 or -<error>;  -ENODEV is ignored,
other nonzero values cause a log message if initcall debugging is enabled.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Nov_2006_15_31_05_+1100_b3YwrG8jDf7EG/13
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXTsJFdBgD/zoJvwRAsO8AJ4z26gsFOm646wrlhBcG6p1yd2hMACcDV3I
wvcZlDT9+vz54lLmYsBvlJg=
=UE7k
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Nov_2006_15_31_05_+1100_b3YwrG8jDf7EG/13--

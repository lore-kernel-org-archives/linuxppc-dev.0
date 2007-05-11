Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BC203DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 22:13:10 +1000 (EST)
Date: Fri, 11 May 2007 22:13:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3] 83xx USB platform code rework
Message-Id: <20070511221304.a5a14f4e.sfr@canb.auug.org.au>
In-Reply-To: <46445455.608@freescale.com>
References: <46445455.608@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_May_2007_22_13_04_+1000_YwDaRvvw_fhBpsGD"
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_May_2007_22_13_04_+1000_YwDaRvvw_fhBpsGD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 11 May 2007 19:32:37 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr"))
> +				!= NULL) {

Normally we like to separate the assignment from the test.  There are a
couple of other places like this.

> +		} else if (prop && !strcmp(prop, "serial")) {
> +			if (!strcmp(of_get_property(np, "dr_mode", NULL), "otg")) {
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Is there any chance that np doesn't have a "dr_mode" property?

> +#ifdef CONFIG_USB_OTG
> +		/* Set OTG_PORT */
> +		if (!strcmp(of_get_property(np, "dr_mode", NULL), "otg"))
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Again.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_May_2007_22_13_04_+1000_YwDaRvvw_fhBpsGD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRF3VFdBgD/zoJvwRAmKFAJ4mUWo40+x/9o2YgPT9gyLWLE6YpwCfTO6L
H6NkVVvIQahKKBpoDZaqKK8=
=qXgF
-----END PGP SIGNATURE-----

--Signature=_Fri__11_May_2007_22_13_04_+1000_YwDaRvvw_fhBpsGD--

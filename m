Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 36A73DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 11:12:58 +1100 (EST)
Date: Wed, 7 Mar 2007 11:12:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] [POWERPC] fix up log_plpar_hcall_return
Message-Id: <20070307111246.79afc104.sfr@canb.auug.org.au>
In-Reply-To: <1173222701.13165.9.camel@localhost>
References: <1173222701.13165.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Mar_2007_11_12_46_+1100_JNZ0uVI0XkQt0c6e"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Mar_2007_11_12_46_+1100_JNZ0uVI0XkQt0c6e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

[sfr done Blue Hair]

Hi Will,

On Tue, 06 Mar 2007 17:11:41 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
>
> This is mostly cosmetic.  This updates log_plpar_hcall_return() to use a
> case statement rather than an if-then-else jumble, and moves it to
> rtas.c where it can be near the other rtas related functions.

You are moving a static function from the only file that calls it.  You
are exporting it when the only callers are in a file that cannot be part
of a module and you are (maybe) optimizing something that is only used in
error paths.

Sorry, but unless you are doing to introduce others uses, that I don't
see that this change helps.

[sfr redons normal hair]

I don't mean to sound harsh  :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Mar_2007_11_12_46_+1100_JNZ0uVI0XkQt0c6e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF7gOIFdBgD/zoJvwRAhZoAJ4naAEG/cA5KL/RxuxU/EQNTmkS2wCdEsXC
WmllshIzFzWtfcmR3XXRo7w=
=jx11
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Mar_2007_11_12_46_+1100_JNZ0uVI0XkQt0c6e--

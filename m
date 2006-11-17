Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 39CDC67BDF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 16:02:50 +1100 (EST)
Date: Fri, 17 Nov 2006 16:02:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-Id: <20061117160259.9c27890d.sfr@canb.auug.org.au>
In-Reply-To: <1163738640.16815.45.camel@localhost.localdomain>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117153105.edca0777.sfr@canb.auug.org.au>
	<1163738640.16815.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__17_Nov_2006_16_02_59_+1100_I+/=+K35jdFzMpud"
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

--Signature=_Fri__17_Nov_2006_16_02_59_+1100_I+/=+K35jdFzMpud
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2006 15:44:00 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> > initcall fucntions should return 0 or -<error>;  -ENODEV is ignored,
> > other nonzero values cause a log message if initcall debugging is enabled.
>
> OK. I wanted to return an error, so there's something in the log to show
> that cpu hotplug was disabled - but I didn't check what to return. I'll
> fix it up on Monday to return -ENOENT.

Which also won't do anything unless initcall debugging is enabled and,
even then, will just give an obscure message in the boot logs.  If you
want to log something, then you should explicitly call printk().

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Nov_2006_16_02_59_+1100_I+/=+K35jdFzMpud
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXUKDFdBgD/zoJvwRArW5AKCgrb6lmfG4DsaK8vl/mmK/o3BKTwCfc3hi
ecW93DzjdrcRXKfpybr/qnQ=
=C08d
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Nov_2006_16_02_59_+1100_I+/=+K35jdFzMpud--

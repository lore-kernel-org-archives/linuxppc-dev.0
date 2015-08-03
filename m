Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B479D1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 10:39:10 +1000 (AEST)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A868C1402D1
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2015 10:39:08 +1000 (AEST)
Received: by padck2 with SMTP id ck2so75710770pad.0
 for <linuxppc-dev@ozlabs.org>; Sun, 02 Aug 2015 17:39:06 -0700 (PDT)
Message-ID: <1438562207.31010.14.camel@axtens.net>
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
From: Daniel Axtens <dja@axtens.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com, Thomas
 Huth <thuth@redhat.com>
Date: Mon, 03 Aug 2015 10:36:47 +1000
In-Reply-To: <87wpxg3cvv.fsf@igel.home>
References: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
 <87wpxg3cvv.fsf@igel.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-mIcDrAO9HqvVCrSUbRHz"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-mIcDrAO9HqvVCrSUbRHz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Fri, 2015-07-31 at 11:16 +0200, Andreas Schwab wrote:
> Daniel Axtens <dja@axtens.net> writes:
>=20
> > Every time I build cxl I see the following warnings:
> >
> > /scratch/dja/linux-capi/drivers/misc/cxl/pci.c: In function =E2=80=98sa=
nitise_afu_regs=E2=80=99:
> > /scratch/dja/linux-capi/drivers/misc/cxl/pci.c:712:6: warning: suggest =
explicit braces to avoid ambiguous =E2=80=98else=E2=80=99 [-Wparentheses]
> >    if (reg & CXL_PSL_DSISR_TRANS)
> >       ^
> > /scratch/dja/linux-capi/drivers/misc/cxl/irq.c: In function =E2=80=98fa=
il_psl_irq=E2=80=99:
> > /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:184:5: warning: suggest =
explicit braces to avoid ambiguous =E2=80=98else=E2=80=99 [-Wparentheses]
> >   if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> >      ^
>=20
> Why are they ambigous?  Why doesn't cxl_p2n_write(afu, CXL_PSL_TFC_An,
> CXL_PSL_TFC_An_AE) expand to a proper statement?
>=20
> #define cxl_p2n_write(afu, reg, val) \
> 	out_be64(_cxl_p2n_addr(afu, reg), val)
>=20

I realised that I started seeing this when I was working on my EEH
patches, which change the definition to:

#define cxl_p2n_write(afu, reg, val) \
	if (cxl_adapter_link_ok(afu->adapter)) \
		out_be64(_cxl_p2n_addr(afu, reg), val)


I'll redo the patch to change the write functions to wrap the if
statement so they cease to be ambiguous. I'll also spin a patch to
enable -Werror so I catch this earlier next time.

Thanks for the feedback, it was very helpful in me figuring out the root
cause.

--=20
Regards,
Daniel

--=-mIcDrAO9HqvVCrSUbRHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVvretAAoJEPC3R3P2I92FHx0P+QE9Y3it7gMoOHTg/ycqc98I
3gQ/wrQo3aJO4jGEpP5VeRZv7MXmpplhTgYRH4LuF6dkRvcxypzJgWCU8oM/ejGS
B7iMCK3JcWiV6fniBmakQIZEWLFIdwErhY3wgvagbvZ1r770taQ8/jdcWtvw66rP
LxfCrV8t7v5JiU+IafvXjhbesfClJAuAKs4f/gEFm6+50p59gniKkPooYYe701ht
ShZ8OS/umFXwteqEenusDkq1hAeZ4M26ogzKagMi94Zg2gDBT2v2azJXiX7jiBxE
vKQcX4RIRYi7SeYt8Epkl+xnl/adKkxlOL77Z9q5Sg9V0WH1RWsOr7T1hODnzxep
XGZ7v0WXZKaVVWLKXw51tCeibGlm9ExgxSmM3I4KSL4umb4hHfSY9Q1cdjL0fovv
Y+Brz4Z8c9WiPL7rU28tiddYjlL/FxgaTPSc3q3NWt64DEYot/wykHUURKby1nFH
pjmbpKNxxtuHhe1gO90x6buweiRgZYW1Kg1kK27n/jzBMVmcZmugku2pX+ZNQm/C
w+DMZXSwDEY2WF+dSW6BJo4S03PBOeUKToB+MoK68tT6aa4Xaj5xKrhZmBJLdiXL
YZBbMqOJaone9T6aHwrH2hmLTvjRfSiHcMdAYMciObrJ16e64Jk/tbejoS4wdQY1
oUKAzapawxl4fJMVSiUH
=gp1/
-----END PGP SIGNATURE-----

--=-mIcDrAO9HqvVCrSUbRHz--

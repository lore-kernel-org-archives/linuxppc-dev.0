Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8DC31A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 15:34:10 +1000 (AEST)
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D90F51402AE
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 15:34:09 +1000 (AEST)
Received: by pdbnf5 with SMTP id nf5so29915419pdb.2
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 22:34:08 -0700 (PDT)
Message-ID: <1433914391.3096.40.camel@axtens.net>
Subject: Re: [PATCH V8 06/10] powerpc, lib: Add new branch analysis support
 functions
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 15:33:11 +1000
In-Reply-To: <1433763511-5270-6-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-6-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-3yDoaZAD8cNuiNvHpKpl"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3yDoaZAD8cNuiNvHpKpl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> +static int instr_is_branch_xlform(unsigned int instr)
> +{
> +	return branch_opcode(instr) =3D=3D 19;
> +}
Why do these not return bool? The functions below do.
> +
> +static int is_xlform_lr(unsigned int instr)
> +{
> +	return (instr & XL_FORM_LR) =3D=3D XL_FORM_LR;
> +}
> +
> +static int is_bo_always(unsigned int instr)
> +{
> +	return (instr & BO_ALWAYS) =3D=3D BO_ALWAYS;
> +}
> +
> +static int is_branch_link_set(unsigned int instr)
> +{
> +	return (instr & BRANCH_SET_LINK) =3D=3D BRANCH_SET_LINK;
> +}
> +
> +bool instr_is_return_branch(unsigned int instr)
> +{
> +	/*
> +	 * Conditional and unconditional branch to LR register
> +	 * without seting the link register.
setting
> +	 */
> +	if (is_xlform_lr(instr) && !is_branch_link_set(instr))
> +		return true;
> +
> +	return false;
> +}
> +




> +bool instr_is_func_call(unsigned int instr)
> +{
> +	/* LR should be set */
> +	if (is_branch_link_set(instr))
> +		return true;
> +
> +	return false;
> +}
> +
> +bool instr_is_indirect_func_call(unsigned int instr)
> +{
> +	/* XL-form instruction with LR set */
> +	if (instr_is_branch_xlform(instr) && is_branch_link_set(instr))
> +		return true;
> +
> +	return false;
> +}
Both of these functions could be made into a single 'return' statement,
right?
> +
>  int instr_is_relative_branch(unsigned int instr)
>  {
>  	if (instr & BRANCH_ABSOLUTE)


--=-3yDoaZAD8cNuiNvHpKpl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd8wYAAoJEPC3R3P2I92FDd4P/2Qth6RdfTTYfr8osaDP5eXl
O9dkSTnaLpWy1u6565atcuac9GO0AUgLaa5DlAFZ15O2sPmAHhgPsRaXhzsu2/46
/VWa/OthKbFmloUUwM7rhiz7zjLf1sfRtfFK9hS3BJcrkbal6t68LKIUn4nZI5ws
W5D7V1mSovaQxB6Yzdl4xwm0oqo1dyABEKrbXszJo8LVa7vQPTxor5CXZRRRfCri
QGpGmI35CUyNLS3/jbj+/mDKXmW+urBisWz5OZnsQfGE3W+shOc+LPP+4EAaHuBq
eFsaDSwA6q6ZTmLLAfj09jUGac+sycUVtvZtEn2m1dXMUJ2YPuZKeY9a2Txd6ooQ
bB0IuLzlUeY5OIShVf2LW6Fz2qwF2KR+lriSH9MmcZa3fihrd6UB+JEtc16Q/Jd7
KJLqLVhr3iT6s287BX/+BYnSjXkOBsw2DIiqTfjDkTvQBr2hjNlzvk1XGPe6W8QC
QXHP+KomCQl0ndLaAFgNLHAAa3PmF4sBHCu7iROu2CmOmV9p+uucV6Fxdbt5vhI2
W08NEL7LfFQAeU5RfMjaTCvv5nZ11IAiBPIprSnnvKEEm2KhIx3y6u3oXH1d2l7t
uw+rh2ZOF2YzPZZ4RQeCS3rpZcZs4KUkZw6msvmE8uEU9PGuk6Sqqd8ilUM0EeRi
aQd53Mumnc9hAMThJ86L
=dVPz
-----END PGP SIGNATURE-----

--=-3yDoaZAD8cNuiNvHpKpl--

Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA1441A0920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 12:43:45 +1100 (AEDT)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F951140DA5
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:43:43 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so4363705pab.0
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 18:43:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/8] powerpc/eeh: Force reset on fenced PHB
In-Reply-To: <1444276739-20372-4-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-4-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2015 12:43:23 +1100
Message-ID: <871tcz4k78.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:


> +	 *
> +	 * When the PHB is fenced, we have to issue a reset to recover from
> +	 * the error. Override the result if necessary to have partially
> +	 * hotplug for this case.
>  	 */
>  	pr_info("EEH: Notify device drivers to shutdown\n");
>  	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
> +	if ((pe->type & EEH_PE_PHB) &&
> +	    result !=3D PCI_ERS_RESULT_NONE &&
> +	    result !=3D PCI_ERS_RESULT_NEED_RESET)
> +		result =3D PCI_ERS_RESULT_NEED_RESET;
I think we shouldn't discard the DISCONNECT state. A driver could ask
that the device be disconnected in the error_detected callback and we
should probably honour that.

Regards,
Daniel

>=20=20
>  	/* Get the current PCI slot state. This can take a long time,
>  	 * sometimes over 300 seconds for certain systems.
> --=20
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWHGG7AAoJEPC3R3P2I92Fo/wP/RPPGSfrHNpC7s7Nd8ZchlmO
LsWe0hKVywvIzav77iufermfD2I1uDgV8XVzclRLlivN5v58K90QPPf8qv29MifV
Gghi3pVvLyNimWCrMbN3xaf4+Kiz52XCSUMqnWLEYvcZBakymSY4zjrsvoq3lUop
xggzkfOpGostR38ncj1Ki1TttZ/bN4lEDYe/tiUxdjVTQXTfVt1i43ToIxjR27et
g0GODd0FMG6wDtYp79nqhbgYsRjkvsPWJEBxhX7PBMr992LhqWFNjxPQqsEHPVyM
2l0wWTnq4KGUo4VBqYGvVP2OxRbafmkTInX0McWWrS65rFLvu9JMAOMkYK3+PKYr
CS/BIDAJVg/6KnhhieWbxYGDu0dZl0Bg+a4xkWKZzlbZAkq2jiz3W4nQNlTAgJ5J
HQeZQExlWITEe6WxfFIFzEe0F1CtqOmXBlj40rTs8BAytb5e0dNRQv2KagbHG7CI
zUH2SUYzK4DTL3m6p9YFiv3/9JGD1WypN0uoXZdoAJ0mQbZWuFxKbzZk/IONq2k9
jAbTa10egusNqSkKu66O4Ks0jhmrH1K0pgVGbWzwiopOIOAulCbv4Dih8Di7GeHk
/XrAQH1HUqH/OOYIyDx4brQ98NIONl5YZo2Wbu288+ZR/p1dpQsQu6fWOVyeh3fW
4tbwfoI28pPFjTAiTJeQ
=nwLA
-----END PGP SIGNATURE-----
--=-=-=--

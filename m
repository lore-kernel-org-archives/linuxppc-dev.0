Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D89351A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 16:11:28 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so53360888pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 21:11:26 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 37/50] powerpc/powernv: Simplify pnv_eeh_reset()
In-Reply-To: <1446642770-4681-38-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-38-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2015 16:11:12 +1100
Message-ID: <877flniyz3.fsf@gamma.ozlabs.ibm.com>
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

> -			rc = opal_pci_reset(phb->opal_id,
> -					    OPAL_RESET_PHB_ERROR,
> -					    OPAL_ASSERT_RESET);
> -			if (rc != OPAL_SUCCESS) {
> -				pr_warn("%s: Failure %lld clearing "
> -					"error injection registers\n",
> -					__func__, rc);

This is very minor, but is there a good reason to change the error
message from the one above to the one below? I just hesitate to change
error messages that people might be grepping the source for without a
good reason.

> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("%s: Error %lld clearing error injection\n",
> +				__func__, rc);

Apart from that this looks good, pending me actually testing it :)

Regards,
Daniel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRB9xAAoJEPC3R3P2I92F6i8P/1nXJklQO2PGRqksurbhrbzf
hgXkRkqK4MgbbsIdw4HCRkbdWF+2pqKl1qWT6CIoyxNe+uZ+RLiq60Z8+2zok650
c5usDrSVMJZ1y8xwQrKe//W8C3sMIfWELvxpOpBKEu50thHXTKHpARzUA576PYYW
epxrt5fwrNckW+Emcyu83c+tEiz3C+goQGM84xBjxIUr7O0wbghinEZ53Otl8BAf
YfU21Z6a1V+qxNb/qaVn9AYp5QR5IBPC0dBqIngWZsPMH8sivb0mgQInaVtkwjET
n04tc2uUcyQsHRmvyKvkOp1lIRzJ7Ho5pZzotLyO+Z8LlUuok1WAVRCKjBsuEav3
Alfv/JKc5kewmo+1+I2P/ofAQQgBHykdrNIYEg3IWJrmHh4GjPDI3csxlILthR6F
WQJiYDZy4DmnPFi9wg5aH8WjWlCw1B9scobAAcf06gafJ6O9tUjt/iYjHUvCjKqn
UDhp4VtBJ2cfAuxXgBNcBzGmQCbRtzCfyRAjrZSKQqAKNE4OTlCuzwSUb9pxZ/+4
C7lFWxLHGm0Eu5rsSh7rFCROt7s7Bg1lZD6cRWNGhGfU9I5vsAtG/i4dAcnNaDZr
zFemBfb6Fghf7gNZm0GrUrXoYdWJFmAexNFiimwQGhQQN/BVgEFgOtHJhQ/Pj6NO
18XJnCap7rqlbJZcmG+v
=AiNj
-----END PGP SIGNATURE-----
--=-=-=--

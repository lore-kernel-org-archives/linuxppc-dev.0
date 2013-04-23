Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 1B0752C0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 11:50:09 +1000 (EST)
Date: Tue, 23 Apr 2013 11:50:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/12] Update firmware_has_feature() to check
 architecture bits
Message-Id: <20130423115002.3d321e6a69ed97d134127a2b@canb.auug.org.au>
In-Reply-To: <517583B7.1070300@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517583B7.1070300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__23_Apr_2013_11_50_02_+1000_FTQaeAHxGmguf+jG"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Apr_2013_11_50_02_+1000_FTQaeAHxGmguf+jG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 22 Apr 2013 13:38:47 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
> -/* Option vector 5: PAPR/OF options supported */
> -#define OV5_LPAR		0x80	/* logical partitioning supported */
> -#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
> +/* Option vector 5: PAPR/OF options supported
> + * Thses bits are also used for the platform_has_feature() call so
      ^^^^^
typo

> + * we encode the vector index in the define and use the OV5_FEAT()
> + * and OV5_INDX() macros to extract the desired information.
> + */
> +#define OV5_FEAT(x)	((x) & 0xff)
> +#define OV5_INDX(x)	((x) >> 8)
> +#define OV5_LPAR		0x0280	/* logical partitioning supported */
> +#define OV5_SPLPAR		0x0240	/* shared-processor LPAR supported */

Wouldn't it be clearer to say

#define OV5_LPAR	(OV5_INDX(0x2) | OV5_FEAT(0x80))

etc?

> @@ -145,6 +141,7 @@
>   * followed by # option vectors - 1, followed by the option vectors.
>   */
>  extern unsigned char ibm_architecture_vec[];
> +bool platform_has_feature(unsigned int);

"extern", please (if nothing else, for consistency).

> +static __initdata struct vec5_fw_feature
> +vec5_fw_features_table[FIRMWARE_MAX_FEATURES] =3D {

Why make this array FIRMWARE_MAX_FEATURES (63) long?  You could just
restrict the for loop below to ARRAY_SIZE(vec5_fw_features_table).

> +	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
> +};
> +
> +void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
> +{
> +	unsigned int index, feat;
> +	int i;
> +
> +	pr_debug(" -> fw_vec5_feature_init()\n");
> +
> +	for (i =3D 0; i < FIRMWARE_MAX_FEATURES; i++) {
> +		if (!vec5_fw_features_table[i].feature)
> +			continue;

And this test could go away.

I realise that you have just copied the existing code, but you should not
do that blindly.  Maybe you could even add an (earlier) patch that fixes
the existing code.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__23_Apr_2013_11_50_02_+1000_FTQaeAHxGmguf+jG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRdejKAAoJEECxmPOUX5FEtOAP/3CzIf11siMAnNIq4yq5h4uF
8qcg5EqBMTYI80Qn4hWBoSxYV2YFh9HX0sBLlBLkBM/DVOUbofMkd1dYw9pPdWaf
nBHmDIBVyZ0XDO2CgTNQdCnbm9JhF5+CWv+Fu0U2YmPQB0vEKHlQVQY+eQxdpw9l
HRIEi03b3M287BL75seJr57TV9DSHH3r8liwRfgk1UNi3OEpZgmApbMwYDz4zCkE
Tb9i27QVGcxZre77mfz30NOXQ/rsvCgZRVUsownonTBv7ZN0WEC3pkeaYHb6AIf1
+Z1P2CCpqFFq7Wj+AHcHZy2VpdwetC6TlAK0oWrT8KgK44vBro4t10HU1rbII4K8
3aQSje/UrVUprRF0Ws0VmHlqWs29Dxz28I8rB8e0Q/zDj35wntL1WbstizUSLDdJ
nnytvEYHFrhqgVveVtmwZp88vWCmUj2JiC0QiC3kNyMiWl8PSfAVQbWXE/VSaxBG
fnqTRia94GKlhP2u8sqLfPK7myNJJ7u0UsTZDcgdt16U0XSKPHlZCoUOc0kyfeIN
QTSHz7RN3dTbnEZ2kH6ymBTICCSW5uv1sLGBxKVrdsMI399wlUfPFGk4+4gbuk1o
4jIwq3KG9TmvORX7eBE6ZRITRt/Rqu7oFzyu3anL+L+NX0h8sWSbCJT03mxc+XgG
sE9NlVAoOTuRvpHEuHeA
=W2hj
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Apr_2013_11_50_02_+1000_FTQaeAHxGmguf+jG--

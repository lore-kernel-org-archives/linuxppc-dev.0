Return-Path: <dja@axtens.net>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0162E1A05F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 11:36:48 +1000 (AEST)
Received: by pablk4 with SMTP id lk4so92866309pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:36:45 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 27/32] cxlflash: Fix to prevent stale AFU RRQ
In-Reply-To: <1443223144-9962-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223144-9962-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 11:36:32 +1000
Message-ID: <8737xyuhun.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> Following an adapter reset, the AFU RRQ that resides in host memory
> holds stale data. This can lead to a condition where the RRQ interrupt
> handler tries to process stale entries and/or endlessly loops due to an
> out of sync generation bit.
>
> To fix, the AFU RRQ in host memory needs to be cleared after each reset.

This looks good. Do you need anything to bail out of cxlflash_rrq_irq if
the data goes stale or to all Fs while that function is running?

Daniel

>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index 24aedfb..ab11ee6 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1598,6 +1598,9 @@ static int start_afu(struct cxlflash_cfg *cfg)
>=20=20
>  	init_pcr(cfg);
>=20=20
> +	/* After an AFU reset, RRQ entries are stale, clear them */
> +	memset(&afu->rrq_entry, 0, sizeof(afu->rrq_entry));
> +
>  	/* Initialize RRQ pointers */
>  	afu->hrrq_start =3D &afu->rrq_entry[0];
>  	afu->hrrq_end =3D &afu->rrq_entry[NUM_RRQ_ENTRY - 1];
> --=20
> 2.1.0
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWCesgAAoJEPC3R3P2I92FE4kP+wYTEdCDP50RfKZPNCpoY//T
5tDNV58W1RasTrJLVGrpeGBboI4WTzRlKYAYX1iLC6ZSkX1rQS5rBqgImQQAg3i5
N9qoAdNCch06UVO7psceptT9653xt0OzitHW/tmB8pOMII65UIm8AtydSs2+J0e8
htw9Jnw098jls8NJtzz32T48QoM+kV1w7vfJJN36Z6FjL36KJLQCAL2/gLvv+3Zt
2ueeP6MM0q0iFxnQJwPFdf3DebggbMqeVbNorNAyCSkNNoUh2QR8NMHeFS8OoXCl
nrzjFoeSFDXh4c4bRzVoGRalIFzP+VY9guk9d/VtAt8ZkkrIyfI3K9lJTgDq2gqj
ShnT/WB4lskUVc/FjdkyIc+Nyg6pPkm4OftCnN7sf7CSd2+myO/d6S1f1qJlCn7s
3KBLXEFrKXKHl9TVDqkZSZVvyJOKmxoMqT98I00CWhXFkRgO126tnqsMsmrqgzxu
QxZQSo+/Oi7av6YuVtTP2c9SeYbGBfhOMOH5Dx7z9VY57rWvE5CVsduYJoG2D59P
Td5ToL1H3UOt8G1vzeqmkb7AWK882py2OLS7WG0PUDRDa2dfE6+8NOCJmuX9tW2x
/NnLlInDTiVTpz3iiJpe9Efu3SkL2KeMEBxi4jdt31hFO0BPeFWnZHKjwOa+uQ/w
OSaHCUZEZ6LRdbeJ1GLk
=3DO6Zk
=2D----END PGP SIGNATURE-----

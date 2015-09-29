Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B26EA1A05FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 11:26:10 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so189596844pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:26:08 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 25/32] cxlflash: Fix to prevent EEH recovery failure
In-Reply-To: <1443223134-9886-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223134-9886-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 11:25:50 +1000
Message-ID: <87612uuich.fsf@gamma.ozlabs.ibm.com>
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


> The process_sense() routine can perform a read capacity which
> can take some time to complete. If an EEH occurs while waiting
> on the read capacity, the EEH handler is unable to obtain the
> context's mutex in order to put the context in an error state.
> The EEH handler will sit and wait until the context is free,
> but this wait can last longer than the EEH handler tolerates,
> leading to a failed recovery.

I'm not quite clear on what you mean by the EEH handler timing
out. AFAIK there's nothing in eehd and the EEH core that times out if a
driver doesn't respond - indeed, it's pretty easy to hang eehd with a
misbehaving driver.

Are you referring to your own internal timeouts?
cxlflash_wait_for_pci_err_recovery and anything else that uses
CXLFLASH_PCI_ERROR_RECOVERY_TIMEOUT?

Regards,
Daniel

>
> To address this issue, make the context unavailable to new,
> non-system owned threads and release the context while calling
> into process_sense(). After returning from process_sense() the
> context mutex is reacquired and the context is made available
> again. The context can be safely moved to the error state if
> needed during the unavailable window as no other threads will
> hold its reference.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/superpipe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/su=
perpipe.c
> index a6316f5..7283e83 100644
> --- a/drivers/scsi/cxlflash/superpipe.c
> +++ b/drivers/scsi/cxlflash/superpipe.c
> @@ -1787,12 +1787,21 @@ static int cxlflash_disk_verify(struct scsi_devic=
e *sdev,
>  	 * inquiry (i.e. the Unit attention is due to the WWN changing).
>  	 */
>  	if (verify->hint & DK_CXLFLASH_VERIFY_HINT_SENSE) {
> +		/* Can't hold mutex across process_sense/read_cap16,
> +		 * since we could have an intervening EEH event.
> +		 */
> +		ctxi->unavail =3D true;
> +		mutex_unlock(&ctxi->mutex);
>  		rc =3D process_sense(sdev, verify);
>  		if (unlikely(rc)) {
>  			dev_err(dev, "%s: Failed to validate sense data (%d)\n",
>  				__func__, rc);
> +			mutex_lock(&ctxi->mutex);
> +			ctxi->unavail =3D false;
>  			goto out;
>  		}
> +		mutex_lock(&ctxi->mutex);
> +		ctxi->unavail =3D false;
>  	}
>=20=20
>  	switch (gli->mode) {
> --=20
> 2.1.0
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWCeieAAoJEPC3R3P2I92F+hMP/1OdLQCin+kKbOb9qxf952bH
DUAkmEhc0oD7xZFQI8HgDmHRxpes5HHxXtwXFsLgsr8QYG+aOIV568GXIZtTbrl0
aCFMqtKXZ6jVqv5L60r1tgzcWxmWdshMLd1op6t3BwA67nUc5Edcr94ePUyDDLj1
at335wCnxuGxn0kdB0Ud/lbPzTsgDPcuV6tCLy0o4J15KFOyFt9hCjO4nmL/wcIt
kmjyn5SHbdgje+73uaRQnXkli4wDA9x7x6/8wFgLspnOxgMEJgnHmm+HYbOXnHyX
nFFHw9+X2ETUcucVWuKNaFzW1vH+WJDteEZbjS7t7liJIkmIiZSFHyUTtVGdBkl1
FsWswA0pkzuGq94Wsb0nGtNHbsMw+WeWTcTlNN46DMG/wqz75iO3yMGK9MZuddSX
9jUokiM0kQvvfwAoujmvpMCVB4b2oseRRG4/yJ0lKSCcC8kETQTXgVHbT8oLmCdk
rUA0hxbbKzVQsDzw8s5HqYZjqHdLp3sDPeyukPeJl2CNhysrmnyHXpq8XgcLi3op
kbuuiR3z8UH3MW4BDpplnjhZ+5Wyw9cSI57vRF2Kr80NnU+5hBvftNh4rBneeny2
0gCDlPHDvB7Ks9HkcxkK9MW78FTgj50ePofS/dUUod4M9ohDd4MSwRKjpwQ+H3By
jmxnzfvWO/oTlL1D9+2W
=3D3BcU
=2D----END PGP SIGNATURE-----

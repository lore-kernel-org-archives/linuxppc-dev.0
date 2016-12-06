Return-Path: <boqun.feng@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXjvD4Zn7zDvx6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 11:59:20 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so17970757pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 16:59:20 -0800 (PST)
Date: Tue, 6 Dec 2016 08:58:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 2/6] powerpc: pSeries/Kconfig: Add qspinlock build
 config
Message-ID: <20161206005834.GC18164@tardis.cn.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
In-Reply-To: <1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:19:22AM -0500, Pan Xinhui wrote:
> pSeries/powerNV will use qspinlock from now on.
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index bec90fb..8a87d06 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig

Why here? Not arch/powerpc/platforms/Kconfig?

> @@ -23,6 +23,14 @@ config PPC_PSERIES
>  	select PPC_DOORBELL
>  	default y
> =20
> +config ARCH_USE_QUEUED_SPINLOCKS
> +	default y
> +	bool "Enable qspinlock"

I think you just enable qspinlock by default for all PPC platforms. I
guess you need to put

	depends on PPC_PSERIES || PPC_POWERNV

here to achieve what you mean in you commit message.

Regards,
Boqun

> +	help
> +	  Enabling this option will let kernel use qspinlock which is a kind of
> +	  fairlock.  It has shown a good performance improvement on x86 and als=
o ppc
> +	  especially in high contention cases.
> +
>  config PPC_SPLPAR
>  	depends on PPC_PSERIES
>  	bool "Support for shared-processor logical partitions"
> --=20
> 2.4.11
>=20

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYRg01AAoJEEl56MO1B/q4kgsH/i3BXJKj+dRDcUNgEk6OTE7V
b0yIMiyX+D0AbdM71XRIQKSdOow4kvSJg4T+ool2PX1w21wzmAyT8w2IN6O7fB5o
4KOEZV9vGeD6tUgRxNKnRTn6IQW5xn0e4QCZxqwCbG5cxitHZ3XgckF3hE0LMUV/
/OzzM0sAv/u7cfEZL9uAE5rDIDweFRi93doWcEpEW9IzpO9debq2+BepS6bWGVNW
SN3FWA7bq3uhBOKUuy25evsvxTMopdvuGKUilXvWi4TGF6l4akIzxyET5M17kNiZ
8TmssGqybyLpTu+N3yZloNh4N8mVZ/0qSNrXUYparJUXbxbGRY8bAZJ8LD6QuvM=
=+Wv7
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

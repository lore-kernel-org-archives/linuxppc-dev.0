Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8B611B711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 01:13:34 +1100 (EST)
Date: Tue, 8 Feb 2011 01:13:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Message-Id: <20110208011324.d5371c4c.sfr@canb.auug.org.au>
In-Reply-To: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Feb_2011_01_13_24_+1100_90ep88Xv/0+grvtc"
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@lists.linux-foundation.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Feb_2011_01_13_24_+1100_90ep88Xv/0+grvtc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon,  7 Feb 2011 12:22:15 +0000 Mark Brown <broonie@opensource.wolfsonmi=
cro.com> wrote:
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 2657299..99e3c52 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -1,23 +1,6 @@
>  config PM
> -	bool "Power Management support"
> -	depends on !IA64_HP_SIM
> -	---help---
> -	  "Power Management" means that parts of your computer are shut
> -	  off or put into a power conserving "sleep" mode if they are not
> -	  being used.  There are two competing standards for doing this: APM
> -	  and ACPI.  If you want to use either one, say Y here and then also
> -	  to the requisite support below.
> -
> -	  Power Management is most important for battery powered laptop
> -	  computers; if you have a laptop, check out the Linux Laptop home
> -	  page on the WWW at <http://www.linux-on-laptops.com/> or
> -	  Tuxmobil - Linux on Mobile Computers at <http://www.tuxmobil.org/>
> -	  and the Battery Powered Linux mini-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>.
> -
> -	  Note that, even if you say N here, Linux on the x86 architecture
> -	  will issue the hlt instruction if nothing is to be done, thereby
> -	  sending the processor to sleep and saving power.
> +	bool
> +	default y if !IA64_HP_SIM

Several powerpc configs have CONFIG_PM (implicitly) disabled (e.g. the
server configs), so this will unexpectedly turn it on for them.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Feb_2011_01_13_24_+1100_90ep88Xv/0+grvtc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNT/4EAAoJEDMEi1NhKgbsDrcIAJw8ipkwrIHQ85DvQ4vVuvrp
neHEQamjzQ8WCcajuxyEZ7D8niykWY9DhM7jtMpgRX+mmKC31aDLavJ/4NDbNJAW
2QRt9ifnpj23e0bSJXz3KWo/CaYU5lP5Ecq3NKHw+dX4BNIfpip8rOPuH1Q7sC4w
OQKCcpWTVvSZiD8e/x6+oPt4jd5PlZwumZr5/wZUzqBRSRF6JfZdPMZyzLkMnKBi
XAY9ctlOy9/VVcBTxiYkVNldo+eiJlZ5rrGcEnSa/S98bzS6JwxGOht+4RJYRQSD
/DommrycV/TjBVE67wg1i48D9/sFh0CenRkMHK13OQla6MmDnLJBcyQRVaZo+uA=
=/fcG
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Feb_2011_01_13_24_+1100_90ep88Xv/0+grvtc--

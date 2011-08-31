Return-Path: <balbi@ti.com>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A3ABB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 06:42:00 +1000 (EST)
Received: by mail-bw0-f54.google.com with SMTP id t8so1510762bka.41
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 13:41:56 -0700 (PDT)
Date: Wed, 31 Aug 2011 23:33:45 +0300
From: Felipe Balbi <balbi@ti.com>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 00/14] Modifications for DWC OTG since v13
Message-ID: <20110831203344.GB4073@legolas.emea.dhcp.ti.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <cover.1314704557.git.pratyush.anand@st.com>
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, Greg KH <greg@kroah.com>,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(you did not add Greg in Cc, he's the USB maintainer. You also didn't Cc
myself as maintainer of the gadget framework)

On Tue, Aug 30, 2011 at 05:27:47PM +0530, Pratyush Anand wrote:
> These patches are based on:http://patchwork.ozlabs.org/patch/89560/
> After not getting any reply from developers, I started to do
> modifications for my platform (SPEAr1340).
> I have done modifications in such a way that all the code in=20
> driver/usb/dwc/ would be platform independent.
> I have tested this code for host/device/dma/slave mode.
> My fifo configuration is dedicated and dynamic.

Looking at that driver code, I believe this is pretty much Synopsys
reference code with a few tweaks. If you want some tip, don't do that.
The reference driver, while functional, has lots of unnecessary layering
which should be avoided.

See how we wrote the DWC3 driver. It's very small code which does the
necessary. It's now functionally complete, from now on we only need to
improve on performance (for example starting transfers on Transfer
Complete event if we already have requests queued). Nevertheless, the
driver is small and has been tested with all transfer types.

If you really want to use this driver as is, that's your call. But I
would suggest to Greg that he only takes this in if there is someone
dedicated to maintain it. It's a really big codebase and whenever I
change something on the gadget framework I will have to patch this
beast too.

If there's no maintainer assigned to it, who's willing to put effort in
improving this driver in the long run, I think this will become yet
another burden on the community. Still, it's your call.

--=20
balbi

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOXpqoAAoJEAv8Txj19kN1oB0H/0wHs4edX0mtK5IuWxKx9YQL
z34bdcyit8nlK5r/GVdek79cW2qBEIoWuG3WTh9D467h6C/rcDpfYL44V5YE8jcb
ZRs6prea0XDVFknftHkFE7s/DOGt58XrJtzgF1tMw5GRIsTYtTelPS1smlI0pNvC
Lw3JmZTEqivnZxJqDS2BaoWl//IfDmwvxrJAV93to83JBakvRHzVy3axz+u7YW1Z
uSw6/rsxYINO2tXwQfzCBTIVZXpW8VFfLMGN3iSxjB83UiracQcbWqBbBDI/BvYT
b/pO81KP+LwuUh0SIzNau9hHBYk1FBCDl8ymGrJPgctCcWsfWEJ/W645WVDwx2I=
=4kdL
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

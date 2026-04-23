Return-Path: <linuxppc-dev+bounces-20004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DDFF9937A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 11:37:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1Ywz0CPGz2yF7;
	Thu, 23 Apr 2026 21:37:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776944258;
	cv=none; b=HFNQmUacVyj216CWaDoLlTVlohExqnnC6sVW2oE0p9mWSySAwR/7wBMUIDKzrM5CkySjbOOGcLfHymiqwPVlxazCYz+e1GSI3ZXvEtttnnrFNTdBryH1pp4q2CTczLI/gbLed8Rl3dAJfAe08h8St5RgJ76p3GR4P9LaQN8PLrpbZUnXWCxwzrzI0fJHEnTC9/Ehx+OzkcL/d1L0SjbZAbS4EX9h1aH36Lr4NEaloImuAau2iieQUaGjAA8Je0Tfstz6hYipern+Qb3WHDNlT/vEI44j0Enh04r2+nlKeTIZajYiNlVnuE3ZRGSAakQxhFdgTGZXS1W8GZLVvH4TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776944258; c=relaxed/relaxed;
	bh=bFnqm5Br1q5pf0XfhOKYqXGgOc0pyuxWAbfVvLd99SU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUk78sJ+kDmeURcPgh7TC1MNvt8IvSwZ28TjajTbB2ZEi8+4ql5Haoi6TB4ST39/vPLpq/aAVz8jHW+qgS/QZmT8jmDrHLpZ0naODyVaouzK399Bx/m5HOmgkGPVoaVIiWQombefYT6I6oUOqRqCW/w1GS0bDg5vQNAh+dQGubE47kCcu4t2r2TTXyKUmflbTGaHw4TSkeAjmlzZv6vQ2eHNVlCaXQqmiWzNBcK9k9WnLuxRItTssMyfJ43N3iecZhTRnFP3wKur2H3OTb5+fPvl/AWObi0mbtGUG3T2oukzAvyjPJAp882sbpT3S75SBh0VPp6WwGUfR5vLc5Iw1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XwhgW7tG; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+e7eb1b9b1e5ffff423f6+8278+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XwhgW7tG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+e7eb1b9b1e5ffff423f6+8278+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1Yws5Gpsz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 21:37:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bFnqm5Br1q5pf0XfhOKYqXGgOc0pyuxWAbfVvLd99SU=; b=XwhgW7tGch2xj+pdcehdwi8n70
	uOkeIw7KG68bHcIeY67PSrtPAd1x4yrw1Gx+mYUZ0REgnRUclDiV1WUF5X84erIWc5f+VoSOSW4AO
	BJnSLRWCPoLXUKgkTDG6kD1bHkzgCvoYlIQaJg6uHRNr0lE24qjTekMn0xJtwA6faSyHE7xOMVTdy
	/DZbgS5nmSknxgNEGS+RR/y0ml+eH8IBJ6EKA8BN2NCvlO+fprDU2Ux8z5iy14tSLCCvBYlBsshuM
	EF8SdYLMaMj1tzOpSmcEOeEneGwDSiV30wazuAGXsh3vRWafyo/TVqpSnCn4LCNsRvy8+WLGwdJ0M
	QzDImPag==;
Received: from [172.31.31.240] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsMe-0000000CxD7-01dC;
	Thu, 23 Apr 2026 11:37:00 +0000
Message-ID: <15fd7d5819f33dd5e880a351b6c8115cc75bbaf7.camel@infradead.org>
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
From: David Woodhouse <dwmw2@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Philip Prindeville
	 <philipp_subx@redfish-solutions.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, openwrt-devel
 <openwrt-devel@lists.openwrt.org>, Guy Ellis <guy@traverse.com.au>, 
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org,  linux@armlinux.org.uk,
 tsbogend@alpha.franken.de, maddy@linux.ibm.com,  mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com, 
 razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com, 
 mchehab+huawei@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au, 
 geert@linux-m68k.org, ebiggers@kernel.org, johannes.berg@intel.com, 
 jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com, 
 fourier.thomas@gmail.com, rdunlap@infradead.org, akpm@linux-foundation.org,
  linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Date: Thu, 23 Apr 2026 12:36:59 +0100
In-Reply-To: <aenP-TVgF-PrayEu@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
	 <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
	 <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
	 <aenP-TVgF-PrayEu@ashevche-desk.local>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-giyqjUvQEX7jP9u8Ofpw"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-giyqjUvQEX7jP9u8Ofpw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-23 at 10:53 +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 08:41:27PM -0600, Philip Prindeville wrote:
> > > On Apr 22, 2026, at 7:05=E2=80=AFAM, David Woodhouse <dwmw2@infradead=
.org> wrote:
> > > On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:
>=20
> ...
>=20
> > > > =C2=A0=C2=A0=C2=A0 I'm still deleting the solos driver, chances are=
 nobody uses it.
> > > > =C2=A0=C2=A0=C2=A0 Easy enough to revert back in since core is stil=
l around.
> > > > =C2=A0=C2=A0=C2=A0 The guiding principle is to keep USB modems and =
delete
> > > > =C2=A0=C2=A0=C2=A0 the rest as USB ADSL2+ CPEs were most popular hi=
storically.
> > >=20
> > > Still not entirely convinced; I worked on both USB ATM modems and on
> > > Solos, and the Solos is both the most modern and the only one I still
> > > actually have. And the only one we have native support for that could
> > > ever do full 24Mb/s ADSL2+, I believe.
> > >=20
> > > If we drop it, OpenWrt will need to drop support for these, which I
> > > think were quite popular at the time; there were a few UK resellers:
> > > https://openwrt.org/toh/traverse/geos1_1
> > >=20
> > > I still don't actually care *enough* to try to find an ADSL line I
> > > could plug one into for testing though... :)
> >=20
> > I have 3 boards lying around if anyone wants them.
>=20
> The problem as I understand it is in one's willing to maintain and
> support that driver while doing regular testing...

Sure, but that's true of the usb-atm devices too, and I threw all of
*those* in the skip already. :)

I'll be more surprised if anyone is actively using one of those, than I
would be if someone is using Solos. *If* we are going to keep the USB
devices, I'd suggest it makes sense to keep Solos too.



--=-giyqjUvQEX7jP9u8Ofpw
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyMzExMzY1
OVowLwYJKoZIhvcNAQkEMSIEIAKihgnDs+u9jIiZYQD9sBrURM0r9Aa6lQZSzu4u6NadMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAam9w1edb95ci
KbOJSCr4JQ49reJ8juoPBXE10SrzqAmh+lCkNePzl6zrc5usEsg5FV6AVgG0GkLwf9sayjjhFHmj
DQMrD7XNOvt1uH6sdOeeKkSiMWGb6RL1Mq7ZAa0hiD6466WPD+q2WPWFHkuormGGGbV352QeOnS6
ET5PodWkdJFXL+7EZ/4dYc/nGlycSnOIiPqCE9Wj3He95TWj3s4S7I0FjPjEL1YenOO8Dfx7s9k4
1pbe9cM+vEA02n2PN9E6Az8UdBgY5LbYLyqNfI2tKeljnBF8h8uQr7cpF3WrzFYP4QLcfL84kh82
5Pypk40APppYLRPuEVsQ52ZYy5GrUNbp0DpWQKWGLM8ISKk8i0TNYCvUGYeeO+OmTneP/eYYlGDI
YUVEZaOzkDEFjIuPNEdSZVTUuqVK14ZH3WYyPxMABXXjtQtadkzzLZSMCMtHj59GzHrxZ4Eniku/
VyhircGMsrRcjfFYE/du49npOva2CjBYVKy1XgRp2JoocjBqjzgUq91crbnjPkquK7LttEduYKAV
deUOc5r0QqcTIE3c85DPn/SkdYBTcueHAv/xJUzXK1Bn/lnXaVthJxKNk+PcGiVTkmxtO8v6Mky6
qLjHZzLXlxFrgIHaQzsjPHyOZPllznp+ee/LMyJTTLz98RLCSHArUb4vBhUeHJYAAAAAAAA=


--=-giyqjUvQEX7jP9u8Ofpw--


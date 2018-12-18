Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:06:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CA9217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CA9217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K4Dj1fpWzDqZm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 04:06:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K4B90BTQzDqW0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 04:04:15 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1gpakj3Hjx-00LFYi; Tue, 18
 Dec 2018 18:04:04 +0100
Date: Tue, 18 Dec 2018 18:04:03 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181218170403.GF24278@latitude>
References: <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
 <20181218030538.GA24278@latitude>
 <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
 <20181218140714.GC24278@latitude>
 <96539c09-ea57-43d6-bae9-7371235b175f@c-s.fr>
 <ee4322c4-60e1-94c5-1e55-5d4c3e4de03b@c-s.fr>
 <c1ee5c7f-d683-924f-68cb-43e1fe14363a@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <c1ee5c7f-d683-924f-68cb-43e1fe14363a@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:vOTDsAX29Qu/G5fkkoHo8SlhyFbmGZy5X7EJrcrzQXOO7NNcDE2
 +3R/hXoLqe41utdVArDd5A6yUPkXLMhXeufp4jgvhHha8AXSlcpfioAVKdcIDu0e7GqAwHG
 E02Y2QTm4O0C0tsCI8kIukmeWyOgwWQTdr+S9qgQB4IoqIkqmZbv9dVKlDNqCTBk9uG6Wxn
 Io8BsnrxT/oI+Cac6I5wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Whz/1x0dDc=:nLrSFRAs+ynZYFKaB95egx
 7/Ufepo4I/DCWqzjMaNyO6MIXkCNXco9CbuIsiI34///BIiCm38npytRTd//dm9c7nPKPV1j9
 vZ1Gv+H9HQpj6p9UtxieK2keAwySBP/uZ/OThLCDt9Pi5xceb3RsNfgOAAfVx54iqYt7rWm67
 AwcGWWt6ASHuCCPkVHCgeItmkGWX23QQDcMc3FNsZoodAK/71kQVuWFSYzYki+Y6BDlhCCuy5
 cLIOdeDks4UV3v6YVw2eCK+R/X5ZTRDPHG+z+OH0S/vc+VaZIbanrH8uItYTmIgwc/ZGL6vLu
 cwxWc9kMx/+L3q5qAsvslzEmNb6oNhjXOdpwU+gMlFfXwf/M1Iwna13Fa80quoOO8I4YAs7FU
 slhsNJ8hj4JCV46ivTC1hrWrwOLJRgg1YJrEOCHtCngRU+87l9JAJOyQeh0b6ky+82iA08K2j
 Hi+seB1xIVAcbLG5ThfQSfk1kQvzYf6pFVrxXd8ePfYITL5lskNCrtakLjqUHeeOl6fP/GGuA
 wkys0oM5hafm1Lsvd9jtLJpcfVI23E9fCdUAOkD5ypv5VfVOmjrNk/Qh7no1YhSwcga6PgdE6
 gmkBtCQQkKUZ0XZRm7WldlexqU3wPYPR6grMIA3CWfluZ7aHyC+hNsZBh6WCB945w9be7XpY1
 SOxjke0WgKngeE+yCEULO3XqL4e3FflGx8Ad3D0hE5EGz1bUn096G7k8Sp8YP2A77uAleDfRv
 P5MOMQaCmfn0h1YDNX249/w6WOrT45P3CxFzO31+s7Uca757V5AcjLI932XIh2e/xMSnATUvI
 TSPHuEWIyn2FgYE7SLuXNZ6Bp8vrK7U3jhTjghGax1589waF6ckL++tSW4p+mxeezWzZm1KcY
 IrEVF0h7yfj3D8nxUotjwpo1WjHIFXLJ8agaLlryts5i+mdEqWkLkgl30E/cq3
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 04:04:42PM +0100, Christophe Leroy wrote:
> Stupid of me. In fact at the time being, BATS cover both RO and RW data
> areas, so it can definitly not be mapped with PAGE_KERNEL_ROX.
>=20
> In fact, as I have CONFIG_BDI_SWITCH in my setup, PAGE_KERNEL_TEXT is
> PAGE_KERNEL_X on my side. That's the reason why I missed it.
>=20
> With this change being done to patch 3, does the overall serie works for =
you ?

Yes, with the PAGE_KERNEL_X change, the whole series boots on the Wii.


Jonathan

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwZKHoACgkQCDBEmo7z
X9tpig//bmhSTq1Kh7bclVY1IgUPwMgUUmIP/xkQbC91G/VM4IDeL+waD6YRYskK
7Ab20CFU6zl6doeot+NdmiZ9vx1sg+73AsxIAIPL2bMXW/lW3CFQDtw+kWsol679
D4WOU3+01OumtFNWKFOp/opHfAZpvudrJnK1tgaTM8Ocp4E+GRof/ZBJc142QiR5
9jJMfY+xPTqxHRVyXg5pHZGV6WJurhb3Gp4Up9JH0AK1o1NoIYQmuxQGAacZs266
/wSY/6j1OhWGa2iSPs9EQ5Up+YPrG7pcC4UU1rE0YsnqRE4uFaWD7rSysNgi9KlX
g2vDlRm8mLP965W0Xr5Kg+VBqkQIhFNHdD4Gvp7ZJzIrwMtp1J0nEm+zYFxA8jt0
LvbZxsSZyC3BhClzEDhbgBSqsqVCDXWUBpAxaKrt3RNY/8dZyvozoDifxM1YXGu2
znJPAn7uJwJdFLSIcjwj7f90eVI8tgZ1nsHT1jtOf8IEr2av0I1Cj78wK4/80Sqg
yvKvOdeBqFr16T8k3TLDkRylSVpLpSKdRmxz+bJ85qXg/yb0CdRLqZDThZ8cT8mK
WLjHcVX376SybBQbI+OVTDNVXCdcUmxZme8gDu/pfPzQgLtEbI31cLc57Q2Ypm6q
cKRKRtSZI8KvvPtSZ93kQrmlxEtaYXjCZgz5Hnl/Yn3tB0Ww+30=
=zGQU
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

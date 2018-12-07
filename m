Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B55C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535B52082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535B52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BLy5201jzF0RC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 05:45:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 43BLtw4DvbzF0Pv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 05:42:48 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 6190872CC59;
 Fri,  7 Dec 2018 21:42:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 549507CEAAE; Fri,  7 Dec 2018 21:42:46 +0300 (MSK)
Date: Fri, 7 Dec 2018 21:42:46 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207184246.GA31278@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207163410.GA19110@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20181207163410.GA19110@redhat.com>
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
Cc: Eugene Syromyatnikov <esyr@redhat.com>, linux-kernel@vger.kernel.org,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 05:34:10PM +0100, Oleg Nesterov wrote:
> On 12/07, Dmitry V. Levin wrote:
> > On Fri, Dec 07, 2018 at 10:12:49PM +1100, Michael Ellerman wrote:
> >
> > > > Sorry, this patch does not work, please ignore it.
> > >
> > > Hmm OK. Why exactly?
> >
> > Unfortunately, I have no idea why it doesn't work.
> > All I can say is it breaks strace because the kernel no longer sends
> > syscall entry stops.
>=20
> May be because TIF_SYSCALL_EMU/etc is a bit number, not a mask? IOW, rath=
er
> than
>=20
> 	whatever & TIF_XXX
>=20
> you should do
>=20
> 	whatever & _TIF_XXX
>=20
> intstead?

Thanks Oleg, this was exactly the reason why it didn't work.
That kind of things happens when you let userspace people hack you kernel. =
:)


--=20
ldv

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcCr8mAAoJEAVFT+BVnCUIStwP/RCWLHfccYIYOaOZbt2c+XfP
o4z6JNFxh37RDbYe+7Omdn+UNJKHc+QHkaRK3fO/2aceuGIshUkqi6IvV6pXy4au
jYxFyD75dgYTV33iDvFOFrATkCXHy3jRxZpKaQOxWdMRBIdgPHTqhgFh2fL0T9i4
Ld/eoaUiUd1KwdpzuJod5S5IxEFkjQdnAollvroo0tAFvC6PRO1MqxvDGZ1SAyA1
umN9tG5GMFXKVlKRnuX1wp54EBB//idStq0CVCdLdEWi3MlcMPPGFXOZYndIS5SN
0XXD5CD3FFMt+Gl+1kP4Z1V+cOTYCajKWN7NLzVq79gPwqP3Fy7BWmVSzXyh2qFD
npF/qcGX4zh3OilqY/8MM2T9MHH5I7Hi9WCWag2HmRVDc9nkvXpgPB5572XFF038
wEDV4ZBH/+uPzm53pushoFL7za/WKS+y0QIEIxy0aS12fXCsvUx1xIniPk2PfgXK
aIjQje0UeVC5MQ0Qabmkavg849KsyoBR+kZA57bsv+PydyWR2MJPIWpmvB2OVwBc
yuudwLTrkIZm30qE7w1cEROzWgTUnC/DcUDVu7zjtlLV41mITDxwcTTdWP0/OvCv
UvyW5K3VPGviyvfNMT6bCH86Cjb5W2DqCxcdeW2ZvBXUnjS+KxnKQh9ulrSJqCm9
+mFvkgjOZJ324Ure7AZh
=3hv8
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

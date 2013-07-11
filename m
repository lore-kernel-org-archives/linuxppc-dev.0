Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 6C5042C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 18:45:11 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 30309-04 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 11 Jul 2013 09:45:04 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Thu, 11 Jul 2013 09:43:35 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
In-Reply-To: <1373492893.8183.236@snotra>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013)
 <1373492893.8183.236@snotra>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Scott Wood" <scottwood@freescale.com>,
 "Haijun Zhang" <Haijun.Zhang@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org,
 r39252@freescale.com, AFLEMING@freescale.com, X.Xie@freescale.com,
 cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +#define IS_SVR_REV(svr, maj, min) \
> > +	((SVR_MAJ(svr) =3D=3D (maj)) && (SVR_MIN(svr) =3D=3D (min)))
>=20
> I don't think IS_SVR_REV is needed.  Callers can just do "if
> (SVR_REV(svr) =3D=3D 0x30)" or whatever, especially since we're =
relying on
> them to do this for greater/less than comparisons.

Not only that, I'd guess that 'maj' and 'min' are likely to be
constants - so you'd want to combine them and compare against 'svr'
rather than have two conditionals.

	David

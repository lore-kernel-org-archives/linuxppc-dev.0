Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0C9E14008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 20:55:19 +1100 (EST)
Received: by mail-pd0-f181.google.com with SMTP id p10so4614628pdj.40
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 02:55:17 -0700 (PDT)
Date: Fri, 28 Mar 2014 17:54:57 +0800
From: Kevin Hao <haokexin@gmail.com>
To: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
Subject: Re: [PATCH] powerpc/irq: Remove HAVE_IRQ_EXIT_ON_IRQ_STACK feature
 at powerpc platform
Message-ID: <20140328095457.GC2176@pek-khao-d1.corp.ad.wrs.com>
References: <1395992312-23035-1-git-send-email-dongsheng.wang@freescale.com>
 <20140328081827.GB2176@pek-khao-d1.corp.ad.wrs.com>
 <98283b6c8da549479d924d99d2b6d300@BN1PR03MB188.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
In-Reply-To: <98283b6c8da549479d924d99d2b6d300@BN1PR03MB188.namprd03.prod.outlook.com>
Cc: Ingo Molnar <mingo@kernel.org>, James Hogan <james.hogan@imgtec.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "fweisbec@gmail.com" <fweisbec@gmail.com>, Helge Deller <deller@gmx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@au1.ibm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 09:00:13AM +0000, Dongsheng.Wang@freescale.com wrot=
e:
> Thanks Kevin. Your patch works normal. :)
>=20
> I still have some confused. I think when __do_softirq always get a interr=
upt, the hard stack will be run out, isn't it?

No, it won't. Please see the explanation in the following commit log.

commit cc1f027454929924471bea2f362431072e3c71be
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Tue Sep 24 17:17:47 2013 +0200

    irq: Optimize softirq stack selection in irq exit
   =20
    If irq_exit() is called on the arch's specified irq stack,
    it should be safe to run softirqs inline under that same
    irq stack as it is near empty by the time we call irq_exit().
   =20
    For example if we use the same stack for both hard and soft irqs here,
    the worst case scenario is:
    hardirq -> softirq -> hardirq. But then the softirq supersedes the
    first hardirq as the stack user since irq_exit() is called in
    a mostly empty stack. So the stack merge in this case looks acceptable.
   =20
    Stack overrun still have a chance to happen if hardirqs have more
    opportunities to nest, but then it's another problem to solve.
   =20
    So lets adapt the irq exit's softirq stack on top of a new Kconfig symb=
ol
    that can be defined when irq_exit() runs on the irq stack. That way
    we can spare some stack switch on irq processing and all the cache
    issues that come along.
   =20
Thanks,
Kevin

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTNUbxAAoJEJNY7TDerrFxcQ8IAIhRsb+6usiUbeZBnn3wwWDB
/ki+dXC8WPsWiJ6U3sjGUtX61FEziOTKfCfQRDDvnxkJc1L/DjLkw9dMSrm8dRtP
gT1lC+0X5Srt+9tlgP7/nkay73zaTmNiTlkDT8jVFUBe1mxX4qfN4acJMs0eqPEq
tf3otxx0/uPsfFjanqYC6MIsVLCqHYOMakbcVBuG8neTL89Hyf7hh6o4JqM2V3dd
AoX/WI+0/N4KnFqHLXB1ubfuUBlsMW99vnuu7xXOS0a7S05f+q97bvbtrEf8vGlt
jRIozup1lrchQnGLkKR7khEuMNYetDcSBnpNwwzie0pT9CS6iWYT0KknmUpIaH0=
=r0/f
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

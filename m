Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 143271A0501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 21:17:07 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so106800041pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 04:17:05 -0700 (PDT)
Date: Mon, 17 Aug 2015 19:16:55 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd
 lock acquiring codes
Message-ID: <20150817111655.GA26870@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-2-git-send-email-haokexin@gmail.com>
 <1439491483.4099.101.camel@freescale.com>
 <20150814071309.GH30310@pek-khao-d1.corp.ad.wrs.com>
 <1439606668.15601.15.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <1439606668.15601.15.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 09:44:28PM -0500, Scott Wood wrote:
> I tried a couple different benchmarks and didn't find a significant=20
> difference, relative to the variability of the results running on the sam=
e=20
> kernel.  A patch that claims to "optimize a bit" as its main purpose ough=
t to=20
> show some results. :-)

I tried to compare the execution time of these two code sequences with the
following test module:

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/printk.h>

static void test1(void)
{
	int i;
	unsigned char lock, c;
	unsigned short cpu, s;

	for (i =3D 0; i < 100000; i++) {
		lock =3D 0;
		cpu =3D 1;

		asm volatile (=09
"1:		lbarx	%0,0,%2\n\
		lhz	%1,0(%3)\n\
		cmpdi	%0,0\n\
		cmpdi	cr1,%1,1\n\
		addi	%1,%1,1\n\
		bne	2f\n\
		stbcx.	%1,0,%2\n\
		bne	1b\n\
2:"
		: "=3D&r" (c), "=3D&r" (s) : "r" (&lock), "r" (&cpu) : "cr0", "cr1", "mem=
ory");=20
	}
}

static void test2(void)
{
	int i;
	unsigned char lock, c;
	unsigned short cpu, s;

	for (i =3D 0; i < 100000; i++) {
		lock =3D 0;
		cpu =3D 1;

		asm volatile (=09
"		lhz	%1,0(%3)\n\
		addi	%1,%1,1\n\
		crclr	cr1*4+eq\n\
1:		lbarx	%0,0,%2\n\
		cmpdi	%0,0\n\
		bne	2f\n\
		stbcx.	%1,0,%2\n\
		bne	1b\n\
2:"
		: "=3D&r" (c), "=3D&r" (s) : "r" (&lock), "r" (&cpu) : "cr0", "cr1", "mem=
ory");=20
	}
}

static int test_init(void)
{
	unsigned long s, e, tm1, tm2;

	__hard_irq_disable();
	/* Just for prefetch */
	test1();
	s =3D mftb();
	test1();
	e =3D mftb();
	tm1 =3D e - s;

	/* Just for prefetch */
	test2();
	s =3D mftb();
	test2();
	e =3D mftb();
	tm2 =3D e - s;
	__hard_irq_enable();

	pr_err("test1: %ld, test2: %ld, %%%ld\n", tm1, tm2, (tm1 - tm2) * 100 / tm=
1);

	return 0;
}

static void test_exit(void)
{
	return;
}

module_init(test_init);
module_exit(test_exit);
MODULE_LICENSE("GPL");

The results:
test1: 156568, test2: 151675, %3
test1: 156604, test2: 151670, %3
test1: 156567, test2: 151684, %3
test1: 156567, test2: 151678, %3
test1: 156567, test2: 151688, %3
test1: 156570, test2: 151683, %3
test1: 156565, test2: 151675, %3
test1: 156565, test2: 151673, %3

It seems that there do have a %3 gain in performance by moving the
3 instructions out of lbarx/stbcx loop.

Thanks,
Kevin

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0cKnAAoJEJNY7TDerrFxdn8IAKj7PEH2PlarCtXxi5VMUSWp
sj75VKQVKucFPKZ1ZsHy/lFUsmkEhzEWxr6bYzs4b42I8vgfEyp2c8zmOABKBHFf
0rql82kExAMBQoMdJKVVOnh7gG7M+Sa/4wJgdpTMObHSnHcDCJxGpLikwj7PK54Y
dDdG95C7lJDmQd4nE95E5SyIJiXsDKHu7rOAFJLva6+BVCubym6z9d3DdH5cD8R1
lNNRInglmLExw+cRQdYpghTC0AWGpgcHzmoO49+nnMw+bK0nYOu/PtCchX+/mIOc
ZaiS/rBAtG9CG97jwOu6hhUz5kfMS6c2cE2hklZORAqzYkXdQufG5nWSBEysrx4=
=KqSy
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

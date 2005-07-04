Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id A4D2A67C1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 00:35:46 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 36so722349wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Jul 2005 07:35:45 -0700 (PDT)
Message-ID: <4dd15d1805070407352bd5120e@mail.gmail.com>
Date: Mon, 4 Jul 2005 10:35:45 -0400
From: David Ho <davidkwho@gmail.com>
To: openssl-dev@openssl.org
In-Reply-To: <42C57F30.902@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14856_9497586.1120487745585"
References: <4dd15d1805063003587276af7e@mail.gmail.com>
	<4dd15d1805063015226379a52c@mail.gmail.com>
	<42C57F30.902@fy.chalmers.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC bn_div_words routine rewrite
Reply-To: David Ho <davidkwho@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_14856_9497586.1120487745585
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Good morning gentleman, =20

Let's start the week off with less hostility and more productive
criticism on this topic.  As I see it, the popular Linux distributions
are not that interested on ppc32 since neither Novell nor Redhat
openly support this arch.  We will have to put our heads together to
make ppc32 a stable Linux platform.

On 7/1/05, Andy Polyakov <appro@fy.chalmers.se> wrote:

> BN_div_word does write to memory, but I fail
> to see how a bogus value could possibly trigger seg-fault.=20

Assuming that you are a maintainer of the openssl code, which I gather
you are, would you even care to take the time to examine the code in
suspect, or find someone who is capable of doing that, I'm sure you
must have a lot of friends, at least one who is knowledgeable in the
ppc32 arch.

> The only
> possibility is that assembler doesn't follow ABI convention and corrupts
> registers, which caller is using/expects to be preserved by callee.
> There're several PPC ABI flavors in use, but OpenSSL routines were
> designed ABI-neutral, Well, "neutrality" really means "common
> denominator for ABI specs examined at the moment of coding," so there is
> a window of opportunity that it won't be "neutral" to future ABI, but is
> it really case?=20

I don't understand the terminology you use here.  As I understand it
ABI is there so binaries can inter-operate in the case of dynamic
loading, when the ABI is consistent you can use any compiler that
conforms to the ABI and those binaries can work together.  As I see it
I'm building openssl and openssh with the same compiler so what is the
real issue here?  Or is it an issue at all?

If you are referring to C calling convention, then I can only guess
you have figured it out or otherwise none of the assembly routine will
work.

> That your system uses some newly designed PPC ABI? You
> never mentioned what's your system...

In my very first email, I have already said quote "tested on a MPC8xx
processor"  and I am using 2.4.24 which is nothing close to the
bleeding edge so I reckon the ABI is fairly standard.

Do you have any experience with the PowerPC arch? =20

> But you're apparently right about a bug being present in PPC assembler.

So you are saying there is a bug in the GCC assembler?  How confident
are you in that?  Is the first correct step to examine the assembly
code for errors before jumping to any conclusion that the GCC
assembler is bad?

> >>This is a rewrite of the bn_div_words routine for the PowerPC arch,
> >>tested on a MPC8xx processor.
>=20
> Well, suggested routine apparently sends ssh-keygen on the PPC-based
> 32-bit system I have access to to an end-less loop...=20

If you care to read the c function I supplied or if you don't believe
it:  If you understand ppc 32-bit instructions, as specified in the
PowerPC Microprocessor Family: Programming Environments for 32-Bit
Microprocessors.  My routine would not be able to find a condition
that will make it go into an end-less loop,unless you messed up bad
somewhere.

> And (cd test; make
> test_bn) fails early in BN_sqr... And test/exptest fails miserably with
> "bad reciprocal"...

I don't know what you did but (make test_bn) works for me.  So I
question how diligently you are in setting up the tests.  If you are
busy, please get one of your ppc friends to do it.

> >>I initially thought there is maybe a small mistake in the code that
> >>requires a one-liner change
>=20
> But apparently this appears to be the case! Please verify following:
>=20
> --- crypto/bn/asm/ppc.pl.orig        2004-04-28 00:05:50.000000000 +0200
> +++ crypto/bn/asm/ppc.pl      2005-07-01 18:58:21.105656512 +0200
> @@ -1717,7 +1717,7 @@
>          li      r9,1                    # r9=3D1
>          $SHL    r10,r9,r8               # r9<<=3Dr8
>          $UCMP   0,r3,r10                #
> -       bc      BO_IF,CR0_GT,Lppcasm_div2       #or if (h > (1<<r8))
> +       bc      BO_IF_NOT,CR0_GT,Lppcasm_div2   #or if (h > (1<<r8))
>          $UDIV   r3,r3,r0                #if not assert(0) divide by 0!
>                                          #that's how we signal overflow
>          bclr    BO_ALWAYS,CR0_LT        #return. NEVER REACHED.
>=20

You don't think I have gone in and fix that before realizing it's
worse than that?  I am sure you didn't think I spend 3 days out in the
beach and somehow come up with an idea of clobbering some useful
routine because I think my routine is better?

In summary, what I am trying to provide the community is an
alternative to do something, the current implementation of which is
very questionable.  You might resist change which is understandable.=20
But I were a diligent maintainer and I realize something is broken in
my code, then I will put the time to investigate the problem.  If I
don't have the time, I will delagate it to a friend.  If I don't have
a friend with that expertise then, I will try to make friends with the
reporter of the bug since he will most likely have spent hours fixing
the problem.

Regards,
David Ho.

------=_Part_14856_9497586.1120487745585
Content-Type: text/plain; name="test_bn.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_bn.txt"

YmFzaC0yLjA1YiMgbWFrZSB0ZXN0X2JuDQpzdGFydGluZyBiaWcgbnVtYmVyIGxpYnJhcnkgdGVz
dCwgY291bGQgdGFrZSBhIHdoaWxlLi4uDQp0ZXN0IEJOX2FkZA0KdGVzdCBCTl9zdWINCnRlc3Qg
Qk5fbHNoaWZ0MQ0KdGVzdCBCTl9sc2hpZnQgKGZpeGVkKQ0KdGVzdCBCTl9sc2hpZnQNCnRlc3Qg
Qk5fcnNoaWZ0MQ0KdGVzdCBCTl9yc2hpZnQNCnRlc3QgQk5fc3FyDQp0ZXN0IEJOX211bA0KdGVz
dCBCTl9kaXYNCnRlc3QgQk5fZGl2X3JlY3ANCnRlc3QgQk5fbW9kDQp0ZXN0IEJOX21vZF9tdWwN
CnRlc3QgQk5fbW9udA0KdGVzdCBCTl9tb2RfZXhwDQp0ZXN0IEJOX2V4cA0KdGVzdCBCTl9rcm9u
ZWNrZXINCi4uLisrKysrKw0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLg0KdGVzdCBCTl9tb2Rfc3FydA0KLi4uLi4NCi4uLi4uDQouLi4uLg0KLi4uLi4NCi4uLi4u
DQouLi4uLg0KLi4uLi4NCi4uLi4uDQouLi4uLi4uKysrKysrKysrKysrDQouLi4uLg0KLi4uLi4u
KysrKysrKysrKysrDQouLi4uLg0KLi4uKysrKysrKysrKysrDQouLi4uLg0KLi4rKysrKysrKysr
KysNCi4uLi4uDQouLi4rKysrKysrKysrKysNCi4uLi4uDQouLi4uLi4uLisrKysrKysrKysrKw0K
Li4uLi4NCi4uLi4uLi4uLi4uLi4uLi4uKysrKysrKysrKysrDQouLi4uLg0KLi4uLi4uLi4uLi4r
KysrKysrKysrKysNCi4uLi4uDQpydW5uaW5nIGJjDQoNCnZlcmlmeSBCTl9hZGQuLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQp2ZXJpZnkgQk5fc3ViLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQp2ZXJpZnkgQk5fbHNoaWZ0MS4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCnZlcmlmeSBCTl9sc2hpZnQgKGZpeGVk
KS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCnZlcmlmeSBCTl9s
c2hpZnQuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQp2ZXJpZnkg
Qk5fcnNoaWZ0MS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCnZl
cmlmeSBCTl9yc2hpZnQuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
DQp2ZXJpZnkgQk5fc3FyLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Lg0KdmVyaWZ5IEJOX211bC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KdmVy
aWZ5IEJOX2Rpdi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KdmVyaWZ5IEJOX2Rpdl9yZWNwLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uDQp2ZXJpZnkgQk5fbW9kLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLg0KdmVyaWZ5IEJOX21vZF9tdWwuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCnZlcmlmeSBCTl9tb250Li4u
Li4NCnZlcmlmeSBCTl9tb2RfZXhwLi4uLi4NCnZlcmlmeSBCTl9leHAuLi4uLg0KdmVyaWZ5IEJO
X2tyb25lY2tlcg0KdmVyaWZ5IEJOX21vZF9zcXJ0DQoyMDE1IHRlc3RzIHBhc3NlZA0KdGVzdCBh
XmIlYyBpbXBsZW1lbnRhdGlvbnMNCi4uL3V0aWwvc2hsaWJfd3JhcC5zaCAuL2V4cHRlc3QNCi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uIGRvbmUNCg==
------=_Part_14856_9497586.1120487745585--

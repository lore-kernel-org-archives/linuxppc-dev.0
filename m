Return-Path: <linuxppc-dev+bounces-18179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5910107BCD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 17:11:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXWHN1bQbz3cKj;
	Sat, 14 Mar 2026 04:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773421904;
	cv=none; b=SRudti8qCU75ldqcrMBjo4n7d44zSyCoGkSM58smcEeCOXDNtuCtfO30gPskzIGDTUeozULLaEb4UbtwFQ6cihj5eaPdQXF4tYDTEd3IB8TwO19JKNB+5uTzdg3kdicPeYuX/ogLCzjFsXcCCqXlL+N9AAd/LGwU9Y7VlMlfdJvN5yiLN9F0u2zJYyXSZq9nDcZFR68EsNemXvkGZI2DcVRFJNPG3aWsqsOorV2acQi5qK2tvukeQLlGNBr8urW+Vnl7Ib+1dcCsJVks+i3mGgD4c4vySv2EzJg/RTq+srimIPKZXdxG41XpIEGLCuheqmlNdNGUCkZj+kDCBRO6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773421904; c=relaxed/relaxed;
	bh=fPJxJVeVm/7iVYh0IAy2Dh155dUXC6i12jwzjOceanY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZFE23VFPZ1bjrOqwpFyoGrLfLAJJ9lEB7Qs479XWvX/ITo8+24aT++EuiZhR7J+KZgwjyML402eOya/tQXPYWHVNqCTbJMExX9HkBpDcCEWj7SXKJZTNYfKU1RW8B2mr+wKJBCneE91FQuqwy/aFPvp3DK3A5Gf8ulXng2NL4Cv1GT9wkSczUsPISQW5eUHUKbKwJowjKPUiMap8LA7dbsE1SAdbL6xibd3+vvERiX5bKqwcCNdTOWoycgRY+Jk1GRWM24C6wb3JMlfyt+9aaVWXKjvTv7CWhjT6Xjfq7LCxisd3U8ford8PP35Chq4QP76aIHUNKA/1h1/UninQhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SQ5cNwFQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SQ5cNwFQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXWHL4RgHz3cKT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 04:11:42 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D54Z7H2257262;
	Fri, 13 Mar 2026 17:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fPJxJV
	eVm/7iVYh0IAy2Dh155dUXC6i12jwzjOceanY=; b=SQ5cNwFQ4HfJOGARYLbFvH
	rwy7iCZBeLI5ocbkiO/92eLvnblTe8bjfoaqwvIvhEZeO1HlzRnuq3CeduuzmTMw
	DkoZ2tphHKzoIhxQdoQbhtFs+wXM3+SCpzk3wXlz9Du4erXyOjZm8rXDu/iBiJ2B
	AttgYETB4znNG67qOoII6uGgkoDYl71QrVJKc1NbAFkyxFkl/Jgwgbx7tl+d/PRv
	hCvv8fXpmt2O7SAECbuAqTLDaF1Y6MevYb0bHCdk2ExBgTS7RBGISEsvX3M6dB0N
	QhG+NqS6nl/7KNq7mdhxysbqnnQooATB4HLHo8rL60xKA9OIWZl5Smb+Dq7xKuYA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92gwju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 17:11:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF13Wl018361;
	Fri, 13 Mar 2026 17:11:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha87k0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 17:11:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DHBKRX27067062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 17:11:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7244658056;
	Fri, 13 Mar 2026 17:11:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 594265803F;
	Fri, 13 Mar 2026 17:11:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.43])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 17:11:17 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] selftests/powerpc: Suppress -Wmaybe-uninitialized with
 GCC 15
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260313165426.43259-1-amachhiw@linux.ibm.com>
Date: Fri, 13 Mar 2026 22:41:04 +0530
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9724700A-A722-432A-879F-30CCF5D0FA0B@linux.ibm.com>
References: <20260313165426.43259-1-amachhiw@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5sCbfRf8xYKlThlaHBSsZIxt--gCyjRE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzNiBTYWx0ZWRfX2tPdMOUyTEho
 Ms9KbkxwvYhGy0ASKPxhcNqOwA79XsM2pgBLtAmKbxks5JJxLBQq0MiPGiALIyYASOUCi25NGQq
 jKScfNUZ3xnUHEXju3vt68kbNQKBtR2RYmLo69FzFbqGCQmt2Zqvk1SG+yHiF5Bj+Lp53q3DDyR
 +4nsLH7wAfHuniPAfwN+/xuKpg841zt++PIewZ5nfaR98Rn7Ih7rfiT/F1jaDEJzbZXFHR2/2Cy
 w/jg+vlqeTcAEKcynO5Lq/sxLt+CsQVxqeh7QzEbhmibddnVx1mOPGKyNplL4kwTDLSKGiX2s5t
 ZLDJPNwR9NmWMDSilBXZ9M0S+o309lyXoy0iAcYc1No+ah8pqv0aP13TCxja5avOjLUGgvEKHAP
 f5b7fWPC0ZFffpEpAMhRHcfWRBbaWBRgAOA50Ii6jctAuXBv0TtgAgd20DA/XhTd0TqcBgUZC1d
 gkMIrMeVnIwo3i3jplw==
X-Proofpoint-GUID: OgdsIt4rAWwDLbkf2snSXI-Yb4TyM0Zq
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b4453b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HFgsHm5sTANq41GHjwkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130136



> On 13 Mar 2026, at 10:24=E2=80=AFPM, Amit Machhiwal =
<amachhiw@linux.ibm.com> wrote:
>=20
> GCC 15 reports the below false positive '-Wmaybe-uninitialized' =
warning
> in vphn_unpack_associativity() when building the powerpc selftests.
>=20
>  # make -C tools/testing/selftests TARGETS=3D"powerpc"
>  [...]
>    CC       test-vphn
>  In file included from test-vphn.c:3:
>  In function =E2=80=98vphn_unpack_associativity=E2=80=99,
>      inlined from =E2=80=98test_one=E2=80=99 at test-vphn.c:371:2,
>      inlined from =E2=80=98test_vphn=E2=80=99 at test-vphn.c:399:9:
>  test-vphn.c:10:33: error: =E2=80=98be_packed=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
>     10 | #define be16_to_cpup(x)         bswap_16(*x)
>        |                                 ^~~~~~~~
>  vphn.c:42:27: note: in expansion of macro =E2=80=98be16_to_cpup=E2=80=99=

>     42 |                 u16 new =3D be16_to_cpup(field++);
>        |                           ^~~~~~~~~~~~
>  In file included from test-vphn.c:19:
>  vphn.c: In function =E2=80=98test_vphn=E2=80=99:
>  vphn.c:27:16: note: =E2=80=98be_packed=E2=80=99 declared here
>     27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
>        |                ^~~~~~~~~
>  cc1: all warnings being treated as errors
>=20
> When vphn_unpack_associativity() is called from hcall_vphn() in kernel
> the error is not seen while building vphn.c during kernel compilation.
> This is because the top level Makefile includes '-fno-strict-aliasing'
> flag always.
>=20
> The issue here is that GCC 15 emits '-Wmaybe-uninitialized' due to =
type
> punning between __be64[] and __b16* when accessing the buffer via
> be16_to_cpup(). The underlying object is fully initialized but GCC 15
> fails to track the aliasing due to the strict aliasing violation here.
> Please refer [1] and [2]. This results in a false positive warning =
which
> is promoted to an error under '-Werror'. This problem is not seen when
> the compilation is performed with GCC 13 and 14. An issue [1] has also
> been created on GCC bugzilla.
>=20
> The selftest compiles fine with '-fno-strict-aliasing'. Since this GCC
> flag is used to compile vphn.c in kernel too, the same flag should be
> used to build vphn tests when compiling vphn.c in the selftest as =
well.
>=20
> Fix this by including '-fno-strict-aliasing' during vphn.c compilation
> in the selftest. This keeps the build working while limiting the scope
> of the suppression to building vphn tests.
>=20
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124427
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99768
>=20
> Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---

Tested this patch, and it fixes reported issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

WithOut This Patch:

make -j32
  CC       test-vphn
In file included from test-vphn.c:3:
In function =E2=80=98vphn_unpack_associativity=E2=80=99,
    inlined from =E2=80=98test_one=E2=80=99 at test-vphn.c:371:2,
    inlined from =E2=80=98test_vphn=E2=80=99 at test-vphn.c:399:9:
test-vphn.c:10:33: error: =E2=80=98be_packed=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
   10 | #define be16_to_cpup(x)         bswap_16(*x)
      |                                 ^~~~~~~~
vphn.c:42:27: note: in expansion of macro =E2=80=98be16_to_cpup=E2=80=99
   42 |                 u16 new =3D be16_to_cpup(field++);
      |                           ^~~~~~~~~~~~
In file included from test-vphn.c:19:
vphn.c: In function =E2=80=98test_vphn=E2=80=99:
vphn.c:27:16: note: =E2=80=98be_packed=E2=80=99 declared here
   27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
      |                ^~~~~~~~~
cc1: all warnings being treated as errors
make: *** [../../lib.mk:225: =
/home/upstreamci/linux/tools/testing/selftests/powerpc/vphn/test-vphn] =
Error 1


With This Patch:

make run_tests=20
TAP version 13
1..1
# timeout set to 130
# selftests: powerpc/vphn: test-vphn
# test: test-vphn
# tags: git_version:ec7d5e129
# success: vphn: no data
# success: vphn: 1 x 16-bit value
# success: vphn: 2 x 16-bit values
# success: vphn: 3 x 16-bit values
# success: vphn: 4 x 16-bit values
# success: vphn: 5 x 16-bit values
# success: vphn: 24 x 16-bit values
# success: vphn: 1 x 32-bit value
# success: vphn: 2 x 32-bit values
# success: vphn: 3 x 32-bit values
# success: vphn: 12 x 32-bit values
# success: vphn: 16-bit value followed by 32-bit value
# success: vphn: 32-bit value followed by 16-bit value
# success: vphn: 16-bit value followed by 2 x 32-bit values
# success: vphn: 32-bit value has all ones in 16 lower bits
# success: vphn: last 32-bit value is truncated
# success: vphn: garbage after terminator
# success: test-vphn
ok 1 selftests: powerpc/vphn: test-vphn


Regards,
Venkat.
> Changes since v2:
>  * Compile vphn test with '-fno-strict-aliasing' as per the =
indications in the
>    [1] instead of locally suppressing the '-Wmaybe-uninitialized' =
warning with
>    diagnostic pragma
>  * v1: =
https://lore.kernel.org/all/20260310101519.67157-1-amachhiw@linux.ibm.com/=

> ---
> tools/testing/selftests/powerpc/vphn/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/powerpc/vphn/Makefile =
b/tools/testing/selftests/powerpc/vphn/Makefile
> index 61d519a076c6..778fc396340d 100644
> --- a/tools/testing/selftests/powerpc/vphn/Makefile
> +++ b/tools/testing/selftests/powerpc/vphn/Makefile
> @@ -5,7 +5,7 @@ top_srcdir =3D ../../../../..
> include ../../lib.mk
> include ../flags.mk
>=20
> -CFLAGS +=3D -m64 -I$(CURDIR)
> +CFLAGS +=3D -m64 -I$(CURDIR) -fno-strict-aliasing
>=20
> $(TEST_GEN_PROGS): ../harness.c
>=20
>=20
> base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
> --=20
> 2.50.1=20
>=20



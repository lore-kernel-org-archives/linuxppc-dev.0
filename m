Return-Path: <linuxppc-dev+bounces-18208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6094ED58B21
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 05:16:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ3Gd049vz2xln;
	Mon, 16 Mar 2026 16:16:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773638184;
	cv=none; b=OXUlLO8PUiMB3WjcoWeg9k8AVjQSrZBumNlouSpqrF1F0I0JTZnszG4XycFPQIvsfTggLsBknd5lXaKR3cCjJZ0JkaTGPVGr6WjqNWTBZgQyrmR9IW14CWqT4VQu4rz5kNnaSS19boWGYQOmDA8osoHPZ04IjC6W4RznKk/Qiff7EHPNjvBEqcD8E2GOtpg9NiACvdmmR3XTMPGK2fjmjqdp8IQIPW+qpw5FEqWo8msZTJM8J1z8cEmokdmSdmA9IA2EJ7fdRX1bLhlKsmEk4WJ42rkFtROnumB5orelQX3EFZXUyrc4mFjLLu37pitTfB1x1u8+FSK6foqS6vWpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773638184; c=relaxed/relaxed;
	bh=fYLnzMhAivmX8BBDReQHzyLJUbnKWpDe1iNJUKQM7VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjSxenEgeAc9x7y55OYsJ5UK9Y0exJamK5frqpJPug3k+B9zlCyBzD6gSQlwin0OOHBzp4zXi1gIHNteuwZijVyRHTuumRzMdVcsiTcdcfTW4FbhqhaCdifizHhfHRfah5++WAVAInjyKvNQOCQc/ZKixLvjVZziKS4X5WmnUi44xXLx6oXVEsGOwHlwsm3g6bSnZc/yDck5U69zjZGrqwaVo5z249Qeypp2JVaf358c5xmmKkXYy9N2bZp1Z8p40SPg/SOkoUIe55jcYrymsbxXAgWjIDlF1nWkuoWRQOazln0D91kJBTahOLBUyJoOR9vwL1eP79OhmK1hWoE2QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DA9cYGjn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DA9cYGjn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ3Gb2bTrz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 16:16:22 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FKOCOf711828;
	Mon, 16 Mar 2026 05:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fYLnzM
	hAivmX8BBDReQHzyLJUbnKWpDe1iNJUKQM7VI=; b=DA9cYGjnmvbz12yo/Nme+k
	ae8DXvwLgv4/qgUugNRnw3B2f9csDcj5ol2te4oM3CjlZBgesf+I9ktOtq/AZTrO
	CHU0gnsEUC76RudeG581kC4UMsVLrONbMvbgQlWB9xXlCDUOZSZIfW9yG6usUcbQ
	Edt5z3RskBx/QRH1I7aHqKE035l2Vjy8hB9dgAtfOn0mZp8CUomf3L0qv4/d6q9L
	BpFwcG/xT9HMYfIodZcZoGd0RUrNGKOM+5VWqbm15Oi4AN7eSRpC25XQPsGe6xXR
	Zkb+TpFkc74LqAFBg+4F1ZJwCqi56kfctfxinuJT0m8iLbOB1Ma5BQuCFKBS9uvg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau5y72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 05:15:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G0NdVG032404;
	Mon, 16 Mar 2026 05:15:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jkc6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 05:15:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G5FpoZ61407622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 05:15:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CB8F2004B;
	Mon, 16 Mar 2026 05:15:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3969220043;
	Mon, 16 Mar 2026 05:15:49 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 05:15:49 +0000 (GMT)
Date: Mon, 16 Mar 2026 06:01:54 +0000
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Suppress false positive
 -Wmaybe-uninitialized with GCC 15
Message-ID: <20260316055822.cd40bb30-47-amachhiw@linux.ibm.com>
Mail-Followup-To: David Laight <david.laight.linux@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>, 
	linux-kernel@vger.kernel.org
References: <20260310101519.67157-1-amachhiw@linux.ibm.com>
 <3f26916b-5a1f-40b0-9c47-8b53e066e08c@kernel.org>
 <20260312123856.65bb5484-2e-amachhiw@linux.ibm.com>
 <20260312185653.3b8570a9@pumpkin>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312185653.3b8570a9@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAzNyBTYWx0ZWRfX8HXab0e/c0pp
 V0zcd1UCkczE9K61dA3ivno55gBLxbLIVz/q733JMth836EKqlZNFY6Jyk/Jj/itQnCObFErpxC
 MY2lgjIF8lW+oRVjiKbAgSQebGa1hUFhcbgCZoIx6zTtoIUaOyxhsdb64jU2uywkyQCdv+ezgQO
 PKMAnWyqMEuxaQ0Uk1nifjI1GcRr1Si4+e2mb4lo6Mo/fZTWtfTxRB0/wVUNoDFtB8dWuQZ9+8l
 yxe9w0q1hjA91JcpnaFXaSizyUgeQlZkkbJVJSdoQuXyQIQ1UWfwBMEi70+Jww1eZpwzPorrvn8
 1aKotR0X2Xcm04dUdeN/zme4aS918LZzN/GgqjBJk6vVNTiLiwsH3fHF6kerZngKB3IdCojACVs
 ZJUSrwmcptxfYtm9B4sdk5bDJqxZhZuu1Pq57z5LeHVaxI0m6mk5olvWqCZSzu2O0Nhy32Tg5RK
 KAnurjwOE0/Heq91QVA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b7920c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8
 a=UqCG9HQmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=uqyPSVgkIIOpVusapscA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: uH78DoSEz-1TF6TUkoRBkz4mkomLmQ14
X-Proofpoint-GUID: LjHMg8SuoYyZuwgTv5nxGeWLOEiGurDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160037

Hi David,

Thanks for looking into the patch and apologies for a late response.
Please find my comments inline below:

On 2026/03/12 06:56 PM, David Laight wrote:
> On Thu, 12 Mar 2026 13:16:26 +0000
> Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> 
> > Hi Christhophe,
> > 
> > Thanks for looking at the patch. Please find my comments inline:j
> > 
> > On 2026/03/10 11:54 AM, Christophe Leroy (CS GROUP) wrote:
> > > 
> > > 
> > > Le 10/03/2026 à 11:15, Amit Machhiwal a écrit :  
> > > > GCC 15 reports the below false positive '-Wmaybe-uninitialized' warning
> > > > in vphn_unpack_associativity() when building the powerpc selftests.
> > > > 
> > > >    # make -C tools/testing/selftests TARGETS="powerpc"
> > > >    [...]
> > > >      CC       test-vphn
> > > >    In file included from test-vphn.c:3:
> > > >    In function ‘vphn_unpack_associativity’,
> > > >        inlined from ‘test_one’ at test-vphn.c:371:2,
> > > >        inlined from ‘test_vphn’ at test-vphn.c:399:9:
> > > >    test-vphn.c:10:33: error: ‘be_packed’ may be used uninitialized [-Werror=maybe-uninitialized]
> > > >       10 | #define be16_to_cpup(x)         bswap_16(*x)
> > > >          |                                 ^~~~~~~~
> > > >    vphn.c:42:27: note: in expansion of macro ‘be16_to_cpup’
> > > >       42 |                 u16 new = be16_to_cpup(field++);
> > > >          |                           ^~~~~~~~~~~~
> > > >    In file included from test-vphn.c:19:
> > > >    vphn.c: In function ‘test_vphn’:
> > > >    vphn.c:27:16: note: ‘be_packed’ declared here
> > > >       27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
> > > >          |                ^~~~~~~~~
> > > >    cc1: all warnings being treated as errors
> > > > 
> > > > When vphn_unpack_associativity() is called from hcall_vphn(), this error
> > > > is not seen during compilation because GCC 15 seems to consider 'retbuf'
> > > > always populated from the hypervisor which is eventually referred by
> > > > 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same
> > > > before the first dereference when vphn_unpack_associativity() is called
> > > > from test_one() with pre-initialized array of 'struct test'. This
> > > > results in a false positive warning which is promoted to an error under
> > > > '-Werror'. This problem is not seen when the compilation is performed
> > > > with GCC 13 and 14.
> > > > 
> > > > Suppress the warning locally around the offending statement when
> > > > building with GCC 15 using a diagnostic pragma. This keeps the build
> > > > working while limiting the scope of the suppression to the specific
> > > > statement that triggers the false positive. An issue [1] has also been
> > > > created on GCC bugzilla.  
> > > 
> > > Usually when we get this kind of warning this is because the code is too
> > > complex. We should try to make it more obvious instead of just hiding the
> > > warning.  
> > 
> > The real issue here is that GCC 15 emits '-Wmaybe-uninitialized' due to
> > type punning between __be64[] and __b16* when accessing the buffer via
> > be16_to_cpup(). The underlying object is fully initialized but GCC 15
> > fails to track the aliasing due to the strict aliasing violation here.
> 
> Nope, I think it is tracking it correctly.
> The writes to be_packed[] are of 64bit values.
> The only reads of that memory are 16bit ones through field[].
> With 'strict aliasing' the compiler doesn't have to order those accesses.
> Indeed, it is allowed to completely optimise away the first loop.

Quoting the below statement from the discussion with GCC folks at [1]

  "This code has aliasing violations in it. The uninitialized happens due 
  to the undefined code due to the alias violations."
  
Having mentioned that and looking at the discussion happened at [2],
the '-Wmaybe-uninitialized' seems to be a case of a bad diagnostic
instead where the actual warning should have been pointing to a
Wstrict-aliasing issue which already is being tracked in the issue.

> If you cast to 'unsigned char *' then the accesses do have to be ordered.
> gcc will also treat accesses to different members of a union as being ordered
> (the C stand doesn't require this, IIRC s/union/struct/ is valid).

True, an union could be used to avoid this type punning problem but I
think its easier (and probablty better at this point) to avoid the
warning while building the vphn.c in test with '-fno-strict-aliasing'
immitating the way its compiled in kernel.

~Amit

> 	David 
> 
> > Please refer [1] and [2].
> > 
> > The selftest compiles fine with '-fno-strict-aliasing'. I see that when
> > we build vphn.c while compiling the kernel, the top level Makefile
> > includes '-fno-strict-aliasing' flag always.
> > 
> > So, I believe the same flag should be used to build vphn tests when
> > compiling vphn.c via the selftests. I'll send the v2 to achieve this
> > thus avoiding the compilation failure.
> > 
> > Please let me know you have different thoughts.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124427 
> > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99768
> > 
> > ~Amit
> > 
> > > 
> > > Here the for loop is a bit misleading.
> > >   
> > > > 
> > > > [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fbugzilla%2Fshow_bug.cgi%3Fid%3D124427&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C06a4d55b55f24c5cf00208de7e8e3676%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639087346428583316%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xEfO94N6IfGYhmmapNFduv3OrMarxpjTpZR6B38uR1s%3D&reserved=0
> > > > 
> > > > Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
> > > > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > > > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > > > ---
> > > >   arch/powerpc/platforms/pseries/vphn.c | 15 +++++++++++++++
> > > >   1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/vphn.c b/arch/powerpc/platforms/pseries/vphn.c
> > > > index 3f85ece3c872..9bc891143fec 100644
> > > > --- a/arch/powerpc/platforms/pseries/vphn.c
> > > > +++ b/arch/powerpc/platforms/pseries/vphn.c
> > > > @@ -39,7 +39,22 @@ static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
> > > >   		be_packed[i] = cpu_to_be64(packed[i]);
> > > >   	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> > > > +/*
> > > > + * When this function is called from hcall_vphn(), GCC 15 seems to consider
> > > > + * 'retbuf' always populated from the hypervisor which is eventually referred by
> > > > + * 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same before
> > > > + * the first dereference when this function is called from test_one() with
> > > > + * pre-initialized array of 'struct test'. This results in a false positive
> > > > + * '-Wmaybe-uninitialized' warning which is promoted to an error under
> > > > + * '-Werror'. This problem is not seen when the compilation is performed with
> > > > + * older GCC versions.
> > > > + */
> > > > +#pragma GCC diagnostic push
> > > > +#if defined(__GNUC__) && __GNUC__ >= 15
> > > > +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> > > > +#endif
> > > >   		u16 new = be16_to_cpup(field++);
> > > > +#pragma GCC diagnostic pop
> > > >   		if (is_32bit) {
> > > >   			/*
> > > > 
> > > > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681  
> > >   
> > 
> 


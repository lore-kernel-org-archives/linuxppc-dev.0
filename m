Return-Path: <linuxppc-dev+bounces-18111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA05105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:30:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn5k5lNbz3cFN;
	Thu, 12 Mar 2026 23:30:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318650;
	cv=none; b=B+0wrtqNlVjU0/EKh10UtAT6hZ/oicH3aOJPqQJanGnYTRRDAp6YNx4SrTU3q31v90HIc67XBKrscY69qkREsERNMeSKV5of/uhofMiXDj4wMZtvXp2HXYXOr3TFKGGobNkUtS6DGbZszVq7QWH+aVw5DN/Ka0bgIwgqT7gwSYyGTYB+F8XfpF/8e26etoEcRE3Sq2xiKvgoEBF5rJYia3h8b69NahIYEud1lq3l3Fa3SPR/L0HlUDBNziVWH8+iDecCXbtLo2sWuz4ZUoautIIeXVOCtN9LYyl4neag4jwlvQu/j1lUPEhX0na+jU4B2iRP4o+5W9LwRU+Yetnnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318650; c=relaxed/relaxed;
	bh=2ugqha6TIjTFrrat+VHqZ7HSOGCxoVBntdBAw7yQLvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8E0nUacoSrFPFN/5fDYTVhtVouAWrjGwSgKP3cv7aR5z+S9Rl/7TMY1yT11Xu4IVDCjI5S/2D2BQY3e3N2Hbuy9WxKMKd1gAVs1u5TmYx6DnlH2sz0URWq0zLywfzTXmlhXnkkUSw/GYdo7/Hji0Cdpyx02wGfIbZLumGABDVUci4i9lYwEzbNz+XLr2bizzyRxI4RGAxUC23VvxNtuw7wRxtOP1geOjL4ulcug1hWKqZbL1pmj9/ZcoW6vqyLVPB7X7yub+n7K8XdLfLYFVVc6UfIN+z7VvElJNlNwuj/Jr+tw9lHyspZgwZNBXaO5Na7yw0MV5lKViYmLLmSJhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwkM32wI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwkM32wI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn5j4567z3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:30:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWSvI2279420;
	Thu, 12 Mar 2026 12:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2ugqha
	6TIjTFrrat+VHqZ7HSOGCxoVBntdBAw7yQLvQ=; b=TwkM32wIr7bQPXNNl5SyhW
	AndjABsuh/pT9ayLEw6lZ5Ud25AUCx0PI/WfJk4LbnPEhcmZSPQBRxmf/6benwYi
	MFsKvTnOj5cBEGegHpSfj5kk1QqHepwteU27kTyCGVInue7pm0gwW0Bqv0oaFBKn
	8G0j0ekdQE5FCoShFsViwHEwf2Y8h2zsv/LOK8fDHCOftybZ/qgicimewC7QGTU8
	MF0esgSwCqnWB1zX8ULk3cNCyrC5vaFGZ07k3liBA8tvtMMQXUFjWjNz8XT9Ot+Z
	roSU47WaIIp+FGbBRD2A61BmXmc+bhkC70LxEChrheCTmR9RoRcNHWF+LAAW7G8A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91jmy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:30:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9U5GP025697;
	Thu, 12 Mar 2026 12:30:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8a9vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:30:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCUW7549152350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46ABF20063;
	Thu, 12 Mar 2026 12:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8747D20040;
	Thu, 12 Mar 2026 12:30:30 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Mar 2026 12:30:30 +0000 (GMT)
Date: Thu, 12 Mar 2026 13:16:26 +0000
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Suppress false positive
 -Wmaybe-uninitialized with GCC 15
Message-ID: <20260312123856.65bb5484-2e-amachhiw@linux.ibm.com>
Mail-Followup-To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org
References: <20260310101519.67157-1-amachhiw@linux.ibm.com>
 <3f26916b-5a1f-40b0-9c47-8b53e066e08c@kernel.org>
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
In-Reply-To: <3f26916b-5a1f-40b0-9c47-8b53e066e08c@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EUviJyIetQ_D9gl8CCpZSSmBAJ86Ma8p
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b2b1ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mDV3o1hIAAAA:8
 a=UqCG9HQmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=WRv-CGeHkRw9IIwHw9EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX0+ltF1iUdhE2
 dl2rjSKFdp3vGEYcIkK6Hr7d+32gMHuuHPclgSaheYQ0e29u4mpKirJU+31+wIvxlfU/FaaNWSq
 FmbSeat7kEHMK5K3EO0Z+5OpmkNIBxRpwSNRICIjigT+sI0ft2DQmp2dSNKWf8s93qTT9TeXk+R
 uyHTLe8fPQAhAAUfXUFUFGER4PovPCypfuLMKZRNdtm/6SkBCMhLFpCvE6gom/AzC4isnfqGm52
 YqgyfZkiwN2iisPDkNl5C12HOBFqhmfIum4NBhSLBc2fBKEw9ROkLRlKgkNSiOv0sn18hGzK2N/
 096apDO/cGfL8NQPUr8LGTj5tU0ids8AmjA65a/idAkgsHlle4KXR9Z8waS5wrdp7o5QoMJuooi
 VyNLcqcdOipJwyvXNhK6Tgf+kMAR8Kv4rgmESLyDh4Tq+A+qBpK15wmrPbaGPCveu4hYIX+hkPG
 Tn11UPCGq7/7HgoAutA==
X-Proofpoint-ORIG-GUID: -nVACrxDguyncZZsIx_MPmZlPW1V-0OO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120095


Hi Christhophe,

Thanks for looking at the patch. Please find my comments inline:j

On 2026/03/10 11:54 AM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 10/03/2026 à 11:15, Amit Machhiwal a écrit :
> > GCC 15 reports the below false positive '-Wmaybe-uninitialized' warning
> > in vphn_unpack_associativity() when building the powerpc selftests.
> > 
> >    # make -C tools/testing/selftests TARGETS="powerpc"
> >    [...]
> >      CC       test-vphn
> >    In file included from test-vphn.c:3:
> >    In function ‘vphn_unpack_associativity’,
> >        inlined from ‘test_one’ at test-vphn.c:371:2,
> >        inlined from ‘test_vphn’ at test-vphn.c:399:9:
> >    test-vphn.c:10:33: error: ‘be_packed’ may be used uninitialized [-Werror=maybe-uninitialized]
> >       10 | #define be16_to_cpup(x)         bswap_16(*x)
> >          |                                 ^~~~~~~~
> >    vphn.c:42:27: note: in expansion of macro ‘be16_to_cpup’
> >       42 |                 u16 new = be16_to_cpup(field++);
> >          |                           ^~~~~~~~~~~~
> >    In file included from test-vphn.c:19:
> >    vphn.c: In function ‘test_vphn’:
> >    vphn.c:27:16: note: ‘be_packed’ declared here
> >       27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
> >          |                ^~~~~~~~~
> >    cc1: all warnings being treated as errors
> > 
> > When vphn_unpack_associativity() is called from hcall_vphn(), this error
> > is not seen during compilation because GCC 15 seems to consider 'retbuf'
> > always populated from the hypervisor which is eventually referred by
> > 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same
> > before the first dereference when vphn_unpack_associativity() is called
> > from test_one() with pre-initialized array of 'struct test'. This
> > results in a false positive warning which is promoted to an error under
> > '-Werror'. This problem is not seen when the compilation is performed
> > with GCC 13 and 14.
> > 
> > Suppress the warning locally around the offending statement when
> > building with GCC 15 using a diagnostic pragma. This keeps the build
> > working while limiting the scope of the suppression to the specific
> > statement that triggers the false positive. An issue [1] has also been
> > created on GCC bugzilla.
> 
> Usually when we get this kind of warning this is because the code is too
> complex. We should try to make it more obvious instead of just hiding the
> warning.

The real issue here is that GCC 15 emits '-Wmaybe-uninitialized' due to
type punning between __be64[] and __b16* when accessing the buffer via
be16_to_cpup(). The underlying object is fully initialized but GCC 15
fails to track the aliasing due to the strict aliasing violation here.
Please refer [1] and [2].

The selftest compiles fine with '-fno-strict-aliasing'. I see that when
we build vphn.c while compiling the kernel, the top level Makefile
includes '-fno-strict-aliasing' flag always.

So, I believe the same flag should be used to build vphn tests when
compiling vphn.c via the selftests. I'll send the v2 to achieve this
thus avoiding the compilation failure.

Please let me know you have different thoughts.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124427 
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99768

~Amit

> 
> Here the for loop is a bit misleading.
> 
> > 
> > [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fbugzilla%2Fshow_bug.cgi%3Fid%3D124427&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C06a4d55b55f24c5cf00208de7e8e3676%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639087346428583316%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xEfO94N6IfGYhmmapNFduv3OrMarxpjTpZR6B38uR1s%3D&reserved=0
> > 
> > Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
> > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/platforms/pseries/vphn.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/vphn.c b/arch/powerpc/platforms/pseries/vphn.c
> > index 3f85ece3c872..9bc891143fec 100644
> > --- a/arch/powerpc/platforms/pseries/vphn.c
> > +++ b/arch/powerpc/platforms/pseries/vphn.c
> > @@ -39,7 +39,22 @@ static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
> >   		be_packed[i] = cpu_to_be64(packed[i]);
> >   	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> > +/*
> > + * When this function is called from hcall_vphn(), GCC 15 seems to consider
> > + * 'retbuf' always populated from the hypervisor which is eventually referred by
> > + * 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same before
> > + * the first dereference when this function is called from test_one() with
> > + * pre-initialized array of 'struct test'. This results in a false positive
> > + * '-Wmaybe-uninitialized' warning which is promoted to an error under
> > + * '-Werror'. This problem is not seen when the compilation is performed with
> > + * older GCC versions.
> > + */
> > +#pragma GCC diagnostic push
> > +#if defined(__GNUC__) && __GNUC__ >= 15
> > +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> > +#endif
> >   		u16 new = be16_to_cpup(field++);
> > +#pragma GCC diagnostic pop
> >   		if (is_32bit) {
> >   			/*
> > 
> > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> 


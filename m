Return-Path: <linuxppc-dev+bounces-18082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C6A103E2F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 23:27:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWRkN2lx0z3cDg;
	Thu, 12 Mar 2026 10:27:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773271676;
	cv=none; b=igAJBCnRKZCqZhD2xH0DWi+RB3CRAx4ONYF4QfoSHfFVgQ1RkDwWOrIYkdaHotiCMZl/R9le1cL19KUgPTs+EuIXuc2TjzUAx1GzlC33o3+1KSLaYcuPggQhLFteTy9Ei1jZwohQEs1i/d/BTcbv82+6oIKs7awi4URu81MyyAnlblepPebEL6U4PGo4pUrMQPoNHTuGWM+XUzMn6SKA1lKOhXJWX0RL6D0cdZR2++VVg4orZnn6TcmjAV+MlpuJxOdrq57BFkVBbAu9yesr7bJHQaboGXPxjJu95UmLPuJAKpN7+CQi2lJmcBSuYDxbv/UOzro8cBSTiqpgASfK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773271676; c=relaxed/relaxed;
	bh=RjABVGqkiAaJE4QBP6ftpwozdzffVALVCEoTxCzK7hA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iohPG2qsURsIyutfZvi6EnhgA58/DWoDkeoZ6JZzxz8aLwqRu4MIlHnpSYfLRheebRsi9OhftiU+AZ2bDQwwot1pJdnvbzeVZtk+xcJkAfdSlJxnz5C+dluohaCLLOi21P8NJHCJWsupOCS5dMZi7ck9ft+q1t7lKxCJi7Rd98oYA09+jEZUHeUOYprrYhSkgVCU+AbhsZ4d5mhvySVA6UniAj1zB520j3Us1Dp0/oY3/U7KPGsD5rBEFMw2urDcKIuCYog+Bma7fJpMuGEyZPHCLHcpzBIlU4DHOX8iYmNFNkV+6T9/NOpWDHx8N4rqXdjr+hX4XzGYgLknxpqbCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7UoJ+pd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7UoJ+pd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWRkM0QbQz3cDf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 10:27:54 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWKYO2581579;
	Wed, 11 Mar 2026 23:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RjABVG
	qkiAaJE4QBP6ftpwozdzffVALVCEoTxCzK7hA=; b=d7UoJ+pdyV9szBRhw39iTa
	8HsKjFQBoBVBriDY/MZ2eQo5ePn11tkwP/iQ0DozPX4W7yF4xSv8EQkoywhy4yBQ
	/NMbWcdUf66SEBhprEm0FYEGmKXkk97VBnBQb8W67yXwdiG52WTMR3aqxWqYG/A7
	S54FaWHLeTJ+hwz7OT+ThujGibOVXoZPVGuydRKlNr4YlWg+lGto5sKtFISK38ul
	+J/+fLA26s57n/xXlzKM0vbPcX7t0nR68jVqi2gBmSzo3cxnRrkSbBxDK6Yf8xyW
	Z7KPq99kIQSnwf2esO9SELAm/Nl0DdQJviStlobs5D93gC+xekSwvkBOq7fhMK8g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94r448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 23:27:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BMY9Ao018361;
	Wed, 11 Mar 2026 23:27:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha80476-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 23:27:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BNRe9714156298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 23:27:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7606A58054;
	Wed, 11 Mar 2026 23:27:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4455803F;
	Wed, 11 Mar 2026 23:27:38 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com (unknown [9.61.190.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 23:27:38 +0000 (GMT)
Message-ID: <b0a99a20f5f56ad8291d91b209d8ad5f7515bb23.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc: vas-api: constify dynamic struct class in
 coproc api register
From: Haren Myneni <haren@linux.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        Srikar Dronamraju
 <srikar@linux.ibm.com>,
        Jonathan Greental	 <yonatan02greental@gmail.com>,
        Kees Cook <kees@kernel.org>, Shrikanth Hegde	 <sshegde@linux.ibm.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"	
 <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Wed, 11 Mar 2026 16:27:38 -0700
In-Reply-To: <2026031154-labored-frivolous-154b@gregkh>
References: <20260308214634.1215051-1-jkoolstra@xs4all.nl>
	 <2026030924-penniless-hermit-ffc0@gregkh>
	 <1304966204.915283.1773053337271@kpc.webmail.kpnmail.nl>
	 <2026031154-labored-frivolous-154b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b1fa6f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ag1SF4gXAAAA:8
 a=xbhhHmXtY4ggDRbBbxIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE5NiBTYWx0ZWRfX7mNCMTsPv/As
 AhnjpeWDOZa80b0LhZP7UtbyT6HUHkjlTR93RXuERmKF9v1YJuYHMZFDIFeer8ZV2ykFViwmtZh
 15tkWFDDVtTPp+nzsZch45MUhtfFUxrs/qPi15KvGMMpiv69l4vpTHg1ia8OtCbc8wXdBe1Wsjf
 k/M+nkoykUhB9kMbGOCJxrCwT5nwF9exhZIBzb7chBu98TjWjjkEzvvH16KDEMCjpxdBA/5RPJ3
 9anqHRdFrCW9yNrMbShUR/pk3hzceRL0cYxs7I9vTSWQVVj4CQTIS4J3yO/e6XTY9MUgPqJ/Qby
 Kl4Bxe6l50hsy1jUD2bxpKL6+X1NfmdZBlpOF/KYYa3zJ3Xt1bbQA80p95qG1FLPKlVs4vF6sZU
 7EH7nlSuZyJwSN150QVMgDLDziYksMMVZ20De2jgViJP607lo5xu4wNDYck4JaYZX//6g7xngg0
 48jG2lKusR8bgSa3FcA==
X-Proofpoint-ORIG-GUID: hy_UYmg9igAjqUoquy-DtDUOn5OpeS7V
X-Proofpoint-GUID: DJFV2naKAfwyUL8WAzm_qBPS3TuJ6i7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603110196

On Wed, 2026-03-11 at 09:23 +0100, Greg KH wrote:
> On Mon, Mar 09, 2026 at 11:48:57AM +0100, Jori Koolstra wrote:
> > My bad, the earlier email went out to soon.
> >=20
> > > Op 09-03-2026 07:01 CET schreef Greg KH
> > > <gregkh@linuxfoundation.org>:
> > > > =C2=A0arch/powerpc/platforms/book3s/vas-api.c | 34
> > > > +++++++++++++++++++------
> > > > =C2=A01 file changed, 26 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/arch/powerpc/platforms/book3s/vas-api.c
> > > > b/arch/powerpc/platforms/book3s/vas-api.c
> > > > index ea4ffa63f043..e377981fd533 100644
> > > > --- a/arch/powerpc/platforms/book3s/vas-api.c
> > > > +++ b/arch/powerpc/platforms/book3s/vas-api.c
> > > > @@ -45,7 +45,7 @@ static struct coproc_dev {
> > > > =C2=A0	struct device *device;
> > > > =C2=A0	char *name;
> > > > =C2=A0	dev_t devt;
> > > > -	struct class *class;
> > > > +	const struct class *class;
> > > > =C2=A0	enum vas_cop_type cop_type;
> > > > =C2=A0	const struct vas_user_win_ops *vops;
> > > > =C2=A0} coproc_device;
> > > > @@ -599,6 +599,21 @@ static struct file_operations coproc_fops
> > > > =3D {
> > > > =C2=A0	.unlocked_ioctl =3D coproc_ioctl,
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static const struct class nx_gzip_class =3D {
> > > > +	.name		=3D "nx-gzip",
> > > > +	.devnode	=3D coproc_devnode
> > > > +};
> > > > +
> > > > +static const struct class* cop_to_class(enum vas_cop_type cop)
> > > > +{
> > > > +	switch (cop) {
> > > > +	case VAS_COP_TYPE_GZIP:		return
> > > > &nx_gzip_class;
> > > > +	default:
> > > > +		pr_err("No device class defined for cop type
> > > > %d\n", cop);
> > > > +		return NULL;
> > > > +	}
> > > > +}
> > > > +
> > > > =C2=A0/*
> > > > =C2=A0 * Supporting only nx-gzip coprocessor type now, but this API
> > > > code
> > > > =C2=A0 * extended to other coprocessor types later.
> > > > @@ -609,6 +624,10 @@ int vas_register_coproc_api(struct module
> > > > *mod, enum vas_cop_type cop_type,
> > > > =C2=A0{
> > > > =C2=A0	int rc =3D -EINVAL;
> > > > =C2=A0	dev_t devno;
> > > > +	const struct class* class =3D cop_to_class(cop_type);
> > > > +
> > > > +	if (!class)
> > > > +		return rc;
> > >=20
> > > How can this happen?
> > >=20
> > > This feels odd, are different types of devices being registered
> > > here?=C2=A0 I
> > > don't see where VAS_COP_TYPE_GZIP was being tested in the
> > > original code,
> > > why add this additional logic?
> > >=20
> >=20
> > My line of thought is this:
> >=20
> > There is a function vas_register_coproc_api() that does some kind
> > of registering
> > for different coprocessor types. It has the following comment
> > above:
> >=20
> > /*
> > =C2=A0* Supporting only nx-gzip coprocessor type now, but this API code
> > =C2=A0* extended to other coprocessor types later.
> > =C2=A0*/
>=20
> I guess "later" never happened :(

Yes, VAS is virtual accelerator switchboard which can support multiple
accelerator types. Hence added vas_register_api* interface for
different accelerators.=C2=A0But no plans to add other accelerators on
powerpc right now. So can we use only VAS_COP_TYPE_GZIP class and can
visit later.=20


diff --git a/arch/powerpc/platforms/powernv/vas-window.c
b/arch/powerpc/platforms/powernv/vas-window.c
index 9f093176b8db..360fdd8f200e 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1459,6 +1459,8 @@ static const struct vas_user_win_ops vops =3D  {
 int vas_register_api_powernv(struct module *mod, enum vas_cop_type
cop_type,
                             const char *name)
 {
+       if (cop_type !=3D VAS_COP_TYPE_GZIP)
+               return -ENOTSUPP;
=20
        return vas_register_coproc_api(mod, cop_type, name, &vops);
 }
diff --git a/arch/powerpc/platforms/pseries/vas.c
b/arch/powerpc/platforms/pseries/vas.c
index 9a28f2899716..19e11056e6aa 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -574,6 +574,9 @@ int vas_register_api_pseries(struct module *mod,
enum vas_cop_type cop_type,
        if (!copypaste_feat)
                return -ENOTSUPP;
=20
+       if (cop_type !=3D VAS_COP_TYPE_GZIP)
+               return -ENOTSUPP;
+
        return vas_register_coproc_api(mod, cop_type, name,
&vops_pseries);
 }
 EXPORT_SYMBOL_GPL(vas_register_api_pseries);

Thanks
Haren


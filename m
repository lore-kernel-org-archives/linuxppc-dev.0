Return-Path: <linuxppc-dev+bounces-17991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C3FD88D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvSw3Tkbz3bTf;
	Wed, 11 Mar 2026 13:14:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195264;
	cv=none; b=n2TXELRrGJZQtlBUlvz0kBeyPdWrSMfxTfzcA+uDpD+r2RvS5Jh7lq17jbsE3OWiWWGAr7XYljXdT/AwTkYqS6k2OgjHncdmv0rtkpWrQTF+qVtQ/W1t45BQdtoG4b7QDQpdPqMU6pbcZRVg2BdBLhhcGVD5V437BBp7h3pdSn9zQLFjwDfOenSKjlj0qYz0Ihq75bvus6dDo7tTvnVHyYsWDXPQ5S7CjGIA+axPIREmFiEvh0iDbrpae/JginzFU3ONnvZtevbLLkb8TKibafwvbsASPC2AkeNbmS+r/yR5FsL4gb0v0Ep2wOgAax3sAJ81vSJB+m7d27W7o/3TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195264; c=relaxed/relaxed;
	bh=/DIowe8SXI1+ziISMRjbd8hUuaX5ZNyaAdENV5NgFmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkJoKdX7cWTDz/IO+TM+EvGBrHQ2oO/UBSkq88HwwPOTdcKS2WFWkJ1lCy1kMPcm/kyiN2x0xxwWcLJkZcxIXoAIHfR2vUOR5UPyEntxhXumVuaBZDfg8XN5odaYKLNxkrZDN3wxTvPVLoDGKgMMVHObqsEHt45YwZ+4Zipsx8QG9FT8Vh9A6HLtGDYPLLmEMEBqjgqNjw7lICAlS04RLPIqfjhyZjPjjs87MlYNNKHG4KpeuEscVG4QcEqGQC/AGl/05N0FsnOAh804Jur38NcQROjgRWrZ5avbA2touHYEYEsWaI/p7nKdwC3HuIlVR/+y8H6nXnIKtkZGF+TBRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xc3Shm3u; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xc3Shm3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvSv5PNpz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:23 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AMIKki1599036;
	Wed, 11 Mar 2026 02:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/DIowe
	8SXI1+ziISMRjbd8hUuaX5ZNyaAdENV5NgFmk=; b=Xc3Shm3u+DzHTqX5cyCCsb
	R1xM9NA4Zu5FIPXi81OuqDj4L5hdy1OVSGivdwMyV5WreJqI5nk3H+lb5wtHiPO0
	MWbwBSkhEIqCd2hMwVaqvrRoQWg5dthGnBf9vXuuFXrwuoGN+n7qcmm9z3KsUlh+
	/cMZ6aGBM5t5Q5dL6b7ibY0iDVqOnMdo6HXu/wIt0mRc932Ch+R778OY8wlNG+pH
	lGnTuv2YHIh+MZwQ2gSNQqr7hd1omARxlQeeScmJeFu+FkcznFK7p+/cVeMXNxiS
	t1dB/Wiy1DLIOxW/jfI5Sj+AHFi6SqNCqyl/+lLvvOfW+jiFrTvWiKrZMhdvWA8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcundbpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ALVegw015725;
	Wed, 11 Mar 2026 02:14:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1223d2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2E1tf50856378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F37002006A;
	Wed, 11 Mar 2026 02:14:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81A220067;
	Wed, 11 Mar 2026 02:13:57 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:13:57 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: "Naveen N. Rao" <naveen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev,
        Maryam Moghadas <maryammo@ca.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v2 0/3] powerpc64/ftrace: fixes clang build issues
Date: Wed, 11 Mar 2026 07:43:56 +0530
Message-ID: <177319508343.269267.4001049522671602586.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260127084926.34497-1-hbathini@linux.ibm.com>
References: <20260127084926.34497-1-hbathini@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sbayf3x52m2RQAwkCF4QDEt4Ou58cmT3
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0cfee cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=fQ7256D8lykKbodKd20A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX8oemS/MfSpB4
 WDbCovCIK5cattu8qxZmm1Vf+u44TTS12ejMuG9r43iULaOj/Q64J13AxD22IPpKF51Sp0qlTMi
 jpvMs7WGfsKcAJpOSQZhJvlP1AP5LawE4TPK0/i7FKGQA25+Dv4yr7tokw8LL610zzcKEqz7nmF
 UNdT9twEpLeI2edbKgtnPjFO3hZVatJKOUMwfwAhw4TxW6hnttuUAEUSBYt0eMtFLluSkN0anyq
 kIfifhaLkRN8Lwk2L8B6/5ijNNBEKWy5CzaNqZgL0I0BhF5f9EA38VU3bCEkB0kFgQ8r6+AgPwS
 NQlb2DtJLhFgxxEOccdssSqqFPGyLggXEaWkXxByCHqAoIfkTEWuEMd2Nvpt5T9uwLrf6k+/1l6
 Eeq9oN3ES3jeh1EBNCQ6xszCVsMJZxHGIO/cxBOt3X6UGgUp/l/b2dgRL//z9SGFF6i04nqsHab
 WiEjcli7hV8Vb94VH9A==
X-Proofpoint-ORIG-GUID: sbayf3x52m2RQAwkCF4QDEt4Ou58cmT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 27 Jan 2026 14:19:23 +0530, Hari Bathini wrote:
> Support for -fpatchable-function-entry on ppc64le was added in Clang
> with [1]. Faced a couple of issues while building the linux kernel
> with Clang though. Patches 1 & 2 address those issues. The last patch
> provides workaround to ensure, an open issue [2] in Clang with
> -fpatchable-function-entry support, does not impact the linux
> ftrace subsystem.
> 
> [...]

Applied to powerpc/fixes.

[1/3] powerpc64: make clang cross-build friendly
      https://git.kernel.org/powerpc/c/73cdf24e81e4eba52a40a6b10c6cf285d0ac23fd
[2/3] powerpc64/ftrace: fix OOL stub count with clang
      https://git.kernel.org/powerpc/c/875612a7745013a43c67493cb0583ee3f7476344
[3/3] powerpc64/ftrace: workaround clang recording GEP in __patchable_function_entries
      https://git.kernel.org/powerpc/c/db54c28702f7270e74dce36c84cb0db4cec96389

cheers


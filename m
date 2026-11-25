Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A2606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kguypUXm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZPcg1C52z2xS6;
	Thu, 26 Nov 2026 03:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795622643;
	cv=none; b=kNSDi0BYSiSSOsBzjhKSO8iVxeoVUCEJIbKvoXlcPFcYovubGAvvI2BZTv9NwXhzjtDQdCm8n0PWjM8Os2g1JEhaz463rpod8cABBGiRbjMRY8NO7VWxgcDVH75Qt5PSB+CsLDp4BdJ+frA/rLK+59h9Lx9KwgKPAGD0BU2+xwuNtj7khXsN6/9dWBhLPS3QAA8kI3lBUBBYqfNRN5M9xAI0nOHKNdT+pBJqEazHydFfYVnoOfZWgyICbyelEU1YopzmF8CKjhjlbhOhuLnY6ugaC2t1Q9E2ZRmwAHB19664msx8fs3Y5HCJQB+Dkq5qLf0ir29SAQU4sc63waHipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795622643; c=relaxed/relaxed;
	bh=K2e98L6/aN2ChnmYQ/goFOMSmsEfvyw6aOZ4gHKO/mI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Le5TtOQWyDtdDzdlEiGhfrHLxJCta0R4PLU91UC3u3PGvl6fS1D6Jit089EwXqLlHWu8hD6gNc48xiRUb1594whte93QQW01+UoJtdzaK4epu83AFge1Dkdwh4kVMzpjeED3/HVwfQzUGUBmHliDJ1XUNqDBCGMN4smdkmohtg9xuXGifBhUCbDSQWMcX9qkAR2/mEyDjW5EeMg6uGM/AcTqODF1bXV39SdtHyrAHmRWKL3/jItJIKpmgC0/MGqsGpNjzVrICsIIAQpkhPmB3LuL/SBvtSkyA0GX/iP9guJcT2eTcXViqLF0nwcFwwyYZUkqurJFnJIfyr9RLXrY+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kguypUXm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kguypUXm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZPcf1Wl9z2xL5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:04:01 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEYXwS4179544;
	Wed, 25 Nov 2026 16:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K2e98L
	6/aN2ChnmYQ/goFOMSmsEfvyw6aOZ4gHKO/mI=; b=kguypUXmNNc0nP1IWXBmNh
	P9r60NR/aE4ynP3tcAGH2XavaJLJp1f99xt4S87e1HXrsgvBJRGuhX1HxgnPfM06
	qUdUbFaYVwWPllzGeTNmk6qSz1GxCCh5lHRsFYXrtBaUW9SkGAeWFhJvmB2FgIgs
	HgWe8c3gencH9bblw5fxVjK+f/uu+BUDZVo41eE7FpLP+EgEH0zIsKRlPnxw2mb6
	q4WXbHehnx6Mlerq5psVI98HghAq/QU22IVdH+x/rxl+pOFRF86mVIoUvNeKgtB4
	b1S/rw7i6deo5vYAVv2pb0yAhKFuWqh3yRhNNui8EwkWc9tUw8PRFlq1OrVq2JWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3d95j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:03:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKGbF810358;
	Wed, 25 Nov 2026 16:03:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkvf8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:03:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APG3aeG39059840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 16:03:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895B420049;
	Wed, 25 Nov 2026 16:03:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D742004B;
	Wed, 25 Nov 2026 16:03:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.29.35])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 16:03:34 +0000 (GMT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] powerpc/perf: vpa-dtl: fix resource leak on allocation
 failure
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <60D6C3C4-BEC7-47CD-BD12-A3C3A426CDA3@linux.ibm.com>
Date: Wed, 25 Nov 2026 21:33:22 +0530
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tanushree Shah <tshah@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <219B6184-256F-4DA4-9319-1B71120CF614@linux.ibm.com>
References: <20261112134455.6880-1-mdshahid03@gmail.com>
 <ld6q74um.ritesh.list@gmail.com>
 <60D6C3C4-BEC7-47CD-BD12-A3C3A426CDA3@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, mdshahid03@gmail.com
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b0706dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=8xFpP55X2xZeg0S8b5oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MiBTYWx0ZWRfX34PZLcvvDNoy
 4VDWQXr9XUifEkgAEBX6BsRGpH/gE6Sz0Eo3tnKZ4z20Zmruh/FG4Y/71/lWPoy4tsH0WqHpXd8
 ALhjfCdhOiFICbtjM+N3U2jSiLFqnZ8=
X-Proofpoint-ORIG-GUID: atDRj3km5rIblynXKp6QaqJeHyLBOtWU
X-Proofpoint-GUID: HF3SB-Pqoc4NsY9HBaEwraEDOJMeFbhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MiBTYWx0ZWRfX4ULaq0XvOf0L
 p04pF82YNUUhkRnxjIPEmULENa9IC++Scg76ZjcAXAB6b9Rdd9hPAL/fFNnnhwaPRz81kEjfvNx
 Y1lSpfufO6bwK9euF8d1Ke3VTCMfiSI7mYCGvUYs/Z3gpq+eQ5MhLcAoIyQyww7ywyVZFc/wYtw
 OQ+3oWlc7sLQMord2jr5xc+Y+e74ToGvGfxOPDCfgUcGpyW9lMyjuwxxGDpYRlgI1pEoq4E+oVu
 g+mLC1YgJgvs5iaIQYXiGQ5Cz8OLHLGvDV0cIwn7QTtOiw/piEA/QsoSzpbUjuAjzueK8zBz/Zs
 xy0dMSpOafKh8FPxC13S/EGPPyZYm9QLvoNKFvEo8La5vQJ6YYLr+3yvAVpxLg89yfJj6fX1zce
 beLQ+HxIViqsTLyekpbGTDGOO295LTRkQAOzJrqetkCjdESs3v5yNA+n0jbU8ELvgpHMkkNdXJ5
 4fdvPWg/12ylqU/3JoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250062
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 22 Nov 2026, at 9:47=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
>=20
>=20
>> On 18 Nov 2026, at 5:02=E2=80=AFPM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>>=20
>>=20
>> mdshahid03@gmail.com writes:
>>=20
>>> From: Mohammad Shahid <mdshahid03@gmail.com>
>>>=20
>>> vpa_dtl_event_init acquires dtl_access_lock when initializing the
>>> first vpa_dtl PMU event.
>>>=20
>>> If vpa_dtl_mem_alloc() fails,the function returns -ENOMEM without
>>> releasing the semaphore.
>>>=20
>>> Release the semaphore when buffer allocation fails and no other
>>> PMU events are active.
>>>=20
>>> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
>>> ---
>>> arch/powerpc/perf/vpa-dtl.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/arch/powerpc/perf/vpa-dtl.c =
b/arch/powerpc/perf/vpa-dtl.c
>>> index 3e3d65b6c796..20eafeaffa6b 100644
>>> --- a/arch/powerpc/perf/vpa-dtl.c
>>> +++ b/arch/powerpc/perf/vpa-dtl.c
>>> @@ -396,6 +396,8 @@ static int vpa_dtl_event_init(struct perf_event =
*event)
>>>=20
>>> /* Allocate dtl buffer memory */
>>> if (vpa_dtl_mem_alloc(event->cpu)) {
>>> + if (dtl_global_refc =3D=3D 0)
>>> + up_write(&dtl_access_lock);
>>> spin_unlock(&dtl_global_lock);
>>> return -ENOMEM;
>>> }
>>=20
>>=20
>> I looked at this code and I am unable to wrap my head around it. We =
have
>> dtl_access_lock and dtl_global_lock. Then we have vpa_dtl, which is a
>> per-cpu variable anyway.
>>=20
>> So I am not sure why we need both locks held while doing
>> vpa_dtl_mem_alloc(). What exactly are they protecting?  Can we move =
the
>> allocation out of the lock and just assign dtl->buf later within the
>> lock?  In one other place I see dtl->buf =3D NULL without any lock.  =
Also,
>> do we need a spinlock to protect dtl_global_refc? Would an atomic
>> variable not work here?
>>=20
>> The above fix is not wrong per se, based on today's code, but it =
would
>> be better if someone who owns this code takes another look and fixes =
its
>> design while we are at it.
>=20
> Thanks Mohammad for the patch and Ritesh for sharing your comments.
>=20
> Reasons for having the different locks:
> dtl_access_lock with down_write_trylock : There are other dtl users, =
example: debugfs dtl=20
> or /proc/powerpc/vcpudispatch_stats. These locks are used to ensure at =
same time these
> interfaces are not used, ie to exclude the debugfs dtl and =
vcpudispatch_stats users.
>=20
> dtl_global_refc :  global reference count variable. One perf record =
opens one event per CPU,=20
> and all of them share one acquisition of the lock. The count says when =
the last CPU event is gone=20
> and the lock can be released. And dtl_global_lock is used to prevent =
race condition on this.=20
>=20
> But the allocation observation which Ritesh pointed out seems valid to =
me.=20
> It can be moved out of dtl_global_lock.
>=20
> I am looking closer at the other points raised here, including the =
buffer
> lifetime and whether the spinlock/refcount can be simplified, and will
> respond back soon.

Hi Mohammad, Ritesh

Please find my points below:

 - dtl->buf =3D NULL in event_del() without a lock:=20
    vpa_dtl_cpu is per-CPU, and event->add/event->del run on the event's =
CPU, so no lock is needed there.=20
    event_init can run on any CPU, but it only writes dtl->buf for the =
target CPU before the event is added.

- Moving vpa_dtl_mem_alloc() out of the lock:
    Agreed. dtl_global_lock only needs to protect dtl_global_refc and =
the first-user/last-user
    handling. of dtl_access_lock. The allocation doesn't need it.

-  Atomic for dtl_global_refc:
   One perf record opens one event per CPU, and all of them share a =
single
   acquisition of dtl_access_lock. The count tells us when the last =
event is gone, so the lock can be
   released. The "refc =3D=3D 0, then down_write_trylock(), then refc++" =
sequence, and the =E2=80=9Crefc--,
   then refc =3D=3D 0, then up_write()" sequence, have to be atomic with =
respect to each other.
   An atomic variable doesn't cover that, so dtl_global_lock is still =
needed.

Redesign changes:=20
  Agreed that the locking and buffer lifetime need cleanup, including =
the clang context analysis
  annotations. I'd like to handle that as a separate follow-up series, =
so it doesn't hold up this fix.

Mohammad,
could you post a v2 of this patch as a minimal fix ? A few changes:

1) Move the allocation before spin_lock(&dtl_global_lock). If it fails, =
return -ENOMEM.
    Then no up_write() special case is needed, and the if =
(dtl_global_refc =3D=3D 0) check goes away.
2) If we move the allocation out of the lock, take care to free the =
buffer if try lock fails
3) We might not need GFP_ATOMIC in vpa_dtl_mem_alloc once it is moved =
out of the spin lock.
4) please add Fixes tag

I'll take the broader redesign, including the clang context analysis =
annotations, as a follow-up.

Thanks
Athira

>=20
> Thanks
> Athira
>=20
>>=20
>> Another motivation for doing this work now is to bring in clang's
>> context analysis for arch/powerpc/perf/, which can statically check
>> that such locking rules are followed, provided there are proper
>> annotations for every lock and the data it protects.
>>=20
>> -ritesh




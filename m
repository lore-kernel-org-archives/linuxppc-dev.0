Return-Path: <linuxppc-dev+bounces-24339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A40C44520
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 11:55:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1pJr67Y8z2yVZ;
	Fri, 17 Jul 2026 21:55:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784289356;
	cv=none; b=gduMFHm2VseJbSUhOoheJ1f7VPn+TEPg2n6FfKdt1RAH7EfSal4ZB/yiwGq70PbBRoANb0Hdm4mYXnv/xFHED13+eV84L8C0bOQtLxPQd0kaA7U+BMuvRZ99ZdegK9jbebdUnPKAsDqmuMLfHq5shoTUrTAK3djXbKxTkuvYsZSBvl14Z817uZ4dTUnZlF5nQMxry9TKIWStKxqFVEcRYSQH18peZ32zRRMradJg1opWNIjaDQIN/n3bmRkoAtQhnARTf7o59q1vvkABAIFwS+6kqB8tOfTIS7LVYGY+tonnl3DU63p9iMY9iOK2SfLONTUDoZwbWVnd2Dvs/OrokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784289356; c=relaxed/relaxed;
	bh=6PYQGE83E/xfs834Tnn8oYBPnBLonjBGomtDAeoT5UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcuMaXFjR0W987bBuE3WcnwV8V3e3FfHV5vUrNBBqgdRghxof62XrAf4tE2bhzQZMN3nddoY6V8bgLll3F+lptEaXJ/FbDSuuGIqX2hCuHObkKrnrmjDBEAJOoxT85BdQ+a/mJG9JNSKUkzgsYiCxMkRlarm6vpUgcFR7CrNa86qxhccuqLtdYWxgI89gZs0Uh+Cc8ywz/7Q9oJZ8mfv4EA9B206dhUM9tghNtMtGY+qEikVBtgITmdVMy6zHFkGa7Z/fUYxXqaYNrjJzEHcvuViSjSf0X0TBKtDO0sfKzug5JgCRC3IEei7V00O57bUgI9ed1I8kxLudVq4uzDFCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V1MhXgFx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V1MhXgFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1pJp6Sdzz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 21:55:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HAgAvG1717922;
	Fri, 17 Jul 2026 11:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6PYQGE
	83E/xfs834Tnn8oYBPnBLonjBGomtDAeoT5UM=; b=V1MhXgFxqHsYnGGshaMZI2
	9hQHxZTM+SO6BKRY9XDHg3MOO+5IJO1QHTjmv+cGHHRW2SB52fDEPio0P1tN4nSi
	ye3sLaHLVMau8XBpgxzhUBXxNZ8Ju46IZTISru8ls7acQoEQn3EsYJv1bOmOExlI
	wv0W7GTFrtiQDTyjLa0woad/TmpTjyzTteVHHno8O3nDXs/+1cYUkN9dpXOqFwqT
	wACv7S6gYkE+6vijA3RbSKVMyJAvcPPBC0l7g61skX7OKBUOJLWy1/vND1GKeqWi
	j4AUgz6tz+p9scqI7V/SE7Nu63wDuLuVNoaQ6CufBJf3cskz447m7okWor+PikEQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2an824-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 11:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HBnedk002639;
	Fri, 17 Jul 2026 11:55:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhsdux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 11:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HBtYn928377544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 11:55:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7092004B;
	Fri, 17 Jul 2026 11:55:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C117620043;
	Fri, 17 Jul 2026 11:55:32 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 11:55:32 +0000 (GMT)
Date: Fri, 17 Jul 2026 17:25:42 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <20260717171540.f81e62f3-71-amachhiw@linux.ibm.com>
Mail-Followup-To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	adityag@linux.ibm.com, mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
 <b5f97f5b-4a17-46f7-8830-a9c4c121f0c4@linux.ibm.com>
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
In-Reply-To: <b5f97f5b-4a17-46f7-8830-a9c4c121f0c4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX3X5nqcyXl0NA
 o7jiH9ye0liXAqfEGvx4/EOWaeb8ZDFgrpCkJi8mUQFwt8WOQXtc98Djvo0owvfNVP+U7mf1da9
 JatRF7i6LBNnFcJETkbqZxsrRBsZer8=
X-Proofpoint-GUID: J1ikVIVQ9WkwDeRRzylUGLW7zX1ZXVQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX9wFpajFDcabK
 z/FJlpimeODI7ky5KrMohhHGEsVpOafeRKWolibpoSyFgtK+xTFJvJBkKG5HZ6RbiZQSpX4aFRx
 8ZEGDBmaLMFkdDOgrxEvDJlijlsklweLYragVlSQYw+Noj6LtuKBqJ+n+N+pJzZ6VkArDwpp9Tf
 WGYKcd8o3TaLsuVOeSdWdaknY45pIqjuLwd3+2z+ttiOAymBvACcPj85/qExUbBPA6nDVbV33sY
 KG3Bg4Os1up6CERbAf+Cc1mz5dj7iN/mXxGAoCjiYG4egR3QrHo9R6wUI1j4IWpyMtBYKwiHAud
 XJwOdtvzVZOs60kEmLTuZvj/Jx04XCJzPoQHMT38duPGfn3kyYIQcqWZCbAB4zlxc+4MVD83pTL
 eHwfs3irxRZL4CjaTEkKiaKce8Juxx8gHYjnAC7hldxlr+lQ0ieI/Rq0/VkHCxARTF92j13BlAg
 Np9OCTtnvTIJAdI0IuQ==
X-Proofpoint-ORIG-GUID: dQKX2K43GLhS1BgFhd9dWB2y9ViptHB8
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5a183c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=3KSfBdxkYujMrS9u-7YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170118

On 2026/07/09 11:40 AM, Nikhil Kumar Singh wrote:
> Hi Mukesh,
> 
> Ideally, checkpatch should take care of this, I see no checkpatch errors.

That is because the default $max_line_length is set to 100 columns in
checkpatch.pl scripts. The kernel coding style document recommends 80,
but checkpatch enforces 100 unless you pass --max-line-length=80
explicitly.

  my $max_line_length = 100;

You will see the warnings being reported when you run the script as:

  ❯ scripts/checkpatch.pl ./v2_20260706_nikhilks_powerpc_64s_clarify_copy_and_flush_cache_sync_loop_comment.mbx --max-line-length=80
  WARNING: line length of 82 exceeds 80 columns
  #44: FILE: arch/powerpc/kernel/head_64.S:716:
  +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
  [...]
  
  total: 0 errors, 12 warnings, 26 lines checked

I agree with Mukesh here and I think the comment should be fixed to fit
within 80 column width limit as staying within 80 columns is certainly
still preferred.

Thanks,
Amit

> 
> ```
> ./scripts/checkpatch.pl
> v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch
> total: 0 errors, 0 warnings, 26 lines checked
> 
> v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch has no
> obvious style problems and is ready for submission.
> ```
> 
> Thanks
> ~ Nikhil
> 
> On 07/07/26 12:48, Nikhil Kumar Singh wrote:
> > Hi Mukesh,
> > 
> > Thanks for reviewing the patch and for the suggestion.
> > I'd prefer to keep the current alignment as I find it a bit more
> > readable.
> > 
> > Thanks,
> > ~ Nikhil
> > 
> > On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
> > > On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
> > > > The value loaded into r0 in copy_and_flush() represents the number of
> > > > 8-byte words processed between cache synchronization operations.
> > > > 
> > > > The existing comment refers to cache line size, which can make
> > > > it appear
> > > > that the value is a cache line size in bytes rather than a loop count.
> > > > Clarify the comment to explain that the loop processes 8 words
> > > > (64 bytes)
> > > > per cache synchronization iteration, and that increasing the
> > > > value would
> > > > skip cache maintenance for intermediate cache lines.
> > > > 
> > > > This is a comment-only change with no functional impact.
> > > > 
> > > > Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > > ---
> > > >   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
> > > >   1 file changed, 12 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/kernel/head_64.S
> > > > b/arch/powerpc/kernel/head_64.S
> > > > index 63432a33ec49..a54f6f979173 100644
> > > > --- a/arch/powerpc/kernel/head_64.S
> > > > +++ b/arch/powerpc/kernel/head_64.S
> > > > @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
> > > >   _GLOBAL(copy_and_flush)
> > > >       addi    r5,r5,-8
> > > >       addi    r6,r6,-8
> > > > -4:    li    r0,8            /* Use the smallest common    */
> > > > -                    /* denominator cache line    */
> > > > -                    /* size.  This results in    */
> > > > -                    /* extra cache line flushes    */
> > > > -                    /* but operation is correct.    */
> > > > -                    /* Can't get cache line size    */
> > > > -                    /* from NACA as it is being    */
> > > > -                    /* moved too.            */
> > > > +4:    li    r0,8            /* r0 is the number of 8-byte words    */
> > > > +                    /* to copy per cache sync iteration. */
> > > > +                    /* 8 words * 8 bytes = 64 bytes. 64B is    */
> > > > +                    /* the current default cache line size.    */
> > > > +                    /* This is a loop count, not a byte    */
> > > > +                    /* count. Increasing it may skip    */
> > > > +                    /* dcbst/icbi for lines in between and */
> > > > +                    /* leave stale instructions in icache. */
> > > > +                    /* This results in extra cache line    */
> > > > +                    /* flushes but operation is correct. */
> > > > +                    /* Can't get cache line size from NACA */
> > > > +                    /* as it is being moved too.        */
> > > The comment looks fine. But the alignement of the comment is still
> > > different from earlier. Keep the alignment same as earlier, it looks a
> > > little nicer.
> > > 
> > > Regards,
> > > Mukesh
> > > >         mtctr    r0            /* put # words/line in ctr    */
> > > >   3:    addi    r6,r6,8            /* copy a cache line */
> > > > -- 
> > > > 2.43.5
> > > > 


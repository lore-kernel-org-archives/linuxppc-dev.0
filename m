Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C1C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 04:39:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C72B20811
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 04:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C72B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TZzF59CCzDqMd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 15:39:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TZxV1GMDzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 15:38:05 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2R4Yq3u031498
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 00:38:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rg23b8dxa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 00:38:02 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 27 Mar 2019 04:38:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Mar 2019 04:37:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2R4buul54853724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2019 04:37:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2F8F11C052;
 Wed, 27 Mar 2019 04:37:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C35111C04C;
 Wed, 27 Mar 2019 04:37:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2019 04:37:56 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 780FAA00E2;
 Wed, 27 Mar 2019 15:37:54 +1100 (AEDT)
Subject: Re: [PATCH v2]  arch/powerpc: Rework local_paca to avoid LTO warnings
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 27 Mar 2019 15:37:54 +1100
In-Reply-To: <1553579424.0r39b9otz6.astroid@bobo.none>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
 <20190314023125.10076-1-alastair@au1.ibm.com>
 <1553579424.0r39b9otz6.astroid@bobo.none>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032704-0008-0000-0000-000002D1F4F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032704-0009-0000-0000-0000223E2439
Message-Id: <8d8a97e145758b92c2760012373f5217877a035c.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-27_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270031
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-03-26 at 15:58 +1000, Nicholas Piggin wrote:
> Alastair D'Silva's on March 14, 2019 12:31 pm:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > When building an LTO kernel, the existing code generates warnings:
> >     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
> >         ‘local_paca’ used for multiple global register variables
> >      register struct paca_struct *local_paca asm("r13");
> >                                   ^
> >     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
> >         ‘local_paca’
> 
> Isn't this a bogus warning? It doesn't look like there's a way to 
> define it any other way.

There isn't any other way to define it as a global. However, the
warning is legitimate.

The compiler sees that there are multiple global register variables,
all pointing at the same register.

The compiler can only determine this when LTO is used, as otherwise it
only sees the one in the current compilation unit, whicd disappears by
the time the kernel is linked.

> 
> > This patch reworks local_paca into an inline getter & setter
> > function,
> > which addresses the warning.
> > 
> > Changelog:
> > V2
> >   - Address whitespace issues
> >   - keep new implementation close to where the old implementation
> > was
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--
> > ------
> >  arch/powerpc/kernel/paca.c      |  2 +-
> >  2 files changed, 29 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/paca.h
> > b/arch/powerpc/include/asm/paca.h
> > index e843bc5d1a0f..2fa0b43357c9 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -34,19 +34,38 @@
> >  #include <asm/cpuidle.h>
> >  #include <asm/atomic.h>
> >  
> > -register struct paca_struct *local_paca asm("r13");
> > -
> >  #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> >  extern unsigned int debug_smp_processor_id(void); /* from
> > linux/smp.h */
> > -/*
> > - * Add standard checks that preemption cannot occur when using
> > get_paca():
> > - * otherwise the paca_struct it points to may be the wrong one
> > just after.
> > - */
> > -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
> > -#else
> > -#define get_paca()	local_paca
> >  #endif
> >  
> > +static inline struct paca_struct *get_paca_no_preempt_check(void)
> > +{
> > +	register struct paca_struct *paca asm("r13");
> > +
> > +	return paca;
> > +}
> 
> Problem is it now changes the global register variable to a local 
> register variable. The compiler would presumably be within its rights
> to "cache" that return value or use another register for it, which
> is not really what we want.
> 
> 

I've confirmed that at least with GCC 8.2.0, the generated assembler is
similar, but yes, the compiler may be free to take a copy into another
register (although that would be a terrible optimisation), and then
operate on that value.

Subsequent uses would still have to call the function (ie. fetch the
data from r13) regardless, so I believe this scenario is safe.

Can you think of a scenario where this is a problem?

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819


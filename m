Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A736C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 01:41:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF252087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 01:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF252087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KWdW4Hk1zDqM5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 12:41:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KWbY0BY1zDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 12:39:36 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2E1Xq24073359
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 21:39:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r7c2ju809-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 21:39:33 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 14 Mar 2019 01:39:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Mar 2019 01:39:27 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2E1dQKe53215264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2019 01:39:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A224D5204F;
 Thu, 14 Mar 2019 01:39:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0AE375205A;
 Thu, 14 Mar 2019 01:39:26 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 46D95A00D1;
 Thu, 14 Mar 2019 12:39:24 +1100 (AEDT)
Subject: Re: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO warnings
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 14 Mar 2019 12:39:23 +1100
In-Reply-To: <bd858b12-7fab-057d-0065-2ccb98cbf648@c-s.fr>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
 <bd858b12-7fab-057d-0065-2ccb98cbf648@c-s.fr>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031401-4275-0000-0000-0000031AB3DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031401-4276-0000-0000-00003829241E
Message-Id: <087c8f5e7bf9f8e77d66ef86ed5ba06905211d60.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-14_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140008
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
Cc: Michal Hocko <mhocko@suse.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "Naveen
 N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-03-13 at 10:06 +0100, Christophe Leroy wrote:
> Hello,

Thanks for reviewing :)
> 
> Le 13/03/2019 à 04:42, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > When building an LTO kernel, the existing code generates warnings:
> >      ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
> >          ‘local_paca’ used for multiple global register variables
> >       register struct paca_struct *local_paca asm("r13");
> >                                ^
> >      ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
> >          ‘local_paca’
> 
> How do you build a LTO kernel ?

I'm using Andi Kleen's LTO tree:
https://github.com/andikleen/linux-misc/tree/lto-420-1

with a few other patches:
https://github.com/andikleen/linux-misc/pull/27

You'll need to add the following to your .config:
CONFIG_LTO_MENU=y
CONFIG_LTO=y

> 
> > This patch reworks local_paca into an inline getter & setter
> > function,
> > which addresses the warning.
> 
> This patch adds sparse warnings, see 
> https://patchwork.ozlabs.org/patch/1055875/

These warnings are bogus, they replace warnings that flagged against
spinlock.h.

> > Generated ASM from this patch is broadly similar (addresses have
> > changed and the compiler uses different GPRs in some places).
> 
> Your text might be confusion. When I read it the first time I
> thought 
> you were saying that the compiler was now using another GPR than r13.
> 

I'll see if I can improve it.

> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> I guess the same has to be done for current, see 
> arch/powerpc/include/asm/current.h :
> 
> /*
>   * We keep `current' in r2 for speed.
>   */
> register struct task_struct *current asm ("r2");

Hmm, I didn't see problems on PPC64 as that already uses an inline
function. I'll address this in another patch for the PPC32 case.

> > ---
> >   arch/powerpc/include/asm/paca.h | 44 +++++++++++++++++++++++-----
> > -----
> >   arch/powerpc/kernel/paca.c      |  2 +-
> >   2 files changed, 32 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/paca.h
> > b/arch/powerpc/include/asm/paca.h
> > index e843bc5d1a0f..9c9e2dea0f9b 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -34,19 +34,6 @@
> >   #include <asm/cpuidle.h>
> >   #include <asm/atomic.h>
> >   
> > -register struct paca_struct *local_paca asm("r13");
> > -
> > -#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> > -extern unsigned int debug_smp_processor_id(void); /* from
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
> > -#endif
> > -
> >   #ifdef CONFIG_PPC_PSERIES
> >   #define get_lppaca()	(get_paca()->lppaca_ptr)
> >   #endif
> > @@ -266,6 +253,37 @@ struct paca_struct {
> >   #endif
> >   } ____cacheline_aligned;
> >   
> > +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> > +extern unsigned int debug_smp_processor_id(void); /* from
> > linux/smp.h */
> > +#endif
> 
> Why moving this down, why not leaving at the same place as before ?
> 
> If you really need to move it, you should remove the 'extern' at the 
> same time to make checkpatch happy.

I moved it to keep it close to the usage of it.

I suppose the new implementation should be in the same place though.

> > +
> > +static inline struct paca_struct *get_paca_no_preempt_check(void)
> > +{
> > +	register struct paca_struct *paca asm("r13");
> 
> Should be a blank line there.
Whoops, I thought I ran checkpatch, but clearly, I forgot. I'll
resubmit.

> > +	return paca;
> > +}
> > +
> > +static inline struct paca_struct *get_paca(void)
> > +{
> > +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> > +	/*
> > +	 * Add standard checks that preemption cannot occur when using
> > get_paca():
> > +	 * otherwise the paca_struct it points to may be the wrong one
> > just after.
> > +	 */
> > +	debug_smp_processor_id();
> > +#endif
> > +	return get_paca_no_preempt_check();
> > +}
> > +
> > +#define local_paca	get_paca_no_preempt_check()
> > +
> > +static inline void set_paca(struct paca_struct *new)
> > +{
> > +	register struct paca_struct *paca asm("r13");
> 
> Blank line should be added here.
> 
> > +	paca = new;
> > +}
> > +
> > +
> >   extern void copy_mm_to_paca(struct mm_struct *mm);
> >   extern struct paca_struct **paca_ptrs;
> >   extern void initialise_paca(struct paca_struct *new_paca, int
> > cpu);
> > diff --git a/arch/powerpc/kernel/paca.c
> > b/arch/powerpc/kernel/paca.c
> > index 913bfca09c4f..ae5c243f9d5a 100644
> > --- a/arch/powerpc/kernel/paca.c
> > +++ b/arch/powerpc/kernel/paca.c
> > @@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct
> > *new_paca, int cpu)
> >   void setup_paca(struct paca_struct *new_paca)
> >   {
> >   	/* Setup r13 */
> > -	local_paca = new_paca;
> > +	set_paca(new_paca);
> >   
> >   #ifdef CONFIG_PPC_BOOK3E
> >   	/* On Book3E, initialize the TLB miss exception frames */
> > 
> 
> Christophe
> 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819


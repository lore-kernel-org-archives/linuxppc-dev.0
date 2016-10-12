Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svKqx4PdzzDsrd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 04:00:45 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3svKqw4KZ7z9sBr
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 04:00:44 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9CGxadZ138785
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 13:00:42 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 261p6u9rhr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 13:00:40 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 12 Oct 2016 22:30:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 758FBE0024
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 22:29:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9CH0AJ033030162
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 22:30:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9CH07lb012196
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 22:30:09 +0530
Date: Wed, 12 Oct 2016 22:30:05 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, markus@trippelsdorf.de, amodra@gmail.com
Subject: Re: [PATCH] powerpc: cmp -> cmpd for 64-bit
Reply-To: svaidy@linux.vnet.ibm.com
References: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
 <877f9e5ksw.fsf@concordia.ellerman.id.au>
 <20161012132647.GA4446@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161012132647.GA4446@gate.crashing.org>
Message-Id: <20161012170005.GB4714@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Segher Boessenkool <segher@kernel.crashing.org> [2016-10-12 08:26:48]:

> On Wed, Oct 12, 2016 at 02:05:19PM +1100, Michael Ellerman wrote:
> > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > 

[snip]

> 
> > > --- a/arch/powerpc/include/asm/cpuidle.h
> > > +++ b/arch/powerpc/include/asm/cpuidle.h
> > > @@ -26,7 +26,7 @@ extern u64 pnv_first_deep_stop_state;
> > 
> > #define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
> > 	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
> > >  	std	r0,0(r1);					\
> > >  	ptesync;						\
> > >  	ld	r0,0(r1);					\
> > > -1:	cmp	cr0,r0,r0;					\
> > > +1:	cmpd	cr0,r0,r0;					\
> > >  	bne	1b;						\
> > >  	IDLE_INST;						\
> > >  	b	.
> > 
> > What's this one doing, is it a bug? I can't really tell without knowing
> > what the magic sequence is meant to do.

This one is the recommended idle state entry sequence described in
ISA.  We need to ensure the context is fully saved and also create
a register dependency using cmp and loop which will ideally not be
taken.  This will get the thread (pipeline) ready to start losing
state when the idle instruction is executed.

ISA 2.07 Section: 3.3.2.1 Entering and Exiting Power-Saving Mode

> 
> It looks like it is making sure the ptesync is done.  The ld/cmp/bne
> is the usual to make sure the ld is done, and in std/ptesync/ld the ld
> won't be done before the ptesync is done.
> 
> The cmp always compares equal, of course, so both cmpw and cmpd would
> work fine here.  cmpd looks better after ld ;-)

Yes :)

cmpd or cmpw would provide same result as far as this code sequence is
concerned.  I agree that cpmd is more appropriate here.

--Vaidy

Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DEAB5B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 21:01:19 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id o75B1BHE020129
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 16:31:11 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o75B1B2T3653836
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 16:31:11 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o75B1Atn012577
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 21:01:11 +1000
Date: Thu, 5 Aug 2010 16:30:58 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 1/2] powerpc: cleanup APIs for cpu/thread/core mappings
Message-ID: <20100805110058.GF3282@dirshya.in.ibm.com>
References: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
	<20100722005707.12905.83615.stgit@drishya.in.ibm.com>
	<1280810653.1902.87.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1280810653.1902.87.camel@pasglop>
Cc: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2010-08-03 14:44:13]:

> On Thu, 2010-07-22 at 06:27 +0530, Vaidyanathan Srinivasan wrote:
> > These APIs take logical cpu number as input
> > Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
> > Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()
> 
> I'm still not happy here.
> 
> I don't find leftmost/rightmost to be a "progress" from the previous
> naming. If you really want to change to avoid in_core() at the end, then
> call them first_thread_sibling() and last_thread_sibling().

Hi Ben,

The naming is based on our discussion during the first RFC:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-April/081610.html

I am fine with first_thread_sibling() name instead of
cpu_{left,right}most_thread_sibling().  The goal is to distinguish
between APIs returning logical cpu numbers and core indexes.

first_thread_sibling() implies that the parameter and return value are
logical cpu (thread) number.

I will change the name as per your suggestion and post an update.

> Then you change:
> 
> > -static inline int cpu_thread_to_core(int cpu)
> > -{
> > -	return cpu >> threads_shift;
> > -}
> 
>   .../... to:
> 
> > -/* Must be called when no change can occur to cpu_present_mask,
> > +/* Helper routines for cpu to core mapping */
> > +int cpu_core_of_thread(int cpu)
> > +{
> > +	return cpu >> threads_shift;
> > +}
> > +EXPORT_SYMBOL_GPL(cpu_core_of_thread);

The cpu_core_of_thread() name implies that the return type is a core index
and not a logical cpu number.

cpu_core_of_thread(5) = 1
cpu_first_thread_of_core(1) = 4

Do you think cpu_core_number_of_thread() will explain the return type
better?

> Any reason you are making it out of line other than gratuituous
> bloat ? :-)
> 
> > +int cpu_first_thread_of_core(int core)
> > +{
> > +	return core << threads_shift;
> > +}
> > +EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
> 
> Same.

The reason behind out of line is to avoid exporting threads_shift or
other variables like threads_per_core and have this API exported so
that modules can read them.  If we make these wrapper inline, then we
will have to export the variables themselves which is not a good idea.

Thanks for the review.  

--Vaidy

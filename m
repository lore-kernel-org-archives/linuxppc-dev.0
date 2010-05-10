Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C52FB7D4F
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 15:48:48 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4A5mwMp005862
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 15:48:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4A5ffSB1552488
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 15:41:41 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4A5miIw008942
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 15:48:45 +1000
Date: Mon, 10 May 2010 11:18:01 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH v2 1/2] powerpc: cleanup APIs for cpu/thread/core
	mappings
Message-ID: <20100510054801.GG5612@dirshya.in.ibm.com>
References: <20100507113907.5035.9794.stgit@drishya.in.ibm.com>
	<20100507114842.5035.65177.stgit@drishya.in.ibm.com>
	<20100509230522.GA2993@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100509230522.GA2993@brick.ozlabs.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Paul Mackerras <paulus@samba.org> [2010-05-10 09:05:22]:

> On Fri, May 07, 2010 at 05:18:42PM +0530, Vaidyanathan Srinivasan wrote:
> 
> > These APIs take logical cpu number as input
> > Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
> > Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()
> > 
> > These APIs convert core number (index) to logical cpu/thread numbers
> > Add cpu_first_thread_of_core(int core)
> > Changed cpu_thread_to_core() to cpu_core_of_thread(int cpu)
> 
> Why make all these changes?  The end result doesn't seem any cleaner
> or better than how it was before, and your patch description doesn't
> give any reason for us to think "yes, we should make this change".
> I assume you think this is a good change to make, so you need to
> explain why it's a good idea and convince the rest of us.

Sure Paul.. let me explain.  The crux of the issue is to make
'threads_per_core' accessible to the pseries_energy module.  In the
first RFC, I had directly exported the variable which is not a good
design.  Ben H suggested to make an API around it and then export the
function:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-April/081610.html

Instead of making an API to read threads_per_core, as Ben suggested,
I have made a wrapper at a higher level to make an API to convert from
logical cpu number to core number.

The current APIs cpu_first_thread_in_core() and
cpu_last_thread_in_core() returns logical CPU number while
cpu_thread_to_core() returns core number or index which is not
a logical CPU number.

Ben recommended to clearly name them to distinguish 'core number'
versus first and last 'logical cpu number' in that core.

Hence in the new scheme, I have:

> > Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
> > Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()

which work on logical cpu numbers.  
While cpu_first_thread_of_core() and cpu_core_of_thread() work on core
index.

Example usage:  (4 threads per core system)

cpu_leftmost_thread_sibling(5) = 4
cpu_rightmost_thread_sibling(5) = 7
cpu_core_of_thread(5) = 1
cpu_first_thread_of_core(1) = 4

cpu_core_of_thread() is used in cpu_to_drc_index() in the module and
cpu_first_thread_of_core() is used in drc_index_to_cpu() in the
module.  These APIs may be useful in other modules in future, and the
proposed design is a good method to export these APIs to modules.

An alternative approach could be to move both the base functions
cpu_to_drc_index() and drc_index_to_cpu() into the kernel like in
arch/powerpc/kernel/smp.c

Thanks for the review, I hope I have explained the requirements and
design for this cleanup.

--Vaidy

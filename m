Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF9D4B7B69
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 17:40:21 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n8L7d1mO105708
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 07:39:06 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n8L7cnmB1179864
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 08:38:51 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n8L7cmSu023647
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 08:38:49 +0100
Date: Mon, 21 Sep 2009 09:38:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
Message-ID: <20090921073848.GA4649@osiris.boeblingen.de.ibm.com>
References: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
	<928CFBE8E7CB0040959E56B4EA41A77EC69BA5E0@irsmsx504.ger.corp.intel.com>
	<20090921073043.GB24467@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090921073043.GB24467@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Metzger, Markus T" <markus.t.metzger@intel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 09:30:43AM +0200, Ingo Molnar wrote:
> 
> * Metzger, Markus T <markus.t.metzger@intel.com> wrote:
> 
> > >-----Original Message-----
> > >From: Paul Mackerras [mailto:paulus@samba.org]
> > >Sent: Monday, September 21, 2009 8:45 AM
> > 
> > 
> > >Markus, please take care in future to mention it in the changelog if
> > >your patches touch definitions used by other architectures.  If you
> > >could go so far as to use grep a bit more and fix up other
> > >architectures' callsites for the things you're changing, that would be
> > >very much appreciated.  Thanks.
> > 
> > I'm sorry I missed that.
> > 
> > There's one more place in arch/sparc/.
> > The below patch should fix it, but I have no means to test it.
> 
> You also missed a third thing:
> 
> +static inline int
> +perf_output_begin(struct perf_output_handle *handle, struct perf_counter *c,
> +                 unsigned int size, int nmi, int sample)               { }
> 
> an 'int' function returning void ...
> 
> Plus all the !PERF_COUNTERS branch of empty inlines is pointless - these 
> facilities are used by perfcounters code only. I fixed that too.

Hi Ingo,

did you fix all of these warnings for !PERF_COUNTERS?

include/linux/perf_counter.h: In function 'perf_output_begin':
include/linux/perf_counter.h:854: warning: no return statement in function returning non-void
include/linux/perf_counter.h: At top level:
include/linux/perf_counter.h:863: warning: 'struct perf_sample_data' declared inside parameter list
include/linux/perf_counter.h:863: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/perf_counter.h:868: warning: 'struct perf_sample_data' declared inside parameter list

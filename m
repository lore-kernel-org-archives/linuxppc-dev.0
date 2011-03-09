Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [194.196.100.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61BC7B6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:15:51 +1100 (EST)
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p29DFgIe024319
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:15:42 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p29DFunG1798364
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:15:56 GMT
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p29DFfUW027210
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 06:15:42 -0700
Date: Wed, 9 Mar 2011 14:15:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
Message-ID: <20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1299670429.2308.2834.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299670429.2308.2834.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 09 Mar 2011 12:33:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2011-03-09 at 11:19 +0100, Peter Zijlstra wrote:
> > > It appears that this corresponds to one CPU deciding to rebuild the
> > > sched domains. There's various reasons why that can happen, the typical
> > > one in our case is the new VPNH feature where the hypervisor informs us
> > > of a change in node affinity of our virtual processors. s390 has a
> > > similar feature and should be affected as well.
> > 
> > Ahh, so that's triggering it :-), just curious, how often does the HV do
> > that to you? 
> 
> OK, so Ben told me on IRC this can happen quite frequently, to which I
> must ask WTF were you guys smoking? Flipping the CPU topology every time
> the HV scheduler does something funny is quite insane. And you did that
> without ever talking to the scheduler folks, not cool.
> 
> That is of course aside from the fact that we have a real bug there that
> needs fixing, but really guys, WTF!

Just for info, on s390 the topology change events are rather infrequent.
They do happen e.g. after an LPAR has been activated and the LPAR
hypervisor needs to reshuffle the CPUs of the different nodes.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

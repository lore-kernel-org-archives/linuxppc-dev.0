Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 9E23E67A73
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 04:08:44 +1000 (EST)
Date: Mon, 3 Apr 2006 11:08:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
In-Reply-To: <20060403180131.GD25663@localdomain>
Message-ID: <Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
	<20060403180131.GD25663@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, pj@sgi.com, ak@suse.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Apr 2006, Nathan Lynch wrote:

> > There are many other for_each_*_cpu loops in the kernel that do not have 
> > any of the instrumentation you suggest. I suggest you come up with a 
> > general solution and then go through all of them and fix this. Please be 
> > aware that many of these loops are performance critical.
> 
> But this one isn't, right?

Right. One could use more expensive processing here.
 
> And I'm afraid there's a misunderstanding here -- only
> for_each_online_cpu (or accessing the cpu online map in general) has
> such restrictions -- for_each_possible_cpu doesn't require any locking
> or preempt tricks since cpu_possible_map must not change after boot.

Correct. We may want to audit the kernel and check that each 
for_each_possible_cpu or for_each_cpu is really correct. Developers 
frequently assume that all processors are up. There may be some 
complicated interactions with cpusets. Adding Paul to this.

However, note that I am not interested hotplug functionality. It is going 
to be a difficult task to make the kernel shutdown processors correctly. I 
can give you feedback but I am not going to do this work.

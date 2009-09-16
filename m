Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 493DFB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 01:33:15 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: dipankar@in.ibm.com
In-Reply-To: <20090916152820.GA12571@in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop> <20090916152820.GA12571@in.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 17:32:51 +0200
Message-Id: <1253115171.7180.1.camel@laptop>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 20:58 +0530, Dipankar Sarma wrote:
> On Tue, Sep 15, 2009 at 02:11:41PM +0200, Peter Zijlstra wrote:
> > On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > > This patchset contains the offline state driver implemented for
> > > pSeries. For pSeries, we define three available_hotplug_states. They are:
> > > 
> > >         online: The processor is online.
> > > 
> > >         offline: This is the the default behaviour when the cpu is offlined
> > > 
> > >         inactive: This cedes the vCPU to the hypervisor with a cede latency
> > > 
> > > Any feedback on the patchset will be immensely valuable.
> > 
> > I still think its a layering violation... its the hypervisor manager
> > that should be bothered in what state an off-lined cpu is in. 
> 
> The problem is that all hypervisor managers cannot figure out what sort
> of latency guest OS can tolerate under the situation. They wouldn't know
> from what context guest OS has ceded the vcpu. It has to have
> some sort of hint, which is what the guest OS provides.

I'm missing something here, hot-unplug is a slow path and should not
ever be latency critical..?

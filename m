Return-Path: <BATV+d1941b170df8d5091610+2224+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F25AB7BA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 19:36:27 +1000 (EST)
Date: Fri, 25 Sep 2009 11:35:56 +0200
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Message-ID: <20090925113556.4e1b1c4a@infradead.org>
In-Reply-To: <1253868864.10287.3.camel@twins>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	<20090924051238.GA5963@linux.vnet.ibm.com>
	<20090924142228.5a2ddf59@infradead.org>
	<20090925070623.GH8595@dirshya.in.ibm.com>
	<1253868864.10287.3.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Shaohua Li <shaohua.li@intel.com>, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, arun@linux.vnet.ibm.com,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Len Brown <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 25 Sep 2009 10:54:24 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Fri, 2009-09-25 at 12:36 +0530, Vaidyanathan Srinivasan wrote:
> > * Arjan van de Ven <arjan@infradead.org> [2009-09-24 14:22:28]:
> > 
> > > On Thu, 24 Sep 2009 10:42:41 +0530
> > > Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> > > 
> > > > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22
> > > > 16:55:27]:
> > > > 
> > > > Hi Len, (or other acpi folks),
> > > > 
> > > > I had a question regarding ACPI-cpuidle interaction in the
> > > > current implementation.
> > > > 
> > > > Currently, every cpu (i.e. acpi_processor) registers to cpuidle
> > > > as a cpuidle_device. So every cpu has to go through the process
> > > > of setting up the idle states and then registering as a cpuidle
> > > > device.
> > > > 
> > > > What exactly is the reason behind this?
> > > > 
> > > 
> > > technically a BIOS can opt to give you C states via ACPI on some
> > > cpus, but not on others.
> > > 
> > > in practice when this happens it tends to be a bug.. but it's
> > > technically a valid configuration
> > 
> > So we will need to keep the per-cpu registration as of now because
> > we may have such buggy BIOS in the field and we don't want the
> > cpuidle framework to malfunction there.
> 
> If the BIOS doesn't mention a certain C state on a cpu, and you try to
> set it anyway, does that go boom?
> 
> This whole per-cpu registration thing is horridly ugly, can't you
> have a per-cpu C state exception mask and leave it at that -- if its
> really needed?

the real solution is to make the acpi code always know about C1, even
if the bios doesn't.... That's one for Len :)

(C1 is just "hlt", what we do in the other idle loop ;-) 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id E8C52DE830
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 04:52:40 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so137816anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 11:52:39 -0700 (PDT)
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1219257000.14362.90.camel@localhost.localdomain>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
	<48AC13E5.5010503@linux.vnet.ibm.com>
	<1219257000.14362.90.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 14:52:08 -0400
Message-Id: <1219258333.26429.29.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 13:30 -0500, Hollis Blanchard wrote:
> On Wed, 2008-08-20 at 14:53 +0200, Christian Ehrhardt wrote:
> > 
> > Arnd Bergmann wrote:
> > > On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
> > >   
> > >> Dependent on the already existing CONFIG_KVM_GUEST config option
> > this patch
> > >> changes wrteei to wrtee allowing the hypervisor to rewrite those to
> > nontrapping
> > >> instructions. Maybe we should split the kvm guest otpimizations in
> > two parts
> > >> one for the overhead free optimizations and on for the rest that
> > might add
> > >> some complexity for non virtualized execution (like this one).
> > >>
> > >> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> > >>     
> > >
> > > How significant is the performance impact of this change for
> > non-virtualized
> > > systems? If it's very low, maybe you should not bother with the
> > #ifdef, and
> > > if it's noticable, you might be better off using dynamic patching
> > for this.
> > >
> > >       Arnd <><
> > >   
> > To be honest I unfortunately don't know how big the impact for 
> > non-virtualized systems is. I would like to test it, but without 
> > hardware performance counters on the core I have I'm not sure (yet)
> > how 
> > to measure that in a good way - any suggestion welcome.
> 
> I don't see why we need performance counters. Can't we just compare any
> bare metal benchmark results with the patch both applied and not?

Do you know of one that causes a large amount of
local_irq_{disable,enable}s to be called?

josh

Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D0C7DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:13:53 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2D9DmeQ073516
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:13:48 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2D9Dmws2220056
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 10:13:48 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2D9Dl0t013856
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 10:13:47 +0100
Date: Tue, 13 Mar 2007 10:11:59 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
Message-ID: <20070313091159.GB9890@osiris.boeblingen.de.ibm.com>
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
	<je6496asea.fsf@sykes.suse.de>
	<20070313090350.GA9890@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313090350.GA9890@osiris.boeblingen.de.ibm.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, spyro@f2s.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Giuliano Pochini <pochini@denise.shiny.it>, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 10:03:50AM +0100, Heiko Carstens wrote:
> On Tue, Mar 13, 2007 at 01:39:25AM +0100, Andreas Schwab wrote:
> > Giuliano Pochini <pochini@denise.shiny.it> writes:
> > 
> > > I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with 
> > > those parts of the kernel.
> > 
> > See arch/powerpc/kernel/sysfs.c:topology_init.  I don't think there is
> > anything to do here.  You probably don't have CONFIG_HOTPLUG_CPU enabled.
> 
> I was referring to arch/ppc not arch/powerpc. But it seems that arch/ppc
> doesn't support cpu hotplug anyway. So I guess it's indeed just a missing
> config option.
> 
> Grepping a bit further shows that arm suffered by the change that inverted
> the logic if the 'online' attribute for cpus should appear. Since arm
> supports cpu hotplug but the patch left arm out, it doesn't work there
> anymore (cc'ing arm people: changeset 72486f1f8f0a2bc828b9d30cf4690cf2dd6807fc
> is most probably disabling cpu hotplug support on arm like it did on s390).

Should have cc'ed Suresh Siddha who caused the breakage ;)

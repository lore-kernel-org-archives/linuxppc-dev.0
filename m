Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B780DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:05:44 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l2D95eWY084704
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:05:40 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2D95daD1839108
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:05:39 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2D95d4N015011
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:05:39 GMT
Date: Tue, 13 Mar 2007 10:03:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
Message-ID: <20070313090350.GA9890@osiris.boeblingen.de.ibm.com>
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
	<je6496asea.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <je6496asea.fsf@sykes.suse.de>
Cc: spyro@f2s.com, linuxppc-dev@ozlabs.org,
	Giuliano Pochini <pochini@denise.shiny.it>, rmk@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 01:39:25AM +0100, Andreas Schwab wrote:
> Giuliano Pochini <pochini@denise.shiny.it> writes:
> 
> > I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with 
> > those parts of the kernel.
> 
> See arch/powerpc/kernel/sysfs.c:topology_init.  I don't think there is
> anything to do here.  You probably don't have CONFIG_HOTPLUG_CPU enabled.

I was referring to arch/ppc not arch/powerpc. But it seems that arch/ppc
doesn't support cpu hotplug anyway. So I guess it's indeed just a missing
config option.

Grepping a bit further shows that arm suffered by the change that inverted
the logic if the 'online' attribute for cpus should appear. Since arm
supports cpu hotplug but the patch left arm out, it doesn't work there
anymore (cc'ing arm people: changeset 72486f1f8f0a2bc828b9d30cf4690cf2dd6807fc
is most probably disabling cpu hotplug support on arm like it did on s390).

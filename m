Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD719DDF24
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:45:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4FGjUPF022872
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 12:45:30 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4FGjUS8246402
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:45:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4FGjTo3017037
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:45:30 -0600
Date: Tue, 15 May 2007 11:45:29 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
Message-ID: <20070515164529.GA4383@austin.ibm.com>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<e1629d824068540e703ba7d661753992@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1629d824068540e703ba7d661753992@kernel.crashing.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:32:08AM +0200, Segher Boessenkool wrote:
> >> -	device_create_file(&wf_platform_device.dev, &new_ct->attr);
> >> +	ret = device_create_file(&wf_platform_device.dev, &new_ct->attr);
> >> +	if (ret) {
> >> +		list_del(&new_ct->link);
> >> +		printk(KERN_WARNING "windfarm: device_creat_file failed"
> >> +			"for %s\n", new_ct->name);
> >> +		goto out_unlock;
> >
> > This shows up why I hate the must_check stuff.  The sysfs files are
> > not essential for the operation of the windfarm subsystem.
> 
> They are essential for the user expectations of the
> subsystem though; if registration fails, a warning
> should be printed.
> 
> > If the
> > sysfs registration fails for any reason, we now have a completely
> > non-functional windfarm subsystem instead of a mostly-working one. :(
> 
> Yeah, but that's not must_check's fault, it doesn't
> say *what* to do with the error code :-)

Ergo, the patch should be reworked to print the warning only, 
but otherwise continue with the setup.

--linas

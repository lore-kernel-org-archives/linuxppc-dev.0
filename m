Return-Path: <vgoyal@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F8D567B9C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 23:56:10 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8LDu7HU018734
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 09:56:07 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8LDu7bN365016
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:56:07 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8LDu77F002294
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:56:07 -0600
Date: Thu, 21 Sep 2006 09:55:34 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching
	for	powerpc	device tree
Message-ID: <20060921135534.GA1542@in.ibm.com>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
	<1158810033.7062.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158810033.7062.23.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Horms <horms@verge.net.au>,
	Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: vgoyal@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 01:40:33PM +1000, Michael Ellerman wrote:
> On Thu, 2006-09-21 at 11:51 +0900, Horms wrote:
> > On Thu, Sep 21, 2006 at 11:59:04AM +1000, Michael Ellerman wrote:
> > > On Thu, 2006-09-21 at 11:10 +1000, Michael Neuling wrote:
> > > > This code no longer needed with Jimi's auto reserve of device tree blob
> > > > kernel patch now in 2.6.18.    
> > > > 
> > > > This patch will break Linux if you're kexecing to a kernel which doesn't
> > > > have this patch (ie. earlier than 2.6.17).  Required kernel patch is
> > > > this one:   
> > > > http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4d1f3f25d9c303d1ce63b42cc94c54ac0ab2e950
> > > > 
> > > 
> > > Although it'd be nice to get rid of that code, I'm not sure we want to
> > > go breaking this. This will mean RHEL5 and SLES10 users can't use
> > > upstream kexec-tools :/
> > 
> > Surely if they are using a RHEL5 or SLES10 kernel then its
> > reasonably to expect they are also using a RHEL5 or SLES10 supplied
> > kexec-tool.
> 
> Or Ubuntu Dapper .. Debian Stable .. FC whatever. In general they'll be
> using the distro tools sure, but I'd rather not force them to. I
> generally expect to be able to run mainline kernels without upgrading my
> entire distro - it should cut both ways IMHO.
> 

Now with distros adopting kexce-tools, I am in for maintaining the backward
compatibility as far as possible. Putting a note in the code is good that
down the line, get rid of this code.

-Vivek

Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 8943467B7B
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 13:24:38 +1000 (EST)
Date: Thu, 21 Sep 2006 11:51:23 +0900
From: Horms <horms@verge.net.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc	device tree
Message-ID: <20060921025122.GA8573@verge.net.au>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158803944.7062.9.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 11:59:04AM +1000, Michael Ellerman wrote:
> On Thu, 2006-09-21 at 11:10 +1000, Michael Neuling wrote:
> > This code no longer needed with Jimi's auto reserve of device tree blob
> > kernel patch now in 2.6.18.    
> > 
> > This patch will break Linux if you're kexecing to a kernel which doesn't
> > have this patch (ie. earlier than 2.6.17).  Required kernel patch is
> > this one:   
> > http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4d1f3f25d9c303d1ce63b42cc94c54ac0ab2e950
> > 
> 
> Although it'd be nice to get rid of that code, I'm not sure we want to
> go breaking this. This will mean RHEL5 and SLES10 users can't use
> upstream kexec-tools :/

Surely if they are using a RHEL5 or SLES10 kernel then its
reasonably to expect they are also using a RHEL5 or SLES10 supplied
kexec-tool.

I guess it all comes down to backwards compatibility.
And IMHO thats a hard thing to maintain with something
as green as kexec.

I'm in favour of the patch, though I'm prepared to be convinced otherwise.

If the code needs to stay, perhaps this patch could be modified
so that the code in question is only executed if the kernel
is pre 2.6.18. Or is that just overly complex?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

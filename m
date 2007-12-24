Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69715DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 16:00:46 +1100 (EST)
Date: Sun, 23 Dec 2007 20:49:12 -0800
From: Greg KH <gregkh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Build breakage on powerpc with 2.6.24-rc6-mm1
Message-ID: <20071224044912.GA10690@suse.de>
References: <20071223224158.GA7975@linux.vnet.ibm.com>
	<20071224134353.c00fc231.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20071224134353.c00fc231.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 24, 2007 at 01:43:53PM +1100, Stephen Rothwell wrote:
> Hi Balbir,
> 
> Thanks for the report.
> 
> On Mon, 24 Dec 2007 04:11:58 +0530 Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
> >
> > I see the following error with the iseries_veth driver in 2.6.24-rc6-mm1
> > 
> > drivers/net/iseries_veth.c: In function ‘veth_init_connection’:
> > drivers/net/iseries_veth.c:818: warning: unused variable ‘rc’
> > drivers/net/iseries_veth.c: In function ‘veth_probe_one’:
> > drivers/net/iseries_veth.c:1086: error: ‘veth_port_ktypeq’ undeclared
> > (first use in this function)
> > drivers/net/iseries_veth.c:1086: error: (Each undeclared identifier is
> > reported only once
> > drivers/net/iseries_veth.c:1086: error: for each function it appears
> > in.)
> > make[2]: *** [drivers/net/iseries_veth.o] Error 1
> > make[1]: *** [drivers/net] Error 2
> > make: *** [drivers] Error 2

Thanks for the report, sorry for the typos, I'll fix up my patch.

> Yeah, that would be
> gregkh-driver-kobject-convert-drivers-net-iseries_vethc-to-use-kobject_init-add_ng.
> 
> Hi Greg, do you even build with your patches applied?

For the power architecture, no, I do not.  I used to, but my cross-build
box died and I haven't taken the time to set it all up again.  For i386
and x86-64 I do build everything, and as that's 99% of the users, it's
usually fine :)

I did start to try to get a s390 cross-build working, but ran out of
time a week or so ago...

> > Here's a patch, compile tested to fix the compilation problem
> 
> Hopefully Greg will fix his original patch before it reaches Linus.

I will do that.

thanks,

greg k-h

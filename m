Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B26831A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:20:21 +1100 (AEDT)
Message-ID: <1455013213.23568.1.camel@ellerman.id.au>
Subject: Re: [1/2] powerpc/powernv: new function to access OPAL msglog
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Tue, 09 Feb 2016 21:20:13 +1100
In-Reply-To: <56B97926.1090304@au1.ibm.com>
References: <20160208113149.F33D1140B99@ozlabs.org>
 <56B97926.1090304@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-09 at 16:29 +1100, Andrew Donnellan wrote:
> On 08/02/16 22:31, Michael Ellerman wrote:
> > Pulling the memcons out of the bin_attr here is not all that nice. This routine
> > should really stand on its own without reference to the bin_attr. In theory I
> > might want to disable building sysfs but still have this routine available.
>
> Yeah it's a bit ugly, though does disabling sysfs actually break it?

Probably not, it looks like bin_attribute is still defined even when sysfs is
disabled. And the build would break in other places too.

> I can separate it out anyway - there's no reason for the memcons to be
> tied to the sysfs entry.

Yeah that was more my point.

> > It's also a bit fishy if it's called before the bin_attr is initialised or when
> > the memcons initialisation fails. In both cases it should be OK, because the
> > structs in question are static and so the private pointer will be NULL, but
> > that's a bit fragile.
> >
> > I think the solution is simply to create a:
> >
> >    static struct memcons *opal_memcons;
> >
> > And use that in opal_msglog_copy() and so on.
>
> Will respin.

Thanks.

cheers

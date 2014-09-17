Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBB8B1A00FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:38:30 +1000 (EST)
Message-ID: <1410925110.1586.3.camel@concordia>
Subject: Re: [RFC PATCH] powerpc/numa: add ability to disable and debug
 topology updates
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 13:38:30 +1000
In-Reply-To: <20140915235455.GB5238@linux.vnet.ibm.com>
References: <20140909200913.GG22906@linux.vnet.ibm.com>
 <1410757536.32643.1.camel@concordia>
 <20140915235455.GB5238@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 16:54 -0700, Nishanth Aravamudan wrote:
> On 15.09.2014 [15:05:36 +1000], Michael Ellerman wrote:
> > On Tue, 2014-09-09 at 13:09 -0700, Nishanth Aravamudan wrote:
> 
> > Does it really need to be a boot param, or could it be a debugfs or
> > sysctl flag? ie. do we need to disable it immediately at boot or would
> > it be OK if it was /etc/rc.local or similar that turned it off ?
> 
> We need it off at boot, potentially. An LPAR does not indicate that it
> will or will not respond to the events in any synchronous fashion, so
> the hypervisor is free to send them to us whenever.

OK. I guess we're stuck with a boot time parameter for on/off then.

> > As far as the debug goes, we could just use pr_debug() with
> > CONFIG_DYNAMIC_DEBUG, it's not quite as easy to enable as a kernel
> > parameter but for the odd bit of debugging it should be fine.
> 
> That's a good point, I wonder with that mechanism if we should perhaps
> extend/remove other static debugging methods in favor of that (e.g.,
> numa=debug)?

Yes definitely.

It's slightly more arcane to enable, ie. to turn on dynamic debugging in numa.c
at boot your command line needs:

  dyndbg="file numa.c +p"

But that's fine unless it's an option you expect users to be using regularly
which none of these are.

cheers

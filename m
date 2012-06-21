Return-Path: <amodra@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10AB8B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 20:48:49 +1000 (EST)
Received: by dajt11 with SMTP id t11so856480daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 03:48:47 -0700 (PDT)
Date: Thu, 21 Jun 2012 20:18:39 +0930
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
 related)
Message-ID: <20120621104839.GE20973@bubble.grove.modra.org>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
 <1340256961.1998.11.camel@concordia>
 <1340259896.3942.2.camel@pasglop>
 <1340262473.1998.19.camel@concordia>
 <1340264307.1998.20.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340264307.1998.20.camel@concordia>
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2012 at 05:38:27PM +1000, Michael Ellerman wrote:
> On Thu, 2012-06-21 at 17:07 +1000, Michael Ellerman wrote:
> > On Thu, 2012-06-21 at 16:24 +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2012-06-21 at 15:36 +1000, Michael Ellerman wrote:
> > > > 
> > > > powerpc64-linux-ld: /src/next/net/openvswitch/vport-netdev.c:189:(.text+0x89b990): 
> > > >         sibling call optimization to `_restgpr0_28' does not allow automatic multiple TOCs;
> > > >         recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `_restgpr0_28' extern
> > > > 

Linker bug.  That's not a sibling call, but a normal function return
via an out-of-line register restore function.  Will fix.  I'm a bit
surprised to see this with gcc-4.6 though.  Or does this gcc-4.6 have
some of my recent mainline gcc patches enabling out-of-line
save/restore functions for -Os?

-- 
Alan Modra
Australia Development Lab, IBM

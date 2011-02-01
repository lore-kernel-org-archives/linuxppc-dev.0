Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22EB2B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 06:41:18 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p11JQxWt011625
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 12:26:59 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p11JfDUM120758
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 12:41:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p11JfDOF020095
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 12:41:13 -0700
Subject: Re: [PATCH V2 5/6] powerpc/44x: boot wrapper: allow kernel to load
	into non-zero address
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110201131357.59fc4445@udp111988uds.am.freescale.net>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110201131357.59fc4445@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 01 Feb 2011 13:41:11 -0600
Message-ID: <1296589271.14347.2.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-02-01 at 13:13 -0600, Scott Wood wrote:
> On Tue, 1 Feb 2011 12:48:45 -0600
> Dave Kleikamp <shaggy@linux.vnet.ibm.com> wrote:
> 
> > For AMP, different kernel instances load into separate memory regions.
> > Read the start of memory from the device tree and limit the memory to what's
> > specified in the device tree.
> > 
> > Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/boot/treeboot-iss4xx.c |   22 +++++++++++++++++++++-
> >  1 files changed, 21 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
> > index fcc4495..868c8b4 100644
> > --- a/arch/powerpc/boot/treeboot-iss4xx.c
> > +++ b/arch/powerpc/boot/treeboot-iss4xx.c
> > @@ -34,9 +34,28 @@
> >  
> >  BSS_STACK(4096);
> >  
> > +static ibm4xx_memstart;
> 
> type?

Oops, I'll fix this

> > +static void *iss_4xx_vmlinux_alloc(unsigned long size)
> > +{
> > +	return ibm4xx_memstart;
> >  }
> 
> Doesn't this generate a warning for implicitly casting int to void *?

Probably.  I could have missed it.  I'll fix this too.

> 
> -Scott
> 

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center

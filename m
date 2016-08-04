Return-Path: <themoken@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4vqW11JczDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 02:03:18 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id x185so5621582qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 09:03:18 -0700 (PDT)
Sender: Jack Miller <themoken@gmail.com>
Date: Thu, 4 Aug 2016 11:03:12 -0500
From: Jack Miller <jack@codezen.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, jk@ozlabs.org
Subject: Re: [PATCH v2] powernv: Simplify searching for compatible device nodes
Message-ID: <20160804160312.GA30161@hypothesis>
References: <20160803164412.7039-1-jack@codezen.org>
 <20160803171800.8999-1-jack@codezen.org>
 <20160804172727.55e81056@camb691>
 <87k2fxexmr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2fxexmr.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 06:39:24PM +1000, Michael Ellerman wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
> 
> > On Wed,  3 Aug 2016 12:18:00 -0500
> > Jack Miller <jack@codezen.org> wrote:
> >
> >> (rebased on powerpc/next)
> >> 
> >> This condenses the opal node searching into a single function that finds
> >> all compatible nodes, instead of just searching the ibm,opal children,
> >> for ipmi, flash, and prd similar to how opal-i2c nodes are found.
> >> 
> >> Signed-off-by: Jack Miller <jack@codezen.org>
> >
> > Using a version of the related skiboot patch that may not be the final one:
> > Tested-by: Cyril Bur <cyrilbur@gmail.com>
> 
> Thanks. The part I'm still not clear on is *why* we're moving them in
> skiboot?

Ostensibly so the actual flash device nodes can inherit the #size-cells /
#address-cells properties properly set in the flash parent node instead of
the ibm,opal node (which has them set to 0). This would be more correct if
anything actually started to honor these settings.

The only concrete effect though is stopping dtc (and thus fwts) from whinging
when you run skiboot's output DT through it.

- Jack

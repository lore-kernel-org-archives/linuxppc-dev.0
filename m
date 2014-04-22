Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEACA1400FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 04:27:31 +1000 (EST)
Date: Tue, 22 Apr 2014 20:27:25 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v11 5/6] dma: mpc512x: add device tree binding document
Message-ID: <20140422182725.GB3528@book.gsilab.sittig.org>
References: <1397559250-17680-1-git-send-email-a13xp0p0v88@gmail.com>
 <1397559250-17680-6-git-send-email-a13xp0p0v88@gmail.com>
 <20140416204410.GP3528@book.gsilab.sittig.org>
 <CAF0T0X4TqhZ=niKRgArG-s1cD6uRH0UZDqGyTLpde_aHBFTVtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X4TqhZ=niKRgArG-s1cD6uRH0UZDqGyTLpde_aHBFTVtw@mail.gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Anatolij Gustschin <agust@denx.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-18 at 15:29 +0400, Alexander Popov wrote:
> 
> 2014-04-17 0:44 GMT+04:00 Gerhard Sittig <gsi@denx.de>:
> > On Tue, 2014-04-15 at 14:54 +0400, Alexander Popov wrote:
> >>
> >> +- reg: Address and size of the DMA controller's register set
> >> +- interrupts: Interrupt for the DMA controller. Generic interrupt client node
> >> +     is described in interrupt-controller/interrupts.txt
> >
> > 'interrupts' only works in combinations with 'interrupt-parent',
> > that actual .dts files don't have the latter in the nodes is an
> > implementation detail but not a binding's requirement
> Excuse me, I didn't understand your point.
> 
> > and an alternative method of specifying interrupts was introduced
> > recently, a reference to the common binding without naming one
> > specific property name could be most appropriate
> Excuse me, I haven't found such an example.

The 'interrupts' property is not enough in itself, it always
needs the 'interrupt-parent' property, too.  Because the parent
(the interrupt controller) often is the same for multiple
interrupts, it usually gets "factored out" into a parent node in
the tree, and thus often gets missed in discussions.  Still the
'interrupt-parent' is strictly required for 'interrupts' to work.
Splitting both properties and putting them into nodes that are
rather distant from each other is just an implementation detail
of .dts files.  This should not be reflected in bindings.

The 'interrupts-extended' property was introduced only recently.
See bindings/interrupt-controller/interrupts.txt for details.
Although the motivation was to reference several parents from one
client node, I very much like the idea of having all of the
interrupt spec within a single property.  Being explicit is a
good thing, especially in setups with cascades.  I consider this
approach an improvement in readability and maintenance.

You might just want to document in the binding that interrupt
specs are required (or optional), which interrupts these are (the
above text could be sufficient if there is only one interrupt for
this IP block), and refer to the common binding for the syntax.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0148.outbound.protection.outlook.com [157.56.111.148])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B9691A085C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 10:43:46 +1000 (EST)
Message-ID: <1412124210.13320.330.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Add support for pci(e) machine check
 exception on E500MC / E5500
From: Scott Wood <scottwood@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Sep 2014 19:43:30 -0500
In-Reply-To: <20140930155029.GA4724@roeck-us.net>
References: <D04F3201.10DEB%jojyv@juniper.net>
 <1412033466.13320.293.camel@snotra.buserror.net>
 <20140930155029.GA4724@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "hongtao.jia@freescale.com" <hongtao.jia@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guenter Roeck <groeck@juniper.net>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jojy Varghese <jojyv@juniper.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-30 at 08:50 -0700, Guenter Roeck wrote:
> On Mon, Sep 29, 2014 at 06:31:06PM -0500, Scott Wood wrote:
> > On Mon, 2014-09-29 at 23:03 +0000, Jojy Varghese wrote:
> > > 
> > > On 9/29/14 12:06 PM, "Guenter Roeck" <linux@roeck-us.net> wrote:
> > > 
> > > >Those are errors related to PCIe hotplug, and are seen with unexpected
> > > >PCIe
> > > >device removals (triggered, for example, by removing power from a PCIe
> > > >adapter).
> > > >The behavior we see on E5500 is quite similar to the same behavior on
> > > >E500:
> > > >If unhandled, the CPU keeps executing the same instruction over and over
> > > >again
> > > >if there is an error on a PCIe access and thus stalls. I don't know if
> > > >this
> > > >is considered an erratum or expected behavior, but it is one we have to
> > > >address
> > > >since we have to be able to handle that condition. 
> > 
> > The reason I ask is that the handling for e500 was described as an
> > erratum workaround.  If it is an erratum it would be nice to know the
> > erratum number and the full list of affected chips.
> > 
> My understanding, which may be wrong, was that this is expected behavior,
> at least for E5500. I actually thought I had seen it somewhere in the
> specification (response to PCIe errors), but I don't recall where exactly.
> 
> At least for my part I am not aware of an erratum.

Jia Hongtao, can you comment here?

> > > >Ultimately, we'll want
> > > >to
> > > >implement PCIe error handlers for the affected drivers, but that will be
> > > >a next
> > > >step.
> > 
> > For now can we at least print a ratelimited error message?  I don't like
> > the idea of silently ignoring these errors.  I suppose it's a separate
> > issue from extending the workaround to cover e500mc, though.
> > 
> I don't really like the idea of printing an error message pretty much each time
> when an unexpected hotplug event occurs.

Unexpected events seem like the sort of thing you'd want to log, but my
concern is that this might not be the only cause of PCI errors.

-Scott

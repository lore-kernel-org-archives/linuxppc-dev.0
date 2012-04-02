Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62407B6F9A
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2012 07:08:43 +1000 (EST)
Message-ID: <1333400910.30734.54.camel@pasglop>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 03 Apr 2012 07:08:30 +1000
In-Reply-To: <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop>
 <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Frank =?ISO-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-02 at 08:10 -0400, Josh Boyer wrote:
> On Fri, Mar 30, 2012 at 8:03 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Sat, 2012-03-31 at 00:53 +0200, Frank Svendsbøe wrote:
> >
> >> Hi Josh Boyer,
> >>
> >> just wanted to add that I'm experiencing the same problem that Robert
> >> reported, but on 8xx instead of 4xx. The mpc8xx does not support the
> >> mfdcrx instruction, so maybe it's more to it than just a binutils bug?
> >
> > The kernel shouldn't have tried to build that instruction on 8xx, though
> > I suppose if it's in arch/powerpc/boot, we are a bit too eager at
> > building everything including what's not relevant, we might to be a bit
> > more careful at excluding 4xx stuff on a 8xx kernel.
> 
> It's still a binutils issue.  Sounds like the toolchain being used to
> build the 8xx kernel is specifically built for 8xx.  A generally built
> binutils should have worked fine (assuming it was new enough), since
> we pass -mcpu=405.

Still, it makes sense to limit the building of the wrappers to the CPU
family of the kernel...

Cheers,
Ben.

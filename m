Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 673401400EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 12:22:57 +1000 (EST)
Message-ID: <1399342967.15726.181.camel@snotra.buserror.net>
Subject: Re: [PATCH v3] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 5 May 2014 21:22:47 -0500
In-Reply-To: <1FE471CC-2024-4B39-89E2-FBACF8F18A9B@kernel.crashing.org>
References: <1399305499-6612-1-git-send-email-diana.craciun@freescale.com>
 <1FE471CC-2024-4B39-89E2-FBACF8F18A9B@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Diana Craciun <diana.craciun@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 21:12 -0500, Kumar Gala wrote:
> On May 5, 2014, at 10:58 AM, Diana Craciun <diana.craciun@freescale.com> wrote:
> 
> > From: Diana Craciun <Diana.Craciun@freescale.com>
> > 
> > The CoreNet coherency fabric is a fabric-oriented, conectivity
> > infrastructure that enables the implementation of coherent, multicore
> > systems. The CCF acts as a central interconnect for cores,
> > platform-level caches, memory subsystem, peripheral devices and I/O host
> > bridges in the system.
> > 
> > Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> > ---
> > v3:
> > 	- added port ID mapping
> > 	- removed fsl,corenetx-cf
> > 
> > .../devicetree/bindings/powerpc/fsl/ccf.txt        | 42 ++++++++++++++++++++++
> > .../devicetree/bindings/powerpc/fsl/cpus.txt       |  8 +++++
> > .../devicetree/bindings/powerpc/fsl/pamu.txt       |  8 +++++
> > 3 files changed, 58 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> 
> [snip]
> 
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> > @@ -20,3 +20,11 @@ PROPERTIES
> > 	a property named fsl,eref-[CAT], where [CAT] is the abbreviated category
> > 	name with all uppercase letters converted to lowercase, indicates that
> > 	the category is supported by the implementation.
> > +
> > +	- fsl,portid-mapping : <u32>
> > +	The Coherency Subdomain ID Port Mapping Registers and Snoop ID Port Mapping
> > +	registers which are part of the CoreNet Coherency fabric (CCF) provide a
> > +	CoreNet Coherency Subdomain ID/CoreNet Snoop ID to cpu mapping functions.
> > +	Certain bits from these registers should be set if the coresponding CPU
> > +	should be snooped. This property defines a bitmask which selects the bit that
> > +	should be set if this cpu should be snooped.
> 
> Under what cases can software not figure out how to set this based on the PAMUs in the DT?

How would it go about doing that?

Besides the difference between corenet1-cf and corenet2-cf, on
corenet1-cf the position of the PAMU bits depends on the number of CPUs
that the chip was designed for.  This may be different from the number
of CPUs that are actually present (e.g. p4040, or AMP).  It's also a
complication that IMHO is asking for trouble, versus straightforwardly
recording information that is present in a table in the manual.

-Scott

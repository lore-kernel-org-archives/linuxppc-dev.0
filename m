Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 74FB3DDF32
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 07:02:26 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 30 May 2007 23:02:12 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Message-ID: <20070530210212.GB4510@iram.es>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
	<1180525484.19517.266.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180525484.19517.266.camel@localhost.localdomain>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 30, 2007 at 09:44:44PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2007-05-30 at 00:32 -0500, Kumar Gala wrote:
> > > I think actually it would be useful to have the saving/restoring of
> > > the high 32 bits controlled by a prctl, so that programs have to ask
> > > explicitly for the new behaviour (and programs that don't want to
> > use
> > > the high 32 bits don't incur the extra overhead).
> > 
> > I like this, it means we can error if HW doesn't support it and  
> > requires applications to do something specific to enable the feature.
> 
> Yeah well.... I liked the prctl at first.. but then, I though twice :-)

I agree, sooner or later, distribution might install two copies in two 
different places and the dynamic loader will select one depending 
availability of 64 bit registers. At this point virtually all applications 
will effectively use 64 bit registers even when compiled in pure 32 bit 
mode but the prctl will have to stay only for "hysterical raisins".

In 32 bit mode, 64 bit divides use a libcall for example. But the
libgcc routine can and should use the 64 bit instructions. There are
many other libcall cases that would benefit from a libgcc compiled
to use 64 bit instructions (64 bit int to floating point conversions and
back). This indirectly affects a lot of functions.

	Gabriel (starting to having nightmares about somebody inventing
	just another processor flavor, like a 64 bit BookE processor 
	with SPE and Altivec).

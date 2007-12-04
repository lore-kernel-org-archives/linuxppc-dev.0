Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 14:10:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge dtc
Message-ID: <20071204031027.GJ32577@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196733544.13978.201.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 01:59:04AM +0000, David Woodhouse wrote:
> 
> On Tue, 2007-10-16 at 15:02 +1000, David Gibson wrote:
> > This very large patch incorporates a copy of dtc into the kernel
> > source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > longer an external dependency to build kernels with configurations
> > which need a dtb file.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > Too big for the list, full patch at
> > http://ozlabs.org/~dgibson/home/merge-dtc.patch
> 
> I think this is a bad idea -- it's hardly a difficult for those people
> who _do_ need dts to obtain it separately.
> 
> It's bad enough that I have to separate out the bootwrapper code, which
> probably ought to live outside the kernel. We shouldn't be merging
> _more_ stuff in.

We've been back and forth on this several times, Paul and I finally
concluded this was the better option.

It means we can feel free to use dtc for whatever new platforms we
wish to without people whinging about having to install a new tool.
And it means as dtc evolves to have new useful features, we just need
to ensure that the dts files in the kernel are buildable with the dtc
in the kernel, rather than requireing people to keep updating their
dtc to match what the kernel build needs.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

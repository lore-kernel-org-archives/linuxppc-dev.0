Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B834B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2012 12:45:35 +1100 (EST)
Date: Mon, 12 Mar 2012 10:12:25 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Rob Herring <rob.herring@calxeda.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm tree
Message-ID: <20120312011224.GA9503@linux-sh.org>
References: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
 <25744.1331174036@neuling.org>
 <20120308145131.fad50bbc79c36f0b0b12d101@canb.auug.org.au>
 <1331185951.3105.29.camel@pasglop> <1331249746.3105.40.camel@pasglop>
 <20120309003937.GC8680@flint.arm.linux.org.uk>
 <1331262821.3105.47.camel@pasglop> <4F5A350F.3090905@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F5A350F.3090905@calxeda.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2012 at 10:51:27AM -0600, Rob Herring wrote:
> On 03/08/2012 09:13 PM, Benjamin Herrenschmidt wrote:
> > On Fri, 2012-03-09 at 00:39 +0000, Russell King wrote:
> >> On Fri, Mar 09, 2012 at 10:35:46AM +1100, Benjamin Herrenschmidt wrote:
> >>> Actually, I didn't keep MAY_HAVE_SPARSE_IRQ, I kept HAVE_SPARSE_IRQ. If
> >>> I remove it, then I get Kconfig warnings:
> >>>
> >>> warning: (PPC) selects SPARSE_IRQ which has unmet direct dependencies
> >>> (HAVE_GENERIC_HARDIRQS && HAVE_SPARSE_IRQ)
> >>
> >> Do you have commit 2ed86b16eabe4efbf80cc725a8cbb5310746a2fc ?
> > 
> > Nope, Grant patch didn't mention a dependency.
> 
> My opinion is that SPARSE_IRQ shouldn't be user visible option, and the
> simple solution was to just make it hidden. It wasn't clear if this was
> desired or not for other arches at the time. There is a mixture of
> settings in powerpc defconfigs. SuperH selects it for 32-bit and leaves
> it user selectable for 64-bit.
> 
> I'm happy to revert adding MAY_HAVE_SPARSE_IRQ and just make SPARSE_IRQ
> a hidden option. It really just needs the okay from SuperH folks.
> 
We basically want it always-enabled for 32-bit and it doesn't matter much
about 64-bit. In the future I'll probably fix up the 64-bit stuff to use
it too and then we'll just leave it on all the time, but it's not such a
big deal if it's not visible for enabling on 64-bit at the moment given
that it's probably broken there at the moment.

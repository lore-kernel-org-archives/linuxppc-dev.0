Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B58091A2ACF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 17:04:50 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
Date: Mon, 23 Mar 2015 07:04:31 +0100
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <20150322220708.GA14061@oracle.com>
 <1427062924.4770.208.camel@kernel.crashing.org>
In-Reply-To: <1427062924.4770.208.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201503230704.31878.arnd@arndb.de>
Cc: sparclinux@vger.kernel.org, Sowmini Varadhan <sowmini.varadhan@oracle.com>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 22 March 2015, Benjamin Herrenschmidt wrote:
> On Sun, 2015-03-22 at 18:07 -0400, Sowmini Varadhan wrote:
> > On (03/23/15 09:02), Benjamin Herrenschmidt wrote:
> > > > How does this relate to the ARM implementation? There is currently
> > > > an effort going on to make that one shared with ARM64 and possibly
> > > > x86. Has anyone looked at both the PowerPC and ARM ways of doing the
> > > > allocation to see if we could pick one of the two to work on
> > > > all architectures?
> > > 
> > > What I see in ARM is horribly complex, I can't quite make sense of it
> > > in a couple of minutes of looking at it, and doesn't seem to address the
> > > basic issue we are addressing here which is the splitting of the iommu
> > > table lock.
> > 
> > Amen to that.. I thought it was just me :-)

Two problems on ARM IOMMU hardware are:

- a very wide range of incompatible approaches, from a simple sw-loaded
  iotlb with just a few hugepage entries to some rather complex
  ones
- a rather overdesigned "SMMU" that will be used by half the SoCs, but
  with some of them implementing slightly incompatible variants.

> > I plan to go through the code to see if/where the armd iommu code
> > does its locking and achieves its parallelism, but the mapping
> > between the sparc/powerpc approach and armd is not immediately obvious
> > to me.

My guess is that the ARM code so far has been concerned mainly with
getting things to work in the first place, but scalability problems
will only be seen when there are faster CPU cores become available.

> We might have more chance with x86_64 though... They would surely have
> similar scalability issues.
> 

I believe the complexity of the modern Intel and AMD IOMMUs is similar
to the ARM SMMU, which appears to have been modeled after the Intel
one to some degree.

	Arnd

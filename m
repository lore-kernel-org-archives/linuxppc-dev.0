Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AF4FB6F83
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 05:47:21 +1000 (EST)
Date: Wed, 15 Jun 2011 14:47:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Relocatable kernel for ppc44x
Message-ID: <20110615144709.0061dbca@schlenkerla.am.freescale.net>
In-Reply-To: <1308132715.2516.1.camel@pasglop>
References: <4DF74E5D.9020908@monstr.eu> <4DF84D92.2030803@in.ibm.com>
	<1308132715.2516.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu,
	Suzuki Poulose <suzuki@in.ibm.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Jun 2011 20:11:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-06-15 at 11:43 +0530, Suzuki Poulose wrote:
> > On 06/14/11 17:34, Michal Simek wrote:
> > > Hi,
> > >
> > > have someone tried to support RELOCATABLE kernel on ppc44x?
> > As Josh, mentioned, I will be working on this. In fact I was trying a couple of
> > patches towards this on PPC440x. But, I am stuck in debugging the hang that I am
> > experiencing with the changes. I am setting up a RISCWatch processor probe to
> > debug the same.
> > 
> > Here is some information that I wanted to share :
> > 
> > The PPC440X currently uses 256M TLB entries to pin the lowmem. When we go for a
> > relocatable kernel we have to :
> > 
> > 1) Restrict the kernel load address to be 256M aligned
> 
> Wait a minute ... :-)
> 
> There's a difference between having the kernel run from any address and
> mapping the linear mapping not starting at 0.
> 
> Those are completely orthogonal.
> 
> I don't see why off hand you are changing the way the TLB is used. The
> only possible change needed is to make sure the initial bolted entry set
> by the asm code properly covers the kernel in whatever it's "current"
> location is. The rest is a matter of fixing up the relocations...

Changing where the linear mapping points to is useful for AMP configurations
where you're supposed to be considering your memory to be a subset of the
real memory.  This is implemented on e500 as CONFIG_RELOCATABLE, though
it should have been called something different since it's not really
building a relocatable kernel (unlike what 64-bit does with
CONFIG_RELOCATABLE).

-Scott

Return-Path: <mgreer@mvista.com>
Date: Tue, 15 May 2007 15:06:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070515220616.GB2433@mag.az.mvista.com>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
	<17987.47155.935764.878634@cargo.ozlabs.ibm.com>
	<20070511170512.GH4452@austin.ibm.com>
	<FF6A6402-37F5-406F-9DA2-0C0D4D6E4D8B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF6A6402-37F5-406F-9DA2-0C0D4D6E4D8B@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 04:06:40PM -0500, Kumar Gala wrote:
> 
> On May 11, 2007, at 12:05 PM, Linas Vepstas wrote:
> 
> > On Fri, May 11, 2007 at 10:26:27AM +1000, Paul Mackerras wrote:
> >> Olof Johansson writes:
> >>
> >>> This adds yet another set of chipset drivers under sysdev, that are
> >>> only used by one platform (several board ports under that platform,
> >>> but only one platforms/* directory).
> >>>
> >>> In my opinion, they really should go under the platform directory  
> >>> instead,
> >>> and not clutter the shared directory.
> >>
> >> I disagree, actually.  Having these things in a shared directory  
> >> makes
> >> it more likely that people will look at the code.  That means that
> >> it's more likely that bugs will be found, and more likely that parts
> >> of the code can get reused when people are doing the port to a new
> >> chip or board.
> >>
> >> If there were hundreds of files in arch/powerpc/sysdev then I  
> >> would be
> >> more likely to agree with you, but there aren't.
> >
> > I like Paul's take, it matches my gut instincts.
> 
> If this is how we are going we should move some code from arch/ 
> powerpc/platforms into sysdev (for example the 5200 platform has its  
> pic code and some other bits that would be candidate to move into  
> sysdev).

I like Paul's take as well and I don't like the idea of moving the
5200 pci code, etc. to sysdev.  I just can't explain why.

But, I'll try anyway:

The 5200 is an SoC so all the portions of that chip are tighly coupled
with the 5200.  It doesn't make sense to put half of the 5200 code under
platforms and the other half under sysdev (unless the code is shared
with something that isn't a 5200).

The marvell code is not tied to any particular processor family/SoC.
There are versions that work on 7xx/74xx, and 970.  So, you could say
that code is shared amongst several families even though all of the
platform code that uses it happens to be under embedded6xx.

That's the best I can come up with right now. :)

Mark

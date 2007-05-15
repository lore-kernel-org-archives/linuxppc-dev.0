Return-Path: <olof@lixom.net>
Date: Tue, 15 May 2007 17:25:29 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070515222529.GA14881@lixom.net>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
	<17987.47155.935764.878634@cargo.ozlabs.ibm.com>
	<20070511170512.GH4452@austin.ibm.com>
	<FF6A6402-37F5-406F-9DA2-0C0D4D6E4D8B@kernel.crashing.org>
	<20070515220616.GB2433@mag.az.mvista.com>
	<528646bc0705151519p5bcce91ctaaa4880cfc9e5902@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0705151519p5bcce91ctaaa4880cfc9e5902@mail.gmail.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 04:19:05PM -0600, Grant Likely wrote:
> On 5/15/07, Mark A. Greer <mgreer@mvista.com> wrote:
> > On Tue, May 15, 2007 at 04:06:40PM -0500, Kumar Gala wrote:
> > > If this is how we are going we should move some code from arch/
> > > powerpc/platforms into sysdev (for example the 5200 platform has its
> > > pic code and some other bits that would be candidate to move into
> > > sysdev).
> >
> > I like Paul's take as well and I don't like the idea of moving the
> > 5200 pci code, etc. to sysdev.  I just can't explain why.
> >
> > But, I'll try anyway:
> >
> > The 5200 is an SoC so all the portions of that chip are tighly coupled
> > with the 5200.  It doesn't make sense to put half of the 5200 code under
> > platforms and the other half under sysdev (unless the code is shared
> > with something that isn't a 5200).
> 
> Actually, that's a good explaination
> 
> I must agree.  If there is little chance that the code will be used by
> any other platform, then don't split it up for the sake of (for
> example) putting all the pic code in the same place.  I think there
> are fewer opportunities for confusion if only code that is actually
> shared goes in the shared directory.  (ie. "how worried do I need to
> be about affecting other platforms when I modify this code?").

In other words, both of you agree with my original points, even though
Mark said first "I agree with Paul", and then gave the same reasons as
me for not putting non-shared stuff in sysdev. :-)

Anyway, I don't care enough to try to persuade anyone to change stance
on the question, I mostly wanted it clarified before it gets out of hand
in case it is NOT to be a dumping ground.


-Olof

Date: Fri, 31 Aug 2001 16:29:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mvme5100 one more time...
Message-ID: <20010831162904.M27811@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010830170043.A8047@ipnpcu5.in2p3.fr> <20010830091936.N18618@cpe-24-221-152-185.az.sprintbbd.net> <20010831111629.A29808@ipnpcu5.in2p3.fr> <20010831075046.E27811@cpe-24-221-152-185.az.sprintbbd.net> <20010831173634.C8764@ipnpcu5.in2p3.fr> <20010831084927.F27811@cpe-24-221-152-185.az.sprintbbd.net> <20010831180336.A13543@ipnpcu5.in2p3.fr> <20010831110938.A3472@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010831110938.A3472@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 31, 2001 at 11:09:38AM -0700, Tom Rini wrote:
>
> On Fri, Aug 31, 2001 at 06:03:36PM +0200, Xavier Grave wrote:
> >
> > Le ven, 31 ao? 2001 17:49:27, Tom Rini a ?crit :
> > >
> > > Okay.  Try this.  Undo what I told you last time, and make the end of
> > > the file look like:
> > > #if 0
> > >
> > > 	.comm	.stack,4096*2,4
> > > #endif
> > >
> > > This may or may not compile.  I have a feeling there'll be some egg on
> > > my face shortly...
> >
> > it doesn't compile : I have the following message :
> > head.o: In function `start_ldr':
> > head.o(.text+0x176): undefined reference to `stack'
> > head.o(.text+0x17a): undefined reference to `stack'
> > make[2]: *** [zvmlinux] Erreur 1
> >
> > Why the eggs ? because it doesn't compile ? :-)
>
> Well, my guess is that .stack is being defined twice, maybe...  The reg dump
> makes it look like it's about to goto decompress_kernel.  Can you try the
> following patch?  And undo what Itold you to do last time..

And if this fails, I just thought of one more thing (I need some hw I can
test this on locally...).
Look for:
	bl	flush_instruction_cache
And add #if 0/#endif around that and try again...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

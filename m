Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2867C1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 20:15:45 +1100 (EST)
Subject: Re: [BUG] pgprot_noncached() is -NOT- safe for mapping vmalloc
	buffers into userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h8vw3vdb1.wl%tiwai@suse.de>
References: <1301005008.2402.453.camel@pasglop> <s5h8vw3vdb1.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 20:15:33 +1100
Message-ID: <1301044533.2402.478.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Matthew Evans <matt.evans@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-25 at 09:01 +0100, Takashi Iwai wrote:
> > In fact, cache coherent architectures often don't support mapping memory
> > uncached -at-all- so something like snd_pcm_lib_mmap_noncached()
> > shouldn't exist, or at least be under arch control. There's no case
> > where it's "always safe". There will almost always be a cache alias in
> > the linear mapping unless special arch specific sauce has been applied.
> 
> I see.  I'll take your removal patch.
> It should be applied to stable kernel, too, right?

I suppose so :-)

> > Now, there's another problem on top of that, which is that
> > snd_pcm_default_mmap() will not work properly the "other way around" on
> > powerpc, where the mapping -needs- to be uncached bcs you are running on
> > a non cache coherent embedded CPU and trying to mmap DMA memory, but
> > that's something that needs fixing inside powerpc by properly defining
> > dma_mmap_coherent() & ARCH_HAS_DMA_MMAP_COHERENT (I thought we had added
> > it a while back but it's not upstream, patch must have got lost).
> 
> Mea culpa.  I moved to a different team and have had little time for
> the upstream development since then...

That's ok, I did a new one, which you have noticed already anyways :-)

> > We
> > must also make sure we don't go down that path for vmalloc memory
> > though.
>
> Yes.

I haven't actually checked, but I assume that the test

substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV

In snd_pcm_default_mmap() takes care of that, please correct me if
I'm wrong in which case we'll need something else there.

> Your patch looks good.  Thanks for taking care of this! 

Are you taking care of sending it upstream ?

Cheers,
Ben.

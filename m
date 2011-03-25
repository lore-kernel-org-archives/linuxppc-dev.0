Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0B77B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 21:23:39 +1100 (EST)
Subject: Re: [BUG] pgprot_noncached() is -NOT- safe for mapping vmalloc
	buffers into userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5htyer8q5m.wl%tiwai@suse.de>
References: <1301005008.2402.453.camel@pasglop>
	<s5h8vw3vdb1.wl%tiwai@suse.de> <1301044533.2402.478.camel@pasglop>
	<s5htyer8q5m.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 21:23:26 +1100
Message-ID: <1301048606.2402.486.camel@pasglop>
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

On Fri, 2011-03-25 at 11:12 +0100, Takashi Iwai wrote:
> At Fri, 25 Mar 2011 20:15:33 +1100,
> Benjamin Herrenschmidt wrote:
> > 
> > > > We
> > > > must also make sure we don't go down that path for vmalloc memory
> > > > though.
> > >
> > > Yes.
> > 
> > I haven't actually checked, but I assume that the test
> > 
> > substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV
> > 
> > In snd_pcm_default_mmap() takes care of that, please correct me if
> > I'm wrong in which case we'll need something else there.
> 
> Well, in the case of usb-audio, it's not handled via
> dma_mmap_coherent(), as the page isn't allocated via
> dma_alloc_coherent() but vmalloc().

Right, I just wanted to make sure I was right to assume that a page
allocated by vmalloc() was going to fail the above test in 
snd_pcm_default_mmap() and thus -not- get into dma_mmap_coherent()...
just double checking as I'm not totally familiar with the intricacies of
the pcm code :-)

> The bad commit was to overcome some problems on SH platform, IIRC,
> when it's used with dmix -- i.e. concurrent accesses on the mmapped
> buffer from multiple processes.  But, this looks obviously like a
> wrong approach.

Is this a vivt architecture ? Maybe enforcing some restrictions on the
virtual addresses so they hit the same cache congruence classes ?

> Actually, the buffer allocated there in usb-audio is an intermediate
> buffer, that isn't directly transferred to hardware.  We may need a
> bit more consideration what is the best way to solve that issue (if
> it's still really present).

Right. I wouldn't expect vmalloc stuff to hit HW in most cases anyways,
though I do wonder why you don't pass the buffer directly to the HCD and
avoid that intermediate step but that's a completely different
question :-)

> > > Your patch looks good.  Thanks for taking care of this! 
> > 
> > Are you taking care of sending it upstream ?
> 
> I'll apply the patch to remove vmalloc pgprot thingy surely to sound
> tree and include in the next pull request.
> 
> Others should be sent through arch maintainers (PPC and ARM), right?

Well, I am ppc maintainer so that's sorted :-) I've CCed Russell for the
other, it's up to him, I have no specific dependency there, it's just an
easy cleanup I stumbled upon.

Cheers,
Ben.

> 
> thanks,
> 
> Takashi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

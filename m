Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id DDF6FB7195
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 10:56:19 +1000 (EST)
Received: by gxk4 with SMTP id 4so7571635gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 17:56:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090617093654B.fujita.tomonori@lab.ntt.co.jp>
References: <4A37DB0F.7060801@freescale.com> <200906162002.12376.arnd@arndb.de>
	<1245197925.21602.0.camel@pasglop>
	<20090617093654B.fujita.tomonori@lab.ntt.co.jp>
Date: Wed, 17 Jun 2009 02:56:17 +0200
Message-ID: <c384c5ea0906161756j4b701abfj2a8908b9c93ddd04@mail.gmail.com>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, scottwood@freescale.com,
	chris.pringle@oxtel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

On Wed, Jun 17, 2009 at 2:37 AM, FUJITA
Tomonori<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Wed, 17 Jun 2009 10:18:45 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Tue, 2009-06-16 at 20:02 +0200, Arnd Bergmann wrote:
>> > On Tuesday 16 June 2009, Scott Wood wrote:
>> > > > If the
>> > > > device is the only one, you can also use dma_alloc_noncoherent() and
>> > > > flush explicitly with dma_cache_sync().
>> > >
>> > > I don't see how that would help -- aren't those also controlled by
>> > > CONFIG_NOT_COHERENT_CACHE?
>> >
>> > Ah, yes you are right. PowerPC implements dma_alloc_noncoherent as
>> > dma_alloc_coherent, so dma_cache_sync() is actually a NOP (or should be).
>>
>> But we still need to sync the result of dma_map_* when used multiple
>> times for a single mapping.
>
> We have dma_sync_{single|sg}_for_{cpu|device} API for the above
> purpose.
>
> dma_cache_sync is supposed to be used only with the buffers that
> dma_alloc_noncoherent() returns. On architecutures that maps
> dma_alloc_noncoherent to dma_alloc_coherent, dma_cache_sync() is
> supposed to be NOP.

This discussion raised some doubt with me about my use case:

I my case (note I am not the poster) I am using (what LDD3 calls)
streaming mappings:

I use pci_map_sg(), have the device perform either DMA master reads or
writes to the bus address using PCIe.
After that, I use pci_unmap_sg().

My assumption is that pci_unmap_sg() either makes the cache coherent
or invalidated and thus I do not need to take further actions.
This is on a MPC83xx or 85xx system.

Is this assumption correct?

Regards,

Leon/

-- 
Leon

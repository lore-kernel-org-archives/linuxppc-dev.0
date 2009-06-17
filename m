Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 1AFD8B71C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:13:09 +1000 (EST)
Received: by gxk4 with SMTP id 4so10929gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 18:13:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245200912.21602.2.camel@pasglop>
References: <4A37DB0F.7060801@freescale.com> <200906162002.12376.arnd@arndb.de>
	<1245197925.21602.0.camel@pasglop>
	<20090617093654B.fujita.tomonori@lab.ntt.co.jp>
	<c384c5ea0906161756j4b701abfj2a8908b9c93ddd04@mail.gmail.com>
	<1245200912.21602.2.camel@pasglop>
Date: Wed, 17 Jun 2009 03:13:07 +0200
Message-ID: <c384c5ea0906161813v26b3a739h8ce36e395841df35@mail.gmail.com>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	scottwood@freescale.com, chris.pringle@oxtel.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Benjamin,

On Wed, Jun 17, 2009 at 3:08 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> On Wed, 2009-06-17 at 02:56 +0200, Leon Woestenberg wrote:
>> I use pci_map_sg(), have the device perform either DMA master reads or
>> writes to the bus address using PCIe.
>> After that, I use pci_unmap_sg().
>>
>> My assumption is that pci_unmap_sg() either makes the cache coherent
>> or invalidated and thus I do not need to take further actions.
>> This is on a MPC83xx or 85xx system.
>>
>> Is this assumption correct?
>
> It is, as far as I understand things :-) Those APIs are fun.
>
> You should only need the explicit sync calls if you are going to peek or
> poke at the DMA mapped memory before you unmap it.
>
Thanks, then at least I understand things in the corr^H^H^H^Hsame way :-)

And btw, I hadn't seen any data mismatch yet.

Regards,
-- 
Leon 'likewise' Woestenberg

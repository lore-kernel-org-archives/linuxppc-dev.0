Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id C041EDE164
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 19:33:08 +1100 (EST)
Message-ID: <4982BB3F.3080509@matrix-vision.de>
Date: Fri, 30 Jan 2009 09:33:03 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc/5200: Bugfix for PCI mapping of memory and IMMR
References: <20090127043315.26160.43312.stgit@localhost.localdomain>
	<b5e2fc790901270956q4448ac4brd0f6ea177ace9ade@mail.gmail.com>
In-Reply-To: <b5e2fc790901270956q4448ac4brd0f6ea177ace9ade@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> On Mon, Jan 26, 2009 at 10:34 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>   
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> This patch ensures that memory gets properly mapped into the PCI
>> address space.  Without this patch, the memory window BAR is left
>> at whatever value happened to be loaded into the BAR when Linux
>> was booted.  Without this patch, memory could end up getting mapped
>> at any of the 1G address boundaries instead of at '0' where Linux
>> expects it.
>>
>> Similarly, this patch also ensures that the internally memory mapped
>> registers (IMMR) are mapped to the correct PCI address range.
>>
>> Without this patch, PCI appears to work correctly until a PCI
>> device is inserted which DMAs into memory.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> This is a bugfix that I intend to merge into 2.6.29 and once it is
>> mainlined get it added to the stable queue.  If you have a 5200 system,
>> please test and make sure it works for you.
>>
>> Thanks
>> g.
>>
>>  arch/powerpc/platforms/52xx/mpc52xx_pci.c |   24 ++++++++++--------------
>>  1 files changed, 10 insertions(+), 14 deletions(-)
>>
>>     
>
> This doesn't affect Efika, right?
>
> What's the expected impact and how come nobody tried a DMA-capable PCI
> card in an MPC5200B board before? :)
>
>   
We're running a MPC5200B based board with an external FPGA pumping as 
much data into the CPU's memory as possible using scatter-gather DMA. No 
problems so far ... besides the lousy PCI target performance of the 
5200, of course. Of course we've been always running latest u-boot.

regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich

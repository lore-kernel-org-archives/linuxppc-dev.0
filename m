Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 116B6DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 05:03:22 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2456839yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 10:03:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b5e2fc790901270956q4448ac4brd0f6ea177ace9ade@mail.gmail.com>
References: <20090127043315.26160.43312.stgit@localhost.localdomain>
	<b5e2fc790901270956q4448ac4brd0f6ea177ace9ade@mail.gmail.com>
Date: Tue, 27 Jan 2009 11:03:20 -0700
Message-ID: <fa686aa40901271003r641a199yfdcb22a7f90c3cee@mail.gmail.com>
Subject: Re: [PATCH] powerpc/5200: Bugfix for PCI mapping of memory and IMMR
From: Grant Likely <grant.likely@secretlab.ca>
To: Matt Sealey <matt@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 27, 2009 at 10:56 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Mon, Jan 26, 2009 at 10:34 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
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
>
> This doesn't affect Efika, right?

Correct

> What's the expected impact and how come nobody tried a DMA-capable PCI
> card in an MPC5200B board before? :)

Most of the board I have don't hit the bug, but only because on most
boards U-Boot is setting the BAR to a sane value.  I discovered the
bug on a custom board where u-boot didn't do the right thing with PCI.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

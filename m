Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BED46B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 01:56:27 +1000 (EST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 42D0ADDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 01:56:26 +1000 (EST)
Message-ID: <4A40FB26.8080301@intel.com>
Date: Tue, 23 Jun 2009 08:56:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] fsldma: Add DMA_SLAVE support
References: <20090619193134.GC30992@ovro.caltech.edu>
	<1245705647.937.2.camel@dwillia2-linux.ch.intel.com>
	<2a27d3730906230318g7103a890ic85d1678425ac2c9@mail.gmail.com>
	<6A70F385-C883-4D89-A302-AB09660762C1@kernel.crashing.org>
In-Reply-To: <6A70F385-C883-4D89-A302-AB09660762C1@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>>> Kumar, Leo,
>>>
>>> Can I get your acked-by's for the current state of async_tx.git/ 
>>> next?  I
>>> just pushed out Ira's latest so it may take a moment to mirror out.
>> Acked-by: Li Yang <leoli@freescale.com>
>>
>> However, the addition of arch/powerpc/include/asm/fsldma.h still needs
>> the ack from Kumar.  It doesn't seem to be a common practice though.
> 
> hmm, why are we moving fsldma.h?

There are now two fsldma.h files.

drivers/dma/fsldma.h: no changes, houses the private driver 
implementation details.

arch/powerpc/include/asm/fsldma.h: adds some helper routines and 
definitions for the DMA_SLAVE capability of the driver.  It defines an 
interface for other drivers to use fsldma to initiate device-to-memory 
dma.  Any drivers that use the interface will depend on CONFIG_FSL_DMA 
hence placing this public header under arch/powerpc/include.

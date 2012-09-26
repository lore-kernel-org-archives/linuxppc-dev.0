Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2DC72C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 14:45:40 +1000 (EST)
Message-ID: <50628861.7050206@freescale.com>
Date: Wed, 26 Sep 2012 10:15:21 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH] driver/mtd:IFC NAND:Initialise internal SRAM before any
 write
References: <1347526489-20186-1-git-send-email-prabhakar@freescale.com>
 <68738277-B1F2-4455-B8FD-67F2DD9E1310@kernel.crashing.org>
In-Reply-To: <68738277-B1F2-4455-B8FD-67F2DD9E1310@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/2012 06:23 PM, Kumar Gala wrote:
> On Sep 13, 2012, at 3:54 AM, Prabhakar Kushwaha wrote:
>
>> IFC-1.1.0 uses 28nm techenology for SRAM. This tech has known limitaion for
>> SRAM i.e. "byte select" is not supported. Hence Read Modify Write is
>> implemented in IFC for any "system side write" into sram buffer. Reading an
>> uninitialized memory results in ECC Error from sram wrapper.
>>
>> Hence we must initialize/prefill SRAM buffer by any data before writing
>> anything in SRAM from system side. To initialize SRAM user can use "READID"
>> NAND command with read bytes equal to SRAM size. It will be a one time
>> activity post boot.
>>
>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>> ---
>> Based upon git://git.infradead.org/linux-mtd.git branch master
>> The compilation of this patch depends upon following patch.
>> http://patchwork.ozlabs.org/patch/177893/
>> This patch is currently applied on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>> branch next and status is "Awaiting Upstream"
>>
>>
>> drivers/mtd/nand/fsl_ifc_nand.c |   56 ++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 55 insertions(+), 1 deletion(-)
> If MTD maintainers ack, I'm happy to pull this in via PPC tree.

Hi  Artem,

Can you please ACK this patch so that it can be pulled via PPC tree.

Regards,
Prabhakar

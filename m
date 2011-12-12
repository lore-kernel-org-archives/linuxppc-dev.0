Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8BF321007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 08:16:52 +1100 (EST)
Message-ID: <4EE66EFE.1050608@freescale.com>
Date: Mon, 12 Dec 2011 15:15:42 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
In-Reply-To: <1323724195.2297.11.camel@koala>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2011 03:09 PM, Artem Bityutskiy wrote:
> On Tue, 2011-12-06 at 18:09 -0600, Scott Wood wrote:
>> On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
>>> From: Liu Shuo <shuo.liu@freescale.com>
>>>
>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
>>> to support the Nand flash chip whose page size is larger than 2K bytes,
>>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and save
>>> them to a large buffer.
>>>
>>> Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
>>> ---
>>> v3:
>>>     -remove page_size of struct fsl_elbc_mtd.
>>>     -do a oob write by NAND_CMD_RNDIN. 
>>>
>>>  drivers/mtd/nand/fsl_elbc_nand.c |  243 ++++++++++++++++++++++++++++++++++----
>>>  1 files changed, 218 insertions(+), 25 deletions(-)
>>
>> What is the plan for bad block marker migration?
> 
> Why it should be migrated? I thought that you support 2KiB pages, and
> this adds 4 and 8 KiB pages support, which you never supported before.
> What is the migration you guys are talking about?

NAND chips come from the factory with bad blocks marked at a certain
offset into each page.  This offset is normally in the OOB area, but
since we change the layout from "4k data, 128 byte oob" to "2k data, 64
byte oob, 2k data, 64 byte oob" the marker is no longer in the oob.  On
first use we need to migrate the markers so that they are still in the oob.

-Scott

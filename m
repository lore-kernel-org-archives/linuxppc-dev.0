Return-Path: <B35362@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CC1F11007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 14:36:57 +1100 (EST)
Message-ID: <4EE81ADD.6090104@freescale.com>
Date: Wed, 14 Dec 2011 11:41:17 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>	
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>	
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
In-Reply-To: <1323724195.2297.11.camel@koala>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

=E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 05:09, Artem Bityutskiy =E5=
=86=99=E9=81=93:
> On Tue, 2011-12-06 at 18:09 -0600, Scott Wood wrote:
>> On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
>>> From: Liu Shuo<shuo.liu@freescale.com>
>>>
>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In o=
rder
>>> to support the Nand flash chip whose page size is larger than 2K byte=
s,
>>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and s=
ave
>>> them to a large buffer.
>>>
>>> Signed-off-by: Liu Shuo<shuo.liu@freescale.com>
>>> ---
>>> v3:
>>>      -remove page_size of struct fsl_elbc_mtd.
>>>      -do a oob write by NAND_CMD_RNDIN.
>>>
>>>   drivers/mtd/nand/fsl_elbc_nand.c |  243 +++++++++++++++++++++++++++=
+++++++----
>>>   1 files changed, 218 insertions(+), 25 deletions(-)
>> What is the plan for bad block marker migration.
I think we can use a special bbt pattern to indicate whether migration=20
has been done.
(we needn't to define another marker)

Do the migration our chip->scan_bbt as follow :

/*
  * this pattern indicate that the bad block information has been migrate=
d,
  * if this isn't found, we do the migration.
  */
static u8 migrated_bbt_pattern[] =3D {'M', 'b', 'b', 't', '0' };

static int fsl_elbc_bbt(struct mtd_info *mtd)
{
         if (!check_migrated_bbt_pattern())
             bad_block_info_migtrate();

          nand_default_bbt(mtd); /* default function in nand_bbt.c */
}

- LiuShuo

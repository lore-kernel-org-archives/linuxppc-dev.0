Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1554D1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 07:53:31 +1100 (EST)
Message-ID: <4EE90CC0.8040807@freescale.com>
Date: Wed, 14 Dec 2011 14:53:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>	
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>	
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE81ADD.6090104@freescale.com>
In-Reply-To: <4EE81ADD.6090104@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, dedekind1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 shuo.liu@freescale.com, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/2011 09:41 PM, LiuShuo wrote:
> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 05:09, Artem Bityutskiy =E5=
=86=99=E9=81=93:
>> On Tue, 2011-12-06 at 18:09 -0600, Scott Wood wrote:
>>> On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
>>>> From: Liu Shuo<shuo.liu@freescale.com>
>>>>
>>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In
>>>> order
>>>> to support the Nand flash chip whose page size is larger than 2K byt=
es,
>>>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and
>>>> save
>>>> them to a large buffer.
>>>>
>>>> Signed-off-by: Liu Shuo<shuo.liu@freescale.com>
>>>> ---
>>>> v3:
>>>>      -remove page_size of struct fsl_elbc_mtd.
>>>>      -do a oob write by NAND_CMD_RNDIN.
>>>>
>>>>   drivers/mtd/nand/fsl_elbc_nand.c |  243
>>>> ++++++++++++++++++++++++++++++++++----
>>>>   1 files changed, 218 insertions(+), 25 deletions(-)
>>> What is the plan for bad block marker migration.
> I think we can use a special bbt pattern to indicate whether migration
> has been done.
> (we needn't to define another marker)
>=20
> Do the migration our chip->scan_bbt as follow :
>=20
> /*
>  * this pattern indicate that the bad block information has been migrat=
ed,
>  * if this isn't found, we do the migration.
>  */
> static u8 migrated_bbt_pattern[] =3D {'M', 'b', 'b', 't', '0' };
>=20
> static int fsl_elbc_bbt(struct mtd_info *mtd)
> {
>         if (!check_migrated_bbt_pattern())
>             bad_block_info_migtrate();
>=20
>          nand_default_bbt(mtd); /* default function in nand_bbt.c */
> }

Hmm.  This is OK as long as the bad block table never gets erased (which
could happen if a user wants it reconstructed, such as if buggy software
makes a mess of it on a developer's board).  If it gets erased, we'll
end up migrating again -- and the place that factory bad block markers
would have been in is now data, so all blocks that have been written to
will show up as bad unless they happen to have 0xff at the right place.

How about a marker that is compatible with the bbt, so the same block
can be used in production (where scrubbing the bbt should never happen),
but that does not have to imply that the block is a bbt (so a developer
that might want to erase the bbt can set the mark elsewhere, preferably
just before the bbt)?

Or have two versions of the marker, one that is also a bbt marker and
one that is not.

When scanning the bbt, the driver would look for one of these markers
from the end of the chip backward.  If not found, it concludes the chip
is unmigrated.  In U-Boot, this would trigger a migration (or a message
to run a migration command).  In Linux (and U-Boot if migration is a
separate command that has not been run) an unmigrated flash could be
read-only, with the possible exception of raw accesses if needed to
support an external migration tool.

-Scott

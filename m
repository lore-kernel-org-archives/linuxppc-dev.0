Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 271A81007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 07:15:21 +1100 (EST)
Message-ID: <4EE903CE.1010903@freescale.com>
Date: Wed, 14 Dec 2011 14:15:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com> <4EE6BC9B.4000602@freescale.com>
 <4EE8612C.9050104@freescale.com>
In-Reply-To: <4EE8612C.9050104@freescale.com>
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

On 12/14/2011 02:41 AM, LiuShuo wrote:
> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 10:46, LiuShuo =E5=86=99=E9=
=81=93:
>> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 05:30, Scott Wood =E5=86=
=99=E9=81=93:
>>> On 12/12/2011 03:19 PM, Artem Bityutskiy wrote:
>>>> On Mon, 2011-12-12 at 15:15 -0600, Scott Wood wrote:
>>>>> NAND chips come from the factory with bad blocks marked at a certai=
n
>>>>> offset into each page.  This offset is normally in the OOB area, bu=
t
>>>>> since we change the layout from "4k data, 128 byte oob" to "2k
>>>>> data, 64
>>>>> byte oob, 2k data, 64 byte oob" the marker is no longer in the
>>>>> oob.  On
>>>>> first use we need to migrate the markers so that they are still in
>>>>> the oob.
>>>> Ah, I see, thanks. Are you planning to implement in-kernel migration=
 or
>>>> use a user-space tool?
>>> That's the kind of answer I was hoping to get from Shuo. :-)
>> OK, I try to do this. Wait for a couple of days.
>>
>> -LiuShuo
> I found it's too complex to do the migration in Linux driver.
>=20
> Maybe we can add a uboot command (e.g. nand bbmigrate) to do it, once i=
s
> enough.

Any reason not to do it automatically on the first U-Boot bad block
scan, if the flash isn't marked as already migrated?

Further discussion on the details of how to do it in U-Boot should move
to the U-Boot list.

> And let user ensure it been completed before linux use the Nand flash c=
hip.

I don't want to trust the user here.  It's too easy to skip it, and
things will appear to work, but have subtle problems.

> Even if we don't do the migration, the bad block also can be marked as =
bad
> by wearing. So, do we really need to take much time to implement it ?
> (code looks too complex.)

It is not acceptable to ignore factory bad block markers just because
some methods of using the flash may eventually detect an error (possibly
after data is lost -- no guarantee that the badness is ECC-correctable)
and mark the block bad again.

If you don't feel up to the task, I can look at it, but won't have time
until January.

-Scott

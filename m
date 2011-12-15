Return-Path: <pku.leo@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6213D1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 15:59:29 +1100 (EST)
Received: by eekb57 with SMTP id b57so1638916eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 20:59:24 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4EE903CE.1010903@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com> <4EE6BC9B.4000602@freescale.com>
 <4EE8612C.9050104@freescale.com> <4EE903CE.1010903@freescale.com>
Date: Thu, 15 Dec 2011 12:59:24 +0800
Message-ID: <CADRPPNRRXTWzBEvY=vhe9+v0b8Ntq8KNoaXFN8pQZGmMc-dJYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Artem.Bityutskiy@nokia.com, dedekind1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, LiuShuo <b35362@freescale.com>,
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

On Thu, Dec 15, 2011 at 4:15 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 12/14/2011 02:41 AM, LiuShuo wrote:
>> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 10:46, LiuShuo =E5=86=99=
=E9=81=93:
>>> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8813=E6=97=A5 05:30, Scott Wood =E5=86=
=99=E9=81=93:
>>>> On 12/12/2011 03:19 PM, Artem Bityutskiy wrote:
>>>>> On Mon, 2011-12-12 at 15:15 -0600, Scott Wood wrote:
>>>>>> NAND chips come from the factory with bad blocks marked at a certain
>>>>>> offset into each page. =C2=A0This offset is normally in the OOB area=
, but
>>>>>> since we change the layout from "4k data, 128 byte oob" to "2k
>>>>>> data, 64
>>>>>> byte oob, 2k data, 64 byte oob" the marker is no longer in the
>>>>>> oob. =C2=A0On
>>>>>> first use we need to migrate the markers so that they are still in
>>>>>> the oob.
>>>>> Ah, I see, thanks. Are you planning to implement in-kernel migration =
or
>>>>> use a user-space tool?
>>>> That's the kind of answer I was hoping to get from Shuo. :-)
>>> OK, I try to do this. Wait for a couple of days.
>>>
>>> -LiuShuo
>> I found it's too complex to do the migration in Linux driver.
>>
>> Maybe we can add a uboot command (e.g. nand bbmigrate) to do it, once is
>> enough.
>
> Any reason not to do it automatically on the first U-Boot bad block
> scan, if the flash isn't marked as already migrated?
>
> Further discussion on the details of how to do it in U-Boot should move
> to the U-Boot list.

The limitation of the proposed bad block marker migration is that you
need to make sure the migration is done and only done once.  If it is
done more than once, the factory bad block marker is totally messed
up.  It requires a complex mechanism to automatically guarantee the
migration is only done once, and it still won't be 100% safe.

I would suggest we use a much easier compromise that we form the BBT
base on the factory bad block marker on first use of the flash, and
after that the factory bad block marker is dropped.  We just relies on
the BBT for information about bad blocks.  Although by doing so we
can't regenerate the BBT again,  as there is mirror for the BBT I
don't think we have too much risk.

- Leo

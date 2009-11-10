Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id A8D97B83FA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:03:05 +1100 (EST)
Received: by ywh37 with SMTP id 37so479425ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 14:03:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257884778.14374.5@antares>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 14:07:17 -0700
Message-ID: <fa686aa40911101307p12bba31s491ef1d8812ca033@mail.gmail.com>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 10, 2009 at 1:26 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi Grant:
>
> Am 10.11.09 20:59 schrieb(en) Grant Likely:
>>
>> On Tue, Nov 10, 2009 at 12:43 PM, Albrecht Dre=DF <albrecht.dress@arcor.=
de>
>> wrote:
>> > Use the MPC5200 GPT api for the WDT which drastically simplifies this
>> > file.
>> >
>> > Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>> > ---
>> >
>> > =A0drivers/watchdog/mpc5200_wdt.c | =A0246
>> > +++++++++++-----------------------------
>> > =A01 files changed, 65 insertions(+), 181 deletions(-)
>>
>>
>> Can the WDT functionality just be merged entirely into
>> arch/powerpc/platforms/52xx/mpc52xx_gpt.c, eliminating the need for
>> this file entirely? =A0I think I'd rather have all the GPT "built in"
>> behaviour handled by a single driver.
>
> I also thought about it, as it has IMHO the cleaner code, and it would ha=
ve
> the extra benefit that the gpt-wdt api doesn't need to be public.
>
> However, the reasons I hesitated to do so are:
> - I don't want to remove a file someone else wrote (even it doesn't work)=
;

Shouldn't be a problem, and I'll handle the fallout if it is.

> - WDT code is shifted from drivers/watchdog to arch/powerpc/platforms/52x=
x
> which might not be the "logical" place from the directory layout's pov;

There is precedence of this in the past, particularly on arch or
platform specific hardware drivers and multifunction devices.  (Heck,
that's almost entirely what arch/powerpc/sysdev is).  I'm not
concerned.

> - a file living in arch/powerpc/platforms/52xx depends upon config option=
s
> set from drivers/watchdog/Kconfig which may be confusing.

I'm not concerned about this either.

> You see these are more political/cosmetical questions, so I would prefer =
to
> leave the decision to the maintainers (i.e. you and Wim). =A0Preparing a =
fully
> merged driver is actually a matter of minutes!

Do it.  I'll champion getting it in.  Wim, do you have any issues with this=
?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69C6D1A1907
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 00:43:17 +1000 (AEST)
Received: by wizk4 with SMTP id k4so149586126wiz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:43:12 -0700 (PDT)
Message-ID: <55672980.4010904@gmail.com>
Date: Thu, 28 May 2015 16:43:12 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: convert bus code to use dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<s5hwpzs7qrz.wl-tiwai@suse.de>	<55671F56.6080402@gmail.com>
 <s5hsiag7q0p.wl-tiwai@suse.de>
In-Reply-To: <s5hsiag7q0p.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/05/2015 16:09, Takashi Iwai wrote:
> At Thu, 28 May 2015 15:59:50 +0200,
> Quentin Lambert wrote:
>>
>>
>> On 28/05/2015 15:52, Takashi Iwai wrote:
>>> At Thu, 28 May 2015 14:48:27 +0200,
>>> Quentin Lambert wrote:
>>>> You should use dev_groups instead of the dev_attrs field of struct
>>>> bus_type. This converts the MDIO bus code to use the correct field.
>>>>
>>>> These modifications were made using Coccinelle.
>>>>
>>>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
>>> What's wrong with dev_attrs?
>>> (Not offending, I'm just curious where the preference for dev_groups
>>>    is referred...)
>> This patch is based on commit 4192c74940e23da727eb02b7b4ee779dde2f670,
>> its message indicates that dev_attrs is going away.
> OK, makes sense.  Then please keep such information in the changelog.
> BTW, the code in question isn't MDIO at all.
Sorry, about that!
>
> Also, it'd be better to move ATTRIBUTE_GROUPS(soundbus_dev) into
> soundbus/sysfs.c, and make it this global instead of
> soundbus_dev_attrs[].
Ok, I need to find a nice way to do that because ATTRIBUTE_GROUPS 
declares the
structure as static. I will send a second version with a better solution.

Quentin
>
>
> Takashi

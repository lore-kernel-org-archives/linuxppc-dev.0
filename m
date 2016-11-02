Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t848b1JLLzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 21:29:19 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id c17so2272697wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 03:29:19 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
 <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 2 Nov 2016 11:28:54 +0100
Message-ID: <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tomi,

On Wed, Nov 2, 2016 at 9:28 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 08/10/16 15:09, Mathieu Malaterre wrote:
>> When the linux kernel is build with (typical kernel ship with Debian
>> installer):
>>
>> CONFIG_FB_OF=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_FB_RADEON=m
>>
>> The offb driver takes precedence over module radeonfb. It is then
>> impossible to load the module, error reported is:
>>
>> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
>> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
>> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
>> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>>
>> This patch reproduce the behavior of the module radeon, so as to make it
>> possible to load radeonfb when offb is first loaded.
>>
>> It should be noticed that `offb_destroy` is never called which explain the
>> need to skip error detection on the radeon side.
>
> Why is that? It sounds rather bad if two drivers claim the same resources.

This has been working great so far for `radeon.ko`, so I assumed I
could shamelessly copy the behavior over to `radeonfb.ko`.

The original reference I found was from Benjamin Herrenschmidt here:
https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.html

I am of course willing to try something else, but I would need some guidance.

Thanks much.

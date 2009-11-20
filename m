Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 869AFB6EF0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 08:13:01 +1100 (EST)
Received: by yxe8 with SMTP id 8so3654127yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 13:12:59 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40911201237y4a41dd63wee3fb4e0a5858e87@mail.gmail.com>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
	<fa686aa40911201237y4a41dd63wee3fb4e0a5858e87@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 14:12:37 -0700
Message-ID: <fa686aa40911201312v3d8b004bu4845e4b9978796e5@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] Rework OpenFirmware GPIO handling
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2009 at 1:37 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Tue, Nov 17, 2009 at 8:42 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> This patch improves OF GPIO bindings so, that most non-OF-specific gpio
>> controllers don't need to call any of OF binding function:
>>
>> 0) Move of_gpio_chip into main gpio_chip structure.
>> 1) Call of_gpio_init/destroy from gpiochip_add/remove.
>> 2) By default supply reasonable defaults for gpio_cells/xlate
>
> I think this change approaches the problem from the wrong way around.
> It is not appropriate to try and build OF hooks into gpiolib. gpiolib
> should be completely agnostic to any layers around them used to get
> data about how they are configured up. =A0If anything, OF helpers should
> wrap around the gpiolib functions so that drivers can use them if it
> is useful to do so.

Hmmm... okay, I didn't read your patch closely enough the first time
around.  I understand what you're trying to do now.  I appreciate
wanting to make GPIO binding transparent to GPIO providers.  However,
I'm still leery of inserting OF hooks into gpiolib.  I'm not convinced
that it is the correct approach.  What *might* work is to add a
notifier API to GPIOLIB so that interested subsystems (like OF) can
register hooks to be told when GPIO pins are added and removed.  That
keeps things all the OF implementation details abstracted away from
gpiolib.

Cheers,
g.

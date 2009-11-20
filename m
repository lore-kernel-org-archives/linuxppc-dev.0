Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id ED429B6F16
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 07:37:40 +1100 (EST)
Received: by ywh37 with SMTP id 37so3570035ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 12:37:38 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 13:37:18 -0700
Message-ID: <fa686aa40911201237y4a41dd63wee3fb4e0a5858e87@mail.gmail.com>
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

On Tue, Nov 17, 2009 at 8:42 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> This patch improves OF GPIO bindings so, that most non-OF-specific gpio
> controllers don't need to call any of OF binding function:
>
> 0) Move of_gpio_chip into main gpio_chip structure.
> 1) Call of_gpio_init/destroy from gpiochip_add/remove.
> 2) By default supply reasonable defaults for gpio_cells/xlate

I think this change approaches the problem from the wrong way around.
It is not appropriate to try and build OF hooks into gpiolib. gpiolib
should be completely agnostic to any layers around them used to get
data about how they are configured up.  If anything, OF helpers should
wrap around the gpiolib functions so that drivers can use them if it
is useful to do so.

g.

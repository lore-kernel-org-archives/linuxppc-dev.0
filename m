Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id F066BDDEB7
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 07:17:00 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2046663wag.13
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:16:58 -0800 (PST)
Message-ID: <9e4733910801111216g7dfee16ev72ec3c58e5d6c746@mail.gmail.com>
Date: Fri, 11 Jan 2008 15:16:57 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/5] Version 17,
	series to add device tree naming to i2c
In-Reply-To: <20080111201550.12abb02c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
	<20080111095638.775670ed@hyperion.delvare>
	<9e4733910801110752k57f1fd7crd5f143900fc64f0b@mail.gmail.com>
	<20080111201550.12abb02c@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/08, Jean Delvare <khali@linux-fr.org> wrote:
> Secondly, it promotes OF device names as acceptable aliases. This I
> don't think I agree with. While I see some value in moving the OF name
> -> Linux name translation to the drivers themselves (even though I
> don't see this as a mandatory move either), this doesn't imply that OF
> names should be used as aliases. I don't like the idea that different
> architectures will name the same device differently in a visible way.
> This could easily break user-space code that makes assumptions on the
> device names (libsensors comes to mind.) So, I think that this part
> will need some more discussion.

They're aliases.  On the x86 my e1000 Ethernet driver loads using this
alias name:
"pci:v00008086d00001010sv*sd*bc*sc*i*"
In fact, the e1000 driver has 63 alias names in addition to "e1000"

But it's still the e1000 driver after it is loaded.
jonsmirl@terra:/home/linux/drivers/net/e1000$ lsmod | grep e1000
e1000                 115968  0

Loading a I2C driver with an OF alias name is not going to change the
module name after it is loaded. In fact, once the module is in memory
there's no way to tell what name was used to load it.

OF device names are set by the Open Firmware committee. It is not
reasonable to force the Linux names back into Open Firmware since this
would force the other operating systems using Open Firmware to adopt
the Linux names.

This issue hasn't been visible before since there was a global table
in the PowerPC code mapping all known Open Firmware names into linux
names. Keeping this as a global table doesn't scale. The mapping needs
to be done by each device individually.

>
> --
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com

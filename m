Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 30E42DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 11:46:58 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so710418wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 16:46:57 -0800 (PST)
Message-ID: <9e4733910801241638u47aa6904u88c6a1606834c9a9@mail.gmail.com>
Date: Thu, 24 Jan 2008 19:38:01 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [i2c] [PATCH 3/3] Add device tree compatible aliases to i2c
	drivers
In-Reply-To: <20080125003249.GA30794@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020916.31675.98481.stgit@terra.home>
	<20080125003249.GA30794@lixom.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/24/08, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jan 22, 2008 at 09:09:16PM -0500, Jon Smirl wrote:
> > PowerPC device trees use a different naming convention than the Linux
> > kernel.  Provide alias names for i2c drivers in order to allow them to
> > be loaded by device tree name. The OF_ID macro ensures that the aliases
> > are only present in powerpc builds and separated into their own namespace.
>
> Hmm. I just realized that there's yet another twist to the PPC device
> bindings that's not yet considered:
>
> Currently the device tree only contains one compatible field for most of
> the devices. But it's perfectly legal (actually, recommended) to have more
> than one compatible field -- they go from the specific to the generic.
>
> For example, for an eeprom I might have: "MCHP,24lc128est",
> "MCHP,24xx128", "24c128". The at24 driver (not in mainline yet :) would
> likely match with "24c128", and it would normally not make sense to have
> to list all specific vendors and models of the device type in question
> in the driver.
>
> I can't register a board_info for each of the compatible fields without
> changing the way the i2c drivers are registered, since the creation of
> the duplicate entries will start reporting errors. I also shouldn't
> (reasonably) have to register every single possible first (i.e. most
> specific) compatible-field -- that goes against the whole concept of
> having more than one compatible string.
>
> So it seems that the solution would be to make i2c_board_info take a
> list of names for the device, and each of them has to be matched with
> all drivers, taking the first match.
>
> Sounds reasonable to everyone? I can provide a patch to go on top of
> what's already proposed.

I was aware that this was missing but I'm having enough trouble
getting the base code in so I hadn't addressed this problem yet. A
patch would be fine, I haven't written any code.

Can you put the support somewhere in powerpc common code? When I get
my dynamically loadable audio codec patch ready it is going to have
the same problem.

Also note that all of this only works for new style i2c drivers, if
you want to dynamically load an old style one your will have to
convert it to new style first (not hard to do).

-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id E51D6B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 07:11:50 +1000 (EST)
Received: by iwn4 with SMTP id 4so3027128iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 14:11:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100929164251.0243ac7f@endymion.delvare>
References: <20100924221313.28357.61419.stgit@angua>
	<20100928232054.GQ21564@trinity.fluff.org>
	<20100929164251.0243ac7f@endymion.delvare>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 Oct 2010 06:11:28 +0900
Message-ID: <AANLkTi=ppV_FiNDPPoiEda-JSp0NDg1aCTgmXj3E_Y-=@mail.gmail.com>
Subject: Re: [PATCH (Option 1)] of/i2c: fix module load order issue caused by
	of_i2c.c
To: Jean Delvare <khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
	linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ben Dooks <ben-i2c@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 29, 2010 at 11:42 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 29 Sep 2010 00:20:54 +0100, Ben Dooks wrote:
>> On Fri, Sep 24, 2010 at 04:14:53PM -0600, Grant Likely wrote:
>> > Commit 959e85f7, "i2c: add OF-style registration and binding" caused a
>> > module dependency loop where of_i2c.c calls functions in i2c-core, and
>> > i2c-core calls of_i2c_register_devices() in of_i2c. =A0This means that
>> > when i2c support is built as a module when CONFIG_OF is set, then
>> > neither i2c_core nor of_i2c are able to be loaded.
>> >
>> > This patch fixes the problem by moving the of_i2c_register_devices()
>> > function into the body of i2c_core and renaming it to
>> > i2c_scan_of_devices (of_i2c_register_devices is analogous to the
>> > existing i2c_scan_static_board_info function and so should be named
>> > similarly). =A0This function isn't called by any code outside of
>> > i2c_core, and it must always be present when CONFIG_OF is selected, so
>> > it makes sense to locate it there. =A0When CONFIG_OF is not selected,
>> > of_i2c_register_devices() becomes a no-op.
>>
>> I sort of go with this one.
>
> Actually I would prefer option #2, even though I understand it won't
> make Grant too happy. Having a large chunk of OF-specific code in
> i2c-core, leaving of_i2c.c almost empty, doesn't seem right.

I'm fine with this.  In the grand scheme, it ends up being an unimportant p=
oint.

> I took a look at what other relevant subsystems do. SPI is boolean so it
> doesn't have the issue. MDIO is tristate, the registration function is
> in of_mdio.c and individual drivers call it. And there are a lot more
> of these (9) than i2c drivers (3).
>
> So I would let individual drivers call of_i2c_register_devices(), as it
> used to be until 2.6.35. 2 extra functions calls doesn't seem a high
> price to pay to keep the code logically separated. This also make
> things consistent, with all OF registration functions living under
> drivers/of.

This is actually historical and somewhat in transition.  Now that all
the OF core code is cleaned up and generalized, I'm looking at the bus
specific hooks and deciding what would be best to do about them.  I'm
likely to move the SPI support into drivers/spi, and I'll probably
post a patch to do the same for drivers/net/phy and for the platform
bus.  The reason being that the data extraction code is far more bus
specific than it is OF-specific.

I will however back off from putting the registration hook directly
into the shared bus registration functions for the time being.  It is
a minor issue, and it does make a certain amount of sense for the
individual drivers to control the bus population.  Proof is in the
patches anyway and we can debate it after I actually post something
concrete.

g.

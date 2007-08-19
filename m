Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA7C0DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 01:38:21 +1000 (EST)
Message-ID: <46C8643B.7010104@genesi-usa.com>
Date: Sun, 19 Aug 2007 16:39:39 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
References: <20070810095153.GC13994@moe.telargo.com>
	<20070818100643.GA31233@nd47.coderock.org>
In-Reply-To: <20070818100643.GA31233@nd47.coderock.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen,

Do it in a Forth script, or in nvramrc (after probe-all). Don't clutter
Linux with more fixups. The Efika PHY isn't going to change to something
else and it's a bog standard no-frills MII PHY anyway.

I think it is a distinction that the OF docs forgot to make, that the
client interface is *all those Forth words* and not just the 6 or 7
distinct, special callable functions like claim (they exist because of
the simple fact that claiming memory shouldn't involve claiming memory
and such other paradoxes) and call-method. Call-method is a perfectly
valid way of doing things.

But, I'd really recommend you please think of a different way.. if you
want to spec out a device tree entry for it I'll update my script which
I am probably going to stick as an 'official' Genesi support file in
the next week.

If you insist on using prom_init and fixups, yaboot has the best
examples of call-method and interpret, both readable and fairly
easily available.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Domen Puncer wrote:
> Hi!
> 
> On 10/08/07 11:51 +0200, Domen Puncer wrote:
>> Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
>> ===================================================================
>> --- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
>> +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
>> +		mdio@3000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			device_type = "mdio";
>> +			compatible = "mpc5200b-fec-phy";
>> +			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
>> +			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
>> +			interrupt-parent = <&mpc5200_pic>;
>> +
>> +			phy0:ethernet-phy@0 {
>> +				device_type = "ethernet-phy";
>> +				reg = <0>;
>> +			};
>>  		};
> 
> I am struggling with this part on Efika.
> I would like to add this to the device tree from
> fixup_device_tree_efika() (arch/powerpc/kernel/prom_init.c).
> 
> AFAICS client-services doesn't offer anything like new-device,
> so I guess "interpret" or "call-method" will have to be used.
> 
> I have read some docs, but I'm still wandering in the dark.
> Can I please get an example?
> Pretty please with a cherry on top?
> 
> 
> 	Domen

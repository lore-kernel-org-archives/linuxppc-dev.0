Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070912035351.GF20218@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<20070912031132.GC20218@localhost.localdomain>
	<AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
	<20070912035351.GF20218@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7F0FE04-5200-4295-9950-ECE387EB65C0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: MDIO & phy device tree bindings (was Re: [PATCH v3] [POWERPC] 85xx:
	Add basic Uniprocessor MPC8572 DS port)
Date: Wed, 12 Sep 2007 10:08:53 -0500
To: David Gibson <david@gibson.dropbear.id.au>,
	Andy Fleming <afleming@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,

I'm splitting this up since the mdio & phy comments are more general  
that the 8572.dts

>>> [snip]
>>>> +		mdio@24520 {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +			device_type = "mdio";
>>>
>>> I don't think we actually have an mdio device_type binding defined.
>>
>> We've had this on 83xx/85xx/86xx device trees for a far amount of
>> time now.  Look at section 2a in booting-without-of.txt
>
> Ah, so we have; sorry.  Although the binding as it is currently
> written is pretty much pointless - it should actually define some
> mappings between dt properties / addresses and the standards defining
> the MDIO bus.x

that's a doc issue at this point

>>>> +			compatible = "gianfar";
>>>
>>> This needs to be more specific.  And it certainly shouldn't be the
>>> same compatible string as the ethernet MACs have.
>>
>> Why not its the same controller?  Again, we've been doing this for
>> some period of time already.
>
> Yes you have, but it's still crap.  'compatible' should be sufficient
> to distinguish the driver needed for device nodes, but the MACs and
> MDIO should clearly have different drivers (or at least, different
> parts of a driver).

don't disagree will see about coming up with a better name, and  
deprecating 'gianfar'.

>>>> +			reg = <24520 20>;
>>>> +			phy0: ethernet-phy@0 {
>>>> +				interrupt-parent = <&mpic>;
>>>> +				interrupts = <a 1>;
>>>> +				reg = <0>;
>>>> +				device_type = "ethernet-phy";
>>>
>>> Do we actually have an ethernet-phy device_type binding?  If not, we
>>> should kill this.  'compatible' properties for phys would  
>>> probably be
>>> a good idea, though (giving the actual phy model).
>>
>> Look section 2c in booting-without-of.txt
>
> Ah, yes.  That one's a rather less redeemable pointless device_type
> binding.  We should kill it from booting-without-of.txt.

agreed, will poke andy on this.

- k

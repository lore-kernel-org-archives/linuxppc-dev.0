Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070924050709.GM8058@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b312e03ef67dcd6cdc5f57e90da746ef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Date: Mon, 24 Sep 2007 23:11:28 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  Scott> #size-cells is zero on i2c, so it should just be reg = <68>.
>>
>>  Scott> You'll probably need to add #address-cells and #size-cells to 
>> the
>>  Scott> controller node, as well.
>
> Uh.. yes.. i2c interfaces should really always have #a and #s.

More generally, every node that defines a bus needs it (unless the
defaults of 2 resp. 1 are correct for this bus, but even then you
might want it because it makes things more explicit).

>>  		i2c@3100 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>>  			device_type = "i2c";
>
> Hrm... we probably want an "i2c" device_type class, but I don't think
> we've actually defined one, which is a problem

By defining new device_type's, or new semantics for device_type,
you open the door to (accidentally) becoming incompatible with
"real" OF.

And you don't need to: "real" OF has a mechanism for specifying
the "generic device class" already, if you use the "generic names"
recommended practice (and you do, for both this node and the rtc
node): it's the generic name itself!

>> +			rtc@68 {
>> +				device_type = "rtc";
>> +				compatible = "dallas,ds1339";
>> +				reg = <68>;
>> +			};
>
> I think we want to think a bit more carefully about how to do bindings
> for RTC devices.  No "rtc" device_type is defined, but again we might
> want to.

Actually, "device_type" = "rtc" _is_ defined (in the "device support
extensions" recommended practice), and there is no useful way a flat
device tree can implement it (it merely defines get-time and set-time
methods).

> The fact that NVRAM+RTC chips are so common is a bit of an issue from
> the point of view of defining a device class binding - a device can't
> have type "rtc" and "nvram".

You should match OS drivers on "compatible" only anyway.

Those cases where OS drivers don't nicely 1-1 match device nodes are a
bit of a headache; for RTC/NVRAM devices, these problems are nicely
side-stepped by handling this from platform code.


Segher

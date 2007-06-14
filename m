Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77843DDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 11:31:54 +1000 (EST)
Message-ID: <46709A84.7030307@am.sony.com>
Date: Wed, 13 Jun 2007 18:31:48 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
In-Reply-To: <f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Segher Boessenkool wrote:
> Hi Geoff,
> 
> Not much that can be wrong in this tree, so I'll get really
> pedantic, so you can have the best device tree ever ;-)
> 
> There is one real bug though.
> 
>> +/ {
>> +	model = "PS3 Game Console";
> 
> model = "sony,some-model-number" or similar

There is no real model number for this product.  Model
numbers specify configuration like PAL video or 60GB disk.

model = "sony,ps3xxxxx"?  That doesn't seem any better than
model = "sony,ps3", but then what will be used for compatible?

I will use model = "SonyPS3";

>> +	compatible = "PS3";
> 
> name = "sony,ps3"


As Ben H. said, the top level 'name' cannot be set, and
I found dtc exits with an error if you include one.

The compatible entry is generally used to test for machine
type, so I think that needs to remain, and I will use 
compatible = "sony,ps3".


>> +	/*
>> +	 * Need to keep linux,platform for a while, not used by kernel.
>> +	 */
> 
> Why that?


Newer dtc seems to be OK with this removed, old ones exited with error.


>> +	 * Seems the only way currently to indicate a processor has multiple
>> +	 * threads is with an ibm,ppc-interrupt-server#s entry.
> 
> Yes, a better way should be defined.  Any suggestions?


No, there was some discussion to fix it, but no action.

 
>> +		CBE,PPE {
> 
> PowerPC,CBE@0 or cpu@0 -- the important thing is you need
> the @0 unit address.
 

OK, I set it up as cpu@0, since the actual type seems to be probed for.


>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			ibm,ppc-interrupt-server#s = <0 1>;
>> +			clock-frequency = <0>;
>> +			timebase-frequency = <0>;
>> +			i-cache-size = <8000>;
>> +			d-cache-size = <8000>;
> 
> I thought DL1 was 64kB, I might be wrong though?

The BE handbook says 32.

-Geoff

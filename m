Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF477DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:39:56 +1000 (EST)
Message-ID: <464C9EFB.8090403@freescale.com>
Date: Thu, 17 May 2007 13:29:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
In-Reply-To: <5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 17, 2007, at 11:47 AM, Scott Wood wrote:
>> But we do handle i2c *controllers* in the device tree, and that's  
>> where a bus number property would go.  Given that we don't have a  
>> binding for non-toplevel i2c buses, and I'm not adding one, I don't  
>> see the relevance.  Note that adding a bus number property makes  zero 
>> sense for toplevel buses, as at that level the bus number is  just a 
>> fiction maintained by Linux for user API and device  preregistration 
>> purposes.
> 
> The only support we have for i2c controllers is to support one  specific 
> i2c controller from Freescale.

That's not what booting-without-of.txt says.

> If you aren't going to provide a complete solution why are you  prosing 
> one?

Because if we can't do everything that anyone could ever need, we 
shouldn't do anything?  There's nothing in what I proposed that prevents 
i2c muxes; it just doesn't explicitly specify what extra things would 
need to be specified.

 >> I'm tired of this put stuff in the device tree but only  as much
> as I need to do my particular thing.

I'm tired of unconstructive whining that something that accomplishes 
something useful doesn't do everything you want it to.  If you want a 
device tree binding for i2c muxes, write one.  If you think it's 
pointless, then stop complaining about bindings that *are* useful.

 > The device tree is just  as
> important an interface point as the kernel/user space interfaces  and we 
> should treat it as such.

I agree.  And you will note that the entire set of kernel/user 
interfaces didn't spring into existence in one instant.  In both cases, 
adding is much easier than changing, and only additions would be needed 
to support i2c muxes.

> If people aren't willing to work to  a 
> complete solution than they should stop proposing changes.

By that token, if you're not willing to work toward any solution 
(complete or otherwise), you should stop proposing changes (or the 
absence thereof).  If there's a specific change that you would like to 
suggest that you believe would improve the binding, then please say what 
it is.

>> It's not a matter of the binding only covering some cases; it's a  
>> matter of the binding being for one thing (i2c devices) and not  
>> another (multiplexed i2c buses).
> 
> 
> But once you introduce the concept of i2c devices you introduce the  
> possibility of hierarchies.  For example, tell me how I'd describe  the 
> following device http://www.nxp.com/pip/PCA9548ABS.html and any  i2c 
> devices connected to it?

i2c-switch@70 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "pca9548a";
	reg = <70>;

	i2c@0 {
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <0>;
		
		rtc@68 {
			device_type = "rtc";
			compatible = "ds1374";
			reg = <68>;
		};
	};

	i2c@1 {
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <1>;
	
		// more devices here
	};

	// i2c@2-i2c@7 here
};

>>> If only some subset of cases are handled what good is the device  
>>> tree  to a user?  They will just have to figure out if their usage  
>>> is  supported or not and if not find some other solution that  works 
>>> for  them.
>>
>>
>> ...just as they'll have to figure out if a binding exists for  device 
>> type $FOO.
> 
> 
> True, but if I go look at the PCI OF spec I have some faith that its  
> complete and will cover my needs.

So what does the PCI OF spec have to say about devices on i2c 
controllers on PCI cards?

> As I've been thinking about this I think trying to even describe i2c  
> devices in the device tree is point less.

Well then device trees aren't a complete solution to the problem, so 
let's just ditch the concept entirely!  That's the way you want to do 
things, right?

 > Since I2C devices have no
> way of uniquely identifying themselves we are looking at taking on  the 
> role of device name registrar 

How's that different from any other random chip or logic block that gets 
  hooked up through something that isn't i2c?

> and if someone is willing to do  that 
> great, but I doubt anyone truly is.

Perhaps something could be done through Power.org?

-Scott

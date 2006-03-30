Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 694BD679F4
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 22:57:06 +1100 (EST)
Date: Thu, 30 Mar 2006 14:26:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Message-ID: <20060330142626.1a9d22f5@vitb.ru.mvista.com>
In-Reply-To: <bed6c40abe7664da7506270a46611d00@embeddededge.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Mar 2006 00:05:38 -0500
Dan Malek <dan@embeddededge.com> wrote:

> 
> On Mar 28, 2006, at 11:14 AM, Vitaly Bordug wrote:
> 
> > Updated the documentation to include the initial description of the 
> > CPM2
> > device that are used on PQII and PQIII families.
> 
> I haven't followed the device tree development in detail, but when
> looking at this the only question that comes to mind is wondering
> what this really does to help me.  None of the information provided
> here is variable nor configurable .... except I guess for the internal
> register base address (IMMR), which for some reason has turned
> into a variable which hasn't changed since I did the first kernel port.
> About the only thing that is variable, which is the two different bank
> addresses of the CPM memory that affects the configuration of
> the FCCs in Ethernet mode, isn't reflected here in any way.

Why do you think/guess the values below _should_ be variable? Well they could, but the target is to have the auto-config only in places it makes sense. (I currently see only PCI stuff in this relation). The dts will be compiled together with the firmware, and provide the correct information to the kernel. The dts is a board-specific thing, it is intended to present all the necessary devices to live happily without all the immr structure. In other words, what it should present, is the same logical construction uniting all the legacy (CPM on 8xx), up-to-date (CPM2 on PQ2 and PQ3) and future (QuiccEngine on 8360) boards in an easy to maintain and extensible  way.

I'll elaborate of course if needed - note I am not the theoretical fanatic of this idea, but it 
-	makes sense, 
- 	the new way, all that will not follow it will be obsoleted sooner or later


> 
> > +		brg@119f0 {
> > +			device_type = "brg";
> > +			model = "BRG1";
> > +			reg = <119f0>;
> > +			linux,phandle = <775>;
> > +		};
> 
> Why?  We already know it's at this address offset.
Hmm? The same offset for 8xx, 82xx PQII and new QE? don't think so...
> 
> > +
> > +		cpmux@11b04 {
> > +			device_type = "cpmux";
> > +			compatible = "fcc";
> > +			reg = <11b04>;
> > +		};
> > +
> > +		cpmux@11b08 {
> > +			device_type = "cpmux";
> > +			compatible = "scc";
> > +			reg = <11b08>;
> > +		};
> 
> I don't understand the value of these either.

As far as I got the idea, on startup I'll have _only_ devicetree, in order to configure the stuff, and insert the devices properly. Hereby, I need the offsets to configure things. And I don't really want to hide those into *.h - or we'll return to #ifdef hell there. These offsets are *not* constant if we look over different PQ generations. 

> 
> > +
> > +		scc@11a20 {
> > +			device_type = "serial";
> > +			compatible = "cpm_uart";
> > +			model = "SCC1";
> > +			reg = <11a20 100>;
> > +			reg_pram = <8000 ff>;
> > +			clock_setup = <0x00ffffff 0>;
> > +			interrupts = <28 3>;
> 
> None of this is variable.  If you know you are using scc1,
> you must use certain configuration bits in the cmxscr (the
> thing you are calling cpmux).  Why would you want to make
> this variable and prone to error?  The driver knows, and
> there are no options.  Same for the interrupts that are used.
> 

Just compared in CPM, CPM2 and QE reference manuals - found no equal values. The aim is to move all that specific offsets over to BSP land in devicetree source. The logic is common, but the numbers/offsets are different, and features as well, for instance, QE UCC is much more flexible than SCC/FCC, differing technically but is really common logically.

> > +		fcc@11300 {
> > +			device_type = "network";
> > +			compatible = "fs_enet";
> > +			model = "FCC1";
> > +			reg = <11300 1f>;
> > +			reg_pram = <8400 ff>;
> > +			address = [00 00 00 00 00 00];
> 
> I'm assuming this is the MAC address, and is probably
> the only thing I see of value here.
> 
> >     More devices will be defined as this spec matures.
> 
> I just don't understand the value of this.  Will you explain
> it for me?
> 
I am not a good "explainer", but AFAIR, the powerpc land is generic-code-prone. All the bsp stuff should be either dealt in the firmware, of passed as a flattened devtree and unpacked/used in one function. 

Even conflicting IOPs in 8xx I am going to be configured completely within u-boot, using env or something like that. I know, the kernel should be able to deal with tuning like the upper dependless of the firmware, but there are no much such designs remaining (that are targeting to the new-generation kernel),
and all of them (I know about) are using u-boot.
 
> Thanks.
>
Thanks for attention to this :) 
> 
> 	-- Dan
> 
> 


-- 
Sincerely, 
Vitaly

Return-Path: <j.anaszewski81@gmail.com>
Received: from mail-wg0-x22a.google.com (mail-wg0-x22a.google.com
 [IPv6:2a00:1450:400c:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7D621A0D82
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 20:16:03 +1000 (AEST)
Received: by wgso17 with SMTP id o17so45611363wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 03:16:00 -0700 (PDT)
Date: Fri, 24 Apr 2015 12:15:49 +0200
From: Jacek Anaszewski <j.anaszewski81@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
Message-ID: <20150424121549.27b74b25@ja.home>
In-Reply-To: <5539D501.3040601@linux.vnet.ibm.com>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com>
 <20150423161342.55e9ac8f@ja.home>
 <5539D501.3040601@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Apr 2015 11:00:41 +0530
Hi Vasant,

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:

> On 04/23/2015 07:43 PM, Jacek Anaszewski wrote:
> > On Thu, 23 Apr 2015 10:55:40 +0530
> > Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> > 
> 
> Hi Jacek,
> 
> .../...
> 
> >>
> >> These device tree comes from out firmware ... which is immutable .
> > 
> > How the firmware is related to kernel? These bindings are for
> > kernel, not for the firmware.
> > 
> > DT bindings are compiled to *.dtb file which is concatenated with
> > zImage. During system boot device drivers are matched with DT
> > bindings through 'compatible' property. A driver should have single
> > matching DT node, i.e. no other driver can probe with the same DT
> > node. This implies that the node should contain only the properties
> > required for configuring the related device.
> > 
> 
> As Stewart mentioned, its not .dtb file in our case.. we pass
> flattened device tree .. which is built by OPAL.

No matter what format of device tree OPAL produces, I assume that
it must compile it from some sources.

dtb file is a compiled form of human readable dts file containing
Flattened Device Tree - a data structure for describing the hardware
in the system.

Please refer to: http://elinux.org/Device_Tree

> >> We can use LED node name + led-type property for naming...which is
> >> what I do currently (v4.. which I haven't posted)
> >>
> >>
> >>> 1. Each LED would have one corresponding LED class device.
> >>>
> >>> 2. Operations on attn and fault LED types:
> >>> 	turn on:
> >>> 		echo 255 > brightness
> >>> 	turn off:
> >>> 		echo 0 > brightness
> >>> 	get status
> >>> 		cat brightness
> >>> 	
> >>> 3. Operations on identify LED:
> >>> 	turn on:
> >>> 		echo "timer" > trigger
> >>> 		(blink_set op would have to be implemented in the
> >>> 		driver)
> >>> 	turn off:
> >>> 		echo 0 > brightness
> >>> 	get status:
> >>> 		support for this would have to be added to the LED
> >>> 		subsystem core
> >>
> >> I see few issues here.
> >>   - Overloading same LED device with multiple opeartion complicates
> >> things .. as these operations can be done independently (say user
> >> is allowed to enable both identify and fault simultaneously)
> > 
> > I agree, it would be hard to distinguish whether by executing
> > `echo 0 > brightness` we want to turn off identify or fault
> > function.
> > 
> >>   - point 3: IIUC after duration value expires identify indicator
> >> reverts.. we don't want to revert until user asks .
> > 
> > From what you shared, blinking has hardware acceleration on OPAL
> > side. At first timer trigger tries to use HW accelerated blinking by
> > calling blink_set op and resorts to using software fallback only if
> > the op fails or is not defined.
> 
> Blinking is the physical state of LED to represent "identify" state.
> which is taken care by hardware. and OS doesn't have control on
> this ..

I am aware of it. Therefore we would probably need to add a flag
LED_BLINK_HW_ONLY to the LED subsystem core and modify led_blink_set
function to log an error and avoid setting software fallback in
case blink_set op fails and the flag is set.

Nevertheless, I am leaning towards using brightness_set op for this.

> From software point of view its just another LED with two state (ON
> and OFF).
>
> > 
> > BTW timer trigger re-sets blink after timer expires, unless
> > LED_BLINK_ONESHOT flag is set by LED class device.
> 
> In my case, I want to retain the state.'
>
> > 
> >>   - point 3: if I use brightness for both identify/fault, how to
> >> disable these LEDs independently?
> > 
> > Another sysfs attribute would be required, but it would be ugly.
> 
> yeah.
> 
> 
> >>   - Also how to use trigger property for each LED (if at all we
> >> want to use them later)?
> >>
> > 
> > After analyzing pros and cons I think that separate LED class
> > devices for each LED type would be most suitable solution in this
> > case.
> 
> Agree.
> 
> > 
> > For 'identify' LED the operation would be:
> > 
> > #echo "timer" > trigger		//set 'identify' (blinking)
> > #cat trigger			//check "identify" state
> > #none [timer]			//'identify' is ON
> > #echo 0 > brightness		//unset 'identify
> > #cat trigger
> > #[none] timer			//'identify' is OFF
> > 
> > You would have to implement blink_set op
> > (see Documentation/leds/leds-class.txt and other LED class drivers
> > for reference).
> 
> Implementing another op should be fine.. I can try to implement it.
> 
> But from user perspective identify is just another LED. Hence can we
> just use "brightness" property itself?

OK, let's use only brightness. Usage of blinking API would impose
turning on led-triggers, which would be used only for exposing trigger
sysfs attribute. Triggers however would not be used, as the intention
is using only HW accelerated blinking.

Please add comment to the driver, describing the reasons for abusing API
semantics.
 
> 
> > 
> > For attention and fault LEDs only brightness attribute would matter.
> > 
> 
> Sure.
> 
> > DT bindings would look as follows:
> > 
> > opal-leds {
> >         compatible = "ibm,opal-leds";
> > 
> >         U78C9.001.RST0027-P1-C1:fault {
> >         };
> > 
> >         U78C9.001.RST0027-P1-C1:indent {
> >         };
> > 
> >         U78C9.001.RST0027-P2-C1:attn
> >         };
> >     }
> > }
> > 
> 
> As mentioned earlier DT is coming from our firmware. For now I will
> respin another round of patches by using led-types property and run
> it through DT experts (DT mailing list). If they insist this method
> is better than what I already have , then will work with my firmware
> folks to see what we can do better.

Please hold on with sending the patches until we clarify all the
DT related issues. Having full picture will help to adjust the
bindings better to LED common bindings specification.

-- 
Best Regards,
Jacek Anaszewski

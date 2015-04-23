Return-Path: <j.anaszewski81@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9163D1A0C91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 00:13:56 +1000 (AEST)
Received: by wgyo15 with SMTP id o15so19818098wgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 07:13:52 -0700 (PDT)
Date: Thu, 23 Apr 2015 16:13:42 +0200
From: Jacek Anaszewski <j.anaszewski81@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
Message-ID: <20150423161342.55e9ac8f@ja.home>
In-Reply-To: <55388254.4000606@linux.vnet.ibm.com>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com>
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

On Thu, 23 Apr 2015 10:55:40 +0530
Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:

> On 04/23/2015 03:15 AM, Jacek Anaszewski wrote:
> > Hi Vasant,
> >=20
>=20
> Hi Jacek,
>=20
>=20
> .../...
>=20
> >>
> >>>
> >>>  From what I can see from the driver code the LEDs are set with:
> >>>
> >>> opal_leds_set_ind(token, loc_code, led_mask, led_value,
> >>> &max_led_type);
> >>>
> >>> and their state can be read with:
> >>>
> >>> opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type)
> >>>
> >>>  From the kernel point of view these are very simple operations.
> >>>
> >>> All the logic you described should be handled by user space.
> >>> If you need to be able to specify the LED mode you want to
> >>> set/read, then additional 'mode' sysfs attribute should be added
> >>> by the driver. There would have to be also additional sysfs
> >>> attribute 'available_modes" provided. The ABI documentation
> >>> should inform how the mode identifiers map to the modes. I
> >>> already explained how to add it, when we were discussing about
> >>> retaining led state on remove.
> >>
> >> Sorry..My fault.. I should have elaborated mode operation...
> >=20
> > What I was thinking about here was actually LED type, not mode in
> > terms of Guiding Light/Light Path. However, please look at the
> > newest approach in the end of this message.
> >=20
>=20
> No problem.
>=20
> >> I forgot to mention that LED mode is static... meaning platform
> >> provides this information, but we cannot change during runtime..
> >>
> >> Presently we have this information in Device Tree. Since this is
> >> static one (and also LED Mode is system wide.. nothing to do
> >> individual LED),  I didn't add it in LED driver code.. .Do you
> >> think we should add that property ?
> >=20
> > The property shouldn't be documented at all if it isn't to be used.
>=20
> Ok . I will remove this.
>=20
> >=20
> >>>
> >>>
> >>> I'd see following use cases.
> >>>
> >>> (let's assume that modes are defined as follows:
> >>> 0: ident, 1: attn, 2: fault)
> >>
> >> Modes are : Guiding Light / Light Path ... which is static and
> >> platform provides this information.
> >>
> >> LED types : IDENT, FAULT and ATTN .... which can be get/set/reset
> >> by OS (kernel/userspace)
> >>
> >> Also only 1 LED can be ATTN ...
> >>
> >>> #cat available_modes
> >>> #0 1 2
> >>> #echo 0 > mode  //set ident mode
> >>> #echo 1 > brightness //set ident state
> >>> #echo 2 > mode  //set fault mode
> >>> #cat brightness //read fault state
> >>> #0
> >>> #echo 1 > attn //set attn mode
> >>> #echo 1 > brightness
> >>>
> >>> This would set the LED in blinking mode, so I am wondering if we
> >>> shouldn't employ timer trigger for this to keep the LED API
> >>> consistent.
> >>>
> >>> Can a single LED support other mode than 'attention'? I'd like to
> >>> know if a LED in attention mode (blinking), can be set to some
> >>> solid mode?
> >>
> >> No.. Its always single attention LED/system ... which can be Set
> >> (Solid) / reset state.
> >=20
> > I confused it with ident.
>=20
> No problem. We have many hardware specific jargon's which is enough
> to confuse anyone :-)
>=20
> >=20
> >>>
> >>> Please let me know if such an approach would still not fit for
> >>> your requirements.
> >>>
> >>
> >> Given above conditions, I think current approach (my v3 patchset)
> >> is simple and works better. What you say?
> >=20
> > Yes, but we still have naming and blinking issues to solve.
> >=20
> > Please look at this draft design of device tree node:
> >=20
> > opal-leds {
> >         compatible =3D "ibm,opal-v3-led";
> >=20
> >         U78C9.001.RST0027-P1-C1:attn {
> >         };
> >=20
> >         U78C9.001.RST0027-P2-C1:identify:fault=20
> >         };
> >=20
> >         U78C9.001.RST0027-P3-C2:identify:fault {
> >         };
> >     };
> > };
> >=20
> > The LED nodes could be empty as the name would convey all the
> > required information. The implications would be as follows:
> >=20
>=20
> These device tree comes from out firmware ... which is immutable .

How the firmware is related to kernel? These bindings are for kernel,
not for the firmware.

DT bindings are compiled to *.dtb file which is concatenated with
zImage. During system boot device drivers are matched with DT bindings
through 'compatible' property. A driver should have single matching DT
node, i.e. no other driver can probe with the same DT node.
This implies that the node should contain only the properties required
for configuring the related device.

> We can use LED node name + led-type property for naming...which is
> what I do currently (v4.. which I haven't posted)
>
>=20
> > 1. Each LED would have one corresponding LED class device.
> >=20
> > 2. Operations on attn and fault LED types:
> > 	turn on:
> > 		echo 255 > brightness
> > 	turn off:
> > 		echo 0 > brightness
> > 	get status
> > 		cat brightness
> > =09
> > 3. Operations on identify LED:
> > 	turn on:
> > 		echo "timer" > trigger
> > 		(blink_set op would have to be implemented in the
> > 		driver)
> > 	turn off:
> > 		echo 0 > brightness
> > 	get status:
> > 		support for this would have to be added to the LED
> > 		subsystem core
>=20
> I see few issues here.
>   - Overloading same LED device with multiple opeartion complicates
> things .. as these operations can be done independently (say user is
> allowed to enable both identify and fault simultaneously)

I agree, it would be hard to distinguish whether by executing
`echo 0 > brightness` we want to turn off identify or fault function.

>   - point 3: IIUC after duration value expires identify indicator
> reverts.. we don't want to revert until user asks .

=46rom what you shared, blinking has hardware acceleration on OPAL side.
At first timer trigger tries to use HW accelerated blinking by
calling blink_set op and resorts to using software fallback only if
the op fails or is not defined.

BTW timer trigger re-sets blink after timer expires, unless
LED_BLINK_ONESHOT flag is set by LED class device.

>   - point 3: if I use brightness for both identify/fault, how to
> disable these LEDs independently?

Another sysfs attribute would be required, but it would be ugly.

>   - Also how to use trigger property for each LED (if at all we want
> to use them later)?
>

After analyzing pros and cons I think that separate LED class devices
for each LED type would be most suitable solution in this case.

For 'identify' LED the operation would be:

#echo "timer" > trigger		//set 'identify' (blinking)
#cat trigger			//check "identify" state
#none [timer]			//'identify' is ON
#echo 0 > brightness		//unset 'identify
#cat trigger
#[none] timer			//'identify' is OFF

You would have to implement blink_set op
(see Documentation/leds/leds-class.txt and other LED class drivers for
reference).

For attention and fault LEDs only brightness attribute would matter.

DT bindings would look as follows:

opal-leds {
        compatible =3D "ibm,opal-leds";

        U78C9.001.RST0027-P1-C1:fault {
        };

        U78C9.001.RST0027-P1-C1:indent {
        };

        U78C9.001.RST0027-P2-C1:attn
        };
    }
}


--=20
Best Regards,
Jacek Anaszewski

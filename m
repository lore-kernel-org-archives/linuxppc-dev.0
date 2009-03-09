Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc3-s12.bay0.hotmail.com (bay0-omc3-s12.bay0.hotmail.com
	[65.54.246.212]) by ozlabs.org (Postfix) with ESMTP id 524B1DE034
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 21:01:30 +1100 (EST)
Message-ID: <BAY101-W1380284517DD6CE929E7DDBEA00@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/usb: Fix 440EPx USBH_3 & USBH_5 EHCI errata
Date: Mon, 9 Mar 2009 10:01:29 +0000
In-Reply-To: <1236463245.7260.170.camel@pasglop>
References: <BAY101-W12966ECAF38C4FD6F26513BEA50@phx.gbl>
	<1236463245.7260.170.camel@pasglop>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Please provide a valid email address here.

New email client helpfully stripped out the address...

>> called in a context where you can't iomap ? (ie with a spinlock held).

That is indeed the case. Keeping ehci generic is a valid point=2C but becau=
se of the above I don't think adding a "hook" is going to work. I'll take a=
 look at the *platform_private option and re-post - this would also allow f=
or better runtime checking=2C as you suggested.

 Cheers
  Jan




----------------------------------
> On Fri=2C 2009-03-06 at 11:30 +0000=2C - Reyneke wrote:
>> Patch applies to 440EPx devices in USB EHCI host mode (USB 2.0).
>>
>>>From the 440EPx errata:
>>
>> USBH_3: Host hangs after underrun or overrun occurs
>> USBH_5: EHCI0_INSNREGxx registers are reset by a Soft or Light Host Cont=
roller Reset
>>
>> Workround for USBH_3 is to enable Break Memory Transfer (BMT) in INSNREG=
3. But the controller is reset after this fix is applied=2C and thus the cu=
rrent workround is lost. The following short patch ensures INSNREG3 is corr=
ectly set after reset.
>
>> Signed-off-by: Jan Reyneke
>
> Please provide a valid email address here.
>
>> ---

>
> A few issues here. First=2C it would be preferable to have this in the
> ehci-ppc-of.c file. If you can't stick that in such a place that it will
> be called after ehci_reset=2C then maybe you can add a reset "hook" so
> that ehci-ppc-of.c gets to wrap the real ehci_reset().
>
> Also=2C while the ifdef CONFIG_440EPX is good to prevent building the cod=
e
> on machines that don't need it=2C it's also not enough. We allow building
> kernels that support multiple boards and SoC's within the same major CPU
> family and thus you -also- need runtime detection. Either using a quirk
> (I think the USB drivers have quirk flags) or just always doing the
> of_device_is_compatible() thingy which is yet another reason for finding
> a way to move that up into ehci-ppc-of.c
>
> That would also avoid some duplication...
>

>
> So if you manage to move the quirk here=2C you can thus re-use the
> existing code=2C or is the reset always called in a context where you
> can't iomap ? (ie with a spinlock held).
>
> In any case=2C I don't like adding a specific field to the generic ehci
> structure like that. If that's what it takes=2C add a void
> *platform_private to it=2C and use -that- to stick a host specific data
> structure=2C but for something not performance sensitive such as a reset=
=2C
> if you can get away with always mapping/unmapping=2C it's probably better=
.
>
> Cheers=2C
> Ben.
>
>

_________________________________________________________________
View your Twitter and Flickr updates from one place =96 Learn more!
http://clk.atdmt.com/UKM/go/137984870/direct/01/=

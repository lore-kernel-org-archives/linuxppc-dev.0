Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 75306DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 14:47:44 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1190763anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 21:47:43 -0700 (PDT)
Message-ID: <fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
Date: Sun, 27 Apr 2008 22:47:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080427222514.1086f2d3@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
	<20080427222514.1086f2d3@lappy.seanm.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 27, 2008 at 8:25 PM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> On Sun, 27 Apr 2008 19:51:57 -0600
>  "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>  > Actually, it looks like he's trying to find the second gpio node in
>  > the tree.
>
>  Correct.
>
>
>  > Sean, if that is true, then this is a very fragile way to do it.
>  > Really, you should have a phandle somewhere that points to the GPIO
>  > node that your LEDs are attached to.  Others have been addressing the
>  > same problem and the consensus seems to be to add a 'leds' node for
>  > each of your leds with a phandle and gpio descriptor to the gpio node.
>  >
>  > See the documentation added by this patch (section 't'):
>  > http://patchwork.ozlabs.org/linuxppc/patch?id=18156
>
>  I saw that earlier. I thought that that method relied on the gpio_led
>  driver? I want to use the gpio_led driver, but I believe the underlying
>  gpio code for the 440EP is not done yet.

Something very important to remember:  The device tree is simply a
description of the hardware.  Its layout *must* *not* be driven by
device driver design.  Driver design can and will change over time;
hardware description conventions should be relatively stable.

If your LEDs are attached to gpio pins, then you should use the
current draft led->gpio bindings as shown in the above patch.  Then,
let your platform code extract whatever data it needs from the device
tree to set up the LEDs.

It is irrelevant that the 44EP GPIO driver doesn't support that
binding.  Just make sure that the warp platform code doesn't register
warp's linux,gpio-led device tree nodes onto the of_platform bus.
That way your platform code can do whatever it wants to handle the
LEDs itself.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <jonsmirl@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by ozlabs.org (Postfix) with ESMTP id 03D68DDF24
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 00:21:25 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so3304606wra.1
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 07:21:24 -0700 (PDT)
Message-ID: <9e4733910807270721h5777bb80u9f3d25413a62883c@mail.gmail.com>
Date: Sun, 27 Jul 2008 10:21:24 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
In-Reply-To: <fa686aa40807262235l47bff0bfi15d86a6e171d6775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<20080727001119.GB12191@secretlab.ca>
	<9e4733910807262205l2db8d662u9dd2e517282686f8@mail.gmail.com>
	<fa686aa40807262235l47bff0bfi15d86a6e171d6775@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/27/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun, Jul 27, 2008 at 1:05 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 7/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> On Mon, Jul 14, 2008 at 09:54:37PM +0400, Anton Vorontsov wrote:
>  >>  > Currently of_i2c will select first compatible property as a last resort
>  >>  > option. This isn't best choice though, because generic compatible entries
>  >>  > are listed last, not first. For example, two compatible entries given for
>  >>  > the MCU node:
>  >>  >
>  >>  > "fsl,mc9s08qg8-mpc837xrdb", "fsl,mcu-mpc8349emitx";
>  >>  >
>  >>  > Since no sane driver will ever match specific devices, what we want is
>  >>  > to select most generic option (last). Then driver may call
>  >>  > of_device_is_compatible() if it is really interested in details.
>  >>
>  >>
>  >> I highly suspect that this will actually be a rare condition and that
>  >>  most of the time the driver you want will bind against the first entry
>  >>  in the list (I'm basing this on what discussion I've seen on the list
>  >>  and it seems to me that Jiri does want i2c devices to list the exact set
>  >>  of chips that each driver binds against).
>  >
>  > Can we put a loop on request_module() and have it try each one down
>  > the list until something matches? request_module() returns errors, but
>  > I can't tell from the source if one of those errors is "no matching
>  > module found" since it invokes a user space helper.
>
>
> What will request_module() do if the modules is compiled in
>  statically?  If it is workable then I'm not opposed to this approach.

I'm no expert on request_module, from the comments:

It appears to be synchronous with user space...
	call_usermodehelper wait flag, and remove exec_usermodehelper.
	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003

 * Load a module using the user mode module loader. The function returns
 * zero on success or a negative errno code on failure. Note that a
 * successful module load does not mean the module did not then unload
 * and exit on an error of its own. Callers must check that the service
 * they requested is now available not blindly invoke it.

Is this really a problem? If the specific driver gets loaded and then
errors out, then something must be wrong. The appropriate action
probably should not be to load the next driver on the list.

It looks like it should work. Compiled in moduled and modules that are
already loaded are essentially the same so they should return 0 from
request module.

>
>
>  > That would work for this compatible string:
>  > compatible = "atmel,24c32wp", "24c32", "eeprom";
>  >
>  > request_module will always fail for the first entry. If you have at24
>  > in your system the second one will succeed. If you have eeprom the
>  > third one works. All of those names are valid in a device tree.
>
>
> I know this is just an example; but to keep thinks clear, the second
>  and third values in this compatible property are completely bogus (for
>  device trees).  The manufacturer prefix needs to be present and
>  'eeprom' is far to vague.

Isn't 24c32 a generic, cross manufacturer term used for these devices?
What if I have a socket and use a different vendor's chip each week?

eeprom is the vague Linuxism that at24 is attempting to correct.
eeprom just goes and searches for anything resembling an eeprom. It
will trigger on chips that aren't eeproms.

>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com

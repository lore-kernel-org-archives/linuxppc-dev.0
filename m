Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FD28DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 10:07:15 +1100 (EST)
Message-ID: <45A17D1A.4050201@genesi-usa.com>
Date: Sun, 07 Jan 2007 23:07:06 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	<45A1535C.1080007@genesi-usa.com>	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
	<45A16FF1.5000401@genesi-usa.com> <45A175B3.4010506@246tNt.com>
In-Reply-To: <45A175B3.4010506@246tNt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: bbrv@genesi-usa.com, Linux PPC DEV <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sylvain Munaut wrote:
> 
> You're proposing (if I understood correctly), that we first match the device
> to a driver by using the normal name/type/compatible list but with very
> broad names like "fsl-ethernet", then look at the SVR to know if it's in
> fact this driver we need to load (two fsl chip could have completly different
> ethernet cores) and also using SVR decide what "quirk" we need to apply.

Yes, to a degree. I understand that between MPC5200 and MPC5200B some things
did change quite a lot; register places, definitions and so on, even whole
ways of supporting a device. I think making a name distinction here and trying
to tie it down to some "model number convention" really loses it's shine.

Like Ben said, it's clumsy. Not wrong, but clumsy. I would say the same about
the difference between "ac97" and "sound" - it IS a clumsy naming convention
and it was contended here, but who really cares as long as the device is detected?
Personally I think "sound" is wrong, and ac97 more accurately defines the
device (I forget who's side I am on now with that!) according to the OF
precedents.

For a PCI device, you do have unique idenitifiers and they are also all present
in the device tree for easy scanning (RTAS also provides this) and picking up.
Linux is already full of lists of arrays of data in order to attach a device
driver to a certain device ID - even with names and compatible nodes, the ethernet
and audio and so on drivers for the Efika and Lite5200 have potentially large
lists of properties they must check for to determine if the device is correct
(one each for mpc5200, mpc5200b, mpc52xx, any compatible future chips will have
to list every one of these in their compatible property to 'be correct'..)

So, giving it some other name is no problem at all. Just add the name into the
list. You can never get rid of the list, and adding entries.. well.. it may
look clumsy, but it is not wrong! Especially if you're the first to name it.
Linux should, I am saying, match against what the firmware provides, not
vice-versa. I don't think it's logical for firmware vendors to keep changing
names or maintain these huge lists... just because of a philosophical difference
on 2 lines of code in Linux? Especially when the other OS guys have not made
any fuss..

> Note I'm not even commenting yet, I first need to be sure of what you're
> saying, but the SVR thing will already not work if you're not in a SoC context ...

Yes, I do think that there needs to be a lot less chip naming in there, and some
other way of identifying chipset features. I agree with Ben there is some issue
when SoC components drop out into other chips, but this fully melds in with my own
and bplan's insistance that the "SoC" node idea sucks.

The firmware device tree describes a platform, be that a single board of multiple
revisions, or even a range of boards. To place all SoC devices in the
root node, we considered clumsy at bplan, so they invented "builtin" instead. This
works also for the Pegasos, where rightly there is no SoC. It works for every
other board we ported the firmware too under contract to do so (every G4 Freescale
board since the 7447, every Marvell dev board, the AMCC "Yosemite"..). It really
doesn't matter where you place it, or what you call it in the end, as long as
somehow you can determine what kind of device you are looking for.

device_type = "ethernet", well, then it's ethernet. Which kind? Well, it's the
kind that can only be available on that particular combination of hardware. If
it is an MPC5200B chip or an MPC5200 chip, you can determine exactly which one
it is. If it is an MPC8349E or an MPC82xx or something, it may be different,
but in general you can determine the exact device you have much easier (one
register comparison..) than running through a null-terminated string list,
doing comparisons against another list, and you get a wealth of information
out of that single 32-bit register value of the SVR that you would not from
a simple name. This is where it differs from PCI devices which you can have
10 of them in the same box and need to work out which one came from where, and
what esoteric combination the user will use. The device tree is simply there
to inform you what is present and what is configured (especially in the case
when a unit can be configured as multiple devices and may be dangerous to
reconfigure) and on an SoC or even a northbridge or southbridge which
implements "non PCI" devices, you have plenty of options for determining
exactly what is in them (/builtin/ethernet@1 on Pegasos is the Marvell
controller, even though we use a chip with 2 ethernet controllers in it,
only one works - there is no PHY card for the other. However rather
scarily the option of 1 or 2 ethernet ports in Linux is defined by a
kernel config flag... so much for the device tree..)

I am sure there are other things that can be checked and verified against, although
there will also be stupid things like.. the only example I can think of is that
the MPC7447 and MPC7457 G4 chips have identical PVRs so you can't tell if there
are L3 tags or not (or if there is any L3 at the end of it) without some loopy
proprietary hardware logic or other system controller feature to inform you. That's
not much fun if your CPU board is removable for example :D

Giving it an esoteric device name string, and listing all it's compatible
hardware in the firmware tree? Considering Linux maintains it's own little
list it checks AGAINST, I see no reason to even name it. It just seems
like a waste of time and space where some other heuristic would be a little
more specific or more foolproof. If the same driver supports multiple devices,
it will check the device to see if it fits with it's list of devices it
supports. Like a PCI device driver has a list of compatible vendor/device/function/id
inside it. Not just for quirks but just for detection. The compatible property
I think is just being misused in the device tree and it's creating more code
and more lists and more firmware work to support it.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations



> 
> 
> Regards,
> 
>     Sylvain
> 
> 
> Matt Sealey wrote:
>> Why is it so funny? I'd love to be enlightened rather than just plain
>> insulted about it.
>>
>> I don't think any of that can be taken into account by simply giving things
>> *names* and then having a 3-week discussion and committee hearing about how
>> someone gave it a DIFFERENT name. It is even more strange to me, that nobody
>> HAS a standard name for the devices on the MPC5200B, yet we are arguing
>> about what would look nicer in the Linux source code?
>>
>> Small example:
>>
>> mpc5200b-fec, mpc5200-fec, mpc52xx-fec doesn't tell you anything, and
>> then with the 5500 or 5120 or something, you then have worked out you
>> named your original devices wrong, and now need to make it compatible
>> with those? Do you switch features on and off based on a string comparison?
>> What if a certain chip revision has a bug you need to work around (there
>> are plenty in the original MPC5200!), is that meant to be encoded in the
>> "compatible" property too, somehow? Or would you check the SVR too? If
>> you would check that, why not use this as the basis of the support for
>> that driver? For a PCI device, you are given basically a 32-bit UID for
>> each device, which is attached to a unique domain, host, bus, device
>> and function number. You manage well here without giving it names.
>>
>> An Intel processor might return a string for CPUID - mine says it's a
>> "Intel(R) Pentium(R) M 1.70GHz". That string is absolutely useless in
>> determining it's compatibility. It's just a name. It may as well say
>> "Fight Famine In Rwanda" for all the good it does.
>>
>> I think there are better ways and better places to encode certain
>> properties of the system as a whole (as the system is a lot more than
>> just that single chip) than having a bunch of strings in a property
>> which claim that it is compatible with something else, strictly defined
>> naming conventions and so on across chip ranges. Although we are talking
>> here mostly about two boards with the same chip basically - Lite5200
>> and Efika, there may be more boards with similar hardware supported,
>> extra hardware supported, new chips which look very much like the 5200
>> but have slightly different or bugfixed operation (and here is my point)
>> which I do not think you can encode in names and compatibile names.
>>
>>   
> 

Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id B49E1DE133
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:45:25 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so111739uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:45:11 -0800 (PST)
Message-ID: <4784FADA.9070603@genesi-usa.com>
Date: Wed, 09 Jan 2008 16:48:26 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de>	 <4784E78C.40904@genesi-usa.com>
	<1199893757.2978.73.camel@pmac.infradead.org>
In-Reply-To: <1199893757.2978.73.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Wed, 2008-01-09 at 15:26 +0000, Matt Sealey wrote:
>> If anyone wants to help/assist/suggest any updates to efika.forth,
>> create binary tools which assist the installation of the script for
>> users and for placement on Linux distro CDs etc. I would be very
>> grateful, but it seems we have hit the Wall of Apathy where users
>> complain for a feature but are not willing to work for it.
> 
> We're already shipping efika.forth in Fedora rawhide, and in my updated
> spins of Fedora 8. It's a pain in the arse, but it kind of works.

I already said I don't like that solution either :]

efika.forth may change between Fedora 8 spins and user downloading it,
meaning updated kernels in the repositories stop working or so. This is
what I am hoping to stop happening by having the kernel *really just not
do anything* so it is entirely the fault of efika.forth or firmware
releases not happening, and not a bastardised combination of both.

> It would be much better if the kernel would 'just work'. The ideal way
> of achieving that is for the firmware to be fixed -- but that's been
> promised for a long time now, and we just don't believe you any more. So
> working round it in the kernel seems to be the next best option.

I don't blame you for thinking that; announcing a firmware update was
a rather ill-thought-out decision not made by anyone who works on the
firmware or with firmware issues.

Don't rely on a real flashable firmware update any time soon, but don't
take that as a task to "fix" the Linux kernel instead.

Your firmware update is and will be for the time being, that Forth
script, which is easy enough to paste into a serial console into nvramrc,
or run from GRUB, or run manually and edit the boot line at the bottom..

When a new firmware appears, and for all you and I know this could
happen this afternoon, this patch will become obselete and needs to
be removed - even Grant's version, because there is no guarantee
whatsoever that Nico will call the device /builtin/mdio when the
search for the device in the driver is for a compatible of "ethernet-phy"
for example.

By hard coding these things into Linux you are shaping firmware
development and making it harder. You are fixing things in the
efika.forth script which needn't be fixed - now we will need to
keep the script entirely compatible with that patch, even if it's
wrong. I don't like this situation because it causes me more work.
The guys in Germany don't release new firmwares BECAUSE of the
chop and change of Linux device tree expectations. If we released
a firmware every time you have a new idea on how it should look,
there would be one every month, and no other bugs would have time
to be fixed due to the extensive regression testing firmware has
to go through on multiple current and future board revisions with
multiple current and future kernels.

>> (I am invoking the Open Source Fallacy of that if the source is
>> available you can patch it, I say that patching Linux is not the
>> solution, but patching the firmware is. But nobody is willing to
>> work on patching the firmware and keeping Linux entirely independant
>> of our so-deemed "crappy" firmware)
> 
> /me looks at http://git.infradead.org/?p=openfirmware.git
> /me looks at the Efika...

It would be quicker to update efika.forth with an installer (I already
told you how I would do it.. the whole technical detail!) than to
bring up SmartFirmware again for the Efika.

I really want to shift the burden to Genesi and not onto the Linux
kernel, as involving Linux patches means double the work, which will
delay firmware releases, delay efika.forth updates due to extended
testing with myriad different versions of patches etc.

It is better if the Linux kernel is simply a known quantity, non-working
without external assistance, if that be the case. It is not your fault
if the Linux kernel doesn't work on stock Efikas, it's OURS. However
without significant support behind fixing the firmware (Genesi is working
on it and efika.forth is PART of that - a good testing bed with no
flashing required!) and with patches being continually submitted to the
kernel to work around supposed firmware weaknesses, it is just going to
be too complicated.

After all, if Linux just trashes the firmware, replaces anything it
doesn't deem right, why bother releasing a new firmware ever? The
patch alone states the case that you do not need us to ever fix anything,
I don't think you really mean to go there.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D453B7CED
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 09:47:31 +1100 (EST)
Message-ID: <4BABE7FB.6070006@freescale.com>
Date: Thu, 25 Mar 2010 17:47:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
	<fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
	<4BABBF54.3010104@freescale.com>
	<fa686aa41003251439t23c04581n16d064c27d2516f4@mail.gmail.com>
In-Reply-To: <fa686aa41003251439t23c04581n16d064c27d2516f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mitch Bradley <wmb@firmworks.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Mar 25, 2010 at 1:53 PM, Scott Wood <scottwood@freescale.com> wrote:
>> Grant Likely wrote:
>>> On Thu, Mar 25, 2010 at 11:03 AM, Timur Tabi <timur@freescale.com> wrote:
>>>> Grant Likely wrote:
>>>>> For indirect firmware, create a /chosen/firmware node.  Don't add a
>>>>> compatible property,
>>>> Oh, I don't like that idea at all.  The compatible property is useful for
>>>> me to know *how* to parse the binary blob.
>>> Compatible is for devices.
>> Compatible is for matching.  Who cares what category the thing being matched
>> is in?  What is the definition of a device, and why does it matter?
> 
> Compatible specifies a device and a list of devices it can emulate:
> 
> http://www.openfirmware.org/1275/proposals/Closed/Accepted/343-it.txt

That's in a context that already assumes we're talking about a device.

I don't see the problem with interpreting it more flexibly to refer to 
compatibility with a format or binding.  ePAPR already heads in this 
direction with class compatibles such as "simple-bus", "cache", "pci", 
"iic", etc.

There's also this bit from section 6 of ePAPR: "The compatible property 
of a device node describes the specific binding (or bindings) to which 
the node complies."

>>> This is not a device.  Drivers cannot bind
>>> against it.  Use a different mechanism if you have metadata about the
>>> blob.  If your driver doesn't know how to validate its own firmware
>>> blobs, then you've got bigger problems.
>> One could also say, if your hardware can't be probed at runtime, you've got
>> bigger problems. :-)
>>
>> What's wrong with an indication of what type of "thing" a node is supposed
>> to be?  There could be multiple microcode formats, for example.
>>
>> I don't know that it's strictly necessary in this case --  it looks like
>> there is a magic number in the firmware blob -- but I don't understand the
>> objection as a matter of principle.  These device tree discussions have a
>> tendency to get awfully bikesheddy.
> 
> That's because the pain inflicted in getting it wrong is very high.

There's still a distinction between things which will actually inflict 
pain versus aesthetic considerations.  As far as I can tell, we're now 
talking about the difference between this:

device {
	fsl,firmware-phandle = <&qefw>;
};

qefw: firmware {
	compatible = "fsl,qe-foo-firmware";
	fsl,firmware = <...>;
};

and this:

device {
	fsl,qe-firmware-foo-phandle = "fsl,qe-firmware";
};

chosen {
	firmware {
		fsl,qe-firmware = <...>;
	}
};

The former involves a slightly greater chance that a driver would ignore 
the compatible and do the wrong thing on a system with 
fsl,qe-bar-firmware instead of erroring out gracefully.

The latter means any additional properties that might be needed or 
wanted to describe the firmware would have to go in the device node 
itself rather than on the entity that it describes.

I don't see either issue as being important enough to make a big fuss 
about...

> Consider this: The model being discussed is for U-Boot to load the
> blob into the tree.  Once U-Boot is deployed there is a lot of
> resistance to changing it for a lot of good reasons, even on eval
> boards.

The device firmware is hardly the only aspect of the device tree that 
would be locked down by that.  There are pros and cons of having the 
firmware be heavily involved in the process, and for better or worse 
we've gone pretty far down that road on p4080.  I think the pros 
outweigh the cons.

> Say that firmware node thingy is put under /qe-firmware,
> u-boot uses it, and the system is shipped.  Then say that the node
> format is changed because of a deficiency.  Or say that the node is
> moved (either intentionally, or as part of an unrelated 'cleanup').
> Will any assumptions made by a deployed version of U-Boot cause
> breakage?

I'd just let u-boot create the whole node from scratch.  The analogous 
problem to the soc<chip> issue would be finding the appropriate QE node, 
not anything to do with the firmware node itself.

Note that the system all of this is modeled after had the firmware 
generate the entire tree. :-)

> Case in point: there are a lot of dts files in the tree using
> "soc<chip>" as a node name.  If the name is changed (say to "soc" as
> per generic names) then many systems won't boot because older versions
> of U-Boot are hardcoded to use the soc<chip> name.
> 
> More manipulation performed by U-Boot == more things to go horribly
> horribly wrong.  :-)  We can work around breakage, but it is always
> better when the design means we don't have to.

The "soc<chip>" thing was bad because it made things harder on the 
consumer of the tree -- which happened to include u-boot.  I consider 
this an example, though, of why the trees shouldn't live in the Linux 
tree at all, except for those intended to be linked directly into the 
kernel.  The static dtb (and dts from which it is derived) is just an 
input that is used to create the actual device tree that is the subject 
of these binding documents.

For another example of firmware dependency that has nothing to do with 
it mucking around with the device tree, consider that many of the 
addresses hardcoded in the device tree are at the firmware's discretion.

U-boot in one configuration may put CCSR at 0xfe000000, and in another 
configuration may put it at 0xffe000000.  Another firmware may put it 
somewhere else entirely.  Look at the adder875 board, where we have one 
tree for u-boot and another for redboot, just because of addresses.

We've also had issues on some 83xx boards with PCI ranges not matching 
what u-boot sets up, etc.

> So, I'm not saying don't have properties that say what kind of thing
> it is; but I am saying make it part of the QE binding proper and
> isolate the scope to the binding for that node.  I'm saying be
> defensive in the design and eliminate the complexities from what
> u-boot needs to do.  ie. create a single named property in a well
> defined location that works for any firmware blob.  U-Boot doesn't
> need to care about the format.

U-boot does need to care, since it needs to use the firmware itself (and 
I suppose it gets lost when Linux initializes the hardware).  It would 
also need to care if the format were encoded in the name of the property 
in the QE node that it had to set.

> The fact that the QE node references
> that specific blob should be sufficient to define what format the blob
> needs to be in.

Not if they suddenly decide to start publishing QE firmware in a new 
format.  It wouldn't surprise me.

> I don't see any need to make the firmware anything more than just a
> named blob.  In fact, I would be even more defensive in designing it
> by not hardcoding the tree update into the U-Boot.  I'd make the fdt
> command support creating properties from memory regions and squirt the
> blob into the tree using a boot script instead.

Boot scripts are easier to for the user to break or bypass, which is a 
feature for some, but also a support headache on a project that already 
has too much user error.  The ability to explicitly run specific bootm 
phases should still give the determined user an escape from needing to 
run the u-boot fdt updates -- and if not, that's a quality of firmware 
issue, not a device binding issue.

A boot script would also need to coordinate with the u-boot code that 
uses the firmware for its own purposes to determine where the firmware 
lives (including possible complications such as having to pick from 
multiple firmwares based on runtime revision detection).  Using a boot 
script for other changes would likewise need to extract information that 
is currently generated by C code (hardware device A disabled due to an 
RCW setting, device B disabled due to an erratum (but it could still be 
enabled if the RCW didn't also enable device C), determination of 
various clocks, etc).  Not impossible, but yet more complexity.

> More fallout from my typo.  I mean something like this:
> 
> /.../...../qe {
>         fsl,qe-firmware-blob = "george";
> };
> chosen {
>         firmware {
>                 george = /bininc/("blob.bin");
>         };
> };

I see.  I don't have a problem with that, but I don't see a large 
practical difference with the existing proposal.

-Scott

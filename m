Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171]) by ozlabs.org (Postfix) with ESMTP id 1AEC1B7CED
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 08:39:29 +1100 (EST)
Received: by pxi1 with SMTP id 1so3675555pxi.10
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 14:39:28 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BABBF54.3010104@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
	<fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
	<4BABBF54.3010104@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 15:39:08 -0600
Message-ID: <fa686aa41003251439t23c04581n16d064c27d2516f4@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Mar 25, 2010 at 1:53 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> Grant Likely wrote:
>>
>> On Thu, Mar 25, 2010 at 11:03 AM, Timur Tabi <timur@freescale.com> wrote=
:
>>>
>>> Grant Likely wrote:
>>>>
>>>> For indirect firmware, create a /chosen/firmware node. =A0Don't add a
>>>> compatible property,
>>>
>>> Oh, I don't like that idea at all. =A0The compatible property is useful=
 for
>>> me to know *how* to parse the binary blob.
>>
>> Compatible is for devices.
>
> Compatible is for matching. =A0Who cares what category the thing being ma=
tched
> is in? =A0What is the definition of a device, and why does it matter?

Compatible specifies a device and a list of devices it can emulate:

http://www.openfirmware.org/1275/proposals/Closed/Accepted/343-it.txt

>> This is not a device. =A0Drivers cannot bind
>> against it. =A0Use a different mechanism if you have metadata about the
>> blob. =A0If your driver doesn't know how to validate its own firmware
>> blobs, then you've got bigger problems.
>
> One could also say, if your hardware can't be probed at runtime, you've g=
ot
> bigger problems. :-)
>
> What's wrong with an indication of what type of "thing" a node is suppose=
d
> to be? =A0There could be multiple microcode formats, for example.
>
> I don't know that it's strictly necessary in this case -- =A0it looks lik=
e
> there is a magic number in the firmware blob -- but I don't understand th=
e
> objection as a matter of principle. =A0These device tree discussions have=
 a
> tendency to get awfully bikesheddy.

That's because the pain inflicted in getting it wrong is very high.
Consider this: The model being discussed is for U-Boot to load the
blob into the tree.  Once U-Boot is deployed there is a lot of
resistance to changing it for a lot of good reasons, even on eval
boards.  Say that firmware node thingy is put under /qe-firmware,
u-boot uses it, and the system is shipped.  Then say that the node
format is changed because of a deficiency.  Or say that the node is
moved (either intentionally, or as part of an unrelated 'cleanup').
Will any assumptions made by a deployed version of U-Boot cause
breakage?

Case in point: there are a lot of dts files in the tree using
"soc<chip>" as a node name.  If the name is changed (say to "soc" as
per generic names) then many systems won't boot because older versions
of U-Boot are hardcoded to use the soc<chip> name.

More manipulation performed by U-Boot =3D=3D more things to go horribly
horribly wrong.  :-)  We can work around breakage, but it is always
better when the design means we don't have to.

So, I'm not saying don't have properties that say what kind of thing
it is; but I am saying make it part of the QE binding proper and
isolate the scope to the binding for that node.  I'm saying be
defensive in the design and eliminate the complexities from what
u-boot needs to do.  ie. create a single named property in a well
defined location that works for any firmware blob.  U-Boot doesn't
need to care about the format.  The fact that the QE node references
that specific blob should be sufficient to define what format the blob
needs to be in.

I don't see any need to make the firmware anything more than just a
named blob.  In fact, I would be even more defensive in designing it
by not hardcoding the tree update into the U-Boot.  I'd make the fdt
command support creating properties from memory regions and squirt the
blob into the tree using a boot script instead.

>
>>>> =A0Put each firmware blob into a separate property, and make
>>>> the names reasonable (ie. mpc<blah>-qe-firmware). =A0Have the QE
>>>> reference the firmware blob by property name.
>>>
>>> I don't like the idea of using the property name as a pseudo-compatible
>>> string.
>>
>> It's a name, not a pseudo compatible string, and your device node will
>> explicitly reference it by name. =A0There is not backwards compatibility
>> or fuzzy binding issues at play here.
>
> There is a forward compatibility issue, in that we'll have to update the
> code with every new mpc<blah> (or p<blah>rev<n>) that comes along.
>
> Or are we supposed to pick some random chip to request the firmware for,
> like with compatibles? =A0What would be the point? =A0This isn't being us=
ed to
> bind a driver.

communication breakdown... see below.

>> It is a way for your driver
>> node to state, "I want *that exact* firmware blob".
>
> The driver wants the firmware blob that the device tree provides. =A0The
> device tree knows better than the driver, being that the device tree is t=
he
> describer of the hardware.

Heh.  Typo.  Sorry.  What you said is exactly what I meant.  "It is a
way for your *device node* to specify..."  Not the driver.

>> You could make
>> the property name "george"
>
> If "george" is fine, then so is "fsl,firmware". =A0Maybe "fsl,qe-firmware=
".
>
>> and it would still be completely clear (if
>> a little weird) because all the references are contained within the
>> tree.
>
> How are the references contained within the tree? =A0The driver has to kn=
ow
> which property to read.

More fallout from my typo.  I mean something like this:

/.../...../qe {
        fsl,qe-firmware-blob =3D "george";
};
chosen {
        firmware {
                george =3D /bininc/("blob.bin");
        };
};

That's what I mean by 'george' being contained within the tree.  The
QE binding will specify the fsl,qe-firmware-blob (or whatever)
property name, but the name assigned to the firmware blob the driver
doesn't actually have to care about it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

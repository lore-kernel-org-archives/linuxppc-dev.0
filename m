Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <DD7A9A95166BF4418C4C1EB2033B6EE2038FA900@na3-mail.mgc.mentorg.com>
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
	<4D13C402.2090209@mentor.com>
	<20101223223325.GK20384@angua.secretlab.ca>
	<20110103135120.32aeb60d@udp111988uds.am.freescale.net>
	<4D24E99F.90908@mentor.com>
	<20110105160918.2b530fea@udp111988uds.am.freescale.net>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E4@na3-mail.mgc.mentorg.com>
	<20110105170725.1a82c5a6@udp111988uds.am.freescale.net>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA8FD@na3-mail.mgc.mentorg.com>
	<AANLkTikROM4MtmLYEK_6ndRzbDJ3xjMM5iSPzDhpRWLy@mail.gmail.com>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA900@na3-mail.mgc.mentorg.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Jan 2011 09:44:21 -0700
Message-ID: <AANLkTikY8z3V-opZ6K3j28QfyBV_p8jEAhxOKywjX27T@mail.gmail.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
To: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, "Inge,
	Meador" <meador_inge@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 7, 2011 at 9:00 AM, Blanchard, Hollis
<Hollis_Blanchard@mentor.com> wrote:
> On 01/07/2011 07:48 AM, Grant Likely wrote:
>> Actually, for a while now the kernel has been moving towards userspace
>> being responsible for device identification. =A0That's what udev is for.
>> =A0 The kernel udev looks at the available information when a device is
>> registered/bound, and it creates useful symlinks to the dynamically
>> assigned major/minor devices. =A0The rest of userspace doesn't need to
>> know about it; it can simply use the symlinks in /dev, but it is
>> appropriate to let udev figure out the correct naming.
> Can you point out an example of how this is done for Open Firmware
> devices currently?

Nope, because while it has been a theoretical concern, in practice the
issue hasn't come up on any of the hardware I've worked on or I've
seen patches for.  Mostly this is because the device tree
representations are internally self consistent;
dependencies/connections are explicitly expressed with phandles or
full paths which eliminates any need for enumeration in all the cases
I've had to deal with.

What I can point at is that almost all Linux character, block, and
network devices are assigned major/minor numbers in a first-come
first-served basis.  This of course causes problems for userspace
applications who need a stable handle to a specific device.  Device
renaming turned out to be horribly complex, which is why for character
and block devices the whole problem was punted out into userspace for
udev to handle with symlinks.  Network device unfortunately don't
appear in /dev, so they are stuck with device renaming until some form
of network device name aliasing is created.

As Scott also says, I know from experience that trying to maintain
enumeration in the device tree nodes themselves, and getting device
drivers to request specific numbers is painful, complex and fragile.
If I could go back in time I would never have attempted it on the
mpc5200 psc (serial) devices.

> In particular, how are the udev rules supposed to
> operate? They get a device path, use that to find additional information
> in /proc/device-tree (hope that's mounted), and then what? Do we
> hardcode the block addresses in the rules, for example @1400 and @2400?

You can do that; but from the little bit I know about your use case,
user-space visible references would be better explicitly expressed in
the aliases node.  It isn't currently, but matching aliases can easily
be added to the device's UEVENT property in /sys.  That is probably
the approach I would investigate for getting instance information out
to udev so it can create useful symlinks to the /dev device files.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

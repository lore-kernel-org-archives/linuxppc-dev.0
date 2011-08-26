Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3229EB6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 00:07:59 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110826093356.GP1923@amd.com>
Date: Fri, 26 Aug 2011 09:07:35 -0500
Message-Id: <571DC890-A1A3-4528-92BE-566F033FD4BF@suse.de>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
	<20110824093300.GI30097@yookeroo.fritz.box>
	<20110824110332.GH2079@amd.com>
	<20110826042000.GE2308@yookeroo.fritz.box>
	<20110826093356.GP1923@amd.com>
To: "Roedel, Joerg" <joerg.roedel@amd.com>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.08.2011, at 04:33, Roedel, Joerg wrote:

> On Fri, Aug 26, 2011 at 12:20:00AM -0400, David Gibson wrote:
>> On Wed, Aug 24, 2011 at 01:03:32PM +0200, Roedel, Joerg wrote:
>>> On Wed, Aug 24, 2011 at 05:33:00AM -0400, David Gibson wrote:
>>>> On Wed, Aug 24, 2011 at 11:14:26AM +0200, Roedel, Joerg wrote:
>>>=20
>>>>> I don't see a reason to make this meta-grouping static. It would =
harm
>>>>> flexibility on x86. I think it makes things easier on power but =
there
>>>>> are options on that platform to get the dynamic solution too.
>>>>=20
>>>> I think several people are misreading what Ben means by "static".  =
I
>>>> would prefer to say 'persistent', in that the meta-groups lifetime =
is
>>>> not tied to an fd, but they can be freely created, altered and =
removed
>>>> during runtime.
>>>=20
>>> Even if it can be altered at runtime, from a usability perspective =
it is
>>> certainly the best to handle these groups directly in qemu. Or are =
there
>>> strong reasons to do it somewhere else?
>>=20
>> Funny, Ben and I think usability demands it be the other way around.
>=20
> The reason is that you mean the usability for the programmer and I =
mean
> it for the actual user of qemu :)

No, we mean the actual user of qemu. The reason being that making a =
device available for any user space application is an administrative =
task.

Forget the KVM case for a moment and think of a user space device =
driver. I as a user am not root. But I as a user when having access to =
/dev/vfioX want to be able to access the device and manage it - and only =
it. The admin of that box needs to set it up properly for me to be able =
to access it.

So having two steps is really the correct way to go:

  * create VFIO group
  * use VFIO group

because the two are done by completely different users. It's similar to =
how tun/tap works in Linux too. Of course nothing keeps you from also =
creating a group on the fly, but it shouldn't be the only interface =
available. The persistent setup is definitely more useful.

>=20
>> If the meta-groups are transient - that is lifetime tied to an fd -
>> then any program that wants to use meta-groups *must* know the
>> interfaces for creating one, whatever they are.
>>=20
>> But if they're persistent, the admin can use other tools to create =
the
>> meta-group then just hand it to a program to use, since the =
interfaces
>> for _using_ a meta-group are identical to those for an atomic group.
>>=20
>> This doesn't preclude a program from being meta-group aware, and
>> creating its own if it wants to, of course.  My guess is that qemu
>> would not want to build its own meta-groups, but libvirt probably
>> would.
>=20
> Doing it in libvirt makes it really hard for a plain user of qemu to
> assign more than one device to a guest. What I want it that a user =
just
> types
>=20
> 	qemu -device vfio,host=3D00:01.0 -device vfio,host=3D00:02.0 ...
>=20
> and it just works. Qemu creates the meta-groups and they are
> automatically destroyed when qemu exits. That the programs are not =
aware
> of meta-groups is not a big problem because all software using vfio
> needs still to be written :)
>=20
> Btw, with this concept the programmer can still decide to not use
> meta-groups and just multiplex the mappings to all open device-fds it
> uses.

What I want to see is:

  # vfio-create 00:01.0
    /dev/vfio0
  # vftio-create -a /dev/vfio0 00:02.0
    /dev/vfio0

  $ qemu -vfio dev=3D/dev/vfio0,id=3Dvfio0 -device vfio,vfio=3Dvfio0.0 =
-device vfio,vfio=3Dvfio0.1


Alex

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 035EDB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 01:29:12 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110826152404.GF8978@8bytes.org>
Date: Fri, 26 Aug 2011 10:29:00 -0500
Message-Id: <165829D4-43BC-49E2-AE49-FDA420F8B02A@suse.de>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
	<20110824093300.GI30097@yookeroo.fritz.box>
	<20110824110332.GH2079@amd.com>
	<20110826042000.GE2308@yookeroo.fritz.box>
	<20110826093356.GP1923@amd.com>
	<571DC890-A1A3-4528-92BE-566F033FD4BF@suse.de>
	<20110826152404.GF8978@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel, Joerg" <joerg.roedel@amd.com>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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


On 26.08.2011, at 10:24, Joerg Roedel wrote:

> On Fri, Aug 26, 2011 at 09:07:35AM -0500, Alexander Graf wrote:
>> On 26.08.2011, at 04:33, Roedel, Joerg wrote:
>>>=20
>>> The reason is that you mean the usability for the programmer and I =
mean
>>> it for the actual user of qemu :)
>>=20
>> No, we mean the actual user of qemu. The reason being that making a
>> device available for any user space application is an administrative
>> task.
>>=20
>> Forget the KVM case for a moment and think of a user space device
>> driver. I as a user am not root. But I as a user when having access =
to
>> /dev/vfioX want to be able to access the device and manage it - and
>> only it. The admin of that box needs to set it up properly for me to
>> be able to access it.
>=20
> Right, and that task is being performed by attaching the device(s) in
> question to the vfio driver. The rights-management happens on the
> /dev/vfio/$group file.

Yup :)

>=20
>> So having two steps is really the correct way to go:
>>=20
>>  * create VFIO group
>>  * use VFIO group
>>=20
>> because the two are done by completely different users. It's similar
>> to how tun/tap works in Linux too. Of course nothing keeps you from
>> also creating a group on the fly, but it shouldn't be the only
>> interface available. The persistent setup is definitely more useful.
>=20
> I see the use-case. But to make it as easy as possible for the =
end-user
> we can do both.
>=20
> So the user of (qemu again) does this:
>=20
> # vfio-ctl attach 00:01.0
> vfio-ctl: attached to group 8
> # vfio-ctl attach 00:02.0
> vfio-ctl: attached to group 16
> $ qemu -device vfio-pci,host=3D00:01.0 -device vfio,host=3D00:01.0 ...
>=20
> which should cover the usecase you prefer. Qemu still creates the
> meta-group that allow the devices to share the same page-table. But =
what
> should also be possible is:
>=20
> # qemu -device vfio-pci,host=3D00:01.0 -device vfio-pci,host=3D00:02.0
>=20
> In that case qemu detects that the devices are not yet bound to vfio =
and
> will do so and also unbinds them afterwards (essentially the developer
> use-case).

I agree. The same it works with tun today. You can either have qemu =
spawn a tun device dynamically or have a preallocated one you use. If =
you run qemu as a user (which I always do), I preallocate a tun device =
and attach qemu to it.

> Your interface which requires pre-binding of devices into one group by
> the administrator only makes sense if you want to force userspace to
> use certain devices (which do not belong to the same hw-group) only
> together. But I don't see a usecase for defining such constraints =
(yet).

Agreed. As long as the kernel backend can always figure out the =
hw-groups, we're good :)


Alex

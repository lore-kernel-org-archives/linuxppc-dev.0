Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 9C45FB6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:30:40 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
Date: Sun, 4 Jul 2010 11:30:36 +0200
Message-Id: <486564E7-7942-4021-8EB2-67DC4E56580D@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
	<79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
	<4C305001.7060301@redhat.com>
	<40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
To: Alexander Graf <agraf@suse.de>
Cc: KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
	Avi Kivity <avi@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2010, at 11:17, Alexander Graf wrote:

>=20
> On 04.07.2010, at 11:10, Avi Kivity wrote:
>=20
>> On 07/04/2010 12:04 PM, Alexander Graf wrote:
>>>=20
>>> My biggest concern about putting things in the device-tree is that I =
was trying to keep things as separate as possible. Why does the firmware =
have to know that it's running in KVM?
>>=20
>> It doesn't need to know about kvm, it needs to know that a particular =
hypercall protocol is available.
>=20
> Considering how the parts of the draft that I read about sound like, =
that's not the inventor's idea. PPC people love to see the BIOS be part =
of the virtualization solution. I don't. That's the biggest difference =
here and reason for us going different directions.
>=20
> I think what they thought of is something like
>=20
> if (in_kvm()) {
>  device_tree_put("/hypervisor/exit", EXIT_TYPE_MAGIC);
>  device_tree_put("/hypervisor/exit_magic", EXIT_MAGIC);
> }
>=20
> which then the OS reads out. But that's useless, as the hypercalls are =
hypervisor specific. So why make the detection on the Linux side =
generic?

In fact, it's even worse. Right now with KVM for PPC we have 3 different =
ways of generating the device tree:

1) OpenBIOS (Mac emulation)
2) Qemu libfdt (BookE)
3) MOL OF implementation

So I'd have to touch even more projects. Just for the sake of splitting =
out something that belongs together anyway. And probably even create new =
interfaces just for that sake (qemu asking the kernel which type of =
hypercalls the vm should use) even though the guest could just query all =
that itself.

Alex

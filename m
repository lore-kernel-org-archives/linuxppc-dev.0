Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 36ACDB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:17:51 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C305001.7060301@redhat.com>
Date: Sun, 4 Jul 2010 11:17:47 +0200
Message-Id: <40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
	<79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
	<4C305001.7060301@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2010, at 11:10, Avi Kivity wrote:

> On 07/04/2010 12:04 PM, Alexander Graf wrote:
>>=20
>> My biggest concern about putting things in the device-tree is that I =
was trying to keep things as separate as possible. Why does the firmware =
have to know that it's running in KVM?
>=20
> It doesn't need to know about kvm, it needs to know that a particular =
hypercall protocol is available.

Considering how the parts of the draft that I read about sound like, =
that's not the inventor's idea. PPC people love to see the BIOS be part =
of the virtualization solution. I don't. That's the biggest difference =
here and reason for us going different directions.

I think what they thought of is something like

if (in_kvm()) {
  device_tree_put("/hypervisor/exit", EXIT_TYPE_MAGIC);
  device_tree_put("/hypervisor/exit_magic", EXIT_MAGIC);
}

which then the OS reads out. But that's useless, as the hypercalls are =
hypervisor specific. So why make the detection on the Linux side =
generic?

>=20
>> Why do I have to patch 3 projects (Linux, OpenBIOS, Qemu) when I =
could go with patching a single one (Linux)?
>>  =20
>=20
> That's not a valid argument.  You patch as many projects as it takes =
to get it right (not that I have an opinion in this particular =
discussion).

If you can put code in Linux that touches 3 submaintainer's directories =
or one submaintainer's directory with both ending up being functionally =
equivalent, which way would you go?

>=20
> At the very least you have to patch qemu for reasons described before =
(backwards compatible live migration).

There is no live migration on PPC (yet). That point is completely moot =
atm.


Alex

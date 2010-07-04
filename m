Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C8872B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:02:23 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100702141003.75302a9a@schlenkerla.am.freescale.net>
Date: Sun, 4 Jul 2010 11:02:16 +0200
Message-Id: <02965CC4-D0E5-4689-8F39-0F9636B88B07@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<AANLkTiksUkrO8ryEiX3Yv-_2KGVE6r5RIT4YDvrmoDPL@mail.gmail.com>
	<3085B58A-01A1-4B5C-A0E7-024DCFDFD4B2@suse.de>
	<20100702141003.75302a9a@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
	Dan Hettena <danh@ghs.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2010, at 21:10, Scott Wood wrote:

> On Fri, 2 Jul 2010 20:47:44 +0200
> Alexander Graf <agraf@suse.de> wrote:
>=20
>>=20
>> On 02.07.2010, at 19:59, Hollis Blanchard wrote:
>>=20
>>> [Resending...]
>>>=20
>>> Please reconcile this with
>>> http://www.linux-kvm.org/page/PowerPC_Hypercall_ABI, which has been
>>> discussed in the (admittedly closed) Power.org embedded hypervisor
>>> working group. Bear in mind that other hypervisors are already
>>> implementing the documented ABI, so if you have concerns, you should
>>> probably raise them with that audience...
>>=20
>> We can not use sc with LV=3D1 because that would break the KVM in
>> something else case which is KVM's strong point on PPC.
>=20
> The current proposal involves the hypervisor specifying the hcall =
opcode
> sequence in the device tree -- to allow either "sc 1" or "sc 0 plus
> magic GPR" depending on whether you've got the hardware hypervisor
> feature (hereafter HHV).

Ah right, so you can still trap a hypercall with HHV. Makes sense.

>=20
> With HHV, "sc 0 plus magic GPR" just doesn't work, since it won't trap
> to the hypervisor.  "sc 1 plus magic GPR" might be problematic on some
> non-HHV implementations, especially if you *do* have HHV but the
> non-HHV hypervisor is running as an HHV guest.

Yes, that's why I need sc 0 plus magic GPR in r0 and r3 - to accomodate =
for all the non-HHV cases. And it would be clever to have a way to =
expose the same functionality when we do use the HHV features.

So, is that draft available anywhere? The wiki page Hollis pointed to is =
very vague.


Alex

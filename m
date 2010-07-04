Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 27620B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:04:15 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1278196909.4200.389.camel@pasglop>
Date: Sun, 4 Jul 2010 11:04:11 +0200
Message-Id: <79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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


On 04.07.2010, at 00:41, Benjamin Herrenschmidt wrote:

> On Fri, 2010-07-02 at 18:27 +0200, Segher Boessenkool wrote:
>>> +To find out if we're running on KVM or not, we overlay the PVR =20
>>> register. Usually
>>> +the PVR register contains an id that identifies your CPU type. If, =20=

>>> however, you
>>> +pass KVM_PVR_PARA in the register that you want the PVR result in, =20=

>>> the register
>>> +still contains KVM_PVR_PARA after the mfpvr call.
>>> +
>>> +	LOAD_REG_IMM(r5, KVM_PVR_PARA)
>>> +	mfpvr	r5
>>> +	[r5 still contains KVM_PVR_PARA]
>>=20
>> I love this part :-)
>=20
> Me not :-)
>=20
> It should be in the device-tree instead, or something like that. =
Enough
> games with PVR...

My biggest concern about putting things in the device-tree is that I was =
trying to keep things as separate as possible. Why does the firmware =
have to know that it's running in KVM? Why do I have to patch 3 projects =
(Linux, OpenBIOS, Qemu) when I could go with patching a single one =
(Linux)?

Alex

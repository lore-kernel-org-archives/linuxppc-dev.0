Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C86ECB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 05:10:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o62JA5Xd005676 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 2 Jul 2010 12:10:05 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o62JLkRV019520
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 2 Jul 2010 14:21:46 -0500 (CDT)
Date: Fri, 2 Jul 2010 14:10:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Message-ID: <20100702141003.75302a9a@schlenkerla.am.freescale.net>
In-Reply-To: <3085B58A-01A1-4B5C-A0E7-024DCFDFD4B2@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<AANLkTiksUkrO8ryEiX3Yv-_2KGVE6r5RIT4YDvrmoDPL@mail.gmail.com>
	<3085B58A-01A1-4B5C-A0E7-024DCFDFD4B2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 2 Jul 2010 20:47:44 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 02.07.2010, at 19:59, Hollis Blanchard wrote:
> 
> > [Resending...]
> > 
> > Please reconcile this with
> > http://www.linux-kvm.org/page/PowerPC_Hypercall_ABI, which has been
> > discussed in the (admittedly closed) Power.org embedded hypervisor
> > working group. Bear in mind that other hypervisors are already
> > implementing the documented ABI, so if you have concerns, you should
> > probably raise them with that audience...
> 
> We can not use sc with LV=1 because that would break the KVM in
> something else case which is KVM's strong point on PPC.

The current proposal involves the hypervisor specifying the hcall opcode
sequence in the device tree -- to allow either "sc 1" or "sc 0 plus
magic GPR" depending on whether you've got the hardware hypervisor
feature (hereafter HHV).

With HHV, "sc 0 plus magic GPR" just doesn't work, since it won't trap
to the hypervisor.  "sc 1 plus magic GPR" might be problematic on some
non-HHV implementations, especially if you *do* have HHV but the
non-HHV hypervisor is running as an HHV guest.

-Scott

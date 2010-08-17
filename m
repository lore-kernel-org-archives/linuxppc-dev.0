Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2D03B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 06:07:54 +1000 (EST)
Subject: Re: [PATCH 21/26] KVM: PPC: Force enable nap on KVM
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100817132813.05efb21d@schlenkerla.am.freescale.net>
Date: Tue, 17 Aug 2010 22:07:47 +0200
Message-Id: <51D32588-0505-401B-979C-F07CC3952AD0@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
	<1282053481-18787-22-git-send-email-agraf@suse.de>
	<20100817132813.05efb21d@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.08.2010, at 20:28, Scott Wood wrote:

> On Tue, 17 Aug 2010 15:57:56 +0200
> Alexander Graf <agraf@suse.de> wrote:
>=20
>> There are some heuristics in the PPC power management code that try =
to find
>> out if the particular hardware we're running on supports proper power =
management
>> or just hangs the machine when going into nap mode.
>>=20
>> Since we know that KVM is safe with nap, let's force enable it in the =
PV code
>> once we're certain that we are on a KVM VM.
>=20
> Could this cause the cache to be flushed unnecessarily on e500?  Where
> available, doze would probably be better for signalling the hypervisor
> that the guest is idle.

You're right - this should be #ifdef'ed on Book3s. I'll add that as a =
patch on top, as Qemu on BookE doesn't expose KVM capabilities yet.


Alex

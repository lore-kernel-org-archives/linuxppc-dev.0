Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3301B70B9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 18:00:08 +1000 (EST)
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-11-git-send-email-agraf@suse.de>
	<20110810044215.GA5404@drongo>
In-Reply-To: <20110810044215.GA5404@drongo>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <0B73DEC7-C430-43D7-8095-D3D0BEDA27AA@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 10/10] KVM: PPC: Enable the PAPR CAP for Book3S
Date: Wed, 10 Aug 2011 09:59:41 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 10.08.2011 um 06:42 schrieb Paul Mackerras <paulus@samba.org>:

> On Tue, Aug 09, 2011 at 06:31:48PM +0200, Alexander Graf wrote:
>=20
>> Now that Book3S PV mode can also run PAPR guests, we can add a PAPR cap a=
nd
>> enable it for all Book3S targets. Enabling that CAP switches KVM into PAP=
R
>> mode.
>=20
> Don't we want to enable it only for 64-bit hosts?  Trying to run a
> PAPR guest on a 32-bit Book 3S host won't work very well, unless I am
> missing something...

I agree that it doesn't make sense, but if anything we should restrict it to=
 64-bit _guests_. you can also run 32-bit guests on 64-bit hosts.

And so far, we don't have a single interface setting PVR and PAPR mode at th=
e same time, so you could still enable PAPR with a 64-bit guest CPU and then=
 switch to a 32-bit CPU.

It'd be a nightmare to check all configurations on every setter function.

Unless...

We could introduce a sanity check function that gets executed every time we c=
hange PVR or enable PAPR. That could set a variable in the vcpu struct to in=
dicate that the config is ok. We could then check that on vcpu_run.


Alex

>=20

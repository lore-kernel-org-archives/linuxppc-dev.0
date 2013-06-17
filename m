Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id EF40C2C0296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 18:42:20 +1000 (EST)
Subject: Re: [PATCH 1/4] KVM: PPC: Add support for multiple-TCE hcalls
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1371458225.21896.153.camel@pasglop>
Date: Mon, 17 Jun 2013 10:42:18 +0200
Message-Id: <6BF879F8-F9F6-4622-81BA-05EB26CA0580@suse.de>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-2-git-send-email-aik@ozlabs.ru>
 <0A6C24DE-1422-4ABA-A516-2B864F4714F8@suse.de> <51BEC0FE.4020805@ozlabs.ru>
 <1371458225.21896.153.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.06.2013, at 10:37, Benjamin Herrenschmidt wrote:

> On Mon, 2013-06-17 at 17:55 +1000, Alexey Kardashevskiy wrote:
>> David:
>> =3D=3D=3D
>> So, in the case of MULTITCE, that's not quite right.  PR KVM can
>> emulate a PAPR system on a BookE machine, and there's no reason not =
to
>> allow TCE acceleration as well.  We can't make it dependent on PAPR
>> mode being selected, because that's enabled per-vcpu, whereas these
>> capabilities are queried on the VM before the vcpus are created.
>> =3D=3D=3D
>>=20
>> Wrong?
>=20
> The capability just tells qemu the kernel supports it, it doesn't have
> to depend on PAPR mode, qemu can sort things out no ?

Yes, this goes hand-in-hand with the documentation bit I'm trying to get =
through to Alexey atm. The CAP merely says that if in PAPR mode the =
kernel can handle hypercalls X and Y itself.

This is true for all book3s implementations as the patches stand. It is =
not true for BookE as the patches stand. Hence the CAP should be limited =
to book3s, regardless of its mode :).


Alex

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA3672C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 00:08:11 +1100 (EST)
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <13876.1349947620@warthog.procyon.org.uk>
Date: Thu, 11 Oct 2012 15:08:01 +0200
Message-Id: <4C573632-7629-4E7A-8A67-FD4698B7430D@suse.de>
References: <20121011120502.0211f1267dedf3776e4cf85b@canb.auug.org.au>
 <13876.1349947620@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liu Yu <yu.liu@freescale.com>,
 B04825@freescale.com, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.10.2012, at 11:27, David Howells wrote:

> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
>> I just removed epapr_hcalls.h from the Kbuild file as I am not sure =
how
>> it should be broken up.  David, can you have a look at this, please?
>=20
> Files should be broken up along around __KERNEL__ conditionals.  If =
there are
> no __KERNEL__ conditionals, it is assumed that the file is entirely =
UAPI and
> can just be moved.
>=20
> The problem appears to be this commit:
>=20
> 	=
https://github.com/agraf/linux-2.6/commit/4c09029a5639c955fcf6d65205796e4f=
1208aed3
>=20
> 	From: Liu Yu <yu.liu@freescale.com>
> 	Subject: KVM: PPC: Add support for ePAPR idle hcall in host =
kernel
>=20
> Just makes epapr_hcalls.h part of the userspace API in its entirety by =
this bit
> of the patch:
>=20
> 	+header-y +=3D epapr_hcalls.h
>=20
> whilst not adding any __KERNEL__ guards - which is almost certainly =
incorrect.
>=20
> At the very least, I would say that the global variable declarations =
need
> limiting to kernel space, and thus so do the inline functions as they =
emit
> inline assembly to jump somewhere specified by one of the global =
variables
> (actually a code array).
>=20
> So for manual splitting purposes, I would go with just moving all the =
#defines
> prior to the __ASSEMBLY__ guard out to uapi.  Everything within the
> __ASSEMBLY__ guard is KABI only by the looks of it.

Do I have to move them to their own header file or can I just #ifdef =
__KERNEL__ around the place where __ASSEMBLY__ starts to the end of the =
file?


Alex

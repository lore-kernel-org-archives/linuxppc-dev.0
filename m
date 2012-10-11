Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D886B2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 02:50:17 +1100 (EST)
Date: Thu, 11 Oct 2012 10:50:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de> (from
 agraf@suse.de on Thu Oct 11 08:04:58 2012)
Message-ID: <1349970603.6903.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/11/2012 08:04:58 AM, Alexander Graf wrote:
>=20
> On 11.10.2012, at 05:32, Tabi Timur-B04825 wrote:
>=20
> > On Wed, Oct 10, 2012 at 9:47 PM, Stephen Rothwell =20
> <sfr@canb.auug.org.au> wrote:
> >
> >> Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
> >> for hcalls") from the kvm-ppc tree added an include of =20
> asm/epapr_hcall.h
> >> to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h =20
> became a
> >> user visible header file.
> >
> > Any real user-space code that tries to call any of the functions in
> > epapr_hcall.h will cause an exception.

Actually it'll cause a linker error, as of the "Don't use hardcoded =20
opcode for ePAPR hcall invocation" patch.

> > Claiming that kernel header files that KVM needs are suddenly
> > user-space header files doesn't make much sense to me, but I guess
> > it's not my decision.
>=20
> This is about kvm_host.h, which is the part that is exported to user =20
> space. It usually contains constants and structs that are required =20
> for the API.

s/kvm_host/kvm_para/

I'm not sure anything in kvm_para.h or epapr_hcalls.h would be of use =20
to userspace, but it would be of use to the guest OS, so it's still not =20
kernel-internal.

The variable externs should be #ifdef __KERNEL__ as David points out.  =20
The asm stuff could still be useful in a guest OS if the guest provides =20
epapr_hypercall_start.

-Scott=

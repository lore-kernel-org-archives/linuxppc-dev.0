Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C527B2C03F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:33:44 +1100 (EST)
Date: Thu, 11 Oct 2012 11:33:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
To: Alexander Graf <agraf@suse.de>
References: <1349970603.6903.2@snotra>
 <CDB8B53D-EEC2-41A4-9BEA-66783409EE66@suse.de>
In-Reply-To: <CDB8B53D-EEC2-41A4-9BEA-66783409EE66@suse.de> (from
 agraf@suse.de on Thu Oct 11 10:56:51 2012)
Message-ID: <1349973211.6903.3@snotra>
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

On 10/11/2012 10:56:51 AM, Alexander Graf wrote:
>=20
> On 11.10.2012, at 17:50, Scott Wood wrote:
>=20
> > On 10/11/2012 08:04:58 AM, Alexander Graf wrote:
> >> On 11.10.2012, at 05:32, Tabi Timur-B04825 wrote:
> >> > On Wed, Oct 10, 2012 at 9:47 PM, Stephen Rothwell =20
> <sfr@canb.auug.org.au> wrote:
> >> >
> >> >> Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
> >> >> for hcalls") from the kvm-ppc tree added an include of =20
> asm/epapr_hcall.h
> >> >> to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h =20
> became a
> >> >> user visible header file.
> >> >
> >> > Any real user-space code that tries to call any of the functions =20
> in
> >> > epapr_hcall.h will cause an exception.
> >
> > Actually it'll cause a linker error, as of the "Don't use hardcoded =20
> opcode for ePAPR hcall invocation" patch.
> >
> >> > Claiming that kernel header files that KVM needs are suddenly
> >> > user-space header files doesn't make much sense to me, but I =20
> guess
> >> > it's not my decision.
> >> This is about kvm_host.h, which is the part that is exported to =20
> user space. It usually contains constants and structs that are =20
> required for the API.
> >
> > s/kvm_host/kvm_para/
> >
> > I'm not sure anything in kvm_para.h or epapr_hcalls.h would be of =20
> use to userspace, but it would be of use to the guest OS, so it's =20
> still not kernel-internal.
> >
> > The variable externs should be #ifdef __KERNEL__ as David points =20
> out.  The asm stuff could still be useful in a guest OS if the guest =20
> provides epapr_hypercall_start.
>=20
> I don't think we should worry about guest kernel code potentially =20
> having use for this. Let's make the user space headers be great for =20
> user space usage, not for guest code usage :).

Well, that asm stuff started out as a guest header (from Freescale's =20
Topaz hypervisor), not a Linux header. :-)

-Scott=

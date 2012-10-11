Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B54632C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 02:56:59 +1100 (EST)
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349970603.6903.2@snotra>
Date: Thu, 11 Oct 2012 17:56:51 +0200
Message-Id: <CDB8B53D-EEC2-41A4-9BEA-66783409EE66@suse.de>
References: <1349970603.6903.2@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 11.10.2012, at 17:50, Scott Wood wrote:

> On 10/11/2012 08:04:58 AM, Alexander Graf wrote:
>> On 11.10.2012, at 05:32, Tabi Timur-B04825 wrote:
>> > On Wed, Oct 10, 2012 at 9:47 PM, Stephen Rothwell =
<sfr@canb.auug.org.au> wrote:
>> >
>> >> Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
>> >> for hcalls") from the kvm-ppc tree added an include of =
asm/epapr_hcall.h
>> >> to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h =
became a
>> >> user visible header file.
>> >
>> > Any real user-space code that tries to call any of the functions in
>> > epapr_hcall.h will cause an exception.
>=20
> Actually it'll cause a linker error, as of the "Don't use hardcoded =
opcode for ePAPR hcall invocation" patch.
>=20
>> > Claiming that kernel header files that KVM needs are suddenly
>> > user-space header files doesn't make much sense to me, but I guess
>> > it's not my decision.
>> This is about kvm_host.h, which is the part that is exported to user =
space. It usually contains constants and structs that are required for =
the API.
>=20
> s/kvm_host/kvm_para/
>=20
> I'm not sure anything in kvm_para.h or epapr_hcalls.h would be of use =
to userspace, but it would be of use to the guest OS, so it's still not =
kernel-internal.
>=20
> The variable externs should be #ifdef __KERNEL__ as David points out.  =
The asm stuff could still be useful in a guest OS if the guest provides =
epapr_hypercall_start.

I don't think we should worry about guest kernel code potentially having =
use for this. Let's make the user space headers be great for user space =
usage, not for guest code usage :).

Alex=

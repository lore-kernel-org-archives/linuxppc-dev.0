Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 14AF51007D4
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Dec 2011 22:46:34 +1100 (EST)
Subject: Re: "KVM: PPC: booke: Improve timer register emulation" breaks Book3s
 HV
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111206114347.GA14832@bloggs.ozlabs.ibm.com>
Date: Tue, 6 Dec 2011 12:46:27 +0100
Message-Id: <018FAA2F-85F9-40EA-8F25-2BBFFF3D6CCF@suse.de>
References: <20111206040300.GA12018@drongo>
 <20111206114347.GA14832@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.12.2011, at 12:43, Paul Mackerras wrote:

> On Tue, Dec 06, 2011 at 03:03:00PM +1100, Paul Mackerras wrote:
>> I'm not sure why yet, but commit 8a97c432 ("KVM: PPC: booke: Improve
>> timer register emulation") in Alex's kvm-ppc-next branch is breaking
>> Book3S HV KVM on POWER7.  Guest cpus fail to spin up, and even with
>> just one cpu, the guest stalls every so often.  If I stop the guest
>> and inspect the state with qemu, PC is at 0x900.  Reverting 8a97c432
>> makes it work properly again.
>=20
> This fixes it:
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 534cbe1..83bcb44 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -560,7 +560,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, =
struct kvm_run *run)
>=20
> void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
> {
> -	if (waitqueue_active(&vcpu->wq)) {
> +	if (waitqueue_active(vcpu->arch.wqp)) {

:(

> 		wake_up_interruptible(vcpu->arch.wqp);
> 		vcpu->stat.halt_wakeup++;
> 	} else if (vcpu->cpu !=3D -1) {
>=20
> Alex, do you want to roll that in with Scott's patch, or do you want =
me
> to send a separate patch on top?

I usually like praise where praise belongs, so I'll put this right after =
Scott's patch if you give me a nice and shiny patch description with a =
signed-off-by line :)


Alex

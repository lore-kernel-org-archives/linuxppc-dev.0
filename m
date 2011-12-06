Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 22:43:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>
Subject: Re: "KVM: PPC: booke: Improve timer register emulation" breaks
 Book3s HV
Message-ID: <20111206114347.GA14832@bloggs.ozlabs.ibm.com>
References: <20111206040300.GA12018@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206040300.GA12018@drongo>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 06, 2011 at 03:03:00PM +1100, Paul Mackerras wrote:
> I'm not sure why yet, but commit 8a97c432 ("KVM: PPC: booke: Improve
> timer register emulation") in Alex's kvm-ppc-next branch is breaking
> Book3S HV KVM on POWER7.  Guest cpus fail to spin up, and even with
> just one cpu, the guest stalls every so often.  If I stop the guest
> and inspect the state with qemu, PC is at 0x900.  Reverting 8a97c432
> makes it work properly again.

This fixes it:

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 534cbe1..83bcb44 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -560,7 +560,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	if (waitqueue_active(&vcpu->wq)) {
+	if (waitqueue_active(vcpu->arch.wqp)) {
 		wake_up_interruptible(vcpu->arch.wqp);
 		vcpu->stat.halt_wakeup++;
 	} else if (vcpu->cpu != -1) {

Alex, do you want to roll that in with Scott's patch, or do you want me
to send a separate patch on top?

Paul.

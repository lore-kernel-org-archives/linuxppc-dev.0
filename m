Return-Path: <paulus@ozlabs.org>
Date: Thu, 28 Nov 2013 15:05:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: book3s: kvm: Don't abuse host r2 in exit path
Message-ID: <20131128040515.GB26309@iris.ozlabs.ibm.com>
References: <1384178387-22993-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384178387-22993-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 11, 2013 at 07:29:47PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We don't use PACATOC for PR. Avoid updating HOST_R2 with PR
> KVM mode when both HV and PR are enabled in the kernel. Without this we
> get the below crash
> 
> (qemu)
> Unable to handle kernel paging request for data at address 0xffffffffffff8310
> Faulting instruction address: 0xc00000000001d5a4
> cpu 0x2: Vector: 300 (Data Access) at [c0000001dc53aef0]
>     pc: c00000000001d5a4: .vtime_delta.isra.1+0x34/0x1d0
>     lr: c00000000001d760: .vtime_account_system+0x20/0x60
>     sp: c0000001dc53b170
>    msr: 8000000000009032
>    dar: ffffffffffff8310
>  dsisr: 40000000
>   current = 0xc0000001d76c62d0
>   paca    = 0xc00000000fef1100   softe: 0        irq_happened: 0x01
>     pid   = 4472, comm = qemu-system-ppc
> enter ? for help
> [c0000001dc53b200] c00000000001d760 .vtime_account_system+0x20/0x60
> [c0000001dc53b290] c00000000008d050 .kvmppc_handle_exit_pr+0x60/0xa50
> [c0000001dc53b340] c00000000008f51c kvm_start_lightweight+0xb4/0xc4
> [c0000001dc53b510] c00000000008cdf0 .kvmppc_vcpu_run_pr+0x150/0x2e0
> [c0000001dc53b9e0] c00000000008341c .kvmppc_vcpu_run+0x2c/0x40
> [c0000001dc53ba50] c000000000080af4 .kvm_arch_vcpu_ioctl_run+0x54/0x1b0
> [c0000001dc53bae0] c00000000007b4c8 .kvm_vcpu_ioctl+0x478/0x730
> [c0000001dc53bca0] c0000000002140cc .do_vfs_ioctl+0x4ac/0x770
> [c0000001dc53bd80] c0000000002143e8 .SyS_ioctl+0x58/0xb0
> [c0000001dc53be30] c000000000009e58 syscall_exit+0x0/0x98
> --- Exception: c00 (System Call) at 00001fffff960160
> SP (1ffffecbe3c0) is in userspace
> 
> These changes were originally part of
> http://mid.gmane.org/20130806042205.GR19254@iris.ozlabs.ibm.com
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>

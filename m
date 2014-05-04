Return-Path: <paulus@ozlabs.org>
Date: Mon, 5 May 2014 09:59:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] KVM: PPC: BOOK3S: PR: Enable Little Endian PR guest
Message-ID: <20140504235910.GA5978@iris.ozlabs.ibm.com>
References: <1399223932-17840-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399223932-17840-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sun, May 04, 2014 at 10:48:52PM +0530, Aneesh Kumar K.V wrote:
> This patch make sure we inherit the LE bit correctly in different case
> so that we can run Little Endian distro in PR mode

[snip]

> +static void kvmppc_set_lpcr_pr(struct kvm_vcpu *vcpu, u64 new_lpcr)
> +{
> +	/*
> +	 * If ILE (interrupt little-endian) has changed, update the
> +	 * MSR_LE bit in the intr_msr for each vcpu in this vcore.
> +	 */
> +	if ((new_lpcr & LPCR_ILE) != (vcpu->arch.intr_msr & MSR_LE)) {

Since LPCR_ILE != MSR_LE, this condition is always going to be true.
I suggest you remove this if statement and just do the body
unconditionally.

Paul.

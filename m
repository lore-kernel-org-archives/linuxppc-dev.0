Return-Path: <paulus@ozlabs.org>
Date: Sat, 16 Nov 2013 18:00:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <qemulist@gmail.com>
Subject: Re: [PATCH v2] powerpc: kvm: optimize "sc 1" as fast return
Message-ID: <20131116070056.GB18339@iris.ozlabs.ibm.com>
References: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1384504501-19348-2-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384504501-19348-2-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 04:35:01PM +0800, Liu Ping Fan wrote:
>  
> +sc_1_fast_return:
> +	mtspr	SPRN_SRR0,r10
> +	mtspr	SPRN_SRR1,r11
> +	li	r10, BOOK3S_INTERRUPT_SYSCALL
> +	li      r11, (MSR_ME << 1) | 1  /* synthesize MSR_SF | MSR_ME */
> +	rotldi  r11, r11, 63

You need a "mr r4, r9" instruction here, because fast_guest_return
needs the vcpu pointer in r4.  Apart from that this looks fine.

> +	b	fast_guest_return

Paul.

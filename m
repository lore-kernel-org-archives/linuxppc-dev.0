Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A54BA2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2012 19:51:12 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V8 04/11] arch/powerpc: Convert virtual address to vpn
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346945351-7672-5-git-send-email-aneesh.kumar__43423.5424655073$1346945525$gmane$org@linux.vnet.ibm.com>
Date: Mon, 15 Oct 2012 10:51:07 +0200
In-Reply-To: <1346945351-7672-5-git-send-email-aneesh.kumar__43423.5424655073$1346945525$gmane$org@linux.vnet.ibm.com>
 (Aneesh Kumar K. V.'s message of "Thu, 6 Sep 2012 20:59:04 +0530")
Message-ID: <m2y5j8qft0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
> index 837f13e..00aa612 100644
> --- a/arch/powerpc/kvm/book3s_32_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
> @@ -141,7 +141,7 @@ extern char etext[];
>  int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>  {
>  	pfn_t hpaddr;
> -	u64 va;
> +	u64 vpn;
>  	u64 vsid;
>  	struct kvmppc_sid_map *map;
>  	volatile u32 *pteg;
> @@ -173,7 +173,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>  	BUG_ON(!map);
>  
>  	vsid = map->host_vsid;
> -	va = (vsid << SID_SHIFT) | (eaddr & ~ESID_MASK);
> +	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)

Where is VPN_SHIFT?  Where is the semicolon?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

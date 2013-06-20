Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4851B2C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 14:57:07 +1000 (EST)
Message-ID: <1371704216.3944.4.camel@pasglop>
Subject: Re: [PATCH -V2] powerpc/kvm: Handle transparent hugepage in KVM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 20 Jun 2013 14:56:56 +1000
In-Reply-To: <1371703304-31687-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371703304-31687-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-20 at 10:11 +0530, Aneesh Kumar K.V wrote:
> +       while (1) {
> +               old_pte = pte_val(*ptep);
> +               /*
> +                * wait until _PAGE_BUSY is clear then set it
> atomically
> +                */
> +               if (unlikely(old_pte & _PAGE_BUSY))
> +                       continue;
> +

Add a cpu_relax...

Cheers,
Ben.

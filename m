Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 868F01A04C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 07:49:56 +1000 (AEST)
Message-ID: <1435873760.10531.11.camel@freescale.com>
Subject: Re: [RFC PATCH 6/6] powerpc/kvm: change the condition of
 identifying hugetlb vm
From: Scott Wood <scottwood@freescale.com>
To: Wenwei Tao <wenweitaowenwei@gmail.com>
CC: <izik.eidus@ravellosystems.com>, <aarcange@redhat.com>,
 <chrisw@sous-sol.org>, <hughd@google.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
 <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm@vger.kernel.org>,
 <kvm-ppc@vger.kernel.org>
Date: Thu, 2 Jul 2015 16:49:20 -0500
In-Reply-To: <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
 <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 14:27 +0800, Wenwei Tao wrote:
> Hugetlb VMAs are not mergeable, that means a VMA couldn't have VM_HUGETLB 
> and
> VM_MERGEABLE been set in the same time. So we use VM_HUGETLB to indicate new
> mergeable VMAs. Because of that a VMA which has VM_HUGETLB been set is a 
> hugetlb
> VMA only if it doesn't have VM_MERGEABLE been set in the same time.

Eww.

If you must overload such bit combinations, please hide it behind a 
vm_is_hugetlb() function.

-Scott

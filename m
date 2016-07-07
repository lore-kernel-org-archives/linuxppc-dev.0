Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlTmW6V8bzDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 17:30:19 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u677TA8t134459
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 03:30:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xmyb10-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 03:30:16 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 7 Jul 2016 08:30:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5AAEA17D8062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 08:31:35 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u677UB9d9699630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 07:30:11 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u677U8Ba028031
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 01:30:11 -0600
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Cc: Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>,
 Vitaly Wool <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Dmitry Vyukov <dvyukov@google.com>, Laura Abbott
 <labbott@fedoraproject.org>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 kernel-hardening@lists.openwall.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 7 Jul 2016 09:30:07 +0200
MIME-Version: 1.0
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <577E04FF.1090000@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 12:25 AM, Kees Cook wrote:
> Hi,
> 
> This is a start of the mainline port of PAX_USERCOPY[1]. After I started
> writing tests (now in lkdtm in -next) for Casey's earlier port[2], I
> kept tweaking things further and further until I ended up with a whole
> new patch series. To that end, I took Rik's feedback and made a number
> of other changes and clean-ups as well.
> 
> Based on my understanding, PAX_USERCOPY was designed to catch a few
> classes of flaws around the use of copy_to_user()/copy_from_user(). These
> changes don't touch get_user() and put_user(), since these operate on
> constant sized lengths, and tend to be much less vulnerable. There
> are effectively three distinct protections in the whole series,
> each of which I've given a separate CONFIG, though this patch set is
> only the first of the three intended protections. (Generally speaking,
> PAX_USERCOPY covers what I'm calling CONFIG_HARDENED_USERCOPY (this) and
> CONFIG_HARDENED_USERCOPY_WHITELIST (future), and PAX_USERCOPY_SLABS covers
> CONFIG_HARDENED_USERCOPY_SPLIT_KMALLOC (future).)
> 
> This series, which adds CONFIG_HARDENED_USERCOPY, checks that objects
> being copied to/from userspace meet certain criteria:
> - if address is a heap object, the size must not exceed the object's
>   allocated size. (This will catch all kinds of heap overflow flaws.)
> - if address range is in the current process stack, it must be within the
>   current stack frame (if such checking is possible) or at least entirely
>   within the current process's stack. (This could catch large lengths that
>   would have extended beyond the current process stack, or overflows if
>   their length extends back into the original stack.)
> - if the address range is part of kernel data, rodata, or bss, allow it.
> - if address range is page-allocated, that it doesn't span multiple
>   allocations.
> - if address is within the kernel text, reject it.
> - everything else is accepted
> 
> The patches in the series are:
> - The core copy_to/from_user() checks, without the slab object checks:
> 	1- mm: Hardened usercopy
> - Per-arch enablement of the protection:
> 	2- x86/uaccess: Enable hardened usercopy
> 	3- ARM: uaccess: Enable hardened usercopy
> 	4- arm64/uaccess: Enable hardened usercopy
> 	5- ia64/uaccess: Enable hardened usercopy
> 	6- powerpc/uaccess: Enable hardened usercopy
> 	7- sparc/uaccess: Enable hardened usercopy

Was there a reason why you did not change s390?

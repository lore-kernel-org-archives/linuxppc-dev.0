Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GSQM04xDzF1Mm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 15:05:11 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so3975907oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 22:05:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
To: Matthew Wilcox <mawilcox@microsoft.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Regression in 4.18 - 32-bit PowerPC crashes on boot - bisected to
 commit 1d40a5ea01d5
Message-ID: <5a98ad6b-e209-a9dc-98db-1745ef5b7f87@lwfinger.net>
Date: Thu, 28 Jun 2018 00:05:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a kernel BUG 
at include/linux/page-flags.h:700! The problem was bisected to commit 
1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is not possible to 
capture the bug with anything other than a camera. The first few lines of the 
traceback are as follows:

free_pgd_range+0x19c/0x30c (unreliable)
free_pgtables_0xa0/0xb0
exit_pmap+0xf4/0x16c
mmput+0x64/0xf0
do_exit+0x33c/0x89c
oops_end+0x13c/0x144
_exception_pkey+0x58/0x128
ret_from_except_full+0x0/0x4
--- interrupt: 700 at free_pgd_range+0x19c/0x30c
     LR = free_pgd_range+0x19c/0x30c
free_pgtables+0xa/0xb
exit_mnap+0xf4/0x16c
mmput+0x64/0xf0
flush_old_exec+0x490/0x550

I have a PDF of the complete dump, but I hesitate to send this to the entire group.

Thanks,

Larry

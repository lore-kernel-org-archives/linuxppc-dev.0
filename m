Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E714F1A07D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 08:28:34 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33DD314014D
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2014 08:28:34 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 18 Nov 2014 14:28:32 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6D49719D8039
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 14:17:10 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAILSTHV30867704
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 22:28:29 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAILSR8c005794
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 14:28:29 -0700
Date: Tue, 18 Nov 2014 13:28:21 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/8] elf: Add new PowerPC specifc core note sections
Message-ID: <20141118212821.GA21540@us.ibm.com>
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-2-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415683597-22819-2-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, davej@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| This patch adds four new core note sections for PowerPC transactional
| memory and one core note section for general miscellaneous debug registers.
| These addition of new elf core note sections extends the existing elf ABI
| without affecting it in any manner.
| 
| Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Except for some minor comments to one of the patches, the patchset
looks good to me. I was also able to run the included selftest on
a PowerVM guest.

Tested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

| ---
|  include/uapi/linux/elf.h | 5 +++++
|  1 file changed, 5 insertions(+)
| 
| diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
| index ea9bf25..2260fc0 100644
| --- a/include/uapi/linux/elf.h
| +++ b/include/uapi/linux/elf.h
| @@ -379,6 +379,11 @@ typedef struct elf64_shdr {
|  #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
|  #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
|  #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
| +#define NT_PPC_TM_SPR	0x103		/* PowerPC TM special registers */
| +#define NT_PPC_TM_CGPR	0x104		/* PowerpC TM checkpointed GPR */
| +#define NT_PPC_TM_CFPR	0x105		/* PowerPC TM checkpointed FPR */
| +#define NT_PPC_TM_CVMX	0x106		/* PowerPC TM checkpointed VMX */
| +#define NT_PPC_MISC	0x107		/* PowerPC miscellaneous registers */
|  #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
|  #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
|  #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
| -- 
| 1.9.3

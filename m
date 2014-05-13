Return-Path: <palves@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id A570B140087
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 03:13:47 +1000 (EST)
Message-ID: <537252C0.6090005@redhat.com>
Date: Tue, 13 May 2014 18:13:36 +0100
From: Pedro Alves <palves@redhat.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: michael@ellerman.id.au, mikey@neuling.org, avagin@openvz.org,
 oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/14 08:54, Anshuman Khandual wrote:
> This patch enables get and set of transactional memory related register
> sets through PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing
> four new powerpc specific register sets i.e REGSET_TM_SPR, REGSET_TM_CGPR,
> REGSET_TM_CFPR, REGSET_CVMX support corresponding to these following new
> ELF core note types added previously in this regard.
> 
> 	(1) NT_PPC_TM_SPR
> 	(2) NT_PPC_TM_CGPR
> 	(3) NT_PPC_TM_CFPR
> 	(4) NT_PPC_TM_CVMX

Sorry that I couldn't tell this from the code, but, what does the
kernel return when the ptracer requests these registers and the
program is not in a transaction?  Specifically I'm wondering whether
this follows the same semantics as the s390 port.

-- 
Pedro Alves

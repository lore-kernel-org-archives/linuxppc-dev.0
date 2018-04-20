Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S7RN62WWzF25M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 17:54:21 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K7nNQi040419
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 03:54:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hfb98am3h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 03:54:18 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Fri, 20 Apr 2018 08:54:16 +0100
Date: Fri, 20 Apr 2018 09:54:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 libc-alpha@sourceware.org, tglx@linutronix.de, deepa.kernel@gmail.com,
 viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
 schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
 ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header
 files
References: <20180419143737.606138-1-arnd@arndb.de>
 <20180419143737.606138-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419143737.606138-5-arnd@arndb.de>
Message-Id: <20180420075407.GA7119@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
> version from asm-generic.
> 
> This patch removes the files and replaces them with 'generic-y'
> statements, to avoid having to modify each copy when we extend sysvipc
> to deal with 64-bit time_t in 32-bit user space.
> 
> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
> different here, so I'm leaving the private copy.
> 
> To deal with 32-bit compat tasks, we also have to adapt the definitions
> of compat_{shm,sem,msg}id_ds to match the changes to the respective
> asm-generic files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>  5 files changed, 19 insertions(+), 133 deletions(-)
>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

FWIW,

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

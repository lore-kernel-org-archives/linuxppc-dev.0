Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvvlt61pfzDr4w
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 20:30:43 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w259StkE127545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 04:30:40 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gh1kuvb07-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 04:30:40 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Mon, 5 Mar 2018 09:30:37 -0000
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de,
 john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 acme@kernel.org, benh@kernel.crashing.org, catalin.marinas@arm.com,
 cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net,
 deller@gmx.de, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com,
 gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
 hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org,
 jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com,
 oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org,
 ralf@linux-mips.org, rostedt@goodmis.org, rric@kernel.org,
 schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com,
 ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 10:30:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

You are now include a <linux/*.h> from several asm files
(
 arch/arm64/include/asm/stat.h   
 arch/s390/include/asm/elf.h     
 arch/x86/include/asm/ftrace.h   
 arch/x86/include/asm/sys_ia32.h 
)
It works, and it is done in many places, but it looks somewhat weird.
Would it make sense to have an asm-generic/compate-time.h instead? Asking for
opinions here.

> 
> The patch also requires an operation similar to:
> 
> git grep "asm/compat\.h" | cut -d ":" -f 1 |  xargs -n 1 sed -i -e "s%asm/compat.h%linux/compat.h%g"

some comments from the s390 perspective:

> --- a/arch/s390/hypfs/hypfs_sprp.c
> +++ b/arch/s390/hypfs/hypfs_sprp.c
ok.
[...]
> --- a/arch/s390/include/asm/elf.h
> +++ b/arch/s390/include/asm/elf.h
> @@ -126,7 +126,7 @@
>   */
> 
>  #include <asm/ptrace.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/syscall.h>
>  #include <asm/user.h>

see above.
[...]
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
ok
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
ok
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
ok 
> --- a/drivers/s390/char/fs3270.c
> +++ b/drivers/s390/char/fs3270.c
ok
> --- a/drivers/s390/char/sclp_ctl.c
> +++ b/drivers/s390/char/sclp_ctl.c
ok
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
ok
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
ok

> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -32,7 +32,7 @@
>  #include <asm/chpid.h>
>  #include <asm/io.h>
>  #include <asm/sysinfo.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/diag.h>
>  #include <asm/cio.h>
>  #include <asm/ccwdev.h>

Can you move that into the other includes (where all the other <linux/*> includes are.

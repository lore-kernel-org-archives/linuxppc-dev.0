Return-Path: <srs0=s7jy=hx=linux.vnet.ibm.com=naveen.n.rao@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cwJd2945zDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 01:04:01 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40cwJd1Prtz8tCx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 01:04:01 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40cwJc1nxQz9s3G
 for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2018 01:04:00 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w44ExsDW194431
 for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2018 11:03:56 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hrq81ysp8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 04 May 2018 11:03:55 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 4 May 2018 16:03:53 +0100
Date: Fri, 04 May 2018 20:33:48 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/6] powerpc/syscalls: Switch trivial cases to
 SYSCALL_DEFINE
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20180502132051.28861-1-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1525446080.ih4a1c8i42.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/kernel/pci_32.c               | 6 +++---
>  arch/powerpc/kernel/pci_64.c               | 4 ++--
>  arch/powerpc/mm/subpage-prot.c             | 4 +++-
>  arch/powerpc/platforms/cell/spu_syscalls.c | 3 ++-
>  4 files changed, 10 insertions(+), 7 deletions(-)
>=20

I suppose we can also do this for switch_endian?

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.=
c
index 466216506eb2..290265f2700c 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -123,7 +123,7 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_hi=
gh, u32 offset_low,
 				 (u64)len_high << 32 | len_low, advice);
 }
=20
-long sys_switch_endian(void)
+SYSCALL_DEFINE0(switch_endian)
 {
 	struct thread_info *ti;


- Naveen

=

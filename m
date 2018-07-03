Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KRXZ4ZPTzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 11:35:58 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w631YhfZ121127
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2018 21:35:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jyrs95m38-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 21:35:56 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 2 Jul 2018 21:35:55 -0400
References: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
 <1529979376-7292-2-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, fweimer@redhat.com, Ulrich.Weigand@de.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/pkeys: key allocation/deallocation must not
 change pkey registers
In-reply-to: <1529979376-7292-2-git-send-email-linuxram@us.ibm.com>
Date: Mon, 02 Jul 2018 22:35:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zhz9ksng.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> Key allocation and deallocation has the side effect of programming the
> UAMOR/AMR/IAMR registers. This is wrong, since its the responsibility of
> the application and not that of the kernel, to modify the permission on
> the key.
>
> Do not modify the pkey registers at key allocation/deallocation.
>
> This patch also fixes a bug where a sys_pkey_free() resets the UAMOR
> bits of the key, thus making its permissions unmodifiable from user
> space.  Latter if the same key gets reallocated from a different thread
> this thread will no longer be able to change the permissions on the key.
>
> Problem noticed/reported by Michael Ellermen while running
> selftests/core-pkeys
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |   11 -----------
>  arch/powerpc/mm/pkeys.c          |   27 ---------------------------
>  2 files changed, 0 insertions(+), 38 deletions(-)

LGTM.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

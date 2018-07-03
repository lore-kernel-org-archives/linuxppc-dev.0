Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KV5R5GkkzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 13:31:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w633SUV1087806
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2018 23:31:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jyxpk52u1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 23:31:04 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 2 Jul 2018 21:31:03 -0600
References: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
 <1529979376-7292-4-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: Re: [PATCH 2/2] powerpc/ptrace-pkeys: execute-permission on keys are
 disabled by default
In-reply-to: <1529979376-7292-4-git-send-email-linuxram@us.ibm.com>
Date: Tue, 03 Jul 2018 00:30:53 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87woudknbm.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> The test case assumes execute-permissions of unallocated keys are
> enabled by default.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> index 5cf631f..559c6cb 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> @@ -104,6 +104,11 @@ static int child(struct shared_info *info)
>
>  	if (disable_execute)
>  		info->expected_iamr |= 1ul << pkeyshift(pkey1);
> +	else
> +		info->expected_iamr &= ~(1ul << pkeyshift(pkey1));
> +	info->expected_iamr &= ~(1ul << pkeyshift(pkey2) | 1ul << pkeyshift(pkey3));
> +
> +
>
>  	info->expected_uamor |= 3ul << pkeyshift(pkey1) |
>  				3ul << pkeyshift(pkey2);

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

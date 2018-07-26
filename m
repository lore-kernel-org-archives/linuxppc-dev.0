Return-Path: <srs0=qs/o=kk=linux.vnet.ibm.com=gromero@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsWC0FQWzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:54:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41bsWB6PJFz8tRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:54:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41bsWB2Kftz9ryl
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2018 22:54:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6QCsbg8036689
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2018 08:54:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kfe31hqq7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2018 08:54:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Thu, 26 Jul 2018 06:54:41 -0600
Subject: Re: [PATCH 2/3] selftests/powerpc: Only run some tests on ppc64le
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20180726122459.9293-1-mpe@ellerman.id.au>
 <20180726122459.9293-2-mpe@ellerman.id.au>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Thu, 26 Jul 2018 09:54:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180726122459.9293-2-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6f71e169-7d73-9128-5cff-72efcf734e7d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 07/26/2018 09:24 AM, Michael Ellerman wrote:
> These tests are currently failing on (some) big endian systems. Until
> we can fix that, skip them unless we're on ppc64le.

I can take a look at this.

Is that the same issue related to the gcc version we discussed a month ago?
If not, could you provide the crash logs as a starting point?
  

Thanks,
Gustavo

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/powerpc/tm/tm-sigreturn.c | 1 +
>   tools/testing/selftests/powerpc/tm/tm-tar.c       | 1 +
>   tools/testing/selftests/powerpc/tm/tm-vmxcopy.c   | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> index 85d63449243b..9a6017a1d769 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> @@ -55,6 +55,7 @@ int tm_sigreturn(void)
>   	uint64_t ret = 0;
> 
>   	SKIP_IF(!have_htm());
> +	SKIP_IF(!is_ppc64le());
> 
>   	memset(&sa, 0, sizeof(sa));
>   	sa.sa_handler = handler;
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
> index 2d2fcc2b7a60..f31fe5a28ddb 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-tar.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
> @@ -26,6 +26,7 @@ int test_tar(void)
>   	int i;
> 
>   	SKIP_IF(!have_htm());
> +	SKIP_IF(!is_ppc64le());
> 
>   	for (i = 0; i < num_loops; i++)
>   	{
> diff --git a/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
> index 0274de7b11f3..fe52811584ae 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
> @@ -46,6 +46,7 @@ int test_vmxcopy()
>   	uint64_t aborted = 0;
> 
>   	SKIP_IF(!have_htm());
> +	SKIP_IF(!is_ppc64le());
> 
>   	fd = mkstemp(tmpfile);
>   	assert(fd >= 0);
> 

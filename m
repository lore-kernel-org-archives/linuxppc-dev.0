Return-Path: <srs0=zceb=fu=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqTWQ1MCczF1Kv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 15:34:42 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zqTWP6ZDqz8t46
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 15:34:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zqTWP0zMSz9s21
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2018 15:34:40 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1Q4YZLg068590
 for <linuxppc-dev@ozlabs.org>; Sun, 25 Feb 2018 23:34:39 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gc9y4a5ds-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 25 Feb 2018 23:34:37 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 04:33:26 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: khandual@linux.vnet.ibm.com
Subject: Re: [PATCH] selftests/powerpc: Skip the subpage_prot tests if the
 syscall is disabled
In-Reply-To: <20180226042510.13373-1-mpe@ellerman.id.au>
References: <20180226042510.13373-1-mpe@ellerman.id.au>
Date: Mon, 26 Feb 2018 10:03:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d10sz7xr.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The subpage_prot syscall is only functional when the system is using
> the Hash MMU. Since commit 5b2b80714796 ("powerpc/mm: Invalidate
> subpage_prot() system call on radix platforms") it returns ENOENT when
> the Radix MMU is active. Currently this just makes the test fail.
>
> Instead check explicitly for ENOENT and skip if we see that.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Fixes: 5b2b80714796 ("powerpc/mm: Invalidate subpage_prot() system call on radix platforms")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/powerpc/mm/subpage_prot.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
> index 35ade7406dcd..81570680e7ea 100644
> --- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
> @@ -135,6 +135,15 @@ static int run_test(void *addr, unsigned long size)
>  	return 0;
>  }
>
> +static int syscall_available(void)
> +{
> +	int rc;
> +
> +	errno = 0;
> +	rc = syscall(__NR_subpage_prot, 0, 0, 0);
> +	return rc == 0 || errno != ENOENT;
> +}
> +
>  int test_anon(void)
>  {
>  	unsigned long align;
> @@ -145,6 +154,8 @@ int test_anon(void)
>  	void *mallocblock;
>  	unsigned long mallocsize;
>
> +	SKIP_IF(!syscall_available());
> +
>  	if (getpagesize() != 0x10000) {
>  		fprintf(stderr, "Kernel page size must be 64K!\n");
>  		return 1;
> @@ -180,6 +191,8 @@ int test_file(void)
>  	off_t filesize;
>  	int fd;
>
> +	SKIP_IF(!syscall_available());
> +
>  	fd = open(file_name, O_RDWR);
>  	if (fd == -1) {
>  		perror("failed to open file");
> -- 
> 2.14.1

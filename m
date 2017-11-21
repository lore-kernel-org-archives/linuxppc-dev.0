Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh5Dx6PTYzDr8h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 23:56:17 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vALCt1GH090641
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 07:56:15 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eckk1vgph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 07:56:14 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Tue, 21 Nov 2017 05:56:13 -0700
Subject: Re: [PATCH 1/2] selftests/powerpc: Check for pthread errors in
 tm-unavailable
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171121071720.24619-1-cyrilbur@gmail.com>
Cc: leitao@debian.org
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 10:56:08 -0200
MIME-Version: 1.0
In-Reply-To: <20171121071720.24619-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5A142268.1030303@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

Thanks for adding the checks!

On 21-11-2017 05:17, Cyril Bur wrote:
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Cheers,
Gustavo

> ---
>  .../testing/selftests/powerpc/tm/tm-unavailable.c  | 43 +++++++++++++++++-----
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> index 96c37f84ce54..e6a0fad2bfd0 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> @@ -15,6 +15,7 @@
>   */
> 
>  #define _GNU_SOURCE
> +#include <error.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -33,6 +34,11 @@
>  #define VSX_UNA_EXCEPTION	2
> 
>  #define NUM_EXCEPTIONS		3
> +#define err_at_line(status, errnum, format, ...) \
> +	error_at_line(status, errnum,  __FILE__, __LINE__, format ##__VA_ARGS__)
> +
> +#define pr_warn(code, format, ...) err_at_line(0, code, format, ##__VA_ARGS__)
> +#define pr_err(code, format, ...) err_at_line(1, code, format, ##__VA_ARGS__)
> 
>  struct Flags {
>  	int touch_fp;
> @@ -303,10 +309,19 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
>  	 * checking if the failure cause is the one we expect.
>  	 */
>  	do {
> +		int rc;
> +
>  		/* Bind 'ping' to CPU 0, as specified in 'attr'. */
> -		pthread_create(&t0, attr, ping, (void *) &flags);
> -		pthread_setname_np(t0, "ping");
> -		pthread_join(t0, &ret_value);
> +		rc = pthread_create(&t0, attr, ping, (void *) &flags);
> +		if (rc)
> +			pr_err(rc, "pthread_create()");
> +		rc = pthread_setname_np(t0, "ping");
> +		if (rc)
> +			pr_warn(rc, "pthread_setname_np");
> +		rc = pthread_join(t0, &ret_value);
> +		if (rc)
> +			pr_err(rc, "pthread_join");
> +
>  		retries--;
>  	} while (ret_value != NULL && retries);
> 
> @@ -320,7 +335,7 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
> 
>  int main(int argc, char **argv)
>  {
> -	int exception; /* FP = 0, VEC = 1, VSX = 2 */
> +	int rc, exception; /* FP = 0, VEC = 1, VSX = 2 */
>  	pthread_t t1;
>  	pthread_attr_t attr;
>  	cpu_set_t cpuset;
> @@ -330,13 +345,23 @@ int main(int argc, char **argv)
>  	CPU_SET(0, &cpuset);
> 
>  	/* Init pthread attribute. */
> -	pthread_attr_init(&attr);
> +	rc = pthread_attr_init(&attr);
> +	if (rc)
> +		pr_err(rc, "pthread_attr_init()");
> 
>  	/* Set CPU 0 mask into the pthread attribute. */
> -	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
> -
> -	pthread_create(&t1, &attr /* Bind 'pong' to CPU 0 */, pong, NULL);
> -	pthread_setname_np(t1, "pong"); /* Name it for systemtap convenience */
> +	rc = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
> +	if (rc)
> +		pr_err(rc, "pthread_attr_setaffinity_np()");
> +
> +	rc = pthread_create(&t1, &attr /* Bind 'pong' to CPU 0 */, pong, NULL);
> +	if (rc)
> +		pr_err(rc, "pthread_create()");
> +
> +	/* Name it for systemtap convenience */
> +	rc = pthread_setname_np(t1, "pong");
> +	if (rc)
> +		pr_warn(rc, "pthread_create()");
> 
>  	flags.result = 0;
> 

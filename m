Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A75E61A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 08:23:36 +1000 (AEST)
In-Reply-To: <1442988302.31273.81.camel@neuling.org>
References: <1442988302.31273.81.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 24 Sep 2015 08:23:35 +1000
To: Michael Neuling <mikey@neuling.org>,benh <benh@kernel.crashing.org>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Aaron Sawdey <sawdey@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>
Message-ID: <8B86AA57-EFAD-4D4E-860A-8F8251DF10AD@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23 September 2015 16:05:02 GMT+10:00, Michael Neuling <mikey@neuling.org> wrote:
>The 32 and 64 bit variants of __get_datapage() use a "bcl; mflr" to
>determine the loaded address of the VDSO. The current version of these
>attempt to use the special bcl variant which avoids pushing to the
>link stack.
>
>Unfortunately it uses bcl+8 rather than the required bcl+4. Hence the
>current code results in link stack corruption and the resulting
>performance degradation (due to branch mis-prediction).
>
>This patch moves us to bcl+4 by moving __kernel_datapage_offset
>out of __get_datapage().
>
>With this patch, running the below benchmark we get a bump in
>performance on POWER8 for gettimeofday() (which uses
>__get_datapage()).
>
>64bit gets ~4% improvement:
>  Without patch:
>    # ./tb
>    time = 0.180321
>  With patch:
>    # ./tb
>    time = 0.187408
>
>32bit gets ~9% improvement:
>  Without patch:
>    # ./tb
>    time = 0.276551
>  With patch:
>    # ./tb
>    time = 0.252767
>
>Testcase tb.c (stolen from Anton)
>  /* gcc -O2 tb.c -o tb */
>  #include <sys/time.h>
>  #include <stdio.h>
>
>  int main()
>  {
>	  int i;
>
>	  struct timeval tv_start, tv_end;
>
>	  gettimeofday(&tv_start, NULL);
>
>	  for(i = 0; i < 10000000; i++) {
>		  gettimeofday(&tv_end, NULL);
>	  }
>
>	  printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec +
>(tv_end.tv_usec - tv_start.tv_usec) * 1e-6);
>
>	  return 0;
>  }

You know where test cases are supposed to go.

I know it's not a pass/fail test, but it's still useful. If it's in the tree it will get run as part of automated test runs and we will have a record of the result over time.

cheers
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

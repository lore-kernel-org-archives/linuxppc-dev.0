Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f195.google.com (mail-yk0-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 153E81A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 20:10:45 +1000 (AEST)
Received: by ykdg206 with SMTP id g206so5849569ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 03:10:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8B86AA57-EFAD-4D4E-860A-8F8251DF10AD@ellerman.id.au>
References: <1442988302.31273.81.camel@neuling.org>
 <8B86AA57-EFAD-4D4E-860A-8F8251DF10AD@ellerman.id.au>
Date: Thu, 24 Sep 2015 13:10:42 +0300
Message-ID: <CAOJe8K20scaHxV50KmzsFGA7uTGZdq7MTkeDCdraG0350gvLeQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, benh <benh@kernel.crashing.org>,
 Aaron Sawdey <sawdey@us.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/24/15, Michael Ellerman <michael@ellerman.id.au> wrote:
>
>
> On 23 September 2015 16:05:02 GMT+10:00, Michael Neuling <mikey@neuling.org>
> wrote:
>>The 32 and 64 bit variants of __get_datapage() use a "bcl; mflr" to
>>determine the loaded address of the VDSO. The current version of these
>>attempt to use the special bcl variant which avoids pushing to the
>>link stack.
>>
>>Unfortunately it uses bcl+8 rather than the required bcl+4. Hence the
>>current code results in link stack corruption and the resulting
>>performance degradation (due to branch mis-prediction).
>>
>>This patch moves us to bcl+4 by moving __kernel_datapage_offset
>>out of __get_datapage().
>>
>>With this patch, running the below benchmark we get a bump in
>>performance on POWER8 for gettimeofday() (which uses
>>__get_datapage()).
>>
>>64bit gets ~4% improvement:
>>  Without patch:
>>    # ./tb
>>    time = 0.180321
>>  With patch:
>>    # ./tb
>>    time = 0.187408
>>
>>32bit gets ~9% improvement:
>>  Without patch:
>>    # ./tb
>>    time = 0.276551
>>  With patch:
>>    # ./tb
>>    time = 0.252767
>>
>>Testcase tb.c (stolen from Anton)
>>  /* gcc -O2 tb.c -o tb */
>>  #include <sys/time.h>
>>  #include <stdio.h>
>>
>>  int main()
>>  {
>>	  int i;
>>
>>	  struct timeval tv_start, tv_end;
>>
>>	  gettimeofday(&tv_start, NULL);
>>
>>	  for(i = 0; i < 10000000; i++) {
>>		  gettimeofday(&tv_end, NULL);
>>	  }
>>
>>	  printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec +
>>(tv_end.tv_usec - tv_start.tv_usec) * 1e-6);
>>
>>	  return 0;
>>  }
>
> You know where test cases are supposed to go.
>
> I know it's not a pass/fail test, but it's still useful. If it's in the tree
> it will get run as part of automated test runs and we will have a record of
> the result over time.

I can send a patch for it.

>
> cheers
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

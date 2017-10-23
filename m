Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLXyT0TfXzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 10:42:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NNfdlM005328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:42:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dst4p0ckn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:42:54 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 17:42:53 -0600
Date: Mon, 23 Oct 2017 16:42:46 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org, paulus@samba.org,
 ebiederm@xmission.com, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
 <1505376837.12628.192.camel@kernel.crashing.org>
 <87y3o28cv7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3o28cv7.fsf@linux.vnet.ibm.com>
Message-Id: <20171023234246.GA5485@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 23, 2017 at 02:22:44PM +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Fri, 2017-09-08 at 15:44 -0700, Ram Pai wrote:
> >> The second part of the PTE will hold
> >> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> >> NOTE: None of the bits in the secondary PTE were not used
> >> by 64k-HPTE backed PTE.
> >
> > Have you measured the performance impact of this ? The second part of
> > the PTE being in a different cache line there could be one...
> >
> 
> I am also looking at a patch series removing the slot tracking
> completely. With randomize address turned off and no swap in guest/host
> and making sure we touched most of guest ram, I don't find much impact
> in performance when we don't track the slot at all. I will post the
> patch series with numbers in a day or two. But my test was
> 
> while (5000) {
>       mmap(128M)
>       touch every page of 2048 pages
>       munmap()
> }
> 
> I could also be the best case in my run because i might have always
> found the hash pte slot in the primary. In one measurement with swap on
> and address randmization enabled, i did find a 50% impact. But then i
> was not able to recreate that again. So could be something i did wrong
> in the test setup.
> 
> Ram,
> 
> Will you be able to get a test run with the above loop?

Yes. results with patch look good; better than w/o patch.


/-----------------------------------------------\
|Itteratn| secs w/ patch	|secs w/o patch |
-------------------------------------------------
|1	 | 45.572621     	| 49.046994	|
|2	 | 46.049545     	| 49.378756	|
|3	 | 46.103657     	| 49.223591	|
|4	 | 46.298903     	| 48.991245	|
|5	 | 46.353202     	| 48.988033	|
|6	 | 45.440878     	| 49.175846	|
|7	 | 46.860373     	| 49.008395	|
|8	 | 46.221390     	| 49.236964	|
|9	 | 45.794993     	| 49.171927	|
|10	 | 46.569491     	| 48.995628	|
|-----------------------------------------------|
|average  | 46.1265053		| 49.1217379    |
\-----------------------------------------------/


The code is as follows:


diff --git a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
index 8d084a2..ef2ad87 100644
--- a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
+++ b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
@@ -10,14 +10,14 @@
 
 #include "utils.h"
 
-#define ITERATIONS 5000000
+#define ITERATIONS 5000
 
 #define MEMSIZE (128 * 1024 * 1024)
 
 int test_mmap(void)
 {
 	struct timespec ts_start, ts_end;
-	unsigned long i = ITERATIONS;
+	unsigned long i = ITERATIONS, j;
 
 	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
@@ -25,6 +25,10 @@ int test_mmap(void)
 		char *c = mmap(NULL, MEMSIZE, PROT_READ|PROT_WRITE,
 			       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
 		FAIL_IF(c == MAP_FAILED);
+
+		for (j=0; j < (MEMSIZE >> 16); j++)
+			c[j<<16] = 0xf;
+
 		munmap(c, MEMSIZE);
 	}
 

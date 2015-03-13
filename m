Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94FE91A0371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 12:06:05 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 12 Mar 2015 19:06:03 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8C8BAC40002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 18:57:12 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D160jT37093392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 18:06:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D15xUp025243
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 19:05:59 -0600
Date: Thu, 12 Mar 2015 18:05:57 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: new decimal conversion - seeking testers
Message-ID: <20150313010557.GA23117@linux.vnet.ibm.com>
References: <87fv99x17k.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fv99x17k.fsf@rasmusvillemoes.dk>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.03.2015 [00:09:19 +0100], Rasmus Villemoes wrote:
> Hi,
> 
> I've proposed a new implementation of decimal conversion for
> lib/vsprintf.c; see
> <http://thread.gmane.org/gmane.linux.kernel/1892035/focus=1905478>.
> Benchmarking so far shows 25-50% (depending on distribution of input
> numbers) improvement on x86_64 and 10-30% on various 32 bit platforms.
> 
> Since the new code plays a little endianness game I would really
> appreciate it if someone here would run the test and verification code
> on ppc.
> 
> The code is on github, https://github.com/Villemoes/dec, and it should
> be as simple as
> 
>    git clone https://github.com/Villemoes/dec.git
>    cd dec
>    make
>    ./test   # benchmark
>    ./verify # correctness
> 
> though I can't blame you if you want to inspect the code before
> compiling and running something some stranger asks you to download :-)
> See also the README file.
> 
> If 'make' doesn't work out-of-the-box, I'd also like to hear from you.

On a ppc64le box:

./test 
Distribution              Function         nsecs/conv   Conv/1 sec      
uniform([10, 2^64-1])     linux_put_dec           56.04         17785895
uniform([10, 2^64-1])     rv_put_dec              31.97         31190888
                          +/-                   -42.94%          +75.37%
3 + neg_binom(0.05)       linux_put_dec           29.55         32986465
3 + neg_binom(0.05)       rv_put_dec              24.61         39416630
                          +/-                   -16.71%          +19.49%
3 + neg_binom(0.10)       linux_put_dec           22.16         43993836
3 + neg_binom(0.10)       rv_put_dec              18.76         50767222
                          +/-                   -15.34%          +15.40%
3 + neg_binom(0.15)       linux_put_dec           18.97         51272565
3 + neg_binom(0.15)       rv_put_dec              16.18         58328176
                          +/-                   -14.70%          +13.76%
3 + neg_binom(0.20)       linux_put_dec           16.79         57792783
3 + neg_binom(0.20)       rv_put_dec              14.03         66418077
                          +/-                   -16.45%          +14.92%
3 + neg_binom(0.50)       linux_put_dec           10.81         89762669
3 + neg_binom(0.50)       rv_put_dec               9.40        104336963
                          +/-                   -13.08%          +16.24%

./verify 
Using 16 threads
Checking [10, 10000000000] and [18446744063709551615,
18446744073709551615]
Thread 9: low range ok
Thread 13: low range ok
Thread 10: low range ok
Thread 15: low range ok
Thread 7: low range ok
Thread 5: low range ok
Thread 14: low range ok
Thread 0: low range ok
Thread 3: low range ok
Thread 1: low range ok
Thread 2: low range ok
Thread 4: low range ok
Thread 8: low range ok
Thread 12: low range ok
Thread 6: low range ok
Thread 11: low range ok
Thread 9: high range ok
Thread 10: high range ok
Thread 7: high range ok
Thread 13: high range ok
Thread 0: high range ok
Thread 14: high range ok
Thread 15: high range ok
Thread 5: high range ok
Thread 1: high range ok
Thread 8: high range ok
Thread 11: high range ok
Thread 6: high range ok
Thread 2: high range ok
Thread 12: high range ok
Thread 3: high range ok
Thread 4: high range ok
Thread 9: mid range ok
Thread 0: mid range ok
Thread 14: mid range ok
Thread 7: mid range ok
Thread 10: mid range ok
Thread 8: mid range ok
Thread 2: mid range ok
Thread 11: mid range ok
Thread 13: mid range ok
Thread 1: mid range ok
Thread 6: mid range ok
Thread 15: mid range ok
Thread 5: mid range ok
Thread 4: mid range ok
Thread 3: mid range ok
Thread 12: mid range ok
Distribution of lengths checked:
1	5
2	101
3	900
4	9000
5	90000
6	900000
7	9000000
8	90000000
9	900000000
10	9000000000
11	81
12	848
13	8384
14	83808
15	838192
16	8381904
17	83819040
18	838190304
19	8381903184
20	17866643425

On a ppc64 box:

./test 
Distribution              Function         nsecs/conv   Conv/1 sec      
uniform([10, 2^64-1])     linux_put_dec           48.97         20478528
uniform([10, 2^64-1])     rv_put_dec              32.14         31915074
                          +/-                   -34.37%          +55.85%
3 + neg_binom(0.05)       linux_put_dec           25.60         38732189
3 + neg_binom(0.05)       rv_put_dec              20.18         48828445
                          +/-                   -21.18%          +26.07%
3 + neg_binom(0.10)       linux_put_dec           18.70         52648284
3 + neg_binom(0.10)       rv_put_dec              15.60         62915143
                          +/-                   -16.56%          +19.50%
3 + neg_binom(0.15)       linux_put_dec           15.27         64695363
3 + neg_binom(0.15)       rv_put_dec              13.34         73279482
                          +/-                   -12.62%          +13.27%
3 + neg_binom(0.20)       linux_put_dec           13.25         74240237
3 + neg_binom(0.20)       rv_put_dec              11.52         83711009
                          +/-                   -13.04%          +12.76%
3 + neg_binom(0.50)       linux_put_dec            9.14        106966472
3 + neg_binom(0.50)       rv_put_dec               7.59        126799499
                          +/-                   -16.92%          +18.54%
./verify 
Using 12 threads
Checking [10, 10000000000] and [18446744063709551615,
18446744073709551615]
Thread 5: low range ok
Thread 10: low range ok
Thread 0: low range ok
Thread 4: low range ok
Thread 1: low range ok
Thread 2: low range ok
Thread 7: low range ok
Thread 8: low range ok
Thread 3: low range ok
Thread 9: low range ok
Thread 11: low range ok
Thread 6: low range ok
Thread 5: high range ok
Thread 10: high range ok
Thread 0: high range ok
Thread 7: high range ok
Thread 2: high range ok
Thread 4: high range ok
Thread 1: high range ok
Thread 8: high range ok
Thread 3: high range ok
Thread 9: high range ok
Thread 11: high range ok
Thread 6: high range ok
Thread 0: mid range ok
Thread 11: mid range ok
Thread 10: mid range ok
Thread 7: mid range ok
Thread 2: mid range ok
Thread 3: mid range ok
Thread 5: mid range ok
Thread 8: mid range ok
Thread 4: mid range ok
Thread 6: mid range ok
Thread 1: mid range ok
Thread 9: mid range ok
Distribution of lengths checked:
1	5
2	97
3	900
4	9000
5	90000
6	900000
7	9000000
8	90000000
9	900000000
10	9000000000
11	61
12	636
13	6288
14	62856
15	628644
16	6286428
17	62864280
18	628642728
19	6286427388
20	15899982569

-Nish

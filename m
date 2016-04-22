Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qs4Nf4TF8zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 04:47:13 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Sat, 23 Apr 2016 03:36:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3135A3578053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 03:36:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MHaavQ8061234
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 03:36:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MHZwEM005743
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 03:35:58 +1000
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
To: Stewart Smith <stewart@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87vb3dmep8.fsf@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com
Message-ID: <571A60EB.5030603@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2016 23:05:39 +0530
MIME-Version: 1.0
In-Reply-To: <87vb3dmep8.fsf@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------080902020909030002000208"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080902020909030002000208
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stewart,

On 04/20/2016 03:41 AM, Stewart Smith wrote:
> Akshay Adiga<akshay.adiga@linux.vnet.ibm.com>  writes:
>> Iozone results show fairly consistent performance boost.
>> YCSB on redis shows improved Max latencies in most cases.
> What about power consumption?
>
>> Iozone write/rewite test were made with filesizes 200704Kb and 401408Kb
>> with different record sizes . The following table shows IOoperations/sec
>> with and without patch.
>> Iozone Results ( in op/sec) ( mean over 3 iterations )
> What's the variance between runs?

Re-Ran Iozone test

w/o : without patch,  w : with patch , stdev : standard deviation , avg ; average

Iozone Results for ReWrite
+----------+--------+-----------+------------+-----------+-----------+---------+
| filesize | reclen |  w/o(avg) | w/o(stdev) |   w(avg)  |  w(stdev) | change% |
+----------+--------+-----------+------------+-----------+-----------+---------+
|  200704  |   1    |  795070.4 |  5813.51   |  805127.8 |  16872.59 |  1.264  |
|  200704  |   2    | 1448973.8 |  23058.79  | 1472098.8 |  18062.73 |  1.595  |
|  200704  |   4    |  2413444  |  85988.09  | 2562535.8 |  48649.35 |  6.177  |
|  200704  |   8    |  3827453  |  87710.52  | 3846888.2 |  86438.51 |  0.507  |
|  200704  |   16   | 5276096.8 |  73208.19  | 5425961.6 | 170774.75 |  2.840  |
|  200704  |   32   | 6742930.6 |  22789.45  | 6848904.4 | 257768.84 |  1.571  |
|  200704  |   64   | 7059479.2 | 300725.26  |  7373635  | 285106.90 |  4.450  |
|  200704  |  128   | 7097647.2 | 408171.71  |  7716500  | 266139.68 |  8.719  |
|  200704  |  256   |  6710810  | 314594.13  | 7661752.6 | 454049.27 |  14.170 |
|  200704  |  512   | 7034675.4 | 516152.97  | 7378583.2 | 613617.57 |  4.888  |
|  200704  |  1024  | 6265317.2 | 446101.38  | 7540629.6 | 294865.20 |  20.355 |
|  401408  |   1    |  802233.2 |  4263.92   |   817507  |  17727.09 |  1.903  |
|  401408  |   2    | 1461892.8 |  53678.12  |  1482872  |  45670.30 |  1.435  |
|  401408  |   4    | 2629686.8 |  24365.33  | 2673196.2 |  41576.78 |  1.654  |
|  401408  |   8    | 4156353.8 |  70636.85  | 4149330.4 |  56521.84 |  -0.168 |
|  401408  |   16   |  5895437  |  63762.43  | 5924167.4 | 396311.75 |  0.487  |
|  401408  |   32   | 7330826.6 | 167080.53  | 7785889.2 | 245434.99 |  6.207  |
|  401408  |   64   | 8298555.2 | 328890.89  | 8482416.8 | 249698.02 |  2.215  |
|  401408  |  128   | 8241108.6 | 490560.96  |  8686478  | 224816.21 |  5.404  |
|  401408  |  256   | 8038080.6 | 327704.66  | 8372327.4 | 210978.18 |  4.158  |
|  401408  |  512   | 8229523.4 | 371701.73  | 8654695.2 | 296715.07 |  5.166  |
+----------+--------+-----------+------------+-----------+-----------+---------+

Iozone results for Write
+----------+--------+-----------+------------+-----------+------------+---------+
| filesize | reclen |  w/o(avg) | w/o(stdev) |   w(avg)  |  w(stdev)  | change% |
+----------+--------+-----------+------------+-----------+------------+---------+
|  200704  |   1    |   575825  |  7,876.69  |  569388.4 |  6,699.59  |  -1.12  |
|  200704  |   2    | 1061229.4 |  7,589.50  | 1045193.2 | 19,785.85  |  -1.51  |
|  200704  |   4    |  1808329  | 13,040.67  | 1798138.4 | 50,367.19  |  -0.56  |
|  200704  |   8    | 2822953.4 | 19,948.89  | 2830305.6 | 21,202.77  |   0.26  |
|  200704  |   16   |  3976987  | 62,201.72  | 3909063.8 | 268,640.51 |  -1.71  |
|  200704  |   32   | 4959358.2 | 112,052.99 |  4760303  | 330,343.73 |  -4.01  |
|  200704  |   64   | 5452454.6 | 628,078.72 | 5692265.6 | 190,562.91 |   4.40  |
|  200704  |  128   | 5645246.8 | 10,455.85  | 5653330.2 | 18,153.76  |   0.14  |
|  200704  |  256   | 5855897.2 | 184,854.25 |  5402069  | 538,523.04 |  -7.75  |
|  200704  |  512   |  5515904  | 326,198.86 | 5639976.4 |  8,480.46  |   2.25  |
|  200704  |  1024  | 5471718.2 | 415,179.15 | 5399414.6 | 686,124.50 |  -1.32  |
|  401408  |   1    |  584786.6 |  1,256.59  |  587237.2 |  6,552.55  |   0.42  |
|  401408  |   2    | 1047018.8 | 26,567.72  | 1040926.8 | 16,495.93  |  -0.58  |
|  401408  |   4    | 1815465.8 | 16,426.92  | 1773652.6 | 38,169.02  |  -2.30  |
|  401408  |   8    |  2814285  | 27,374.53  |  2756608  | 96,689.13  |  -2.05  |
|  401408  |   16   |  3931646  | 129,648.79 | 3805793.4 | 141,368.40 |  -3.20  |
|  401408  |   32   | 4875353.4 | 146,203.70 |  4884084  | 265,484.01 |   0.18  |
|  401408  |   64   | 5479805.8 | 349,995.36 | 5565292.2 | 20,645.45  |   1.56  |
|  401408  |  128   |  5598486  | 195,680.23 |  5645125  | 62,017.38  |   0.83  |
|  401408  |  256   |  5803148  | 328,683.02 |  5657215  | 20,579.28  |  -2.51  |
|  401408  |  512   | 5565091.4 | 166,123.57 | 5725974.4 | 169,506.29 |   2.89  |
+----------+--------+-----------+------------+-----------+------------+---------+

>> Tested with YCSB workload (50% update + 50% read) over redis for 1 million
>> records and 1 million operation. Each test was carried out with target
>> operations per second and persistence disabled.
>>
>> Max-latency (in us)( mean over 5 iterations )
> What's the variance between runs?
>
> std dev? 95th percentile?
>
>> ---------------------------------------------------------------
>> op/s    Operation       with patch      without patch   %change
>> ---------------------------------------------------------------
>> 15000   Read            61480.6         50261.4         22.32
> This seems fairly significant regression. Any idea why at 15K op/s
> there's such a regression?

Just Re-Ran the test for power numbers.
Results for YCSB+Redis test.
P95 : 95 Percentile
P99 : 99 Percentile

Power numbers are taken for one run of YCSB+redis test which has 50% Read + 50% Update.
Maximum Latency has clearly gone down for all cases will less than 5% increase in power.


+------------+----------+--------+------------+---------+---------+----------------+
|   Op/sec   | Testcase | AvgLat |   MaxLat   |   P95   |   P99   |     Power      |
+------------+----------+--------+------------+---------+---------+----------------+
|   15000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  |  51.8  |  127903.0  |   55.8  |  145.2  |     602.7      |
| w/o patch  |  StdDev  | 5.692  | 105355.497 |  11.232 |   2.04  |      5.11      |
| with patch | Average  | 53.28  |  30834.2   |   72.2  |  151.2  |     629.01     |
| with patch |  StdDev  | 2.348  |  8928.323  |  15.74  |  3.544  |      3.25      |
|     -      |*Change% | 2.86 | -75.89 | 29.39 | 4.13 | 4.36535589846*   |
|   25000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 53.78  |  123743.0  |   85.4  |  152.2  |     617.95     |
| w/o patch  |  StdDev  | 4.593  |  80224.53  |  5.886  |   4.49  |      1.32      |
| with patch | Average  | 49.65  |  84101.4   |   84.2  |  154.4  |     651.64     |
| with patch |  StdDev  | 1.658  | 72656.042  |  4.261  |  2.332  |      8.76      |
|     -      |*Change% | -7.68 | -32.04 | -1.41 | 1.45 | 5.4518974027 *  |
|   35000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 56.07  |  57391.0   |   93.0  |  147.6  |     636.39     |
| w/o patch  |  StdDev  | 1.391  | 34494.839  |  1.789  |  2.871  |      2.92      |
| with patch | Average  | 56.46  |  39634.2   |   95.0  |  149.2  |     653.44     |
| with patch |  StdDev  | 3.174  |  6089.848  |  3.347  |   3.37  |      4.4       |
|     -      |*Change% | 0.69 | -30.94 | 2.15 | 1.08 | 2.6791747199 *  |
|   40000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  |  58.6  |  80427.8   |   97.2  |  147.4  |     636.85     |
| w/o patch  |  StdDev  | 1.105  | 59327.584  |  0.748  |  2.498  |      1.51      |
| with patch | Average  | 58.76  |  45291.8   |   97.2  |  149.0  |     656.12     |
| with patch |  StdDev  | 1.675  | 10486.954  |  2.482  |  3.406  |      6.97      |
|     -      |*Change% | 0.27 | -43.69 | 0.0 | 1.09 | 3.0258302583*   |
|   45000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 69.02  |  120027.8  |  102.6  |  149.6  |     640.68     |
| w/o patch  |  StdDev  |  0.74  | 96288.811  |  1.855  |  1.497  |      7.65      |
| with patch | Average  | 69.65  |  98024.6   |  102.0  |  147.8  |     653.09     |
| with patch |  StdDev  |  1.14  | 78041.439  |   2.28  |  1.939  |      3.91      |
|     -*| Change% | 0.92 | -18.33 | -0.58 | -1.2 | 1.93700443279*   |
|   15000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 48.144 |  86847.0   |   52.4  |  189.2  |     602.7      |
| w/o patch  |  StdDev  | 5.971  | 41580.919  |  16.427 |  8.376  |      5.11      |
| with patch | Average  | 47.964 |  31106.2   |   58.4  |  182.2  |     629.01     |
| with patch |  StdDev  | 3.003  |  4906.179  |  7.088  |  6.177  |      3.25      |
|     -      |*Change% | -0.37 | -64.18 | 11.45 | -3.7 | -3.69978858351*  |
|   25000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 51.856 |  102808.6  |   87.0  |  182.4  |     617.95     |
| w/o patch  |  StdDev  | 5.721  | 79308.823  |  4.899  |  7.965  |      1.32      |
| with patch | Average  | 46.07  |  74623.0   |   86.2  |  183.0  |     651.64     |
| with patch |  StdDev  | 1.779  | 77511.229  |  4.069  |  7.014  |      8.76      |
|     -      |*Change% | -11.16 | -27.42 | -0.92 | 0.33 | 0.328947368421*  |
|   35000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 54.142 |  51074.2   |   93.6  |  181.8  |     636.39     |
| w/o patch  |  StdDev  | 1.671  | 36877.588  |  1.497  |  8.035  |      2.92      |
| with patch | Average  | 54.034 |  44731.8   |   94.4  |  184.4  |     653.44     |
| with patch |  StdDev  | 3.363  |  13400.4   |   1.02  |  7.172  |      4.4       |
|     -      |*Change% | -0.2 | -12.42 | 0.85 | 1.43 | 1.4301430143*   |
|   40000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 57.528 |  71672.6   |   98.4  |  184.8  |     636.85     |
| w/o patch  |  StdDev  | 1.111  | 63103.862  |  1.744  |  9.282  |      1.51      |
| with patch | Average  | 57.738 |  32101.4   |   98.0  |  186.4  |     656.12     |
| with patch |  StdDev  | 1.294  |  4481.801  |  1.673  |   7.71  |      6.97      |
|     -      |*Change% | 0.37 | -55.21 | -0.41 | 0.87 | 0.865800865801 *|
|   45000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 69.97  |  117183.0  |  105.4  |  182.4  |     640.68     |
| w/o patch  |  StdDev  | 0.925  | 99836.076  |   1.2   |  9.091  |      7.65      |
| with patch | Average  | 70.508 |  104175.0  |  103.2  |  185.4  |     653.09     |
| with patch |  StdDev  | 1.463  |  74438.13  |   1.47  |  7.915  |      3.91      |
|     -      |*Change% | 0.77 | -11.1 | -2.09 | 1.64 | 1.64473684211 *|
+------------+----------+--------+------------+---------+---------+----------------+

>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -36,12 +36,56 @@
>>   #include <asm/reg.h>
>>   #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>>   #include <asm/opal.h>
>> +#include <linux/timer.h>
>>   
>>   #define POWERNV_MAX_PSTATES	256
>>   #define PMSR_PSAFE_ENABLE	(1UL << 30)
>>   #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>>   #define PMSR_MAX(x)		((x >> 32) & 0xFF)
>>   
>> +#define MAX_RAMP_DOWN_TIME				5120
>> +/*
>> + * On an idle system we want the global pstate to ramp-down from max value to
>> + * min over a span of ~5 secs. Also we want it to initially ramp-down slowly and
>> + * then ramp-down rapidly later on.
> Where does 5 seconds come from?
>
> Why 5 and not 10, or not 2? Is there some time period inherit in
> hardware or software that this is computed from?

  As global pstates are per-chip and there are max 12 cores, so if the system is really
  idle, considering 5 seconds for each cores, it should take 60 seconds for the chip to
  go to pmin.

>> +/* Interval after which the timer is queued to bring down global pstate */
>> +#define GPSTATE_TIMER_INTERVAL				2000
> in ms?

Yes its 2000 ms.



--------------080902020909030002000208
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre>Hi Stewart,

</pre>
    On 04/20/2016 03:41 AM, Stewart Smith wrote:<br>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">Akshay Adiga <a class="moz-txt-link-rfc2396E" href="mailto:akshay.adiga@linux.vnet.ibm.com">&lt;akshay.adiga@linux.vnet.ibm.com&gt;</a> writes:
</pre>
      <blockquote type="cite">
        <pre wrap="">Iozone results show fairly consistent performance boost.
YCSB on redis shows improved Max latencies in most cases.
</pre>
      </blockquote>
      <pre wrap="">What about power consumption?

</pre>
      <blockquote type="cite">
        <pre wrap="">Iozone write/rewite test were made with filesizes 200704Kb and 401408Kb
with different record sizes . The following table shows IOoperations/sec
with and without patch.
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">Iozone Results ( in op/sec) ( mean over 3 iterations )
</pre>
      </blockquote>
      <pre wrap="">What's the variance between runs?
</pre>
    </blockquote>
    <pre>Re-Ran Iozone test

w/o : without patch,  w : with patch , stdev : standard deviation , avg ; average 

Iozone Results for ReWrite
+----------+--------+-----------+------------+-----------+-----------+---------+
| filesize | reclen |  w/o(avg) | w/o(stdev) |   w(avg)  |  w(stdev) | change% |
+----------+--------+-----------+------------+-----------+-----------+---------+
|  200704  |   1    |  795070.4 |  5813.51   |  805127.8 |  16872.59 |  1.264  |
|  200704  |   2    | 1448973.8 |  23058.79  | 1472098.8 |  18062.73 |  1.595  |
|  200704  |   4    |  2413444  |  85988.09  | 2562535.8 |  48649.35 |  6.177  |
|  200704  |   8    |  3827453  |  87710.52  | 3846888.2 |  86438.51 |  0.507  |
|  200704  |   16   | 5276096.8 |  73208.19  | 5425961.6 | 170774.75 |  2.840  |
|  200704  |   32   | 6742930.6 |  22789.45  | 6848904.4 | 257768.84 |  1.571  |
|  200704  |   64   | 7059479.2 | 300725.26  |  7373635  | 285106.90 |  4.450  |
|  200704  |  128   | 7097647.2 | 408171.71  |  7716500  | 266139.68 |  8.719  |
|  200704  |  256   |  6710810  | 314594.13  | 7661752.6 | 454049.27 |  14.170 |
|  200704  |  512   | 7034675.4 | 516152.97  | 7378583.2 | 613617.57 |  4.888  |
|  200704  |  1024  | 6265317.2 | 446101.38  | 7540629.6 | 294865.20 |  20.355 |
|  401408  |   1    |  802233.2 |  4263.92   |   817507  |  17727.09 |  1.903  |
|  401408  |   2    | 1461892.8 |  53678.12  |  1482872  |  45670.30 |  1.435  |
|  401408  |   4    | 2629686.8 |  24365.33  | 2673196.2 |  41576.78 |  1.654  |
|  401408  |   8    | 4156353.8 |  70636.85  | 4149330.4 |  56521.84 |  -0.168 |
|  401408  |   16   |  5895437  |  63762.43  | 5924167.4 | 396311.75 |  0.487  |
|  401408  |   32   | 7330826.6 | 167080.53  | 7785889.2 | 245434.99 |  6.207  |
|  401408  |   64   | 8298555.2 | 328890.89  | 8482416.8 | 249698.02 |  2.215  |
|  401408  |  128   | 8241108.6 | 490560.96  |  8686478  | 224816.21 |  5.404  |
|  401408  |  256   | 8038080.6 | 327704.66  | 8372327.4 | 210978.18 |  4.158  |
|  401408  |  512   | 8229523.4 | 371701.73  | 8654695.2 | 296715.07 |  5.166  |
+----------+--------+-----------+------------+-----------+-----------+---------+

Iozone results for Write 
+----------+--------+-----------+------------+-----------+------------+---------+
| filesize | reclen |  w/o(avg) | w/o(stdev) |   w(avg)  |  w(stdev)  | change% |
+----------+--------+-----------+------------+-----------+------------+---------+
|  200704  |   1    |   575825  |  7,876.69  |  569388.4 |  6,699.59  |  -1.12  |
|  200704  |   2    | 1061229.4 |  7,589.50  | 1045193.2 | 19,785.85  |  -1.51  |
|  200704  |   4    |  1808329  | 13,040.67  | 1798138.4 | 50,367.19  |  -0.56  |
|  200704  |   8    | 2822953.4 | 19,948.89  | 2830305.6 | 21,202.77  |   0.26  |
|  200704  |   16   |  3976987  | 62,201.72  | 3909063.8 | 268,640.51 |  -1.71  |
|  200704  |   32   | 4959358.2 | 112,052.99 |  4760303  | 330,343.73 |  -4.01  |
|  200704  |   64   | 5452454.6 | 628,078.72 | 5692265.6 | 190,562.91 |   4.40  |
|  200704  |  128   | 5645246.8 | 10,455.85  | 5653330.2 | 18,153.76  |   0.14  |
|  200704  |  256   | 5855897.2 | 184,854.25 |  5402069  | 538,523.04 |  -7.75  |
|  200704  |  512   |  5515904  | 326,198.86 | 5639976.4 |  8,480.46  |   2.25  |
|  200704  |  1024  | 5471718.2 | 415,179.15 | 5399414.6 | 686,124.50 |  -1.32  |
|  401408  |   1    |  584786.6 |  1,256.59  |  587237.2 |  6,552.55  |   0.42  |
|  401408  |   2    | 1047018.8 | 26,567.72  | 1040926.8 | 16,495.93  |  -0.58  |
|  401408  |   4    | 1815465.8 | 16,426.92  | 1773652.6 | 38,169.02  |  -2.30  |
|  401408  |   8    |  2814285  | 27,374.53  |  2756608  | 96,689.13  |  -2.05  |
|  401408  |   16   |  3931646  | 129,648.79 | 3805793.4 | 141,368.40 |  -3.20  |
|  401408  |   32   | 4875353.4 | 146,203.70 |  4884084  | 265,484.01 |   0.18  |
|  401408  |   64   | 5479805.8 | 349,995.36 | 5565292.2 | 20,645.45  |   1.56  |
|  401408  |  128   |  5598486  | 195,680.23 |  5645125  | 62,017.38  |   0.83  |
|  401408  |  256   |  5803148  | 328,683.02 |  5657215  | 20,579.28  |  -2.51  |
|  401408  |  512   | 5565091.4 | 166,123.57 | 5725974.4 | 169,506.29 |   2.89  |
+----------+--------+-----------+------------+-----------+------------+---------+

</pre>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">Tested with YCSB workload (50% update + 50% read) over redis for 1 million
records and 1 million operation. Each test was carried out with target
operations per second and persistence disabled.

Max-latency (in us)( mean over 5 iterations )
</pre>
      </blockquote>
      <pre wrap="">What's the variance between runs?

std dev? 95th percentile?

</pre>
      <blockquote type="cite">
        <pre wrap="">---------------------------------------------------------------
op/s    Operation       with patch      without patch   %change
---------------------------------------------------------------
15000   Read            61480.6         50261.4         22.32
</pre>
      </blockquote>
      <pre wrap="">This seems fairly significant regression. Any idea why at 15K op/s
there's such a regression?
</pre>
    </blockquote>
    <pre>Just Re-Ran the test for power numbers. 
Results for YCSB+Redis test.
P95 : 95 Percentile 
P99 : 99 Percentile

Power numbers are taken for one run of YCSB+redis test which has 50% Read + 50% Update.
Maximum Latency has clearly gone down for all cases will less than 5% increase in power.


+------------+----------+--------+------------+---------+---------+----------------+
|   Op/sec   | Testcase | AvgLat |   MaxLat   |   P95   |   P99   |     Power      |
+------------+----------+--------+------------+---------+---------+----------------+
|   15000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  |  51.8  |  127903.0  |   55.8  |  145.2  |     602.7      |
| w/o patch  |  StdDev  | 5.692  | 105355.497 |  11.232 |   2.04  |      5.11      |
| with patch | Average  | 53.28  |  30834.2   |   72.2  |  151.2  |     629.01     |
| with patch |  StdDev  | 2.348  |  8928.323  |  15.74  |  3.544  |      3.25      |
|     -      | <b>Change%  |  2.86  |   -75.89   |  29.39  |   4.13  | 4.36535589846</b>  |
|   25000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 53.78  |  123743.0  |   85.4  |  152.2  |     617.95     |
| w/o patch  |  StdDev  | 4.593  |  80224.53  |  5.886  |   4.49  |      1.32      |
| with patch | Average  | 49.65  |  84101.4   |   84.2  |  154.4  |     651.64     |
| with patch |  StdDev  | 1.658  | 72656.042  |  4.261  |  2.332  |      8.76      |
|     -      |<b> Change%  | -7.68  |   -32.04   |  -1.41  |   1.45  |  5.4518974027 </b> |
|   35000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 56.07  |  57391.0   |   93.0  |  147.6  |     636.39     |
| w/o patch  |  StdDev  | 1.391  | 34494.839  |  1.789  |  2.871  |      2.92      |
| with patch | Average  | 56.46  |  39634.2   |   95.0  |  149.2  |     653.44     |
| with patch |  StdDev  | 3.174  |  6089.848  |  3.347  |   3.37  |      4.4       |
|     -      |<b> Change%  |  0.69  |   -30.94   |   2.15  |   1.08  |  2.6791747199 </b> |
|   40000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  |  58.6  |  80427.8   |   97.2  |  147.4  |     636.85     |
| w/o patch  |  StdDev  | 1.105  | 59327.584  |  0.748  |  2.498  |      1.51      |
| with patch | Average  | 58.76  |  45291.8   |   97.2  |  149.0  |     656.12     |
| with patch |  StdDev  | 1.675  | 10486.954  |  2.482  |  3.406  |      6.97      |
|     -      | <b>Change%  |  0.27  |   -43.69   |   0.0   |   1.09  |  3.0258302583</b>  |
|   45000    |   Read   |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 69.02  |  120027.8  |  102.6  |  149.6  |     640.68     |
| w/o patch  |  StdDev  |  0.74  | 96288.811  |  1.855  |  1.497  |      7.65      |
| with patch | Average  | 69.65  |  98024.6   |  102.0  |  147.8  |     653.09     |
| with patch |  StdDev  |  1.14  | 78041.439  |   2.28  |  1.939  |      3.91      |
|     -      <b>| Change%  |  0.92  |   -18.33   |  -0.58  |   -1.2  | 1.93700443279</b>  |
|   15000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 48.144 |  86847.0   |   52.4  |  189.2  |     602.7      |
| w/o patch  |  StdDev  | 5.971  | 41580.919  |  16.427 |  8.376  |      5.11      |
| with patch | Average  | 47.964 |  31106.2   |   58.4  |  182.2  |     629.01     |
| with patch |  StdDev  | 3.003  |  4906.179  |  7.088  |  6.177  |      3.25      |
|     -      | <b>Change%  | -0.37  |   -64.18   |  11.45  |   -3.7  | -3.69978858351</b> |
|   25000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 51.856 |  102808.6  |   87.0  |  182.4  |     617.95     |
| w/o patch  |  StdDev  | 5.721  | 79308.823  |  4.899  |  7.965  |      1.32      |
| with patch | Average  | 46.07  |  74623.0   |   86.2  |  183.0  |     651.64     |
| with patch |  StdDev  | 1.779  | 77511.229  |  4.069  |  7.014  |      8.76      |
|     -      | <b>Change%  | -11.16 |   -27.42   |  -0.92  |   0.33  | 0.328947368421</b> |
|   35000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 54.142 |  51074.2   |   93.6  |  181.8  |     636.39     |
| w/o patch  |  StdDev  | 1.671  | 36877.588  |  1.497  |  8.035  |      2.92      |
| with patch | Average  | 54.034 |  44731.8   |   94.4  |  184.4  |     653.44     |
| with patch |  StdDev  | 3.363  |  13400.4   |   1.02  |  7.172  |      4.4       |
|     -      |<b> Change%  |  -0.2  |   -12.42   |   0.85  |   1.43  |  1.4301430143</b>  |
|   40000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 57.528 |  71672.6   |   98.4  |  184.8  |     636.85     |
| w/o patch  |  StdDev  | 1.111  | 63103.862  |  1.744  |  9.282  |      1.51      |
| with patch | Average  | 57.738 |  32101.4   |   98.0  |  186.4  |     656.12     |
| with patch |  StdDev  | 1.294  |  4481.801  |  1.673  |   7.71  |      6.97      |
|     -      | <b>Change%  |  0.37  |   -55.21   |  -0.41  |   0.87  | 0.865800865801 </b>|
|   45000    |  Update  |   -    |     -      |    -    |    -    |       -        |
| w/o patch  | Average  | 69.97  |  117183.0  |  105.4  |  182.4  |     640.68     |
| w/o patch  |  StdDev  | 0.925  | 99836.076  |   1.2   |  9.091  |      7.65      |
| with patch | Average  | 70.508 |  104175.0  |  103.2  |  185.4  |     653.09     |
| with patch |  StdDev  | 1.463  |  74438.13  |   1.47  |  7.915  |      3.91      |
|     -      |<b> Change%  |  0.77  |   -11.1    |  -2.09  |   1.64  | 1.64473684211  </b>|
+------------+----------+--------+------------+---------+---------+----------------+
</pre>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -36,12 +36,56 @@
 #include &lt;asm/reg.h&gt;
 #include &lt;asm/smp.h&gt; /* Required for cpu_sibling_mask() in UP configs */
 #include &lt;asm/opal.h&gt;
+#include &lt;linux/timer.h&gt;
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL &lt;&lt; 30)
 #define PMSR_SPR_EM_DISABLE	(1UL &lt;&lt; 31)
 #define PMSR_MAX(x)		((x &gt;&gt; 32) &amp; 0xFF)
 
+#define MAX_RAMP_DOWN_TIME				5120
+/*
+ * On an idle system we want the global pstate to ramp-down from max value to
+ * min over a span of ~5 secs. Also we want it to initially ramp-down slowly and
+ * then ramp-down rapidly later on.
</pre>
      </blockquote>
      <pre wrap="">Where does 5 seconds come from?

Why 5 and not 10, or not 2? Is there some time period inherit in
hardware or software that this is computed from?</pre>
    </blockquote>
    <pre> As global pstates are per-chip and there are max 12 cores, so if the system is really
 idle, considering 5 seconds for each cores, it should take 60 seconds for the chip to
 go to pmin.</pre>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <blockquote type="cite">
        <pre wrap="">+/* Interval after which the timer is queued to bring down global pstate */
+#define GPSTATE_TIMER_INTERVAL				2000
</pre>
      </blockquote>
      <pre wrap="">in ms?</pre>
    </blockquote>
    <pre>Yes its 2000 ms.
</pre>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">
</pre>
    </blockquote>
    <blockquote cite="mid:87vb3dmep8.fsf@linux.vnet.ibm.com" type="cite">
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080902020909030002000208--

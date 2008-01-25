Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 3C8FADDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:57:08 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so542018fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:57:06 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: benh@kernel.crashing.org
In-Reply-To: <1201164372.6815.55.camel@pasglop>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201091798.6341.49.camel@lappy>  <1201164372.6815.55.camel@pasglop>
Content-Type: multipart/mixed; boundary="=-/wAgnnZ9I3bYUPj04iwm"
Date: Fri, 25 Jan 2008 11:57:02 +0100
Message-Id: <1201258622.6293.34.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/wAgnnZ9I3bYUPj04iwm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 2008-01-24 at 19:46 +1100, Benjamin Herrenschmidt wrote:
> Could the fact that our sched_clock() returns utter crap if called
> before time_init() explain the problem ?

I don't think so. I've confirmed that it gets called exactly once before
time_init(), but it just returns 0 then, which I don't think should be a
problem.


Also, I'm attaching two copies of /proc/sched_debug obtained with

        sudo -b -u nobody nice -n 19 sh -c 'while true; do true; done'
        && cat /proc/sched_debug >/tmp/sched_debug.before && sleep 20 &&
        cat /proc/sched_debug >/tmp/sched_debug.after && sudo -u nobody
        killall sh

Looking at the diff below, the clock appears quite accurate.


Peter or Ingo, maybe you notice something else odd with these or have
other ideas for what conditions could cause niced processes to have such
an impact on interactivity?


--- /home/michdaen/sched_debug.before	2008-01-25 09:40:34.000000000 +0100
+++ /home/michdaen/sched_debug.after	2008-01-25 09:40:34.000000000 +0100
@@ -1,5 +1,5 @@
 Sched Debug Version: v0.07, 2.6.24-rc8 #4
-now at 204890.233650 msecs
+now at 224908.343840 msecs
   .sysctl_sched_latency                    : 20.000000
   .sysctl_sched_min_granularity            : 4.000000
   .sysctl_sched_wakeup_granularity         : 10.000000
@@ -8,56 +8,56 @@ now at 204890.233650 msecs
   .sysctl_sched_features                   : 7
 
 cpu#0
-  .nr_running                    : 6
-  .load                          : 9971
-  .nr_switches                   : 133199
-  .nr_load_updates               : 80363
-  .nr_uninterruptible            : 2
-  .jiffies                       : 4294872186
+  .nr_running                    : 5
+  .load                          : 4364
+  .nr_switches                   : 142978
+  .nr_load_updates               : 100239
+  .nr_uninterruptible            : 0
+  .jiffies                       : 4294892204
   .next_balance                  : 0.000000
-  .curr->pid                     : 4736
-  .clock                         : 80363.072863
+  .curr->pid                     : 4746
+  .clock                         : 100239.072955
   .idle_clock                    : 0.000000
-  .prev_clock_raw                : 204876.445696
+  .prev_clock_raw                : 224892.259968
   .clock_warps                   : 0
-  .clock_overflows               : 114542
+  .clock_overflows               : 119985
   .clock_deep_idle_events        : 0
   .clock_max_delta               : 0.999936
-  .cpu_load[0]                   : 9971
-  .cpu_load[1]                   : 9948
-  .cpu_load[2]                   : 9733
-  .cpu_load[3]                   : 8396
-  .cpu_load[4]                   : 5996
+  .cpu_load[0]                   : 4364
+  .cpu_load[1]                   : 3979
+  .cpu_load[2]                   : 3443
+  .cpu_load[3]                   : 3331
+  .cpu_load[4]                   : 3268
 
 cfs_rq
-  .exec_clock                    : 60747.682602
-  .MIN_vruntime                  : 35455.964402
-  .min_vruntime                  : 35455.964402
-  .max_vruntime                  : 35455.964402
-  .spread                        : 0.000000
+  .exec_clock                    : 80597.780820
+  .MIN_vruntime                  : 54813.436178
+  .min_vruntime                  : 54813.436178
+  .max_vruntime                  : 54818.646546
+  .spread                        : 5.210368
   .spread0                       : 0.000000
-  .nr_running                    : 2
-  .load                          : 3072
+  .nr_running                    : 3
+  .load                          : 4096
   .bkl_count                     : 0
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 1.407424
-  .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
-  .max_vruntime                  : 0.000001
+  .exec_clock                    : 19353.983950
+  .MIN_vruntime                  : 1362837.967264
+  .min_vruntime                  : 54813.436178
+  .max_vruntime                  : 1362837.967264
   .spread                        : 0.000000
   .spread0                       : 0.000000
-  .nr_running                    : 0
-  .load                          : 0
+  .nr_running                    : 1
+  .load                          : 15
   .bkl_count                     : 0
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 9247.295261
-  .MIN_vruntime                  : 41795.173040
-  .min_vruntime                  : 35455.964402
-  .max_vruntime                  : 41795.173040
+  .exec_clock                    : 9397.906333
+  .MIN_vruntime                  : 41843.822192
+  .min_vruntime                  : 54813.436178
+  .max_vruntime                  : 41843.822192
   .spread                        : 0.000000
   .spread0                       : 0.000000
   .nr_running                    : 2
@@ -68,7 +68,7 @@ cfs_rq
 cfs_rq
   .exec_clock                    : 0.997824
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -78,9 +78,9 @@ cfs_rq
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 84.409635
+  .exec_clock                    : 85.106979
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -90,9 +90,9 @@ cfs_rq
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 93.714624
+  .exec_clock                    : 94.005568
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -104,7 +104,7 @@ cfs_rq
 cfs_rq
   .exec_clock                    : 76.941956
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -114,9 +114,9 @@ cfs_rq
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 489.676070
+  .exec_clock                    : 496.666022
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -126,9 +126,9 @@ cfs_rq
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 6.610804
+  .exec_clock                    : 7.357556
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -140,7 +140,7 @@ cfs_rq
 cfs_rq
   .exec_clock                    : 9.548608
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -152,7 +152,7 @@ cfs_rq
 cfs_rq
   .exec_clock                    : 130.004741
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -164,7 +164,7 @@ cfs_rq
 cfs_rq
   .exec_clock                    : 5.477635
   .MIN_vruntime                  : 0.000001
-  .min_vruntime                  : 35455.964402
+  .min_vruntime                  : 54813.436178
   .max_vruntime                  : 0.000001
   .spread                        : 0.000000
   .spread0                       : 0.000000
@@ -174,24 +174,23 @@ cfs_rq
   .nr_spread_over                : 0
 
 cfs_rq
-  .exec_clock                    : 47873.754074
-  .MIN_vruntime                  : 41804.982498
-  .min_vruntime                  : 35455.964402
-  .max_vruntime                  : 41827.144008
-  .spread                        : 22.161510
+  .exec_clock                    : 48211.939702
+  .MIN_vruntime                  : 42001.676760
+  .min_vruntime                  : 54813.436178
+  .max_vruntime                  : 42013.220923
+  .spread                        : 11.544163
   .spread0                       : 0.000000
-  .nr_running                    : 4
-  .load                          : 7923
+  .nr_running                    : 2
+  .load                          : 2301
   .bkl_count                     : 0
   .nr_spread_over                : 8
 
 runnable tasks:
             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
 ----------------------------------------------------------------------------------------------------------
-       kblockd/0    61     41804.982498      5110   115     41804.982498        24.883015     78433.943969
-           udevd  1304     41827.144008       686   116     41827.144008       425.666176     63782.106879
-      pbbuttonsd  3878     41805.034397     20351   120     41805.034397       453.425277     41231.848603
-            Xorg  4574     41824.962717     12488   119     41824.962717      4933.764004     24971.603455
-             zsh  4675     41795.173040       631   120     41795.173040       301.572431     24901.348163
-R            cat  4736     41787.850967         0   120     41787.850967         3.696000         0.000000
+      pbbuttonsd  3878     42001.676760     22659   120     42001.676760       506.463055     52940.745088
+            Xorg  4574     42013.220923     15439   119     42013.220923      5168.535269     27513.009418
+             zsh  4675     41843.822192       634   120     41843.822192       302.744207     44763.221535
+              sh  4734   1362837.967264      2791   139   1362837.967264     19352.994638        47.795532
+R            cat  4746     41816.398384         0   120     41816.398384         2.149568         0.000000



-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer

--=-/wAgnnZ9I3bYUPj04iwm
Content-Disposition: attachment; filename=sched_debug.after
Content-Type: text/plain; name=sched_debug.after; charset=utf-8
Content-Transfer-Encoding: 7bit

Sched Debug Version: v0.07, 2.6.24-rc8 #4
now at 224908.343840 msecs
  .sysctl_sched_latency                    : 20.000000
  .sysctl_sched_min_granularity            : 4.000000
  .sysctl_sched_wakeup_granularity         : 10.000000
  .sysctl_sched_batch_wakeup_granularity   : 10.000000
  .sysctl_sched_child_runs_first           : 0.000001
  .sysctl_sched_features                   : 7

cpu#0
  .nr_running                    : 5
  .load                          : 4364
  .nr_switches                   : 142978
  .nr_load_updates               : 100239
  .nr_uninterruptible            : 0
  .jiffies                       : 4294892204
  .next_balance                  : 0.000000
  .curr->pid                     : 4746
  .clock                         : 100239.072955
  .idle_clock                    : 0.000000
  .prev_clock_raw                : 224892.259968
  .clock_warps                   : 0
  .clock_overflows               : 119985
  .clock_deep_idle_events        : 0
  .clock_max_delta               : 0.999936
  .cpu_load[0]                   : 4364
  .cpu_load[1]                   : 3979
  .cpu_load[2]                   : 3443
  .cpu_load[3]                   : 3331
  .cpu_load[4]                   : 3268

cfs_rq
  .exec_clock                    : 80597.780820
  .MIN_vruntime                  : 54813.436178
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 54818.646546
  .spread                        : 5.210368
  .spread0                       : 0.000000
  .nr_running                    : 3
  .load                          : 4096
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 19353.983950
  .MIN_vruntime                  : 1362837.967264
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 1362837.967264
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 1
  .load                          : 15
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 9397.906333
  .MIN_vruntime                  : 41843.822192
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 41843.822192
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 2
  .load                          : 2048
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 0.997824
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 85.106979
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 94.005568
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 76.941956
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 496.666022
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 7.357556
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 9.548608
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 130.004741
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 5.477635
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 48211.939702
  .MIN_vruntime                  : 42001.676760
  .min_vruntime                  : 54813.436178
  .max_vruntime                  : 42013.220923
  .spread                        : 11.544163
  .spread0                       : 0.000000
  .nr_running                    : 2
  .load                          : 2301
  .bkl_count                     : 0
  .nr_spread_over                : 8

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------
      pbbuttonsd  3878     42001.676760     22659   120     42001.676760       506.463055     52940.745088
            Xorg  4574     42013.220923     15439   119     42013.220923      5168.535269     27513.009418
             zsh  4675     41843.822192       634   120     41843.822192       302.744207     44763.221535
              sh  4734   1362837.967264      2791   139   1362837.967264     19352.994638        47.795532
R            cat  4746     41816.398384         0   120     41816.398384         2.149568         0.000000


--=-/wAgnnZ9I3bYUPj04iwm
Content-Disposition: attachment; filename=sched_debug.before
Content-Type: text/plain; name=sched_debug.before; charset=utf-8
Content-Transfer-Encoding: 7bit

Sched Debug Version: v0.07, 2.6.24-rc8 #4
now at 204890.233650 msecs
  .sysctl_sched_latency                    : 20.000000
  .sysctl_sched_min_granularity            : 4.000000
  .sysctl_sched_wakeup_granularity         : 10.000000
  .sysctl_sched_batch_wakeup_granularity   : 10.000000
  .sysctl_sched_child_runs_first           : 0.000001
  .sysctl_sched_features                   : 7

cpu#0
  .nr_running                    : 6
  .load                          : 9971
  .nr_switches                   : 133199
  .nr_load_updates               : 80363
  .nr_uninterruptible            : 2
  .jiffies                       : 4294872186
  .next_balance                  : 0.000000
  .curr->pid                     : 4736
  .clock                         : 80363.072863
  .idle_clock                    : 0.000000
  .prev_clock_raw                : 204876.445696
  .clock_warps                   : 0
  .clock_overflows               : 114542
  .clock_deep_idle_events        : 0
  .clock_max_delta               : 0.999936
  .cpu_load[0]                   : 9971
  .cpu_load[1]                   : 9948
  .cpu_load[2]                   : 9733
  .cpu_load[3]                   : 8396
  .cpu_load[4]                   : 5996

cfs_rq
  .exec_clock                    : 60747.682602
  .MIN_vruntime                  : 35455.964402
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 35455.964402
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 2
  .load                          : 3072
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 1.407424
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 9247.295261
  .MIN_vruntime                  : 41795.173040
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 41795.173040
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 2
  .load                          : 2048
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 0.997824
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 84.409635
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 93.714624
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 76.941956
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 489.676070
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 6.610804
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 9.548608
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 130.004741
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 5.477635
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 0
  .load                          : 0
  .bkl_count                     : 0
  .nr_spread_over                : 0

cfs_rq
  .exec_clock                    : 47873.754074
  .MIN_vruntime                  : 41804.982498
  .min_vruntime                  : 35455.964402
  .max_vruntime                  : 41827.144008
  .spread                        : 22.161510
  .spread0                       : 0.000000
  .nr_running                    : 4
  .load                          : 7923
  .bkl_count                     : 0
  .nr_spread_over                : 8

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------
       kblockd/0    61     41804.982498      5110   115     41804.982498        24.883015     78433.943969
           udevd  1304     41827.144008       686   116     41827.144008       425.666176     63782.106879
      pbbuttonsd  3878     41805.034397     20351   120     41805.034397       453.425277     41231.848603
            Xorg  4574     41824.962717     12488   119     41824.962717      4933.764004     24971.603455
             zsh  4675     41795.173040       631   120     41795.173040       301.572431     24901.348163
R            cat  4736     41787.850967         0   120     41787.850967         3.696000         0.000000


--=-/wAgnnZ9I3bYUPj04iwm--

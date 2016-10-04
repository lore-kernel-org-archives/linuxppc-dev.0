Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp0cW6RrPzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:47:23 +1100 (AEDT)
Date: Mon, 3 Oct 2016 21:47:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v21 16/19] perf, tools: Make alias matching
 case-insensitive
Message-ID: <20161004004706.GF7143@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-17-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473978296-20712-17-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Sep 15, 2016 at 03:24:53PM -0700, Sukadev Bhattiprolu escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Make alias matching the events parser case-insensitive. This is useful
> with the JSON events. perf uses lower case events, but the CPU manuals
> generally use upper case event names. The JSON files use lower
> case by default too. But if we search case insensitively then
> users can cut-n-paste the upper case event names.
> 
> So the following works:
> 
> % perf stat -e BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL true
> 
>  Performance counter stats for 'true':
> 
>                305      BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL
> 
>        0.000492799 seconds time elapsed

So now trying to figure this out:

[acme@jouet linux]$ perf stat -e br_inst_exec.all_direct_near_call true
event syntax error: 'br_inst_exec.all_direct_near_call'
                     \___ 'period' is not usable in 'perf stat'
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[acme@jouet linux]$ 

[acme@jouet linux]$ perf stat -e cycles true

 Performance counter stats for 'true':

           228,093      cycles:u                                                    

       0.002678362 seconds time elapsed

[acme@jouet linux]$


Who is setting period in that case?

For cycles we get in verbose mode:

[acme@jouet linux]$ perf stat -vv -e cycles true
Using CPUID GenuineIntel-6-3D
intel_pt default config: tsc
------------------------------------------------------------
perf_event_attr:
  size                             112
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 13346  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
Warning:
kernel.perf_event_paranoid=2, trying to fall back to excluding kernel samples
------------------------------------------------------------
perf_event_attr:
  size                             112
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 13346  cpu -1  group_fd -1  flags 0x8
cycles:u: 0: 322539 536424 536424
cycles:u: 322539 536424 536424

 Performance counter stats for 'true':

           322,539      cycles:u                                                    

       0.001061349 seconds time elapsed

And for br_inst_exec.all_direct_near_call:

Strange:

[acme@jouet linux]$ perf stat -vvv -e 'br_inst_exec.all_direct_near_call' true
Using CPUID GenuineIntel-6-3D
event syntax error: 'br_inst_exec.all_direct_near_call'
                     \___ 'period' is not usable in 'perf stat'
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[acme@jouet linux]$ 
[acme@jouet linux]$ perf record -e 'br_inst_exec.all_direct_near_call' true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data ]
[acme@jouet linux]$ perf evlist -v
br_inst_exec.all_direct_near_call:u: type: 4, size: 112, config: 0xd088, { sample_period, sample_freq }: 200003, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, exclude_kernel: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
[acme@jouet linux]$ 

I've put what I have on a tmp.perf/json branch, will run it thru my tests and
continue tomorrow, when I'll try to investigate this problem with 'perf stat' and
these events, unless someone does it while I'm asleep. :-)

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9abd60d..1abda10 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1453,7 +1453,7 @@ comp_pmu(const void *p1, const void *p2)
>  	struct perf_pmu_event_symbol *pmu1 = (struct perf_pmu_event_symbol *) p1;
>  	struct perf_pmu_event_symbol *pmu2 = (struct perf_pmu_event_symbol *) p2;
>  
> -	return strcmp(pmu1->symbol, pmu2->symbol);
> +	return strcasecmp(pmu1->symbol, pmu2->symbol);
>  }
>  
>  static void perf_pmu__parse_cleanup(void)
> -- 
> 1.8.3.1

Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D3C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4014420684
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4014420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k0rj3vNbzDqGN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 19:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=anju@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k0pQ604pzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 19:45:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G9idBO109030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 05:44:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwcb50xjw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 05:44:59 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 16 Apr 2019 10:44:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 10:44:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3G9iqVS49414248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 09:44:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED7ECA404D;
 Tue, 16 Apr 2019 09:44:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2509BA4053;
 Tue, 16 Apr 2019 09:44:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.144.43])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Apr 2019 09:44:50 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] powerpc/perf: IMC trace-mode support
To: mpe@ellerman.id.au
References: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 16 Apr 2019 15:14:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19041609-0008-0000-0000-000002DA57B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041609-0009-0000-0000-000022468F4C
Message-Id: <e85ee33d-9be6-e2ec-2779-c187602c547a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160067
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Kindly ignore this series, since patch 5/5 in this series doesn't 
incorporate the event-format change

that I've done in v4 of this series.


Apologies for the inconvenience. I will post the updated v5 soon.


Thanks,

Anju

On 4/15/19 3:41 PM, Anju T Sudhakar wrote:
> IMC (In-Memory collection counters) is a hardware monitoring facility
> that collects large number of hardware performance events.
> POWER9 support two modes for IMC which are the Accumulation mode and
> Trace mode. In Accumulation mode, event counts are accumulated in system
> Memory. Hypervisor then reads the posted counts periodically or when
> requested. In IMC Trace mode, the 64 bit trace scom value is initialized
> with the event information. The CPMC*SEL and CPMC_LOAD in the trace scom, specifies
> the event to be monitored and the sampling duration. On each overflow in the
> CPMC*SEL, hardware snapshots the program counter along with event counts
> and writes into memory pointed by LDBAR. LDBAR has bits to indicate whether
> hardware is configured for accumulation or trace mode.
> Currently the event monitored for trace-mode is fixed as cycle.
>
> Trace-IMC Implementation:
> --------------------------
> To enable trace-imc, we need to
> 								
> * Add trace node in the DTS file for power9, so that the new trace node can
> be discovered by the kernel.
> 								
> Information included in the DTS file are as follows, (a snippet from
> the ima-catalog)
> 								
> TRACE_IMC: trace-events {
>       #address-cells = <0x1>;
>       #size-cells = <0x1>;
>       event at 10200000 {
> 	 event-name = "cycles" ;
> 	 reg = <0x10200000 0x8>;
> 	 desc = "Reference cycles" ;
>       };
>   };
>   trace@0 {
> 	 compatible = "ibm,imc-counters";
> 	 events-prefix = "trace_";
> 	 reg = <0x0 0x8>;
> 	 events = < &TRACE_IMC >;
> 	 type = <0x2>;
> 	 size = <0x40000>;
>   };
> 								
> OP-BUILD changes needed to include the "trace node" is already pulled in
> to the ima-catalog repo.
> 								
> ps://github.com/open-power/op-build/commit/d3e75dc26d1283d7d5eb444bff1ec9e40d5dfc07
> 								
> * Enchance the opal_imc_counters_* calls to support this new trace mode
> in imc. Add support to initialize the trace-mode scom.
> 								
> TRACE_IMC_SCOM bit representation:
> 								
> 0:1     : SAMPSEL
> 2:33    : CPMC_LOAD
> 34:40   : CPMC1SEL
> 41:47   : CPMC2SEL
> 48:50   : BUFFERSIZE
> 51:63   : RESERVED
> 								
> CPMC_LOAD contains the sampling duration. SAMPSEL and CPMC*SEL determines
> the event to count. BUFFRSIZE indicates the memory range. On each overflow,
> hardware snapshots program counter along with event counts and update the
> memory and reloads the CMPC_LOAD value for the next sampling duration.
> IMC hardware does not support exceptions, so it quietly wraps around if
> memory buffer reaches the end.
>
> OPAL support for IMC trace mode is already upstream.
>
> * Set LDBAR spr to enable imc-trace mode.
>                                                                               
>    LDBAR Layout:
>                                                                               
>    0     : Enable/Disable
>    1     : 0 -> Accumulation Mode
>            1 -> Trace Mode
>    2:3   : Reserved
>    4-6   : PB scope
>    7     : Reserved
>    8:50  : Counter Address
>    51:63 : Reserved
>
> ----------------------
>
> PMI interrupt handling is avoided, since IMC trace mode snapshots the
> program counter and update to the memory. And this also provide a way for
> the operating system to do instruction sampling in real time without
> PMI(Performance Monitoring Interrupts) processing overhead.          								    					
> Performance data using 'perf top' with and without trace-imc event:
> 								
> PMI interrupts count when `perf top` command is executed without trace-imc event.
> 								
> # cat /proc/interrupts  (a snippet from the output)
> 9944      1072        804        804       1644        804       1306
> 804        804        804        804        804        804        804
> 804        804       1961       1602        804        804       1258
> [-----------------------------------------------------------------]
> 803        803        803        803        803        803        803
> 803        803        803        803        804        804        804
> 804        804        804        804        804        804        803
> 803        803        803        803        803       1306        803
> 803   Performance monitoring interrupts
> 								
> 								
> `perf top` with trace-imc (executed right after 'perf top' without trace-imc event):
> 								
> # perf top -e trace_imc/trace_cycles/
> 12.50%  [kernel]          [k] arch_cpu_idle
> 11.81%  [kernel]          [k] __next_timer_interrupt
> 11.22%  [kernel]          [k] rcu_idle_enter
> 10.25%  [kernel]          [k] find_next_bit
>   7.91%  [kernel]          [k] do_idle
>   7.69%  [kernel]          [k] rcu_dynticks_eqs_exit
>   5.20%  [kernel]          [k] tick_nohz_idle_stop_tick
>       [-----------------------]
> 								
> # cat /proc/interrupts (a snippet from the output)
> 								
> 9944      1072        804        804       1644        804       1306
> 804        804        804        804        804        804        804
> 804        804       1961       1602        804        804       1258
> [-----------------------------------------------------------------]
> 803        803        803        803        803        803        803
> 803        803        803        804        804        804        804
> 804        804        804        804        804        804        803
> 803        803        803        803        803       1306        803
> 803   Performance monitoring interrupts
> 								
> The PMI interrupts count remains the same.
>
>
> Changelog:
> ----------
>  From v3 -> v4:
>
> * trace_imc_refc is introduced. So that even if, core-imc
> is disabled, trace-imc can be used.
>
> * trace_imc_pmu_sched_task is removed and opal start/stop
> is invoked in trace_imc_event_add/del function.
>
>
> Suggestions/comments are welcome.
>
> Anju T Sudhakar (4):
>    powerpc/include: Add data structures and macros for IMC trace mode
>    powerpc/perf: Rearrange setting of ldbar for thread-imc
>    powerpc/perf: Trace imc events detection and cpuhotplug
>    powerpc/perf: Trace imc PMU functions
>
> Madhavan Srinivasan (1):
>    powerpc/perf: Add privileged access check for thread_imc
>
>   arch/powerpc/include/asm/imc-pmu.h        |  39 +++
>   arch/powerpc/include/asm/opal-api.h       |   1 +
>   arch/powerpc/perf/imc-pmu.c               | 318 +++++++++++++++++++++-
>   arch/powerpc/platforms/powernv/opal-imc.c |   3 +
>   include/linux/cpuhotplug.h                |   1 +
>   5 files changed, 351 insertions(+), 11 deletions(-)
>


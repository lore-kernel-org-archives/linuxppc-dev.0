Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF3C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:19:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3AD20870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPR3dHFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3AD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ppXN0zprzDqJm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 01:19:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dPR3dHFh"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ppVS0bLhzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:17:36 +1100 (AEDT)
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B6C42082F;
 Tue, 29 Jan 2019 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548771454;
 bh=SCJkvK4CRi1w2djXvgwSDL6jcxRRR3cWKMEiex39eZk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dPR3dHFhp2UZ4RT2BUv6GQnBK6YAIRLxVh/MUqejmMrFoKJiL+ZnnWAvwXbhZpSt6
 znd7vP3bl5AEWmsy6NTSsbDI1EscBQ+IZHYYmP8AA6YIzcf33Sqs+Uir4DPu8WYEek
 UqkMYXUjUpc1HV9Aahp3RXkwgQnW92LmLiHkn+1g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 6D6354034F; Tue, 29 Jan 2019 15:17:32 +0100 (CET)
Date: Tue, 29 Jan 2019 15:17:32 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf mem/c2c: Fix perf_mem_events to support powerpc
Message-ID: <20190129141732.GN4344@kernel.org>
References: <dd6d04f3-c8aa-1d57-c466-c6b3c333db51@linux.ibm.com>
 <20190129132412.771-1-ravi.bangoria@linux.ibm.com>
 <20190129134236.GB30190@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129134236.GB30190@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: dzickus@redhat.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, fowles@inreach.com,
 jmario@redhat.com, namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Tue, Jan 29, 2019 at 02:42:36PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 29, 2019 at 06:54:12PM +0530, Ravi Bangoria wrote:
> > Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
> > event and, perf_mem_events by default includes ldlat=30 which is
> > causing failure on powerpc. Refactor code to support perf mem/c2c on
> > powerpc.
> > 
> > This patch depends on kernel side changes done my Madhavan:
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied to perf/urgent, as soon as the kernel bits are there tooling
will be ready.

- Arnaldo
 
> thanks,
> jirka
> 
> >  tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
> >  tools/perf/Documentation/perf-mem.txt     |  2 +-
> >  tools/perf/arch/powerpc/util/Build        |  1 +
> >  tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
> >  tools/perf/util/mem-events.c              |  2 +-
> >  5 files changed, 26 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/perf/arch/powerpc/util/mem-events.c
> > 
> > diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> > index 095aebd..e6150f2 100644
> > --- a/tools/perf/Documentation/perf-c2c.txt
> > +++ b/tools/perf/Documentation/perf-c2c.txt
> > @@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
> >  The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
> >  you to track down the cacheline contentions.
> >  
> > -The tool is based on x86's load latency and precise store facility events
> > -provided by Intel CPUs. These events provide:
> > +On x86, the tool is based on load latency and precise store facility events
> > +provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
> > +with thresholding feature.
> > +
> > +These events provide:
> >    - memory address of the access
> >    - type of the access (load and store details)
> >    - latency (in cycles) of the load access
> > @@ -46,7 +49,7 @@ RECORD OPTIONS
> >  
> >  -l::
> >  --ldlat::
> > -	Configure mem-loads latency.
> > +	Configure mem-loads latency. (x86 only)
> >  
> >  -k::
> >  --all-kernel::
> > @@ -119,11 +122,16 @@ Following perf record options are configured by default:
> >    -W,-d,--phys-data,--sample-cpu
> >  
> >  Unless specified otherwise with '-e' option, following events are monitored by
> > -default:
> > +default on x86:
> >  
> >    cpu/mem-loads,ldlat=30/P
> >    cpu/mem-stores/P
> >  
> > +and following on PowerPC:
> > +
> > +  cpu/mem-loads/
> > +  cpu/mem-stores/
> > +
> >  User can pass any 'perf record' option behind '--' mark, like (to enable
> >  callchains and system wide monitoring):
> >  
> > diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> > index f8d2167..199ea0f 100644
> > --- a/tools/perf/Documentation/perf-mem.txt
> > +++ b/tools/perf/Documentation/perf-mem.txt
> > @@ -82,7 +82,7 @@ RECORD OPTIONS
> >  	Be more verbose (show counter open errors, etc)
> >  
> >  --ldlat <n>::
> > -	Specify desired latency for loads event.
> > +	Specify desired latency for loads event. (x86 only)
> >  
> >  In addition, for report all perf report options are valid, and for record
> >  all perf record options.
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> > index 2e659531..ba98bd0 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -2,6 +2,7 @@ libperf-y += header.o
> >  libperf-y += sym-handling.o
> >  libperf-y += kvm-stat.o
> >  libperf-y += perf_regs.o
> > +libperf-y += mem-events.o
> >  
> >  libperf-$(CONFIG_DWARF) += dwarf-regs.o
> >  libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
> > diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
> > new file mode 100644
> > index 0000000..f1194fc
> > --- /dev/null
> > +++ b/tools/perf/arch/powerpc/util/mem-events.c
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "mem-events.h"
> > +
> > +/* PowerPC does not support 'ldlat' parameter. */
> > +char *perf_mem_events__name(int i)
> > +{
> > +	if (i == PERF_MEM_EVENTS__LOAD)
> > +		return (char *) "cpu/mem-loads/";
> > +
> > +	return (char *) "cpu/mem-stores/";
> > +}
> > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > index 93f74d8..42c3e5a 100644
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> >  static char mem_loads_name[100];
> >  static bool mem_loads_name__init;
> >  
> > -char *perf_mem_events__name(int i)
> > +char * __weak perf_mem_events__name(int i)
> >  {
> >  	if (i == PERF_MEM_EVENTS__LOAD) {
> >  		if (!mem_loads_name__init) {
> > -- 
> > 1.8.3.1
> > 

-- 

- Arnaldo

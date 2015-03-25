Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1B561A025A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:25:09 +1100 (AEDT)
In-Reply-To: <aa8dd4f5b50686871c9d3a1c27337006b1c9eea9.1427200114.git.jstancek@redhat.com>
To: Jan Stancek <jstancek@redhat.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/perf: add missing put_cpu_var in power_pmu_event_init
Message-Id: <20150325052509.C995F1400F1@ozlabs.org>
Date: Wed, 25 Mar 2015 16:25:09 +1100 (AEDT)
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 tj@kernel.org, cl@linux.com, jolsa@redhat.com, jstancek@redhat.com,
 joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-24-03 at 12:33:22 UTC, Jan Stancek wrote:
> One path in power_pmu_event_init() calls get_cpu_var(), but is
> missing matching call to put_cpu_var(), which causes preemption
> imbalance and crash in user-space:
> 
>   Page fault in user mode with in_atomic() = 1 mm = c000001fefa5a280
>   NIP = 3fff9bf2cae0  MSR = 900000014280f032
>   Oops: Weird page fault, sig: 11 [#23]

<snip>

Thanks. But I don't see this. I guess you have CONFIG_PREEMPT enabled?

cheers

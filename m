Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:24:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECC4206DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECC4206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TPKR3fXCzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:24:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TPHn3xdJzDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 08:23:17 +1100 (AEDT)
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1h8tWr-0006dc-M9; Tue, 26 Mar 2019 22:22:41 +0100
Date: Tue, 26 Mar 2019 22:22:40 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain
 the watchdog_allowed_mask
In-Reply-To: <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262221140.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>,
 x86@kernel.org, David Rientjes <rientjes@google.com>,
 Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>,
 Byungchul Park <byungchul.park@lge.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 Feb 2019, Ricardo Neri wrote:
>  
> -struct cpumask watchdog_allowed_mask __read_mostly;
> +static struct cpumask watchdog_allowed_mask __read_mostly;

That hunk is correct.

>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> @@ -92,6 +92,11 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>  }
>  __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>  # endif /* CONFIG_SMP */
> +
> +struct cpumask *watchdog_get_allowed_cpumask(void)
> +{
> +	return &watchdog_allowed_mask;
> +}

That part is pointless as I showed you in the other reply. You don't need
that mask in your code at all.

Thanks,

	tglx



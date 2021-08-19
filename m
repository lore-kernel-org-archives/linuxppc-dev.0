Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C70C432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 21:53:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330946108F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 21:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 330946108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrJRj2klbz3cXR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 07:53:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=default header.b=ojeijnyp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=efficios.com (client-ip=167.114.26.124; helo=mail.efficios.com;
 envelope-from=compudj@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256
 header.s=default header.b=ojeijnyp; dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrJQw0fkNz3bYp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 07:52:39 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C4AC93785BB;
 Thu, 19 Aug 2021 17:52:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id q90BhJanX94H; Thu, 19 Aug 2021 17:52:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 981C1378471;
 Thu, 19 Aug 2021 17:52:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 981C1378471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1629409956;
 bh=FT/9tsRw4GHMRYZjMUjeW+dU3pWo2sTLu4BVILOQ3Vw=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=ojeijnypP3ibFpXP9GNKQC8QIHrIsqnBvvg+UEcRGyTa1FEfNhNn8x208wd/fFwqK
 l4eyPmQ5rRnhb9troaWdmxK9D9Evv+XIMyJFQCuftEfqk0wjU2POlBaXcUaVCTgxtW
 Vo1/uOSpVLBZB4xKOPKTxe8Q8LbyfK3HVMrISp65jV9WWI4ghtodol8w+aFwXZmRRS
 if6ZhAzSmtaA+QoIUip1h9ZuECrrxt/QgvDDIsnKdpaBH77xh4OEae/C83cxudANvB
 Pg50WpzUclYjyihqu4XpgTA/XXyjqSfze5ZyC2oYsBYC2dN6eoVhXGuPn8jsIR2SGa
 ykKv2wTVq8fjw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jWSv7EA9TFNO; Thu, 19 Aug 2021 17:52:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 74D7037846E;
 Thu, 19 Aug 2021 17:52:36 -0400 (EDT)
Date: Thu, 19 Aug 2021 17:52:36 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Sean Christopherson <seanjc@google.com>
Message-ID: <1540548616.19739.1629409956315.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210818001210.4073390-5-seanjc@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
 <20210818001210.4073390-5-seanjc@google.com>
Subject: Re: [PATCH 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: selftests: Add a test for KVM_RUN+rseq to detect task migration
 bugs
Thread-Index: ANwizCRJ0rGzNBwji1ThaEUA7GOz0w==
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
Cc: KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, linux-kselftest <linux-kselftest@vger.kernel.org>,
 Ben Gardon <bgardon@google.com>, shuah <shuah@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
 gor <gor@linux.ibm.com>, "Russell King, ARM Linux" <linux@armlinux.org.uk>,
 linux-csky <linux-csky@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeelb@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Foley <pefoley@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

----- On Aug 17, 2021, at 8:12 PM, Sean Christopherson seanjc@google.com wrote:

> Add a test to verify an rseq's CPU ID is updated correctly if the task is
> migrated while the kernel is handling KVM_RUN.  This is a regression test
> for a bug introduced by commit 72c3c0fe54a3 ("x86/kvm: Use generic xfer
> to guest work function"), where TIF_NOTIFY_RESUME would be cleared by KVM
> without updating rseq, leading to a stale CPU ID and other badness.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

[...]

> +
> +static void *migration_worker(void *ign)
> +{
> +	cpu_set_t allowed_mask;
> +	int r, i, nr_cpus, cpu;
> +
> +	CPU_ZERO(&allowed_mask);
> +
> +	nr_cpus = CPU_COUNT(&possible_mask);
> +
> +	for (i = 0; i < 20000; i++) {
> +		cpu = i % nr_cpus;
> +		if (!CPU_ISSET(cpu, &possible_mask))
> +			continue;
> +
> +		CPU_SET(cpu, &allowed_mask);
> +
> +		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> +		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)", errno,
> +			    strerror(errno));
> +
> +		CPU_CLR(cpu, &allowed_mask);
> +
> +		usleep(10);
> +	}
> +	done = true;
> +	return NULL;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	u32 cpu, rseq_cpu;
> +	int r;
> +
> +	/* Tell stdout not to buffer its content */
> +	setbuf(stdout, NULL);
> +
> +	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
> +	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
> +		    strerror(errno));
> +
> +	if (CPU_COUNT(&possible_mask) < 2) {
> +		print_skip("Only one CPU, task migration not possible\n");
> +		exit(KSFT_SKIP);
> +	}
> +
> +	sys_rseq(0);
> +
> +	/*
> +	 * Create and run a dummy VM that immediately exits to userspace via
> +	 * GUEST_SYNC, while concurrently migrating the process by setting its
> +	 * CPU affinity.
> +	 */
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +
> +	pthread_create(&migration_thread, NULL, migration_worker, 0);
> +
> +	while (!done) {
> +		vcpu_run(vm, VCPU_ID);
> +		TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
> +			    "Guest failed?");
> +
> +		cpu = sched_getcpu();
> +		rseq_cpu = READ_ONCE(__rseq.cpu_id);
> +
> +		/*
> +		 * Verify rseq's CPU matches sched's CPU, and that sched's CPU
> +		 * is stable.  This doesn't handle the case where the task is
> +		 * migrated between sched_getcpu() and reading rseq, and again
> +		 * between reading rseq and sched_getcpu(), but in practice no
> +		 * false positives have been observed, while on the other hand
> +		 * blocking migration while this thread reads CPUs messes with
> +		 * the timing and prevents hitting failures on a buggy kernel.
> +		 */

I think you could get a stable cpu id between sched_getcpu and __rseq_abi.cpu_id
if you add a pthread mutex to protect:

sched_getcpu and __rseq_abi.cpu_id  reads

vs

sched_setaffinity calls within the migration thread.

Thoughts ?

Thanks,

Mathieu

> +		TEST_ASSERT(rseq_cpu == cpu || cpu != sched_getcpu(),
> +			    "rseq CPU = %d, sched CPU = %d\n", rseq_cpu, cpu);
> +	}
> +
> +	pthread_join(migration_thread, NULL);
> +
> +	kvm_vm_free(vm);
> +
> +	sys_rseq(RSEQ_FLAG_UNREGISTER);
> +
> +	return 0;
> +}
> --
> 2.33.0.rc1.237.g0d66db33f3-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

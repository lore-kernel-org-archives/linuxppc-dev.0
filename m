Return-Path: <linuxppc-dev+bounces-19314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C1E88D9B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 13:33:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnxPD4RqGz2yVL;
	Sun, 05 Apr 2026 00:33:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775294405;
	cv=none; b=Aa0TQ2fU9erjsdjUotnmBZV8EjvowofmrMaISm66WacboEIn0BAdwqKwMaUIvkRwLWsBK0YcRVZY+Cq1T5iw2EXU9UzFYsrzp18PY66C1jWnC6nzZcar89tXpW2r4upWEoMRGBYfgQMpz1wLeYo4dbdU+NooK2hiLNtMlPU3EK8k0RJWwan52b9sorz0uSsYxFPohsUPkOAQwARAf20HgglaHNHO5G+SQk0ewJ0M9ru0FA+In6oEwa3z9F+yOIeEMv87B53LK8AbFZCALTEyFtJk3sLkDr8pJyxvpffh6N7tYEaKx7te4wY/HMm4UpJAkrR6J+2D8RA3ClFFMTGdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775294405; c=relaxed/relaxed;
	bh=m4D9KIHfQ19G+ih5n0VIDlQHW6gYQM9spmrNFkW8GpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkNHduO/nMc4sL1+3FXYqDx2WZZVVdfWSOJHjE1AS2B9NTGm5nWK9r+949ULx4nUbuQlquqHjfr5atJCeX8yRrwQX3vbOiJFXs4E17T4LZwsdzyV/jterVckY41DnETgCGQr4StYibd89v7kaurPIHkwWseDnnxzT6/mEo4e0kVkLwXon/pAD1p/g3YaKSx5Fz1W06z1kdE/Acv54csvcIE6ULCXI3ng1074J7n6v3WYR/eduGKX73f5OxpSYsS6BVpVB9gIuWjShuMp6Z9SBoF64hmjshYIYjr9fDJHWbKetfrV5yJfpZIZorPOu50wLZV1Fr8xGkTFFJOI/ljgzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YV2188ow; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=lianux.mm@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YV2188ow;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=lianux.mm@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnqn00Kwjz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 20:20:03 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2290344eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775294401; x=1775899201; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4D9KIHfQ19G+ih5n0VIDlQHW6gYQM9spmrNFkW8GpA=;
        b=YV2188owzZSlzUO0juFWhwwwsZlHDQqvKDu1LYpefR2wILMiZplb8sKw1Lou1uv1EN
         EmZqDJXfYujO7lAPTTJc8Jjy2fiatvJxa2J9GREkWtxzAHfDyMvtePKURO6HRSqfTyY5
         67z2fQoDDJ6EDrj2Okytizkk52BVe6FooZSYxnSoIfNjiHdLhyApfw7wHoVsl4avfDMK
         IzI20bY8ITmUl4CNc6dYpbfwLONrgbRgZOlSdnvd6SxYeS7EPYrjKTzzy/leLoD6j+g3
         54d4veseNrE2ozCtINj7RCCjZyIuBDWQEtSDff0f7gM8s9fO8uKi0ARO6ayl2AJTdYAE
         kdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775294401; x=1775899201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4D9KIHfQ19G+ih5n0VIDlQHW6gYQM9spmrNFkW8GpA=;
        b=dDl1nnyRXkIyVS+gXxEadLEP6TxUKOc4TtiGVaeV+QspFHvR5gRVJLca/XLt88Jw1U
         hABDy63smP0SzdXBBcE9LzIfMF1Ht5/NyhOxvZVbs9PuWweDniAhBcVuGhfuafuLUyJU
         glpPocLCVWb1QLEKvwvmX1c/jnYfedKKSZDNb9hoUPNCI3+h9UPgWkWIzlw7AFEkrJ/h
         uUtGHB0FtzgaZ1neV+bTjbpf93gTfvh4AgmlnwPX820fz2h7w1EOn+N58tHr48y8Ui6d
         Q0Nr5brydzVHF6ETGWyONK7nSP95fXwO0B+q4hlf4O0PAQ26UPtyR504KEe+zTJFcR4O
         VvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg1EVFdefLxKUA2gi/qoX+oqGthSgo7Im9Izzo7SHAAU3bjFiGhzk1wJe9X9pSNSm2h/L6YnFAYn5f8PQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKATTj3lf0XUN1RKSjwMhXwxDOll+MbjyVrJw7G4jVyiSSZTen
	aRu6AKilbPvqzgnHaMNgxhOd5LoM0gcVTnNuZElIKr88uDZNo4ZJXsyK
X-Gm-Gg: AeBDievwsi2Lutay5TJP+ZZGooe45838AFVmS2bXhhkGfsyBL+1TUE+qznvsp9wnlvY
	hGMHNi9bQXUHcs+UlCYlyGci4SZHLCwrf4nTc1LgawbMOeUNHQI6h4nPhjPWFT0FPzz4asMDqLS
	vfhR3LFuyonPuyieilDE0WgPJYJ0WmKWiAqOheMTKazZ+S1TKz7GR6i4DAc+fHjmQiLjZwmKtd1
	S+JBgdHb97/m/tfF9ivGZYGSOCIpxpzbWcSFnvoLo/6Y2n2JqM3Q62u33hcuRU5wo1uX2nr6ZfA
	Sx8xflE1hcTSGlliMIHK8aXSs5CSsFkCh/Gnm8+bsdcaRv65CAb3OjRt9rJWBTYI5Bjrr8spwT1
	ye9F1gok94UrQURw7rFiTO6BMJwVFBkjDsFo3ljW8DRHuFMZqjaHEObxYkv51VgdZJN0zvhiVnZ
	mYv8troE87rHlu91RGKp2hgtI=
X-Received: by 2002:a05:7300:a287:b0:2c1:74ad:2cd7 with SMTP id 5a478bee46e88-2cbfbf760c4mr2791873eec.27.1775294400761;
        Sat, 04 Apr 2026 02:20:00 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm7176920eec.5.2026.04.04.02.19.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 02:20:00 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	surenb@google.com,
	willy@infradead.org,
	wang lian <lianux.mm@gmail.com>,
	Wang Lian <wanglian@kylinos.cn>,
	Kunwu Chan <chentao@kylinos.cn>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying page faults after I/O
Date: Sat,  4 Apr 2026 17:19:32 +0800
Message-ID: <20260404091936.51961-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAGsJ_4wnwAet4svDrxT4sTdp24sweAU-2VyYn3iNPOoaKdXxPw@mail.gmail.com>
References: <CAGsJ_4wnwAet4svDrxT4sTdp24sweAU-2VyYn3iNPOoaKdXxPw@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Barry,

> If either you or Matthew have a reproducer for this issue, I’d be
> happy to try it out.

Kunwu and I evaluated this series ("mm: continue using per-VMA lock when
retrying page faults after I/O") under a stress scenario specifically
designed to expose the retry behavior in filemap_fault(). This models
the exact situation described by Matthew Wilcox [1], where retries after
I/O fail to make forward progress under memory pressure.

The scenario targets the critical window between I/O completion and
mmap_lock reacquisition. This workload deliberately includes frequent
mmap/munmap operations to simulate a highly contended mmap_lock
environment alongside severe memory pressure (1GB memcg limit). Under
this pressure, folios instantiated by the I/O can be aggressively
reclaimed before the delayed task can re-acquire the lock and install
the PTE, forcing retries to repeat the entire work.

To make this behavior reproducible, we constructed a stress setup that
intentionally extends this interval:
* 256-core x86 system
* 1GB memory cgroup
* 500 threads continuously faulting on a 16MB file

The core reproducer and the execution command are provided below:

#define _GNU_SOURCE 
#include <errno.h> 
#include <fcntl.h> 
#include <pthread.h> 
#include <stdatomic.h> 
#include <stdint.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <sys/mman.h> 
#include <unistd.h> 
#include <time.h> 

#define THREADS 500 
#define FILE_SIZE (16 * 1024 * 1024) /* 16MB */ 

static _Atomic int g_stop = 0; 
#define RUN_SECONDS 600 

struct worker_arg { 
        long id; 
        uint64_t *counts; 
}; 

void *worker(void *arg) 
{ 
        struct worker_arg *wa = (struct worker_arg *)arg; 
        long id = wa->id; 
        char path[64]; 
        uint64_t local_rounds = 0; 

        snprintf(path, sizeof(path), "./test_file_%d_%ld.dat", 
                 getpid(), id); 
        int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666); 
        if (fd < 0) return NULL; 
        if (ftruncate(fd, FILE_SIZE) < 0) { 
                close(fd); return NULL; 
        } 

        while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) { 
                char *f_map = mmap(NULL, FILE_SIZE, PROT_READ, 
                                   MAP_SHARED, fd, 0); 
                if (f_map != MAP_FAILED) { 
                        /* Pure page cache thrashing */ 
                        for (int i = 0; i < FILE_SIZE; i += 4096) { 
                                volatile unsigned char c = 
                                        (unsigned char)f_map[i]; 
                                (void)c; 
                        } 
                        munmap(f_map, FILE_SIZE); 
                        local_rounds++; 
                } 
        } 
        wa->counts[id] = local_rounds; 
        close(fd); 
        unlink(path); 
        return NULL; 
} 

int main(void) 
{ 
        printf("Pure File Thrashing Started. PID: %d\n", getpid()); 
        pthread_t t[THREADS]; 
        uint64_t local_counts[THREADS]; 
        memset(local_counts, 0, sizeof(local_counts)); 
        struct worker_arg args[THREADS]; 

        for (long i = 0; i < THREADS; i++) { 
                args[i].id = i; 
                args[i].counts = local_counts; 
                pthread_create(&t[i], NULL, worker, &args[i]); 
        } 

        sleep(RUN_SECONDS); 
        atomic_store_explicit(&g_stop, 1, memory_order_relaxed); 

        for (int i = 0; i < THREADS; i++) pthread_join(t[i], NULL); 

        uint64_t total = 0; 
        for (int i = 0; i < THREADS; i++) total += local_counts[i]; 

        printf("Total rounds     : %llu\n", (unsigned long long)total); 
        printf("Throughput       : %.2f rounds/sec\n", 
               (double)total / RUN_SECONDS); 
        return 0; 
}

Command line used for the test:
systemd-run --scope -p MemoryHigh=1G -p MemoryMax=1.2G -p MemorySwapMax=0 \
--unit=mmap-thrash-$$ ./mmap_lock & \
TEST_PID=$!

We also added temporary counters in page fault retries [2]:
- RETRY_IO_MISS   : folio not present after I/O completion
- RETRY_MMAP_DROP : retry fallback due to waiting for I/O

We report representative runs from our 600-second test iterations 
(kernel v7.0-rc3):

| Case                | Total Rounds | Throughput | Miss/Drop(%) | RETRY_MMAP_DROP | RETRY_IO_MISS |
| ------------------- | ------------ | ---------- | ------------ | --------------- | ------------- |
| Baseline (Run 1)    | 22,711       | 37.85 /s   | 45.04        | 970,078         | 436,956       |
| Baseline (Run 2)    | 23,530       | 39.22 /s   | 44.96        | 972,043         | 437,077       |
| With Series (Run A) | 54,428       | 90.71 /s   | 1.69         | 1,204,124       | 20,398        |
| With Series (Run B) | 35,949       | 59.91 /s   | 0.03         | 327,023         | 99            |


Notes:
1. Throughput Improvement: During the 600-second testing window, overall 
   workload throughput can more than double (e.g., Run A jumped from ~38 
   to 90.71 rounds/sec).
2. Elimination of Race Condition: Without the patch, ~45% of retries 
   were invalid because newly fetched folios were evicted during the 
   mmap_lock reacquisition delay. With the per-VMA retry path, the 
   invalidation ratio plummeted to near zero (0.03% - 1.69%).
3. Counter Scaling and Variance: In Run A, because the I/O wait 
   bottleneck is eliminated, the threads advance much faster. Thus, the 
   absolute number of mmap_lock drops naturally scales up with the 
   increased throughput. In Run B, the primary bottleneck shifts to the 
   mmap write-lock contention (lock convoying), causing throughput and 
   total drops to fluctuate. Crucially, the Miss/Drop ratio remains near 
   zero regardless of this variance.

Without this series, almost half of the retries fail to observe
completed I/O results, causing severe CPU and I/O waste. With the
finer-grained VMA lock, the faulting threads bypass the heavily
contended mmap_lock entirely during retries, completing the fault
almost instantly.

This scenario perfectly aligns with the exact concern raised, and these
results show that the patch not only successfully eliminates the retry
inefficiency but also tangibly boosts macro-level system throughput.

[1] https://lore.kernel.org/linux-mm/aSip2mWX13sqPW_l@casper.infradead.org/
[2] https://github.com/lianux-mm/ioretry_test/

Tested-by: Wang Lian <wanglian@kylinos.cn>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Wang Lian <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

--
Best Regards,
wang lian


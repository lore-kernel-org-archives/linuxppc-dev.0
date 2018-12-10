Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E3C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 14:50:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C16220851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 14:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C16220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D5c10F7kzDqyj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 01:50:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D5Yk5RWDzDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 01:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iogearbox.net
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43D5Yk3wdkz8t1p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 01:48:58 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43D5Yk3Y3Tz9s55; Tue, 11 Dec 2018 01:48:58 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iogearbox.net
 (client-ip=213.133.104.62; helo=www62.your-server.de;
 envelope-from=daniel@iogearbox.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iogearbox.net
X-Greylist: delayed 1337 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 01:48:58 AEDT
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43D5Yk06pGz9s4s
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2018 01:48:57 +1100 (AEDT)
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1gWMW1-0006Oe-JZ; Mon, 10 Dec 2018 15:26:33 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
 by sslproxy06.your-server.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daniel@iogearbox.net>)
 id 1gWMW1-000BNi-DN; Mon, 10 Dec 2018 15:26:33 +0100
Subject: Re: [PATCH] bpf: fix overflow of bpf_jit_limit when PAGE_SIZE >= 64K
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org
References: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
 <87pnudjz72.fsf@concordia.ellerman.id.au>
 <154419700199.27049.4999726632209685368@sif>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <428482af-6202-4ad7-0548-0bfdd4d4ce94@iogearbox.net>
Date: Mon, 10 Dec 2018 15:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <154419700199.27049.4999726632209685368@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25194/Mon Dec 10 11:16:15 2018)
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
Cc: linuxppc-dev@ozlabs.org, Sandipan Das <sandipan@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/07/2018 04:36 PM, Michael Roth wrote:
> Quoting Michael Ellerman (2018-12-07 06:31:13)
>> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
>>
>>> Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
>>> JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
>>> and is adjusted again at init time if MODULES_VADDR is defined.
>>>
>>> For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with
>>
>> But maybe it should be, I don't know why we don't define it.
>>
>>> the compile-time default at boot-time, which is 0x9c400000 when
>>> using 64K page size. This overflows the signed 32-bit bpf_jit_limit
>>> value:
>>>
>>>   root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
>>>   -1673527296
>>>
>>> and can cause various unexpected failures throughout the network
>>> stack. In one case `strace dhclient eth0` reported:
>>>
>>>   setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=11, filter=0x105dd27f8}, 16) = -1 ENOTSUPP (Unknown error 524)
>>>
>>> and similar failures can be seen with tools like tcpdump. This doesn't
>>> always reproduce however, and I'm not sure why. The more consistent
>>> failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9 host
>>> would time out on systemd/netplan configuring a virtio-net NIC with no
>>> noticeable errors in the logs.
>>>
>>> Fix this by limiting the compile-time default for bpf_jit_limit to
>>> INT_MAX.
>>
>> INT_MAX is a lot more than (4k * 40000), so I guess I'm not clear on
>> whether we should be using PAGE_SIZE here at all. I guess each BPF
>> program uses at least one page is the thinking?
> 
> That seems to be the case, at least, the max number of minimum-sized
> allocations would be less on ppc64 since the allocations are always at
> least PAGE_SIZE in size. The init-time default also limits to INT_MAX,
> so it seemed consistent to do that here too.
> 
>>
>> Thanks for tracking this down. For some reason none of my ~10 test boxes
>> have hit this, perhaps I don't have new enough userspace?
> 
> I'm not too sure, I would've thought things like the dhclient case in
> the commit log would fail every time, but sometimes I need to reboot the
> guest before I start seeing the behavior. Maybe there's something special
> about when JIT allocations are actually done that can affect
> reproducibility?
> 
> In my case at least the virtio-net networking timeout was consistent
> enough for a bisect, but maybe it depends on the specific network
> configuration (single NIC, basic DHCP through netplan/systemd in my case).
> 
>>
>> You don't mention why you needed to add BPF_MIN(), I assume because the
>> kernel version of min() has gotten too complicated to work here?
> 
> I wasn't sure if it was safe here or not, so I tried looking at other
> users and came across:
> 
> mm/vmalloc.c:777:#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> 
> I'm not sure what the reasoning was (or whether it still applies), but I
> figured it was safer to do the same here. Maybe Nick still recalls?
> 
>>
>> Daniel I assume you'll merge this via your tree?
>>
>> cheers
>>
>>> Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allocations")
>>> Cc: linuxppc-dev@ozlabs.org
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Sandipan Das <sandipan@linux.ibm.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks for the reports / fixes and sorry for my late reply (bit too
swamped last week), some more thoughts below.

>>>  kernel/bpf/core.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index b1a3545d0ec8..55de4746cdfd 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -365,7 +365,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>>>  }
>>>  
>>>  #ifdef CONFIG_BPF_JIT
>>> -# define BPF_JIT_LIMIT_DEFAULT       (PAGE_SIZE * 40000)
>>> +# define BPF_MIN(x, y) ((x) < (y) ? (x) : (y))
>>> +# define BPF_JIT_LIMIT_DEFAULT       BPF_MIN((PAGE_SIZE * 40000), INT_MAX)
>>>  
>>>  /* All BPF JIT sysctl knobs here. */
>>>  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);

I would actually just like to get rid of the BPF_JIT_LIMIT_DEFAULT
define also given for 4.21 arm64 will have its own dedicated area for
JIT allocations where neither the above limit nor the MODULES_END/
MODULES_VADDR one would fit and I don't want to make this even more
ugly with adding further cases into the core. Would the below variant
work for you?

Thanks,
Daniel

From da9daf462d41ce5506c6b6318a9fa3d6d8a64f6c Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 10 Dec 2018 14:30:27 +0100
Subject: [PATCH bpf] bpf: fix bpf_jit_limit knob for PAGE_SIZE >= 64K

Michael and Sandipan report:

  Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
  JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
  and is adjusted again at init time if MODULES_VADDR is defined.

  For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with
  the compile-time default at boot-time, which is 0x9c400000 when
  using 64K page size. This overflows the signed 32-bit bpf_jit_limit
  value:

  root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
  -1673527296

  and can cause various unexpected failures throughout the network
  stack. In one case `strace dhclient eth0` reported:

  setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=11, filter=0x105dd27f8},
             16) = -1 ENOTSUPP (Unknown error 524)

  and similar failures can be seen with tools like tcpdump. This doesn't
  always reproduce however, and I'm not sure why. The more consistent
  failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9
  host would time out on systemd/netplan configuring a virtio-net NIC
  with no noticeable errors in the logs.

Given this and also given that in near future some architectures like
arm64 will have a custom area for BPF JIT image allocations we should
get rid of the BPF_JIT_LIMIT_DEFAULT fallback / default entirely. For
4.21, we have an overridable bpf_jit_alloc_exec(), bpf_jit_free_exec()
so therefore add another overridable bpf_jit_alloc_exec_limit() helper
function which returns the possible size of the memory area for deriving
the default heuristic in bpf_jit_charge_init().

Like bpf_jit_alloc_exec() and bpf_jit_free_exec(), the new
bpf_jit_alloc_exec_limit() assumes that module_alloc() is the default
JIT memory provider, and therefore in case archs implement their custom
module_alloc() we use MODULES_{END,_VADDR} for limits and otherwise for
vmalloc_exec() cases like on ppc64 we use VMALLOC_{END,_START}.

Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allocations")
Reported-by: Sandipan Das <sandipan@linux.ibm.com>
Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b1a3545..6c2332e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -365,13 +365,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 }

 #ifdef CONFIG_BPF_JIT
-# define BPF_JIT_LIMIT_DEFAULT	(PAGE_SIZE * 40000)
-
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
 int bpf_jit_harden   __read_mostly;
 int bpf_jit_kallsyms __read_mostly;
-int bpf_jit_limit    __read_mostly = BPF_JIT_LIMIT_DEFAULT;
+int bpf_jit_limit    __read_mostly;

 static __always_inline void
 bpf_get_prog_addr_region(const struct bpf_prog *prog,
@@ -580,16 +578,27 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,

 static atomic_long_t bpf_jit_current;

+/* Can be overridden by an arch's JIT compiler if it has a custom,
+ * dedicated BPF backend memory area, or if neither of the two
+ * below apply.
+ */
+u64 __weak bpf_jit_alloc_exec_limit(void)
+{
 #if defined(MODULES_VADDR)
+	return MODULES_END - MODULES_VADDR;
+#else
+	return VMALLOC_END - VMALLOC_START;
+#endif
+}
+
 static int __init bpf_jit_charge_init(void)
 {
 	/* Only used as heuristic here to derive limit. */
-	bpf_jit_limit = min_t(u64, round_up((MODULES_END - MODULES_VADDR) >> 2,
+	bpf_jit_limit = min_t(u64, round_up(bpf_jit_alloc_exec_limit() >> 2,
 					    PAGE_SIZE), INT_MAX);
 	return 0;
 }
 pure_initcall(bpf_jit_charge_init);
-#endif

 static int bpf_jit_charge_modmem(u32 pages)
 {
-- 
2.9.5


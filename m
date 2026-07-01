Return-Path: <linuxppc-dev+bounces-23294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0460C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtwf33pMz2xPb;
	Wed, 01 Jul 2026 18:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895746;
	cv=none; b=jcoAdNo8j58yFwkpYr1J4Hl8qqbXlARn+6tgukeBy3uxW7EVsdGlHe3ANhCm2Di+CjRRqWakc/8GxAfLSftiFo85F0S9HWleJdhznepOL+lGF20hXlN2M8t7tbz05Tgz49NG3GGvRYFZASaylfNynB+5fFKFOSDghGCyOWWGPibi5WafpQE57BkXLNqJH5SbcnpjoghAH9kNN0hgJQsQ8L0sDz77FrgfiZhM8atIq89aRX8NyxLVjdNXmEiycWJ+QffCYmNmWZ1CEj2kq2kMJh5vweLEuMGSG9D8hlP9gMWgE8TO8vfdtZ6fJa6eBS7VBFFcwsInlEy51dF+VOIjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895746; c=relaxed/relaxed;
	bh=Qwh3iCvPoscNvLdWAClhJFPVit/GjXCDqMIF/PB2xCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN8ipeblcqRBdlpk2Xk+9JXgagrljvV5OFSVzDKs5Nst1J0s861s5LskTuVHrWTMnr199elqgeauAWpUKZTHddC5EOd7qq/P/JoQGP56tmp6xdz5vWiEPMSAys1khKhlGJkNYXeE0AlisXpUQgbUoH1hHlBDUWdxQNgMqhHoB7kqYnw1Mb602chuoZbznE+zAUB0RO2Z4Bm4ygy3eGiSzfhX95aK7c9zB5YGjKu+qfMYUIIapX8Zp+Zxie9aIzwz1N81XHBIzIhnNuhhPFqOW1sazFUin/fJI+//2qDewnarew0yaezjrlnHQ0X/HpDhE6QDO1ekkJFt6BWXjDWJvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHHaODqK; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHHaODqK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtwc1YRDz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:49:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3184D4406B;
	Wed,  1 Jul 2026 08:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93CD1F00A3E;
	Wed,  1 Jul 2026 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782895741;
	bh=Qwh3iCvPoscNvLdWAClhJFPVit/GjXCDqMIF/PB2xCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UHHaODqKt/7I9kXLn5TRk/fGFrTWSf+1LZEkQYk+MTXMVHcxP82H+QCE1Q4eJRcV4
	 ASOoFiFBROJEEEqNF1rVfK9VdTGcwlgUdmZzWiXZoCqoEu1Wi6o36I5lzUkAywYgot
	 t7axQEnnKW2HBT98BSGCa89fsvXVNaBwyuYW4znYMpISemm7MRb90bgvv1TxrRKBbM
	 em+fjdvJ7SYMrdhRnFWhGQDCzNP3ZH5nLCIEXNtwn3N+65hIlCfXa9NmJc4GrCbl4K
	 rGiwqMy6MYajD0EfCPwhZ+tNtN7YzoBE76wpWB6b+3JfTckZTOnz6L2ti/RA/UmALH
	 mIoCtChly3Liw==
Message-ID: <32a42e83-3e5e-4b00-b78c-d762094b9d76@kernel.org>
Date: Wed, 1 Jul 2026 10:48:55 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: handle EINVAL when configuring
 gigantic hugepages
To: Sayali Patil <sayalip@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1782811071.git.sayalip@linux.ibm.com>
 <3d394c8cd59fe380d4e2d13b051544f241918f07.1782811071.git.sayalip@linux.ibm.com>
 <ccba342f-1ed0-43fe-ac59-9b8bbfb168d4@kernel.org>
 <968b496a-a83e-491a-950c-3f6f975fa5f5@linux.ibm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <968b496a-a83e-491a-950c-3f6f975fa5f5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/30/26 22:20, Sayali Patil wrote:
> 
> 
> On 30/06/26 16:15, David Hildenbrand (Arm) wrote:
>> On 6/30/26 11:32, Sayali Patil wrote:
>>> Some MM selftests attempt to configure the amount of
>>> HugeTLB pages of different sizes by writing to nr_hugepages.
>>>
>>> PowerPC hash MMU pSeries systems advertise gigantic hugepage sizes
>>> but do not support runtime allocation of such pages, writes
>>> to the corresponding nr_hugepages file fail with -EINVAL.
>>> This causes the test to bail out even though the failure is due
>>> to a platform limitation rather than the
>>> functionality being tested.
>>>
>>> Treat -EINVAL from the sysfs write as a skipped configuration request
>>> and continue running the test instead of failing.
>>>
>>> Before patch:
>>>     -------------------------
>>>     running ./hugetlb-madvise
>>>     -------------------------
>>>     TAP version 13
>>>     1..1
>>>       [INFO] detected hugetlb page size: 16777216 KiB
>>>       [INFO] detected hugetlb page size: 16384 KiB
>>>      ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>>      Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>      Bail out! /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>>      write(0) failed: Invalid argument
>>>      Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>      [FAIL]
>>>
>>> After patch:
>>>     -------------------------
>>>     running ./hugetlb-madvise
>>>     -------------------------
>>>     TAP version 13
>>>     1..1
>>>      [INFO] detected hugetlb page size: 16777216 KiB
>>>      [INFO] detected hugetlb page size: 16384 KiB
>>>     ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>>     Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>     /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>>     write(0) failed: Invalid argument
>>>     [PASS]
>>>
>>> Fixes: 27477b28b74f ("selftests/mm: hugepage_settings: add APIs to get and
>>> set nr_hugepages")
>>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>>> ---
>>>   .../testing/selftests/mm/hugepage_settings.c  | 32 ++++++++++++++++++-
>>>   .../testing/selftests/mm/hugepage_settings.h  |  1 +
>>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/hugepage_settings.c b/tools/testing/
>>> selftests/mm/hugepage_settings.c
>>> index 2eab2110ac6a..ce38ae3da01a 100644
>>> --- a/tools/testing/selftests/mm/hugepage_settings.c
>>> +++ b/tools/testing/selftests/mm/hugepage_settings.c
>>> @@ -422,6 +422,36 @@ static void hugetlb_sysfs_path(char *buf, size_t buflen,
>>>            size / 1024, attr);
>>>   }
>>>   +void hugetlb_write_num(const char *path, unsigned long num)
>>> +{
>>> +    int fd, saved_errno;
>>> +    ssize_t numwritten;
>>> +    char buf[21];
>>> +
>>> +    sprintf(buf, "%lu", num);
>>> +
>>> +    fd = open(path, O_WRONLY);
>>> +    if (fd == -1)
>>> +        ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
>>> +
>>> +    numwritten = write(fd, buf, strlen(buf));
>>> +    saved_errno = errno;
>>> +    close(fd);
>>> +    errno = saved_errno;
>>> +
>>> +    /* Treat EINVAL as a skipped configuration (e.g., unsupported gigantic
>>> pages) */
>>> +    if (numwritten < 0 && errno == EINVAL) {
>>> +        ksft_print_msg("%s write(%s) failed: %s\n", path, buf,
>>> strerror(errno));
>>
>> Should we even print anything here? Rather confusing. It's just like we cannot
>> allocate anything (no memory).
>>
>> In general, you are copy-pasting a lot of write_num()+write_file() content,
>> which is really suboptimal.
>>
>> All you want is an option for write_num -> write_file to skip on -EINVAL,
>> correct?
>>
>> There are not that many write_num / write_file users ...
>>
> 
> Hi David,
> 
> Yes, all I need is to ignore the expected -EINVAL when attempting to
> configure gigantic hugepages via nr_hugepages.
> 
> I looked at extending write_num()/write_file() for this as in v1
> (https://lore.kernel.org/
> all/8bfa921e30eb94072685103f6496784aa23bb166.1782365671.git.sayalip@linux.ibm.com/),
> but these helpers are shared by several other selftests.
> For example, write_file() is used by split_huge_page_test setup and by
> khugepaged tests for drop_caches, and is also used for various THP and
> khugepaged settings where -EINVAL would indicate a genuine setup
> failure. This concern was also raised during the v1 review.
> 
> Because the expected -EINVAL is specific to gigantic hugepage runtime
> allocation, I kept the handling local to the hugetlb setup path rather
> than changing the semantics of the common helpers.
> 
> I also agree that printing a message is not particularly useful in this
> case, and we can simply return without emitting any output.

We can either convert the functions to use flags, or hide it in some internal helpers, like the following:

From 1b1b8ad51f1f0be469cb191736300254b9521fe4 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 1 Jul 2026 10:45:16 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 tools/testing/selftests/mm/vm_util.c | 28 ++++++++++++++++++++++++----
 tools/testing/selftests/mm/vm_util.h |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 311fc5b4513eb..362070f817e9b 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -719,7 +719,8 @@ int read_file(const char *path, char *buf, size_t buflen)
 	return (unsigned int) numread;
 }
 
-void write_file(const char *path, const char *buf, size_t buflen)
+static int __write_file(const char *path, const char *buf, size_t buflen,
+		bool ignore_einval)
 {
 	int fd, saved_errno;
 	ssize_t numwritten;
@@ -735,14 +736,23 @@ void write_file(const char *path, const char *buf, size_t buflen)
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	if (numwritten < 0)
+
+	if (numwritten < 0) {
+		if (ignore_einval && errno == EINVAL)
+			return;
 		ksft_exit_fail_msg("%s write(%.*s) failed: %s\n", path, (int)(buflen - 1),
 				buf, strerror(errno));
+	}
 	if (numwritten != buflen - 1)
 		ksft_exit_fail_msg("%s write(%.*s) is truncated, expected %zu bytes, got %zd bytes\n",
 				path, (int)(buflen - 1), buf, buflen - 1, numwritten);
 }
 
+static void write_file(const char *path, const char *buf, size_t buflen)
+{
+	__write_file(path, bug, buflen, /* ignore_einval = */ false);
+}
+
 unsigned long read_num(const char *path)
 {
 	char buf[21];
@@ -753,12 +763,22 @@ unsigned long read_num(const char *path)
 	return strtoul(buf, NULL, 10);
 }
 
-void write_num(const char *path, unsigned long num)
+static void __write_num(const char *path, unsigned long num, bool ignore_einval)
 {
 	char buf[21];
 
 	sprintf(buf, "%lu", num);
-	write_file(path, buf, strlen(buf) + 1);
+	write_file(path, buf, strlen(buf) + 1, ignore_einval);
+}
+
+void write_num(const char *path, unsigned long num)
+{
+	return __write_num(path, num, /* ignore_einval = */ false);
+}
+
+void write_num_ignore_einval(const char *path, unsigned long num)
+{
+	return __write_num(path, num, /* ignore_einval = */ true);
 }
 
 static unsigned long shmall, shmmax;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index ea8fc8fdf0eb0..7799154b67eed 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -168,6 +168,7 @@ void write_file(const char *path, const char *buf, size_t buflen);
 int read_file(const char *path, char *buf, size_t buflen);
 unsigned long read_num(const char *path);
 void write_num(const char *path, unsigned long num);
+void write_num_ignore_einval(const char *path, unsigned long num);
 
 void shm_limits_prepare(unsigned long length);
 void __shm_limits_restore(void);
-- 
2.43.0


-- 
Cheers,

David


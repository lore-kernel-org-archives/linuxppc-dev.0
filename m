Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC07C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 12:52:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1862070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 12:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1862070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T9xn4ZlzzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 23:51:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=molgen.mpg.de
 (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T9vH3q06zDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 23:49:40 +1100 (AEDT)
Received: from [172.18.205.202] (unknown [46.183.103.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 61CB9604E3A59;
 Tue, 26 Mar 2019 13:49:35 +0100 (CET)
Subject: Re: Reading `/sys/kernel/debug/kmemleak` takes 3 s and content not
 shown
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <88e651e2-d876-376e-81fa-eab0729ebb47@molgen.mpg.de>
Message-ID: <f18fb509-bee1-e411-3761-bd28a0d8aab7@molgen.mpg.de>
Date: Tue, 26 Mar 2019 13:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <88e651e2-d876-376e-81fa-eab0729ebb47@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Linux folks,


On 19.02.19 10:44, Paul Menzel wrote:

> On a the IBM S822LC (8335-GTA) with Ubuntu 18.10, and Linux 5.0-rc5+
> accessing `/sys/kernel/debug/kmemleak` takes a long time. According to
> strace it takes three seconds.
> 
> ```
> $ sudo strace -tt -T cat /sys/kernel/debug/kmemleak
> 10:35:49.861641 execve("/bin/cat", ["cat", "/sys/kernel/debug/kmemleak"], 0x7ffffdbcb518 /* 16 vars */) = 0 <0.000293>
> 10:35:49.862112 brk(NULL)               = 0x75b12a50000 <0.000012>
> 10:35:49.862190 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory) <0.000015>
> 10:35:49.862261 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory) <0.000015>
> 10:35:49.862324 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3 <0.000018>
> 10:35:49.862389 fstat(3, {st_mode=S_IFREG|0644, st_size=143482, ...}) = 0 <0.000011>
> 10:35:49.862444 mmap(NULL, 143482, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7ce4a1150000 <0.000017>
> 10:35:49.862501 close(3)                = 0 <0.000011>
> 10:35:49.862550 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory) <0.000015>
> 10:35:49.862615 openat(AT_FDCWD, "/lib/powerpc64le-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3 <0.000019>
> 10:35:49.862676 read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\25\0\1\0\0\0pN\2\0\0\0\0\0"..., 832) = 832 <0.000011>
> 10:35:49.862731 fstat(3, {st_mode=S_IFREG|0755, st_size=2310856, ...}) = 0 <0.000011>
> 10:35:49.862783 mmap(NULL, 2380672, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ce4a0f00000 <0.000018>
> 10:35:49.862842 mprotect(0x7ce4a1120000, 65536, PROT_NONE) = 0 <0.000019>
> 10:35:49.862899 mmap(0x7ce4a1130000, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x220000) = 0x7ce4a1130000 <0.000019>
> 10:35:49.862990 close(3)                = 0 <0.000010>
> 10:35:49.863110 mprotect(0x7ce4a1130000, 65536, PROT_READ) = 0 <0.000017>
> 10:35:49.863192 mprotect(0x75ad43b0000, 65536, PROT_READ) = 0 <0.000016>
> 10:35:49.863252 mprotect(0x7ce4a11e0000, 65536, PROT_READ) = 0 <0.000015>
> 10:35:49.863305 munmap(0x7ce4a1150000, 143482) = 0 <0.000022>
> 10:35:49.863446 brk(NULL)               = 0x75b12a50000 <0.000011>
> 10:35:49.863495 brk(0x75b12a80000)      = 0x75b12a80000 <0.000014>
> 10:35:49.863561 openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3 <0.000019>
> 10:35:49.863624 fstat(3, {st_mode=S_IFREG|0644, st_size=6035920, ...}) = 0 <0.000010>
> 10:35:49.863677 mmap(NULL, 6035920, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7ce4a0930000 <0.000017>
> 10:35:49.863736 close(3)                = 0 <0.000011>
> 10:35:49.863828 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0 <0.000010>
> 10:35:49.863881 openat(AT_FDCWD, "/sys/kernel/debug/kmemleak", O_RDONLY) = 3 <0.000034>
> 10:35:49.863956 fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0 <0.000029>
> 10:35:49.864028 fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0 <0.000011>
> 10:35:49.864076 mmap(NULL, 262144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ce4a08f0000 <0.000017>
> 10:35:49.864146 read(3, "", 131072)     = 0 <3.528503>
> 10:35:53.392797 munmap(0x7ce4a08f0000, 262144) = 0 <0.000092>
> 10:35:53.392957 close(3)                = 0 <0.000029>
> 10:35:53.393038 close(1)                = 0 <0.000010>
> 10:35:53.393078 close(2)                = 0 <0.000009>
> 10:35:53.393123 exit_group(0)           = ?
> 10:35:53.393280 +++ exited with 0 +++
> $ uname -a
> Linux flughafenberlinbrandenburgwillybrandt 5.0.0-rc5+ #1 SMP Thu Feb 7 11:23:11 CET 2019 ppc64le ppc64le ppc64le GNU/Linux
> $ more /proc/version
> Linux version 5.0.0-rc5+ (pmenzel@flughafenberlinbrandenburgwillybrandt) (gcc version 8.2.0 (Ubuntu 8.2.0-7ubuntu1)) #1 SMP Thu Feb 7 11:23:11 CET 2019
> $ more /proc/cmdline
> root=UUID=2c3dd738-785a-469b-843e-9f0ba8b47b0d ro rootflags=subvol=@ quiet splash
> $ grep KMEMLEAK /boot/config-5.0.0-rc5+
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=10000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> $ grep KMEMLEAK /boot/config-4.18.0-rc4+
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=10000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> $ dmesg | grep leak
> [    4.407957] kmemleak: Kernel memory leak detector initialized
> [    4.407959] kmemleak: Automatic memory scanning thread started
> [745989.625624] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> [1002619.951902] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> ```
> 
> Unfortunately, the leaks supposedly stored in that file are not shown
> either.

The problem is still present with Linux 5.0. Do you have an idea, how to 
fix this?


Kind regards,

Paul

Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:26:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C4820850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C4820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449qvM6RD7zDqWp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:26:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449qsV1f5KzDqPZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 00:25:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 449qsT4nXNz9s7h;
 Sat,  2 Mar 2019 00:25:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jakub Drnec <jaydee@email.cz>, linuxppc-dev@lists.ozlabs.org
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
In-Reply-To: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
Date: Sat, 02 Mar 2019 00:24:57 +1100
Message-ID: <877edik9qu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <john.stultz@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jakub,

[Cc += Timekeeping maintainers]

"Jakub Drnec" <jaydee@email.cz> writes:
> Hi all,
>
> I think I observed a potential problem, is this the correct place to report it? (CC me, not on list)
>
> [1.] One line summary: monotonic clock can be made to decrease on ppc64
> [2.] Full description:
> Setting the realtime clock can sometimes make the monotonic clock go back by over a hundred years.
> Decreasing the realtime clock across the y2k38 threshold is one reliable way to reproduce.
> Allegedly this can also happen just by running ntpd, I have not managed to reproduce that other
> than booting with rtc at >2038 and then running ntp.
> When this happens, anything with timers (e.g. openjdk) breaks rather badly.

Thanks for the report.

> The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.

You're right, the wall-to-monotonic offset (wtom_clock_sec) is a signed
32-bit value, so that seems like it's going to have problems.

If I do `date -s 2037-1-1` I see:

[   26.024061] update_vsyscall: tk->wall_to_monotonic.tv_sec -2114341175
[   26.042633] update_vsyscall: vdso_data->wtom_clock_sec    -2114341175

Which looks sane.

But then 2040-1-1 shows:

[   32.617020] update_vsyscall: tk->wall_to_monotonic.tv_sec -2208949168
[   32.632642] update_vsyscall: vdso_data->wtom_clock_sec     2086018128

ie. the larger negative offset has overflowed and become positive.

But then when we go back to 2037 we get a negative offset again and
monotonic time appears to go backward and things are unhappy.

I don't know this code well, but the patch below *appears* to work. I'll
have a closer look on Monday.

cheers


diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 1afe90ade595..139133ec21d5 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -82,7 +82,7 @@ struct vdso_data {
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
 	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
+	__s64 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a4ed9edfd5f0..1f324c28705b 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -92,7 +92,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	 * At this point, r4,r5 contain our sec/nsec values.
 	 */
 
-	lwa	r6,WTOM_CLOCK_SEC(r3)
+	ld	r6,WTOM_CLOCK_SEC(r3)
 	lwa	r9,WTOM_CLOCK_NSEC(r3)
 
 	/* We now have our result in r6,r9. We create a fake dependency
@@ -125,7 +125,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	bne     cr6,75f
 
 	/* CLOCK_MONOTONIC_COARSE */
-	lwa     r6,WTOM_CLOCK_SEC(r3)
+	ld	r6,WTOM_CLOCK_SEC(r3)
 	lwa     r9,WTOM_CLOCK_NSEC(r3)
 
 	/* check if counter has updated */


> [3.] Keywords: gettimeofday, ppc64, vdso
> [4.] Kernel information
> [4.1.] Kernel version: any (tested on 4.19)
> [4.2.] Kernel .config file: any
> [5.] Most recent kernel version which did not have the bug: not a regression
> [6.] Output of Oops..: not applicable
> [7.] Example program which triggers the problem
> --- testcase.c
> #include <stdio.h>
> #include <time.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> long get_time() {
>   struct timespec tp;
>   if (clock_gettime(CLOCK_MONOTONIC, &tp) != 0) {
>     perror("clock_gettime failed");
>     exit(1);
>   }
>   long result = tp.tv_sec + tp.tv_nsec / 1000000000;
>   return result;
> }
>
> int main() {
>   printf("monitoring monotonic clock...\n");
>   long last = get_time();
>   while(1) {
>     long now = get_time();
>     if (now < last) {
>       printf("clock went backwards by %ld seconds!\n",
>         last - now);
>     }
>     last = now;
>     sleep(1);
>   }
>   return 0;
> }
> ---
> when running
> # date -s 2040-1-1
> # date -s 2037-1-1
> program outputs: clock went backwards by 4294967295 seconds!
>
> [8.] Environment: any ppc64, currently reproducing on qemu-system-ppc64le running debian unstable
> [X.] Other notes, patches, fixes, workarounds:
> The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.
> (possibly because some values used in the calculation are only 32 bit?)
> Slightly silly workaround: 
> nuke the "cmpwi cr1,r3,CLOCK_MONOTONIC" in __kernel_clock_gettime
> Now it always goes through the syscall fallback which does not have the same problem.
>
> Regards,
> Jakub Drnec

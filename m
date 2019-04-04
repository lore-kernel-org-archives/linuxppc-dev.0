Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AD3C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 01:00:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E3A2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 01:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="WlpG7aqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZPl35HXgzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:00:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::10; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="WlpG7aqB"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZPhk3VJHzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 11:58:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554339512;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=YQ2Qq4t/PE6JDSTMAfXLZZuJp7RaJhTS1n/3iH2gqIg=;
 b=WlpG7aqBHZmN/8DCe6VoyMqv2w4oNeI0daQPqergd84rG6hPyWdZQnHCW/ELhCEepc
 1cTBw+OyFzNF8ELxThnEi8W2MesXb9sQ3PYO1IhNM6RAoYTdCD3u1a9xp6DQLz0n78OX
 1/ZZZvOWrL9uGy/evIdTWNfreAiM2qIV2l8jozAI+DQOqnuCN6YzWUhcxOsrJuOzU6Fz
 Qvs91BncLMvov8cpiXvI4rtZnD5Av+tjZ5NpMCwSd6+f45NIk0BD/GW6U7ydcpFanob5
 TOy390IhLUtIxpLyh4YzZxSqttfikvW2bgFF/ybw5S5mWiE/cYcZ/c1wWxf7dsMhjLus
 eNiQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7ClcjjKHPTGuGvjbpCNNMiQNOZOU"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:c0d1:c439:dd6:cffc]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id k00e1ev340wT0O1
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 4 Apr 2019 02:58:29 +0200 (CEST)
Subject: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
 <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <0f0403a0-476a-6129-8dc6-866d894c9adc@xenosoft.de>
Date: Thu, 4 Apr 2019 02:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03 April 2019 at 07:05AM, Christophe Leroy wrote:
> Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
>> Please test VLC with the RC3 of kernel 5.1.
>>
>> The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. 
>> Another user has already confirmed that [1]. This isn’t an April 
>> Fool‘s. ;-)
>
> Could you bisect to identify the guilty commit ?
>
> Thanks
> Christophe
>
>>
>> Thanks
>>
>> [1] 
>> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561
>>
>
Hello Christophe,

I have found the problematic patch. The following patch from the PowerPC 
fixes 5.1-3 is responsible for the VLC issue.

diff --git a/arch/powerpc/include/asm/vdso_datapage.h 
b/arch/powerpc/include/asm/vdso_datapage.h
index 1afe90ade595..bbc06bd72b1f 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -82,10 +82,10 @@ struct vdso_data {
     __u32 icache_block_size;      /* L1 i-cache block size     */
     __u32 dcache_log_block_size;      /* L1 d-cache log block size */
     __u32 icache_log_block_size;      /* L1 i-cache log block size */
-   __s32 wtom_clock_sec;         /* Wall to monotonic clock */
-   __s32 wtom_clock_nsec;
-   struct timespec stamp_xtime;   /* xtime as at tb_orig_stamp */
-   __u32 stamp_sec_fraction;   /* fractional seconds of stamp_xtime */
+   __u32 stamp_sec_fraction;      /* fractional seconds of stamp_xtime */
+   __s32 wtom_clock_nsec;         /* Wall to monotonic clock nsec */
+   __s64 wtom_clock_sec;         /* Wall to monotonic clock sec */
+   struct timespec stamp_xtime;      /* xtime as at tb_orig_stamp */
        __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
        __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
  };

-----

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/arch/powerpc/include/asm/vdso_datapage.h?h=v5.1-rc2&id=a5ed1e96cafde5ba48638f486bfca0685dc6ddc9

I created a patch for solving the VLC issue today.

vdso_datapage_vlc.patch:

diff -rupN a/arch/powerpc/include/asm/vdso_datapage.h 
b/arch/powerpc/include/asm/vdso_datapage.h
--- a/arch/powerpc/include/asm/vdso_datapage.h  2019-04-03 
22:56:44.560645936 +0200
+++ b/arch/powerpc/include/asm/vdso_datapage.h  2019-04-04 
02:20:09.479361827 +0200
@@ -82,10 +82,10 @@ struct vdso_data {
         __u32 icache_block_size;                /* L1 i-cache block 
size     */
         __u32 dcache_log_block_size;            /* L1 d-cache log block 
size */
         __u32 icache_log_block_size;            /* L1 i-cache log block 
size */
-       __u32 stamp_sec_fraction;               /* fractional seconds of 
stamp_xtime */
-       __s32 wtom_clock_nsec;                  /* Wall to monotonic 
clock nsec */
-       __s64 wtom_clock_sec;                   /* Wall to monotonic 
clock sec */
-       struct timespec stamp_xtime;            /* xtime as at 
tb_orig_stamp */
+       __s32 wtom_clock_sec;                   /* Wall to monotonic 
clock */
+       __s32 wtom_clock_nsec;
+       struct timespec stamp_xtime;    /* xtime as at tb_orig_stamp */
+       __u32 stamp_sec_fraction;       /* fractional seconds of 
stamp_xtime */
         __u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls */
         __u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
  };

-----

Cheers,
Christian

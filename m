Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD94C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Feb 2022 07:33:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtF9N261dz3cPS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Feb 2022 18:33:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtF8r1whcz2xDY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Feb 2022 18:32:43 +1100 (AEDT)
Received: from [192.168.0.2] (ip5f5aebc2.dynamic.kabel-deutschland.de
 [95.90.235.194])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0129961E64846;
 Tue,  8 Feb 2022 08:32:38 +0100 (CET)
Message-ID: <0baca95b-771f-2217-1098-2d0eee568ea7@molgen.mpg.de>
Date: Tue, 8 Feb 2022 08:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Frederic Weisbecker <fweisbec@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ppc64le: `NOHZ tick-stop error: Non-RCU local softirq work is
 pending, handler #20!!!` when turning off SMT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Linux folks,


On the POWER8 server IBM S822LC running Ubuntu 21.10, Linux 5.17-rc1+ 
built with

     $ grep HZ /boot/config-5.17.0-rc1+
     CONFIG_NO_HZ_COMMON=y
     # CONFIG_HZ_PERIODIC is not set
     CONFIG_NO_HZ_IDLE=y
     # CONFIG_NO_HZ_FULL is not set
     CONFIG_NO_HZ=y
     # CONFIG_HZ_100 is not set
     CONFIG_HZ_250=y
     # CONFIG_HZ_300 is not set
     # CONFIG_HZ_1000 is not set
     CONFIG_HZ=250

once warned about a NOHZ tick-stop error, when I executed `sudo 
/usr/sbin/ppc64_cpu --smt=off` (so that KVM would work).

```
$ dmesg
[    0.000000] Linux version 5.17.0-rc1+ 
(pmenzel@flughafenberlinbrandenburgwillybrandt.molgen.mpg.de) (Ubuntu 
clang version 13.0.0-2, LLD 13.0.0) #1 SMP Fri Jan 28 17:13:04 CET 2022
[…]
[271272.030262] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271272.305726] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271272.549790] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271274.885167] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.113896] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.412902] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.625245] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.833107] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271276.041391] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271277.244880] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
```


Kind regards,

Paul

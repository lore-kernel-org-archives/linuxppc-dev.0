Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8618EC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 09:05:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD727204EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGZl1e7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD727204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Whkj3dL9zF3SD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 20:05:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGZl1e7s";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aneeshkumar.opensource@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGZl1e7s"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Whgx3YmSzF3J1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 20:03:06 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id s4-v6so5638565plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ecgA7/dAk8I/lT6yAtzH8MiQolUoS+Cs6H4mX4/y0c4=;
 b=VGZl1e7ssXoNTXiyLf9O7o2pjOWl1ref5rz0tNaHwgptwI8wdS5k9a6azmFG1WS6kT
 lc5etBOx/b+IeP0tXQ4SfK7FW9fZU7OrlbAZEDyNpS9+CBEqMBou0yY8qgKF0BBihPGN
 vCtuCs8KmMdJZ7YCwlekbHeq9t0FCrXHTp6qgwN6qn+iUCB5OfXebjKI+ZwlWhL6h7ya
 u248s7B9H2r/rL2Oqp67C2lxsqrVQqoEgxCLmBqkKA/61KOdCkdz7TR5iq0l+DPFen9U
 d+bFe2luB4xOt2nCCR2oEqIGHbXY/YHdRxIlOiOyZMHoKvZIQMKj05HD18Imj3AIv/3y
 YBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ecgA7/dAk8I/lT6yAtzH8MiQolUoS+Cs6H4mX4/y0c4=;
 b=kpGmg9N7/BUBXg8QnK87TxLyp5xXBUJbiruHQtKU5Ft7QdR3U7sm4g/BsojE4jxRmK
 iBqEiWMvvfK78hbtkoY+ecqQQHx4fWjKfu+Nao5dFtwiNqhUmHfG3XJ4bf3tNrI7lsK3
 6SujNB+pPdPVPMddSxL7UeIkXWOpg/WVGjEk5mnJjsD7WfQAWRjsiVLw2C/diXe9aF3H
 i6sk6ei3Toev/JadnS02IbFZnucRDwWmUKVmtWD8fLKUD9vm6Z0TeM8KP2eyTBHw0nCz
 /WV8hhG1wPVqpMx30U+gWEaUop6mgBSROy457iV59SSJGrvsqkMdWzlzjkBdG4pNb69y
 Sa/w==
X-Gm-Message-State: ABuFfohJ48uA/mO36kJGjsAuwkmHTKjznmJgV25S9nRJWYCwL4tV1Ks0
 n0ChUqRYQMD/mKgzqF9fTVU=
X-Google-Smtp-Source: ACcGV62bw9LaI+k0OBk6BmyOly5m0fcsQcuhJZQ1z5+y13vIse24HQsPQd1PY0yXFuEywW/WQXph6w==
X-Received: by 2002:a17:902:34a:: with SMTP id
 68-v6mr5033657pld.39.1539334983845; 
 Fri, 12 Oct 2018 02:03:03 -0700 (PDT)
Received: from [192.168.0.123] ([106.51.21.108])
 by smtp.gmail.com with ESMTPSA id b81-v6sm1745584pfm.96.2018.10.12.02.03.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 02:03:03 -0700 (PDT)
From: "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
 <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
Message-ID: <da8634b4-77ae-90e3-b6b4-fa1284ed8d85@linux.ibm.com>
Date: Fri, 12 Oct 2018 14:32:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 linux-next <linux-next@vger.kernel.org>,
 manvanth <manvanth@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/12/18 1:38 PM, Christophe LEROY wrote:
> 
> 
> Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
>> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
>>> Greeting's
>>>
>>> Today's linux-next fails to boot on powerpc bare-metal with this error
>>>
>>> POWER8 performance monitor hardware support registered
>>> rcu: Hierarchical SRCU implementation.
>>> smp: Bringing up secondary CPUs ...
>>> Kernel panic - not syncing: stack-protector: Kernel stack is 
>>> corrupted in: __schedule+0x978/0xa80
>>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
>>> 4.19.0-rc7-next-20181010-autotest-autotest #1
>>> Call Trace:
>>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
>>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
>>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
>>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
>>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
>>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
>>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
>>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
>>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
>>> Rebooting in 10 seconds..
>>>
>>> Machine: Power 8 bare-metal
>>> kernel version: 4.19.0-rc7-next-20181010
>>> gcc version: 4.8.5 20150623
>>> config attach
>>
>> Attaching the kernel config file
>>
> 
> # Linux/powerpc 4.11.0-rc4 Kernel Configuration
> 
> This is not the correct config file. Can you send the .config ?
> 
> Christophe

modified   kernel/sched/idle.c
@@ -352,7 +352,6 @@ void cpu_startup_entry(enum cpuhp_state state)
  	 * make this generic (ARM and SH have never invoked the canary
  	 * init for the non boot CPUs!). Will be fixed in 3.11
  	 */
-#ifdef CONFIG_X86
  	/*
  	 * If we're the non-boot CPU, nothing set the stack canary up
  	 * for us. The boot CPU already has it initialized but no harm
@@ -361,7 +360,6 @@ void cpu_startup_entry(enum cpuhp_state state)
  	 * canaries already on the stack wont ever trigger).
  	 */
  	boot_init_stack_canary();
-#endif
  	arch_cpu_idle_prepare();
  	cpuhp_online_idle(state);
  	while (1)


This fixes it for me. But we may have to look at the other arch details 
mentioned there.

-aneesh

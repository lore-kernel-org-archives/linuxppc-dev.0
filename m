Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD20C677FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:58:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607D220835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiPtGSK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607D220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WMH019JhzF3KG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 06:58:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiPtGSK+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiPtGSK+"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WMCY46RnzF0RC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 06:55:53 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id j23-v6so4934008pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MksRJ+C2rJrllRc3ReKK6Yfk7dgXChe1JArvN/CPh3I=;
 b=iiPtGSK+nhwXd4auAjQKgRCtQb/NKh7L6j+TjTalEiEGz/GvBZxuxcuAX9uOPmokoR
 7Ii3TJLQVYLZpa+xA5Rr1Vsr9/FfO7Ez9uo/uwaa+y//AjOpB+ZowcLu1N5H4TXnsy7G
 sQB3AEnCD0zFK7Dzs/SLpM4d/v4xpHg4+fc2HSWS7Lj/xiWY0IfVYg0ANxpMUpKpNN+2
 d3UbIQlKyK45PM30Jn1sXySveoYg+UbuMrh6mpuiSASMMpDsT0GIhm8jQjKSBvZLBH11
 sdi4+DYzZ8SpG2dOmg76k2vXo/ad7nu5T0DJe89UzOQDmczkx1TDpfEr/DAwJ6JrfxwM
 /gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MksRJ+C2rJrllRc3ReKK6Yfk7dgXChe1JArvN/CPh3I=;
 b=Vy1R530AgYbfRa8ma5p/VA6yAUBqT0taPN1XO0oQXhirUD5/kexEnTaUBHqbahEZeW
 s2jP6GXQqLNKGQ1sdDBfoyWdYZwDcVNVzB5JFZnu/iO9DG2m/7qN+L9dK8hQwa1H5TwS
 ADhGFW/h4yhJdjY2uiRnFANdhNhhDDe63R65TgyL1Df4i5+jJbnTzCBKaS6u+IuZfpTN
 i2sCksFu/6kvoitAfR1ObIy1rjZrkf3S34LJoiVkTG98R2bm/gPPLb8ASk74xeSuVqXw
 MfM+yc2Rnb57oTFi/F9v72NCnxAV3HTlqLNsPKWS5drAoBpwNzX/lxk/4Q1Zf/zoZAer
 I3RA==
X-Gm-Message-State: ABuFfojseHxFJG5OwVOz/qWtZMwfbuyVoaNoMT5Q6UBQ2yY4iDsHx4/t
 t7hhwMn9IPE5+ly9mElpXz0=
X-Google-Smtp-Source: ACcGV61Dw62Yvmxevnd+knkWbxY84KVl16ZFrLzf2j2QRkaE0qFKocZpKM1oHYn2ivA3XnBzGqUlPQ==
X-Received: by 2002:a62:6dc3:: with SMTP id
 i186-v6mr2959194pfc.218.1539287751395; 
 Thu, 11 Oct 2018 12:55:51 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u1-v6sm27113907pgr.61.2018.10.11.12.55.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Oct 2018 12:55:50 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] New device-tree format and Opal based idle
 save-restore
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <1b6bcd31-1dc8-abf7-304a-4de95b8f998b@gmail.com>
Date: Thu, 11 Oct 2018 12:55:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: huntbag@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+ devicetree mail list

On 10/11/18 06:22, Akshay Adiga wrote:
> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
> 
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
> 
> 1) Idea is to bump up the version string in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
> 
> 2) Slowly deprecate cpuidle/cpuhotplug threshold which is hard-coded
> into cpuidle-powernv driver. Instead use compatible strings to indicate
> if idle state is suitable for cpuidle and hotplug.
> 
> New idle state device tree format :
>        power-mgt {
>             ...
>          ibm,enabled-stop-levels = <0xec000000>;
>          ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>          ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>          ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>          ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>          ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>          ibm,idle-states {
>                      stop4 {
>                          flags = <0x207000>;
>                          compatible = "ibm,state-v1",
> 				      "opal-support";
> 			 type = "cpuidle";
>                          psscr-mask = <0x0 0x3003ff>;
>                          handle = <0x102>;
>                          latency-ns = <0x186a0>;
>                          residency-ns = <0x989680>;
>                          psscr = <0x0 0x300374>;
>                   };
>                     ...
>                     stop11 {
>                      ...
>                          compatible = "ibm,state-v1",
> 				      "opal-support";
> 			 type = "cpuoffline";
>                          ...
>                   };
>              };
> 
> High-level parsing algorithm :
> 
> Say Known version string = "ibm,state-v1"
> 
> for each stop state node in device tree:
> 	if (compatible has known version string)
> 		kernel takes care of stop-transitions
> 	else if (compatible has "opal-support")
> 		OPAL takes care of stop-transitions
> 	else
> 		Skip All deeper states
> 
> When a state does not have both version support and opal support,
> Its possible to exit from a shallower state. Hence skipping all
> deeper states.
> 
> OPAL support for idle states
> ----------------------------
> 
> With this patch series, all the states that loose hypervisor state
> will be handled through opal_call.
> 
> Patch 3 adds support for Saving/restoring of SPRs and resync-timebase
> in OPAL. Also all the decision making such as identifying first thread
> in the core and taking locks before restoring, etc are implemented in
> OPAL.
> 
> How does it work ?
> -------------------
> 
> Consider a case that stop4 has a bug. We take the following steps to
> mitigate the problem.
> 
> 1) Change compatible string for stop4 in OPAL to "ibm-state-v2" and
> remove "opal-supported". ship the new firmware.
> The kernel ignores stop4 and all deeper states. But we will still have
> shallower states. Prevents from completely disabling stop states.
> 
> 2) Implement workaround in OPAL and add "opal-supported". Ship new firmware
> The kernel uses opal for stop-transtion , which has workaround implemented.
> We get stop4 and deeper states working without kernel changes and backports.
> (and considerably less time)
> 
> 3) Implement workaround in kernel and add "ibm-state-v2" as known versions
> The kernel will now be able to handle stop4 and deeper states.
> 
> Changes from v1 :
>  - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
>    idle code in C"
> 	http://patchwork.ozlabs.org/patch/969596/
>  - All the states that loses hypervisor states will be handled by OPAL
>  - All the decision making such as identifying first thread in
>    the core and taking locks before restoring in such cases have also been
>    moved to OPAL
> 
> 
> Abhishek Goel (1):
>   cpuidle/powernv: save-restore sprs in opal
> 
> Akshay Adiga (2):
>   cpuidle/powernv: Add support for states with ibm,cpuidle-state-v1
>   powernv/cpuidle: Pass pointers instead of values to  stop loop
> 
>  arch/powerpc/include/asm/cpuidle.h            |   9 +
>  arch/powerpc/include/asm/opal-api.h           |   4 +-
>  arch/powerpc/include/asm/opal.h               |   3 +
>  arch/powerpc/include/asm/processor.h          |   8 +-
>  arch/powerpc/kernel/idle_book3s.S             |   6 +-
>  arch/powerpc/platforms/powernv/idle.c         | 247 ++++++++++++++----
>  .../powerpc/platforms/powernv/opal-wrappers.S |   2 +
>  drivers/cpuidle/cpuidle-powernv.c             |  46 ++--
>  8 files changed, 251 insertions(+), 74 deletions(-)
> 


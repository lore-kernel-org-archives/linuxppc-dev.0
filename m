Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049B8C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 17:31:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C422070B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="STm8VDpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C422070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cn9w4CMnzDqGC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 04:31:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="STm8VDpI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cn866TJ8zDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 04:29:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Cn7r3hlGz9v0ZZ;
 Mon,  4 Mar 2019 18:29:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=STm8VDpI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dB6PFsiPO2rb; Mon,  4 Mar 2019 18:29:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Cn7r2W7Fz9v0ZJ;
 Mon,  4 Mar 2019 18:29:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551720552; bh=VpAKZH9Op+tnA5F4iZNY+PYOrDq9JB+2s7o/HCjIJ8E=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=STm8VDpI6OlZOC96zGMcFDQo7lOdY+rfkrD0iruyZQkHRQEYPPZnT7rf94nYJ25KT
 RSqwCJzI+Aqd/9ZoZHxIyoKbva+Ui9z8kuuAZG51xTQgGc1EsQJUVoeivTExlUpv0i
 owFD5KQVT9dYnYns73Z368RrNPSgJ5a/8DZoKej0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 857228B795;
 Mon,  4 Mar 2019 18:29:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cTYc-GGhqSxM; Mon,  4 Mar 2019 18:29:17 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57CE18B768;
 Mon,  4 Mar 2019 18:29:17 +0100 (CET)
Subject: Re: [PULL REQUEST] powerpc generic command line
To: Daniel Walker <danielwa@cisco.com>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <e80b18e3-92fe-3726-a7d7-72f98cdd0b86@c-s.fr>
 <20190304165758.suqyact3tiueslqx@zorba>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b804556b-9a2d-96a3-3e16-8ffbbd6006d4@c-s.fr>
Date: Mon, 4 Mar 2019 18:29:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304165758.suqyact3tiueslqx@zorba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, xe-linux-external@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/03/2019 à 17:57, Daniel Walker a écrit :
> On Mon, Mar 04, 2019 at 02:55:08PM +0100, Christophe Leroy wrote:
>>
>>
>> Le 01/03/2019 à 20:44, Daniel Walker a écrit :
>>> Here are the generic command line changes for powerpc.
>>>
>>> These changes have been in linux-next for two cycles, with few problems reported.
>>> It's also been used at Cisco Systems, Inc. in production products for many many
>>> years with no problems.
>>>
>>> Please pull these changes.
>>>
>>>
>>> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
>>>
>>>     Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
>>>
>>> are available in the git repository at:
>>>
>>>     https://github.com/daniel-walker/cisco-linux.git for-powerpc
>>>
>>> for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
>>>
>>>     powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
>>>
>>> ----------------------------------------------------------------
>>> Daniel Walker (3):
>>>         add generic builtin command line
>>>         powerpc: convert to generic builtin command line
>>>         powerpc: convert config files to generic cmdline
>>
>> Hello,
>>
>> This series is in total contradiction with the work being done to add KASAN
>> support to powerpc.
>>
>> It also modifies the behaviour for powerpc.
>>
>> Please do not apply this series as is, see my comments on the individual
>> patchs for details.
>>
> 
> Not trying to offend you, but you comments seems overly alarmist. KASAN is a
> debug feature, generally we don't write code around debug features (especially
> ones which aren't merged yet). It would not be hard to correct our use of string
> functions when your KASAN enablement is merged, I'm sure you could do it, but I would be happy
> to do it also. The other comments you had I don't think rise to the level of
> stopping a pull request. Our code is stabilized, so I'm not going to
> re-design it at a late date like this.
> 
> I think the pull request is still valid.
> 

Ok, lets the KASAN stuff aside. And I agree I misread the patch when I 
felt that it was changing the behaviour in prom_init.c

I don't want to criticise your work either, but your series seems 
overkill. Anyway, could you explain your approach and what is the 
benefit of your series compared to what is already existing ?

Can you also explain how your changes fit with the what is done is the 
function early_init_dt_scan_chosen_ppc() in drivers/of/fdt.c as your 
series doesn't modify it ? (extract below)



	/*
	 * CONFIG_CMDLINE is meant to be a default in case nothing else
	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
	 * is set in which case we override whatever was found earlier.
	 */
#ifdef CONFIG_CMDLINE
#if defined(CONFIG_CMDLINE_EXTEND)
	strlcat(data, " ", COMMAND_LINE_SIZE);
	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
#elif defined(CONFIG_CMDLINE_FORCE)
	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
#else
	/* No arguments from boot loader, use kernel's  cmdl*/
	if (!((char *)data)[0])
		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
#endif
#endif /* CONFIG_CMDLINE */




What I like in your series is that you make the CMDLINE config common to 
all arches. But my feeling is that the 40 or so lines of code in your 
cmdline.h is way complex compared to what it aims to do, ie replacing a 
few lines on code in two places. But I might not have the complete 
picture so feel free to tell all the details behind it. I see you 
already submitted part of your series to the ppc list in Novembre 
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=75078) 
unfortunatly the first patch of the series was not there, and it seems 
at that time your series has not generated any further discussion.

Thanks
Christophe

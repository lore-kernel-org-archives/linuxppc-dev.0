Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A260BC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 23:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D1B213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 23:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyl1yBa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D1B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QWrp0b7CzF38c
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:07:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uyl1yBa3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=turtle.in.the.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uyl1yBa3"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QWnz6lFSzF37Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 09:05:24 +1000 (AEST)
Received: by mail-qt1-x841.google.com with SMTP id d8-v6so7858113qtk.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NtgnYGX5TZTIsyzBGTGdTLrxLpQU1HQo3yABRuackGY=;
 b=Uyl1yBa3C1Zgg87PteEYTyBFxzSDCOviMifTelcLHDc+dwADdP8gbWd1YielQztIR8
 whIy4UVgUOubBDBbVdwAlXEmWc+Z8IrWiMmmZg2trcGcBAbZF6oVEAUCSyQ9u1+GcNYB
 t8hhF96PKOpUp+D3Buhz0tE9FYqXxgeME9eOepysa2iyvK8R8scLkVIOtQxJ4htOi8od
 8g0N5QrP3M6kBmD1riY5Rh0egK7Z/+kA5Tw7kHHHpS0OuT6ISVy1RRcnl8U7sFDf8W8Q
 VNwi1LQjMpxFLZRvtE+oMPAumLIpTB/St9XCzm7c7Nd3Tca2/fOtCRvsyKiSYxJom6BW
 KSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NtgnYGX5TZTIsyzBGTGdTLrxLpQU1HQo3yABRuackGY=;
 b=P4fKS7iVzxkOMNZeXY7IiW2okQYWejvpX1WUEyMjDGwnAp1NtwO8zZyqOhIM5e9DWn
 wNcky4HwR7hONaOwzBJ9nf9Jwkf2BHe/voRYBmsSdSPu8ZkiXWFIAK+7alWAV9UY5O9e
 HFfKMS40PM86Zra+lv5y24gG1qdACLMHy4qu5pg1ejhhl7zlJ4L+utW7HU+bm+U+DP5Y
 onO1MxMmDViPUJk7a9tH4dTdXguwl3Od5e3FTCYJw5iqKqBiIYBV+n619D46heEX7+yr
 MaurtTDu/2IYhMUAfbNxHD00hFMt7vWoTFe8UiKuy2LcW43blBr2bSVz32GsKkqGLPb5
 ZUXg==
X-Gm-Message-State: ABuFfoiBjVBHQahB42gk+9088oLhiikIcqbEo/kcty9pl45K+wfqYTU7
 Ez1FGYQcQfQm6iXW74TCr70=
X-Google-Smtp-Source: ACcGV612bW91pttUf9pvRokWDEZ0vDRolfNIfVS3U8s+dK7vRLzqFsJhQZq5xNfV8TESIGBIVx56nQ==
X-Received: by 2002:ac8:185d:: with SMTP id
 n29-v6mr3286963qtk.10.1538607922180; 
 Wed, 03 Oct 2018 16:05:22 -0700 (PDT)
Received: from oc6857751186.ibm.com ([2601:1c2:1b7f:e860:c35a:1d95:8a0f:9ad0])
 by smtp.gmail.com with ESMTPSA id
 b128-v6sm1498412qkc.21.2018.10.03.16.05.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Oct 2018 16:05:21 -0700 (PDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Michal Hocko <mhocko@kernel.org>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
 <20181002160446.GA18290@dhcp22.suse.cz>
 <e7dd66c1-d196-3a14-0115-acdaf538ebfd@linux.vnet.ibm.com>
 <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
 <17781f9e-abfb-8c1e-eb18-39571d1b5cd6@linux.vnet.ibm.com>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <e7c0f7cc-02a4-47ff-9d7c-0b63f106932e@gmail.com>
Date: Wed, 3 Oct 2018 16:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <17781f9e-abfb-8c1e-eb18-39571d1b5cd6@linux.vnet.ibm.com>
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/03/2018 06:27 AM, Michael Bringmann wrote:
> On 10/02/2018 02:45 PM, Tyrel Datwyler wrote:
>> On 10/02/2018 11:13 AM, Michael Bringmann wrote:
>>>
>>>
>>> On 10/02/2018 11:04 AM, Michal Hocko wrote:
>>>> On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
>>>>> On 10/02/2018 09:59 AM, Michal Hocko wrote:
>>>>>> On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
>>>>>> [...]
>>>>>>> When the device-tree affinity attributes have changed for memory,
>>>>>>> the 'nid' affinity calculated points to a different node for the
>>>>>>> memory block than the one used to install it, previously on the
>>>>>>> source system.  The newly calculated 'nid' affinity may not yet
>>>>>>> be initialized on the target system.  The current memory tracking
>>>>>>> mechanisms do not record the node to which a memory block was
>>>>>>> associated when it was added.  Nathan is looking at adding this
>>>>>>> feature to the new implementation of LMBs, but it is not there
>>>>>>> yet, and won't be present in earlier kernels without backporting a
>>>>>>> significant number of changes.
>>>>>>
>>>>>> Then the patch you have proposed here just papers over a real issue, no?
>>>>>> IIUC then you simply do not remove the memory if you lose the race.
>>>>>
>>>>> The problem occurs when removing memory after an affinity change
>>>>> references a node that was previously unreferenced.  Other code
>>>>> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
>>>>> node when adding memory to a system.  The 'removing memory' case is
>>>>> specific to systems that perform LPM and allow device-tree changes.
>>>>> The powerpc kernel does not have the option of accepting some PRRN
>>>>> requests and accepting others.  It must perform them all.
>>>>
>>>> I am sorry, but you are still too cryptic for me. Either there is a
>>>> correctness issue and the the patch doesn't really fix anything or the
>>>> final race doesn't make any difference and then the ppc code should be
>>>> explicit about that. Checking the node inside the hotplug core code just
>>>> looks as a wrong layer to mitigate an arch specific problem. I am not
>>>> saying the patch is a no-go but if anything we want a big fat comment
>>>> explaining how this is possible because right now it just points to an
>>>> incorrect API usage.
>>>>
>>>> That being said, this sounds pretty much ppc specific problem and I
>>>> would _prefer_ it to be handled there (along with a big fat comment of
>>>> course).
>>>
>>> Let me try again.  Regardless of the path to which we get to this condition,
>>> we currently crash the kernel.  This patch changes that to a WARN_ON notice
>>> and continues executing the kernel without shutting down the system.  I saw
>>> the problem during powerpc testing, because that is the focus of my work.
>>> There are other paths to this function besides powerpc.  I feel that the
>>> kernel should keep running instead of halting.
>>
>> This is still basically a hack to get around a known race. In itself this patch is still worth while in that we shouldn't crash the kernel on a null pointer dereference. However, I think the actual problem still needs to be addressed. We shouldn't run any PRRN events for the source system on the target after a migration. The device tree update should have taken care of telling us about new affinities and what not. Can we just throw out any queued PRRN events when we wake up on the target?
> 
> We are not talking about queued events provided on the source system, but about
> new PRRN events sent by phyp to the kernel on the target system to update the
> kernel state after migration.  No way to predict the content.

Okay, but either way shouldn't your other proposed patches to update memory affinity by re-adding memory and changing the time topology updates are stopped to include the post-mobility updates put things in the right nodes? Or, am I missing something? I would assume a PRRN on the target would assume the target was up-to-date with respect to where things are supposed to be located.

-Tyrel

> 
>>
>> -Tyrel
>>>
>>> Regards,
>>>
> 
> Michael
> 


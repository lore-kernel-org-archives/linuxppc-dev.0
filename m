Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5EFC38142
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Jan 2023 23:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P49b54bBcz3cBy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Jan 2023 10:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P48g96GgWz3cBt
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2023 09:45:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=DyB9Vj9xQ6QPWO2/0ubzR4pe1ytfMqO3uNOVBQFARx4=; b=gll/4aWbNrhHk87vl7Jm7WsLsb
	3G3dSBLayBbLTvl2BVI+8Ov1xW5VCIU1P4L+Qzqnk/x8s6U8A7XUMEztVNv7POLOaMj3N7Cf7gVU5
	/5OfBMqkkTrlcF1yVYrwtVE15TXAZmcyb6AjJ/mExCJ8kP6guI5eqdHu4g3mpLaZFmjIhkJ3+rt44
	Ie416c7jrvFs/dj2kqPdZPNPyY2+h6AmC/O1SunkX9Snhxs1ogFGK6VDgt4fWnRJIeYmpfKS1h8S0
	Uk7mQ6PT/aSZkt1pA9onP7GwsD1PbnflX4mwjy1v5/++PYqkYkiUBj72SiyUBwNJWWMrWxnjlGtNT
	F5FwJNSw==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLtx6-008xZ5-PT; Sat, 28 Jan 2023 22:45:44 +0000
Message-ID: <38e58d03-3142-72ae-7424-696499a99bb2@infradead.org>
Date: Sat, 28 Jan 2023 14:45:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] powerpc/ps3: Change updateboltedpp panic to info
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1672767868.git.geoff@infradead.org>
 <2df879d982809c05b0dfade57942fe03dbe9e7de.1672767868.git.geoff@infradead.org>
 <25cc9a51-2311-d7d3-3451-08725e6384cd@csgroup.eu>
 <284aed88-dc26-d74a-cf7a-f5875ba058eb@infradead.org>
 <87mt6j9wcf.fsf@mpe.ellerman.id.au>
 <a449698b-93f5-0742-77fe-5699544eab5c@infradead.org>
 <75194fe4-8276-4749-ab41-f8ddf02a0200@csgroup.eu>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <75194fe4-8276-4749-ab41-f8ddf02a0200@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/16/23 23:26, Christophe Leroy wrote:
> Le 16/01/2023 à 21:08, Geoff Levand a écrit :
>>
>> As mentioned, I'd really like to keep PS3 included in ppc64_defconfig.  My
>> original patch that basically just ignores the call to
>> mmu_hash_ops.updateboltedpp allows that, and I haven't experienced any problems
>> with it yet.
> 
> When you say you have not experienced any problems with it, do you mean 
> that STRICT_RWX works for you ? When you select CONFIG_DEBUG_RODATA_TEST 
> it tells you that it works ? Otherwise it looks incorrect to enable 
> something that doesn't work.

What I mean is that the system boots up, and works as expected.
I have not tried with CONFIG_DEBUG_RODATA_TEST set.

>> My preference would be to keep PS3 in ppc64_defconfig, and either apply my
>> original patch, or I keep that patch in my ps3-linux repo on kernel.org. Then,
>> if we end up adding runtime support for RWX I then fixup PS3 to use that.
>>
> 
> In that case I see two solutions:
> 1/ Implement updateboltedpp for PS3.

I'm now looking into if this is possible.

> 2/ Implement arch_parse_debug_rodata() to always set rodata_enabled = 
> false on PS3, and update free_initmem() to only call mark_initmem_nx() 
> when strict_kernel_rwx_enabled() returns true.

OK, I'll consider this if I cannot get updateboltedp working.

-Geoff


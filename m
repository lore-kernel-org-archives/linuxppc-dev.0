Return-Path: <linuxppc-dev+bounces-26563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080DCC624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 15:29:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc0kf4D48z2y22;
	Sat, 05 Sep 2026 01:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.244.194.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788535770;
	cv=none; b=CArJ+K+ad5Qk7n8b+0mPtz0yLvKTmtv/Iy5DbHu32UaFA3RLK5xPeALJOSSs+3VrS1VrSBmUADT+fmGZdF2WXknGfATMySFZaYLW6eyUjXk45Gf/EHx3zQ66YFzO38lx+gbRPb2g8tCUQiEHREkTPf1EHZ4wKCXweKj58lIUzH5KcdEaNJa0AAKIXREch1Boid3yNr/39ZDjIF3GnSIrYaYrrJloOjHIAEZva7AmfzLdVMDj/Bknxfe5SeKQhgjPWtpnPqdbcd+ctThPoex1Mv4Jr6dhDzs+7Cw3XknKkDkHw69bYlaZ9r/n5mK5FPj6R61SXEbq9fBtjOUO635dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788535770; c=relaxed/relaxed;
	bh=nxI97ubcEM5+2BBS4utR3zx7Wwf4emiSTt1Vf7EV6EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw7F1LT1L9QUdhkfXQYApnDuo3YI5jx1FCkXK9SaGKVsRzvE2bpy70V/rLlHFI/Yi+y5P6C0rNVVQKjc0plKTQeE2VVDGR/9ae5W786Zhux7Dnm6q/yDdcULz+fhOD13WGrkDECVimsT0mjBpnK7RU8dAPkiAdcYOKBZJdDOYLAN768drj35z1nbYK77bF+5SW8ht4AGaY6WZ20hwMlAGw6ZIHfSgof4abcodtzMsHt/oo3g8vZgBrlALI0AoVnt+XefhQizHwulUrjmufiEhGQzmXUnBd8XjXJvOs+V6VdqOvXq90n9Wu3t3hgvAF2rJn+dMipMI+Nkr4MHcIbQcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=leemhuis.info; dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=CS8zyAGO; dkim-atps=neutral; spf=pass (client-ip=185.244.194.184; helo=relay.yourmailgateway.de; envelope-from=regressions@leemhuis.info; receiver=lists.ozlabs.org) smtp.mailfrom=leemhuis.info
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=leemhuis.info
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=CS8zyAGO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=leemhuis.info (client-ip=185.244.194.184; helo=relay.yourmailgateway.de; envelope-from=regressions@leemhuis.info; receiver=lists.ozlabs.org)
X-Greylist: delayed 387 seconds by postgrey-1.37 at boromir; Sat, 05 Sep 2026 01:29:27 AEST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc0kb5B0cz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 01:29:27 +1000 (AEST)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hc0b13zTjz9MW5;
	Fri,  4 Sep 2026 17:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788535373;
	bh=nxI97ubcEM5+2BBS4utR3zx7Wwf4emiSTt1Vf7EV6EU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CS8zyAGOP9LXa05GPpn9Vq1he1xRlR/5ZxoiFbeciZjmClL3Xcr1Ow8oTETujBzml
	 RN57ezgBln53pwYuG0ZGfFNwsN1IJFKdYsJ/I/R4PtYVyY9VaZHhHUxRGFIqYgv/60
	 UUXGGQR73bzVi4E4LdONz8HkaFND4h6JQZ40egYoyEUSmnBkBhJgCleo7fNODJIiTC
	 r2RSOBv2I10GYgJUvVin7pqTrcaDhkHKX9m2NMsm8O3P0/ks5HDXI7BtHRRY3oetxS
	 /gzgwzKQ4nEuY3Vrobi+eoDJFvjkbawSXrYztgOHG4fTM8FICGScP/t39z7CK+PP2F
	 DJMoqo95Dq4Ww==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hc0b13HR1z7xH9;
	Fri,  4 Sep 2026 17:22:53 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hc0b00M77z8sgw;
	Fri,  4 Sep 2026 17:22:52 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 276FA5FAB5;
	Fri,  4 Sep 2026 17:22:47 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <10138a14-a7c6-424e-950e-c1e5f878beac@leemhuis.info>
Date: Fri, 4 Sep 2026 17:22:46 +0200
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
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
 <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
 <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <ansZjSJMWMV8DDF-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <2f7e6c34-7258-4b20-a38e-cedebccb835f@linux.ibm.com>
 <985770a7-e488-456a-a9fa-aa71f1cbafd5@leemhuis.info>
 <appZ1UB1tzKz3IY9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <appZ1UB1tzKz3IY9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178853536760.332824.6991298509015054257@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 276FA5FAB5
X-NC-CID: o/w1lT5fDgOK6gXaBrvPIBFhIb+UL7T+sDpvHEat68+j6lsB9MY=

On 9/4/26 07:43, Mukesh Kumar Chaurasiya wrote:
> On Thu, Sep 03, 2026 at 01:22:35PM +0200, Thorsten Leemhuis wrote:
>> On 8/12/26 07:16, Venkat Rao Bagalkote wrote:
>>> On 11/08/26 6:16 pm, Mukesh Kumar Chaurasiya wrote:
>>>> On Tue, Aug 11, 2026 at 11:37:45AM +0530, Mukesh Kumar Chaurasiya wrote:
>>>>> On Mon, Aug 10, 2026 at 05:19:27PM +0530, Venkat Rao Bagalkote wrote:
>>>>>> On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
>>>>>>> On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
>>>>>>>>
>>>>>>>> I'm seeing a boot regression on a Power9 pseries LPAR. The system
>>>>>>>> hangs very early during boot after:
>>>>>>>>
>>>>>>>> Quiescing Open Firmware ...
>>>>>>>> Booting Linux via __start() ...
>>>>>>>>
>>>>>>> That is strange. not sure where to look at without any logs.
>>>>>>> Is it a specific config that fails or this specific LPAR that fails?
>>>>>>>
>>>>> Is this a specific lpar or all power9 pseries are exhibiting same
>>>>> behaviour?
>>> Its specific to a lpar.
>
> I am working on this, [...]
Great, thx.
> Can you also confirm the same.
Na, sorry, can't help, I'm not affected, I'm just keeping an eye on
regression to ensure they are fixed.

Ciao, Thorsten


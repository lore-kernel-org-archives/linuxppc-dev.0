Return-Path: <linuxppc-dev+bounces-26172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D75C61DCB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWfmf2VrBz2y8F;
	Fri, 28 Aug 2026 23:46:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787924770;
	cv=none; b=dJoAIDdR5A7dsZSqcRiNAZOvIXYMOu5xhId2GRQZDJK1vtUql/aWv2w/e1iL/3t0V08xDRQtgpdp7De0d2haTcxE1Pe2TzFzwFQ4oZckbiVSm6H6+fAxEyTBUrSAy5akUr50QCS+68y3W/No5ro/znamLLOlpk0cI56qXtz/y/7dqEJMxKIq9LGM60roy9R+LvtbW6UdHBIoSfIicHF74SDDxHluEXxKA243D0rq3vlKjh7IPG9lGJHCFy996nTK8Q8JtHTMdHQyFc8JnQiEuMNBSJZNTOkRLBtz2vrgZJD7+jFRuWvUuTlaZAE8Gbcg2lEJqbiMzc2IlaS0Un6M/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787924770; c=relaxed/relaxed;
	bh=ZkAIK4sJSZ+M6U7rXtAMjWYbvL4XnlFujZHGVX//GSY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ctuLh65lZx4S152Zu39QeTWQ4FS3dTZ+CH9zde3DSvMg7Pea9+OMZqQZcrqQ9qrqCvPJpTLma0ms74FzMUz+X+xaq6wtYszt2GusqKds2blLUSgpjEYP1SuuKA547VpJ3p1hMlCH/k5cYipAymaZtF+mBBu6cS0y34QwCIZUSK5tNVOGBYFq33bY4fat9JwrHepjuvc4YnJ2Vaf1Xk3u1SudUDonm8h2Ywzu/awNz75jU5nXKwB6CRjqzhSZvf5ueR/vzexzEMHSNZhQ5DUrej0J4A8pS9m7qej88QV/iaQqzi+h2SLzHcUwnwqx547R+EU0wSK9fInyNnTfk2SmJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN75zKWo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN75zKWo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWfmd1J9pz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 23:46:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4137E601FD;
	Fri, 28 Aug 2026 13:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98601F00A3D;
	Fri, 28 Aug 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787924766;
	bh=ZkAIK4sJSZ+M6U7rXtAMjWYbvL4XnlFujZHGVX//GSY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CN75zKWoF+1mzVHhe3/K7jFoShI11b+ruaRcdHTITvn7+SyoPQ9//oA9V4AyNgrWe
	 TEr3RkvkSCUaMk51+gxdYNvZuEJ6RCYWWXKntUXixXkl/UhTCE/+k7RXRrOWw6SiME
	 KIpaJVDj1mx4uZN0AWZKpZrV5HpWiC6l/C2cwy6h/psIZw95h9SheHWNTDXvrBHdFl
	 FQRsmsZl+tBHp0Yp7i0wgVTDygPtb6DY4jWVdyhaPikfGWB5HRfobhDmkRk4cS8PeN
	 ww85C1HqoAvyI5/CV6S9F9RHka7uJNzD0GJeabOQD/nz+tU2QAMPM/UIhBz0P/1tl1
	 r8RRR5G8xq2XQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5F2B21980072;
	Fri, 28 Aug 2026 09:46:03 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 28 Aug 2026 09:46:03 -0400
X-ME-Sender: <xms:F5GRaqE2NkgyW7Ns-LsvSLTTDYKdh01qS6ZTDLQ4fw9t-N0Ddrtc0Q>
    <xme:F5GRamK8JEod1kC8v70PUAKg83EM3BJ4mNsF9zenJckTWXg_DbGiqaZsOaLiTcf1f
    Un5nzICP58n5e2w4IxsrJ6DR2ew4HXCRnU0kgMGarbUP730m9edsSHf>
X-ME-Proxy-Cause: dmFkZTERWf76UbFSBm7gP10dcMTeqKkA8/cAL0sZG2rtqNj9Cm8XygX+z/UkBm5JSSVYUy
    tiYsLDls4/Z8P0ArKeB4JwxyT1aUPV/lD2jc7QsFKIVQHQani//0H1PZEuJk/TiRbXXB2d
    2quRJqkXk73Cy9UXGvcExqZtTKUBQHobcpzJhpw2JFide00btCWCAKJxj+FFD/0LYuztV0
    RDQfQ9I5GuMU2Gp/6HPTrAQR0FUWuP5nz+ODfL0oI1jx4s+jzNT/OxnaNHzIWAbOUDVPAP
    w5fd1Gn9Re9N8rvjRkwEA2WKBs4KNvy7cNDKTIaIdI60cHjToYvMPt6lZJQt9iOoIsFcNt
    RgMeFGqQHwKXp/37eumLweC5yrLclcKzJJT5cNY+IHV1VdIyqIG3ZtBU5HWRsmj47nFXXO
    E35L8lICEmkjQ8uKpI/zFxfHP7ZNKUlS9+8zbra8ZkiUUpsAFf0YCS46pUJJrUCDgx6aMI
    V3tmtGKfMb0aauZJvHtfGU1pRrhYIJs+OLLCQ73AXWjoo3DemVX15rIZX+nlbfZxakHWuF
    qQOXvsSwhEkofy7Mi18iqc/ZOGzI2iapsjruAeX/BsRit5HFPQYWWAYVRwICynS23+3qDa
    lSE1BUqfAQ+/hmaZUT/n/B29/elggaG5nEArlIRIROmCs2ooVKdFgmt50K7A
X-ME-Proxy: <xmx:G5GRaidmDIofxjDrnckkltqpU-EBp3Rle_aBNo2F6P7BC62Z4iDwZQ>
    <xmx:G5GRagLQLLdIZbdkb7L2guevnkadNbHtrAwSNHFCWgxQJ7GeNQ4xXQ>
    <xmx:G5GRasCciwc4APHUJloqDeNMxyVffl53TzupnMualIviek0VAjp3Uw>
    <xmx:G5GRaphOIhi5fNP21BBwmTKuIl5vQHIh-O74BW-RnFIO-oBnHepfnQ>
    <xmx:G5GRamNZICx_vr-e_gFs2Augf5avMnxddCHXulCSvH7Iw1aF3MgajzWL>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 89751F80080; Fri, 28 Aug 2026 09:45:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Fri, 28 Aug 2026 15:45:39 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Petr Pavlu" <petr.pavlu@suse.com>, "Ard Biesheuvel" <ardb+git@google.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Aaron Tomlin" <atomlin@atomlin.com>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
In-Reply-To: <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 28 Aug 2026, at 15:07, Petr Pavlu wrote:
> On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> The arm64 module loader has to deal with a couple of corner cases that
>> may occur when .init.text is placed out of direct branch range of .text:
>> 
>> - ordinary direct branches from .init.text into .text may require the
>>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>>   only that additional PLT entries need to be allocated for
>>   cross-section calls, but also that .init.text needs its own PLT
>>   reservation, as the one in .text will be out of range as well;
>> 
>> - dynamic patching of the ftrace handler into .init.text code needs its
>>   own dedicated trampoline as the one in .text may be too far away.
>> 
>> - recent compilers may omit BTI veneers for static functions that never
>>   have their address taken, and so additional veneers will need to be
>>   added to .text in case cross-section direct branches from .init.text 
>>   require a PLT entry (and therefore a landing pad at the target end).
>> 
>> This is unfortunate, because it is actually somewhat unusual for .text
>> and .init.text to be so far away from each other: only when allocating
>> either of them (but not both) exhausts the 'near' (PLT-less) module
>> region, the other will be allocated from the spillover region, which is
>> not in direct branching range, and therefore requires PLT entries for
>> cross-section calls.
>> 
>> This series addresses this wart by allocating both of them as a single
>> chunk, and freeing the .init.text part along with the other init
>> sections at the appropriate time. This ensures that the two regions will
>> never require veneers for cross-section calls, allowing the arm64 module
>> loader to be simplified.
>
> It looks like this should also be useful for ppc64, which currently
> merges .init.text and .text because keeping them separate would require
> stubs between the two, and consequently .init.text is never released in
> modules on this architecture.
>

Thanks for the data point - are those stubs needed when there is some
distance between the placements of .text and .init.text?



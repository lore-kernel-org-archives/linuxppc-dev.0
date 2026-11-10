Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8669606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RvEu62MN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMBd0cWCz2y2h;
	Wed, 11 Nov 2026 09:43:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794346181;
	cv=none; b=SeIRjpXbGAev6O3KigR3I97pNvLaJgbQcl1+BHk6DV7jBk0plHEt5jlZBkd1+o/42ZFlEeed5QVkA+L6D5ZjJJF10TYIJUjkHb6+uJbC5+UjgyGwSmpRDWdobe3VfoZlvPsPlB6vPzdiLL6EwwnadHGYohbYLLa1nWHTedeBbeAIwwdesVCst6Pvrm2z3rQMshloKgm3EWErYEvG3cXrXTXR+zT6k/nxl6xtFTClBy7HsmCJktpLbescb6EgfGZ0Bq6ivYR54B2XROdd/VGbSbz7i5gdi9w6Eqo89PLaiImVJNEL49SdX8iNEqvUdgmTFw8b9TRA82tX8MvuewFwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794346181; c=relaxed/relaxed;
	bh=biwkDAkhrSVkft1MaQo1t5KVNSxdEdz7Z7B6JVIMvak=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=hY9m6MI+tZe68Uqvu39xsF72QXCrwPUKRIA1KCj49VzqKLSOBkJILfTcLs9ib/HIGQP+uyggB/0gzveARuRPaXtf7vwZjBYcgGOLvwl0zknKuPwfmoAVAcJDcxIjxkc/fT7qw2heHmLrPcpSNDVrnkB3j9n4aNP9S0bxrvaYqiK1NRMWEloZ0uRaQRp9rgbx9Fi4xIrQkDePF1RHkk9RKaSMR4DD3ncLk4yMAsWbsU5YBFasfYrZDnXcm5rvIz/BmJQT4FHhy41GZGHC2Sx5npWnLZ89ntIYwTya1XaxbzruvBoXLDsL74f2E62X8xIwJ9eDhthrrCyL0kmQaS0RcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RvEu62MN; dkim-atps=neutral; spf=pass (client-ip=95.215.58.54; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RvEu62MN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.54; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 400 seconds by postgrey-1.37 at boromir; Wed, 11 Nov 2026 08:29:37 AEDT
Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPKYF1L8Zz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 08:29:36 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=JqxqGip0H/iVwtmJNlw71uL3W6XGftaGigDng0GTLUc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794346158; v=1; x=1794950958;
 b=RvEu62MN1hp1kKbVNBHOL9kp/AeRp01IPDvEPGDOjxP15589zj4qYNd+8KIk1q9MocSR4yJJ
 qXVpYlYQv2SVNPsn1Ke3Hy+0BbVelth0q3p9tWmhE7Jtg/yikQgMInzpbPaqOmQU0k50LzgJ5Nt
 WuCvviLrITq/AKcJdbBOddOg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 756820372af72f57;
	Tue, 10 Nov 2026 21:22:36 +0000
X-Mizu-Trace-ID: 756820372af72f57
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 21:22:32 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: chleroy@kernel.org
CC: brads@mainlining.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ritesh.list@gmail.com, sshegde@linux.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_powerpc32/modules=3A_Reser?=
 =?US-ASCII?Q?ve_a_PLT_entry_for_ftrace=5Fregs=5Fcaller?=
In-Reply-To: <e89ab6eb-2fd3-4638-a3a9-fef406478435@kernel.org>
Message-ID: <70954FB8-713D-4ACA-B176-03E335F00C33@linux.dev>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10 November 2026 08:57:28 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>
>
>Le 23/09/2026 à 19:56, Bradley Morgan a écrit :
>> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
>> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
>> undercount the PLT entries the loader
>> consumes: module_finalize_ftrace() now creates two trampolines
>> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
>> ftrace_regs_caller()), while count_relocs() reserves only one entry
>> for ftrace.
>> 
>> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
>> walk in do_plt_call() scans for a free slot with
>> "while (entry->jump[0])" and has no bound check, so once the last
>> reserved slot is used up, the walk steps past the end of the section
>> and patch_instruction() writes the 4-instruction trampoline into
>> whatever module memory follows the .plt.
>> 
>> Count the second entry, mirroring what module_64.c does for the same
>> pair of stubs.
>> 
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>
>I would have had a preference for something similar to commit c12cfe9dee07
>("powerpc/module_64: Convert #ifdef to IS_ENABLED()")
>
>Nevertheless,
>
>Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Thx, now the good question will be, who merges?

>
>
>
>> ---
>>   arch/powerpc/kernel/module_32.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/module_32.c
>b/arch/powerpc/kernel/module_32.c
>> index f930e3395a7f..61152deffc55 100644
>> --- a/arch/powerpc/kernel/module_32.c
>> +++ b/arch/powerpc/kernel/module_32.c
>> @@ -41,6 +41,9 @@ static unsigned int count_relocs(const Elf32_Rela
>*rela, unsigned int num)
>>     #ifdef CONFIG_DYNAMIC_FTRACE
>>   	_count_relocs++;	/* add one for ftrace_caller */
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +	_count_relocs++;	/* add one for ftrace_regs_caller */
>> +#endif
>>   #endif
>>   	return _count_relocs;
>>   }
>

--- Thanks!


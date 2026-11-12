Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=MnSt6P5v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kIByQjqn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQqj6YZQz2xS2;
	Fri, 13 Nov 2026 03:30:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501057;
	cv=none; b=RiHVMaciqKp9vB9f2FPqDi1xNU5WGnPyYARmmIR5npVsNMBf+A4EaD4EbjwxHPBthqQhqiq+Nj46ZFwnFP4nfyN6Nees+Bf2qOojuvp+xrV2j1vO639cN3i1WNQXDCSFgwM07xGlWreiyfafwmOqI15M/1FWqonMs/LS34IbyovxK8Q/6JLH5xD+BS+E9C5pQBC5ASClse8wbx4qfzcGiItbABsYbgCoRUYO9AQ9rZb7H6AxHQY4F1Gk8gUofWDWaYLYuHzYgm7v0cQcFkaIWUNzgW79NuwzZhnImsZm0EWtH9huJMK3Qti677ux3DdTz5keqROCQHhRpwTibdsa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501057; c=relaxed/relaxed;
	bh=2wC+DHpfvhjOngkdTUsTlLEY73HKthsXUYzx3ptaIKs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dzmlILYwMceBmzNjYmCQ55TsobJJpESl/fQKVggJhobPXFR0miLEeRwA/YbesvWVdaZ/SFF/ElVmajxfaWCA4mGOPrTaTgqznCd3TkUo32LQzpspi2BFodi4NLJpGd37+kPNkfFaBc928Ovfj60IXrvasrw71kWIAWp3xTmwZ6azCvNqeER8gppfzZF7AdA5WkW1e7Aqen8iZgFjqfqop0/qtuly35/edREcB7bcuPyUMmeH1ZQJxMhaKOcGFcFoXwghNL0KHHOQT5CGfumQ+gDRyASFpZT7A8PRVdiPh2Q+BVMnJ+YWgAZs/0r24IO6CDTkFxEfbpXlYy+Hc8baXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=MnSt6P5v; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kIByQjqn; dkim-atps=neutral; spf=pass (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=MnSt6P5v;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kIByQjqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQqf4MnQz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:30:54 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 673D71D0021B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:30:50 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 11:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794501048;
	 x=1794587448; bh=2wC+DHpfvhjOngkdTUsTlLEY73HKthsXUYzx3ptaIKs=; b=
	MnSt6P5v3joC+WgwhIXh/N1M3gZjtKe4J6Rg8mkHqObmO61/4ZWokdUu6qnZs/6r
	Axu+saX9rM3nl97b8zzGNbYT8nZymr4DWjBrtuY1dmOEDkUBxJEDytKs31pKiuKa
	+WPyWGEh1YxeAXDMX5Z3e23Jv8tIIMJEaI9P5TGepbAXxMUJlTGDo2aktDTUuZNQ
	PjQzjrc+YNHvLdTEsNcKY2bbAkQbXNfDt+x+8gG6XMezE1nKCdgJc2jvL/aMvbF9
	wJd+051Ig5VLTdHeLfrPUZfJxPuGxG1joCb5+KyfV+OH7A4Yn3BGU4Kg2IzYAEzp
	yk44fQqADYsgCdFs4GtoYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794501048; x=
	1794587448; bh=2wC+DHpfvhjOngkdTUsTlLEY73HKthsXUYzx3ptaIKs=; b=k
	IByQjqnICmGqcMGjcmcuB8MlMN3jacuzhUMi70um6CNBs0oZyLVylGJccbMCp2hO
	UqHvlsR5ylbfLF86P4UvZDzSIGFqicD0/JcmuJh4lrxWIDty5lvurkqX3pwftsG/
	hNc1L5aqit1stP7zNzGytFgd8vhsIwyu3ab+bCr5NF+hAevWytJZ2qEClcPNW42f
	Lf8FSgNenTCmKRHA67yFSCP73VZZzWC5tzkmr8/lyQJPHq/CglJmpDt2epUFCi4H
	HJQrjRsDGTRE17tF5ipGpOQITzV0fCYZlEHOmUw4DKBZFkakckC336OPqQfErGzE
	StPfjpSpFoaQi4j5j28EA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794501048; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:dGRLL7HG5y2tey4Bc8z83SoNEXUHxkVd2tSBse3B0/r39uH
	N6G4oicAzSz2J3/NGpk9nhC8yb8qZOOARJSURGknpilCG7gsKxtlDXm5y4y+hpXW
	zutzZLK2oQEu+MwRy3BZ1NrqTjy6vakA/loMzrgYWkmn9+G8j0aYcPNKVmckzPl4
	ZfyIuGIaCk/zY364iuoUsnMBbaY5NQlJz90NwcpUUMsRVrXRQv/zgGAILY7WNRyY
	4FDXoSzXO1LIxQeaWstqB5raEctD5OAr87JbiRXrPMHRhAYxuVfwSgowZDid6bQG
	mStKD9zrT4g6x20atHT1zutByHBoESlbdpV1vvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Tmp5tBgBP57jVEVYbBl47F5LIEsvDav9g5veU3DBpaw=:93Pw5IM9X04jl9lXmDuAcZ6gbWLkLC2V4uYkny3XtYQ=;
X-ME-Sender: <xms:ten1anWYmP8k7_3-GNaAlKQbY2duV5_yyHugJ1YOxnjn6oSqHSTN4g>
    <xme:ten1aqbbXMrwFTpD_wfQG0iKlbCRXj4fAQvTLc50wauITm_xAf4xt6H-IY-7AUb8B
    q1ZyGaSaFiQbJTeZJYD9U6vqueyp9rDhqIbHvL51hCVejGYWZyxY3Y>
X-ME-Proxy-Cause: dmFkZTEocBj/d8YWT2NbaK+590DeUK9E/Q9DJXtBoorFz5iQKhBgaSBs0k3h2jdf2ky8j1
    EpB4soQ5W0uRiLCQvWE2+BKJWePhlR9ApqT+uDXgmOdA3FBIq4BbThPHnCnWwx33wNy+Vm
    a8Y7pgtnAoV26J3W7koRSgdaBjqHxg1jSzmdUZ5N4ulcC3vQnS55QVhfVQOk+j+dkejCqv
    5Ba74+/aIGDTN7cbPzRtonEoVnqprEZh772UpTR/FPmtlG/7TDcgoFB2OQgyWpfBkYgsJv
    CxwZFPfLVIGj/wDsD0yIj43IM63fsRaykSGICTMLrE5W/YXFPFqINAtjNn7C791NUQ/InU
    hqMNK8JbEa0KJFQfObuLQXtZWxTbBqohHsYCOhphpF5wTIjhs2Y8lwBNlRw/L0ZF7nTGzR
    rYPY5vt/YQgtxf2XaNlDgUSzywP7xfD9HnVHCsaNAcg2plEvfJIRei88dX9fPzkNPWzO/V
    gqnP4VmiyYFqx7POy6IssiCOoWI7S9Ib1SXviYQdQ1Q6574f+UynmkSRqt1AD6wpBy18vk
    1ctZHGEMJIZXjUM/y5sWu+TEbskVOLf9TCjiPt0a18bFTy9QAFYYF5AX2bvzUkW3mqqCDk
    jMjdJhGwYCDwarr8Lvg9FAPU296XyVrmXvcejsGnzu9cHPDT4olpgGVZOJTQ
X-ME-Proxy: <xmx:tun1am4g6Vt1M5-a-s4l5XsiW4fz_G3ZeXOcEG3cvoQLO8-iuwve5A>
    <xmx:tun1agAkX-kXLPS--3uPrT71crgeFq-mkzb9kyveGoAiq3KJz3dnBQ>
    <xmx:tun1atZdrXVc7hg-N_Af2B2ehQDutSN_N4ZdTZzpRqsKJmY9qL23pw>
    <xmx:tun1arb4lVXwI-Dvr7f4V2ICrHdUr1HTuesrTuoLKvkjMzzOonZxkg>
    <xmx:uOn1ajIb9GPBSAFvdRR2KkOTDv9NoVQwv-1vWuseja_i2swQw48RHPmA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7952732A0099; Thu, 12 Nov 2026 11:30:45 -0500 (EST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMahpuQ4Atds
Date: Thu, 12 Nov 2026 17:30:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Message-Id: <ffac8517-468b-4dd6-b354-5e63ed2b40cc@app.fastmail.com>
In-Reply-To: <202611121726.xboRqpix-lkp@intel.com>
References: <202611121726.xboRqpix-lkp@intel.com>
Subject: Re: [arnd-playground:highmem-7.4 5/6] arch/powerpc/mm/init_32.c:49:2: error:
 #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026, at 17:13, kernel test robot wrote:
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202611121726.xboRqpix-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> arch/powerpc/mm/init_32.c:49:2: error: #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
>     #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
>      ^~~~~

The randconfig file contains

# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x80000000
CONFIG_PAGE_OFFSET_BOOL=y
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0xc0000000

which is an invalid configuration

My patch changed the defaults for both PAGE_OFFSET and LOWMEM_SIZE
in a way that should still work:

 config LOWMEM_SIZE
        hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
-       default "0x30000000"
+       default "0x80000000" if HIGHMEM
+       default "0x40000000"
 
 config PAGE_OFFSET
        hex "Virtual address of memory base" if PAGE_OFFSET_BOOL
-       default "0xc0000000"
+       default "0x70000000" if HIGHMEM
+       default "0xb0000000"

What I'm guessing happened is that the .config file was generated
with the old defaults by running 'make randconfig' on an unpatched
tree, but then running 'make olddefconfig' changes the default
for LOWMEM_SIZE without changing the others.

     Arnd


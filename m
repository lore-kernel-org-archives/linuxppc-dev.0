Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E5BC49ED7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82004208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82004208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46STCL2kMczF1P8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 01:16:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ST5z6937zDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2019 01:12:07 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8AFBrQS016611;
 Tue, 10 Sep 2019 10:11:53 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x8AFBqhw016608;
 Tue, 10 Sep 2019 10:11:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 10 Sep 2019 10:11:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 2/2] powerpc/kexec: move kexec files into a dedicated
 subdir.
Message-ID: <20190910151152.GV9749@gate.crashing.org>
References: <68d12eb0b815049049babc9be243ffd8521b48c7.1568127294.git.christophe.leroy@c-s.fr>
 <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 10, 2019 at 02:55:27PM +0000, Christophe Leroy wrote:
> arch/powerpc/kernel/ contains 7 files dedicated to kexec.
> 
> Move them into a dedicated subdirectory.

>  arch/powerpc/kernel/{ => kexec}/ima_kexec.c        |  0
>  arch/powerpc/kernel/{ => kexec}/kexec_32.S         |  2 +-
>  arch/powerpc/kernel/{ => kexec}/kexec_elf_64.c     |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec.c    |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_32.c |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_64.c |  0
>  .../kernel/{ => kexec}/machine_kexec_file_64.c     |  0

The filenames do not really need "kexec" in there anymore then?


Segher

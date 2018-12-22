Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877FC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 23:07:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F1E206A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 23:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F1E206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Mh355wtGzDqdT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 10:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Mh0n1nCCzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 10:05:13 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBMN51n0020296;
 Sat, 22 Dec 2018 17:05:02 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wBMN4pfo020281;
 Sat, 22 Dec 2018 17:04:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 22 Dec 2018 17:04:51 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
Message-ID: <20181222230451.GB23740@gate.crashing.org>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr> <2160350.91F9KbYz58@debian64>
 <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
 <20181222171631.GA23740@gate.crashing.org>
 <f365c733-6a1d-1ae9-067a-2a9490388c38@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f365c733-6a1d-1ae9-067a-2a9490388c38@c-s.fr>
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
 Markus Elfring <elfring@users.sourceforge.net>,
 Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 22, 2018 at 08:37:28PM +0100, christophe leroy wrote:
> Le 22/12/2018 à 18:16, Segher Boessenkool a écrit :
> >On Sat, Dec 22, 2018 at 02:08:02PM +0100, christophe leroy wrote:
> >>
> >>Usually, Guarded implies no exec (at least on 6xx and 8xx).
> >
> >Huh?  What do you mean here?
> 
> From the 885 Reference Manual:
> 
> Address translation: the EA is translated by using the MMU’s TLB 
> mechanism. Instructions are not fetched from no-execute or guarded 
> memory and data accesses are not executed speculatively to or from the 
> guarded memory.
> 
> 6.1.3.4 Instruction TLB Error Exception (0x01300)
> This type of exception occurs as a result of one of the following 
> conditions if MSR[IR] = 1:
> - The EA cannot be translated.
> - The fetch access violates memory protection
> - The fetch access is to guarded memory
> 
> 
> From e300core reference manual:
> 
> Translation Exception Conditions:
> Exception condition: Instruction fetch from guarded memory
> with MSR[IR] = 1 ==> ISI interrupt SRR1[3] = 1

Right, but you said 6xx as well, i.e. pure PowerPC.

If for example IR=0 you cannot have N=1, but you do have G=1.  There is
no case where G=1 implies N=1 afaik, or where fetch is prohibited some
other way (causes an ISI, say).


Segher

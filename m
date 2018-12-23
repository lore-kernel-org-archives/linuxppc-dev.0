Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372CC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 10:00:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55379218FD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 10:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55379218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MyXN1nH2zDqfV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 21:00:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MyVJ2QQ0zDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 20:58:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43MyV153S5z9tykc;
 Sun, 23 Dec 2018 10:58:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kt8UJLop1mNY; Sun, 23 Dec 2018 10:58:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43MyV14QvZz9tykb;
 Sun, 23 Dec 2018 10:58:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 476078B787;
 Sun, 23 Dec 2018 10:58:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dqHjfcsXW6Cg; Sun, 23 Dec 2018 10:58:06 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E500F8B74B;
 Sun, 23 Dec 2018 10:58:05 +0100 (CET)
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Gabriel Paubert <paubert@iram.es>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr> <2160350.91F9KbYz58@debian64>
 <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
 <20181222171631.GA23740@gate.crashing.org>
 <f365c733-6a1d-1ae9-067a-2a9490388c38@c-s.fr>
 <20181222230451.GB23740@gate.crashing.org>
 <20181223082944.o2qakn6f34megzfj@lt-gp.iram.es>
 <20181223093133.GC23740@gate.crashing.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <5cfb8921-3106-52af-6d75-a5fb6cfd7c29@c-s.fr>
Date: Sun, 23 Dec 2018 10:58:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181223093133.GC23740@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 181223-0, 23/12/2018), Outbound message
X-Antivirus-Status: Clean
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 23/12/2018 à 10:31, Segher Boessenkool a écrit :
> On Sun, Dec 23, 2018 at 09:29:44AM +0100, Gabriel Paubert wrote:
>> •   The fetch access is to guarded storage and MSR[IR] = 1.
> 
> That is architected, yes.  You get an ISI if IR=1 and (N=1 or G=1).
> 

If IR=0, mappings don't apply. So in 4xx/ocm, this mapping with 
_PAGE_EXEC and _PAGE_GUARDED at the same time seems pointless.

A standard ioremap() should do it (ie without exec), or a non guarded 
exec mapping if execution is expected for this area.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus


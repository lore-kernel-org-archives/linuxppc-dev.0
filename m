Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D5C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 20:11:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B361120651
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="K2TjjzNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B361120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZvGs4HpNzDqRK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 07:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.45;
 helo=mail.rptsys.com; envelope-from=tpearson@raptorengineering.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=raptorengineering.com header.i=@raptorengineering.com
 header.b="K2TjjzNm"; dkim-atps=neutral
X-Greylist: delayed 520 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Apr 2019 07:09:52 AEDT
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZvDw0RHCzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 07:09:51 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id BC34FE64BF8;
 Thu,  4 Apr 2019 15:01:06 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id aZDxJ46WG23u; Thu,  4 Apr 2019 15:01:05 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 28A2DE634F7;
 Thu,  4 Apr 2019 15:01:05 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 28A2DE634F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1554408065; bh=UOXZistDtfIVLs1k2qCBucJryKN2lZmP/gp8TjK5bx0=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=K2TjjzNm46u1tmFyW8wBZvXL/9qrV060qp0bmdAUszA/AfzFhFHMozT/+CQLJ6tEX
 ub93M5n+xF5CvGrHtMQMHqbWWHxUnisL589Y8qRBBKqV76ZmcQYXzPqWciCP/Bi1pe
 qPtvm5GnL3UD24XrVS6pKAWky+XoQ8sXaxTusuu0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 96swXYcdsRvL; Thu,  4 Apr 2019 15:01:04 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
 by mail.rptsys.com (Postfix) with ESMTP id B798DE6505A;
 Thu,  4 Apr 2019 15:01:04 -0500 (CDT)
Date: Thu, 4 Apr 2019 15:01:04 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Jiri Kosina <jikos@kernel.org>
Message-ID: <401506569.4710878.1554408064001.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
 <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/speculation: Add support for 'cpu_spec_mitigations='
 cmdline options
Thread-Index: dinaMtutIL4nwvFGZxvsYJw0doq+RA==
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Jon Masters <jcm@redhat.com>,
 Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Will be joining in ~ 5 mins.  Getting Chromium set up here.

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Josh Poimboeuf" <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra" <peterz@infradead.org>, "Heiko Carstens" <heiko.carstens@de.ibm.com>, "Paul Mackerras"
> <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>, "Andrea Arcangeli"
> <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, "Will Deacon" <will.deacon@arm.com>, "Linus
> Torvalds" <torvalds@linux-foundation.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Waiman Long"
> <longman@redhat.com>, linux-arch@vger.kernel.org, "Jon Masters" <jcm@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
> "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, "Tyler Hicks" <tyhicks@canonical.com>,
> "Martin Schwidefsky" <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
> Sent: Thursday, April 4, 2019 2:49:05 PM
> Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline options

> On Thu, 4 Apr 2019, Josh Poimboeuf wrote:
> 
>> Configure powerpc CPU runtime speculation bug mitigations in accordance
>> with the 'cpu_spec_mitigations=' cmdline options.  This affects
>> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
> [ ... snip ... ]
>> -	if (!no_nospec)
>> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
> 
> '!no_nospec' is something that I am sure will come back to hunt me in my
> bad dreams.
> 
> But that's been there already, and fixing it is out of scope of this
> patch. Other than that, as discussed previously -- I really like this new
> global option. Feel free to add
> 
>	Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> 
> for the whole set.
> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs

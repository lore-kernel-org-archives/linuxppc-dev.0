Return-Path: <srs0=b2td=7h=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPlJs00WpzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 23:39:41 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xPlJr6Nrwz8t7L
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 23:39:40 +1000 (AEST)
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xPlJq2yWrz9sN7
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 23:39:37 +1000 (AEST)
Received: by mail-pg0-x22a.google.com with SMTP id v189so18077057pgd.2
 for <linuxppc-dev@ozlabs.org>; Sat, 05 Aug 2017 06:39:37 -0700 (PDT)
Date: Sat, 5 Aug 2017 23:39:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
Message-ID: <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
In-Reply-To: <877eyjkt0u.fsf@linux-m68k.org>
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 04 Aug 2017 21:54:57 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> No, this is really a 4.13-rc1 regression.
> 
> Andreas.
> 

SLB miss with MSR[RI]=0 on

lbz     r0,THREAD+THREAD_LOAD_FP(r7)

Caused by bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f

Hmm, I'll see if something can be done, but that MSR_RI stuff in syscall
exit makes things fairly difficult (and will reduce performance improvement
of this patch anyway).

I'm trying to work to a point where we have a soft-RI bit for these kinds of
uses that would avoid all this complexity. Until then it may be best to
just revert this patch.

Thanks for the report

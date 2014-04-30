Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C678F1400AB
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2014 18:18:00 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Apr 2014 13:47:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A1C7D394005B
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2014 13:47:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3U8I18M196906
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2014 13:48:01 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3U8HrLJ019102
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2014 13:47:53 +0530
Message-ID: <5360B14D.8000902@linux.vnet.ibm.com>
Date: Wed, 30 Apr 2014 13:46:13 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com> <535F4E10.2020300@linux.vnet.ibm.com>
 <CAEjGV6yi5YY95tM-HY4akN4BGXGn4chA8_sCaqvWx3HPSu2V3w@mail.gmail.com>
 <535F5BDE.2030309@linux.vnet.ibm.com>
 <CAEjGV6y8MRiCfRBtWjNfrwKMccROEAJw2rPVc_u+r=tAo2EcHQ@mail.gmail.com>
 <535F997B.3000500@linux.vnet.ibm.com> <20730.1398817745@ale.ozlabs.ibm.com>
In-Reply-To: <20730.1398817745@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, oleg@redhat.com,
 linux-kernel@vger.kernel.org, roland@redhat.com, avagin@openvz.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2014 05:59 AM, Michael Neuling wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> On 04/29/2014 01:52 PM, Michael Neuling wrote:
>>> That's not what that patch does. It shouldn't make any user visible changes
>>> to DSCR or PPR.
>>
>> It may not when it runs uninterrupted but after the tracee process has
>> stopped, thread.dscr reflects the default DSCR value as mentioned
>> before. This can be proved by changing the "dscr_default" value in
>> arch/powerpc/sysfs.c file.
> 
> The intention with DSCR is that if the user changes the DSCR, the kernel
> should always save/restore it.  If you are seeing something else, then
> that is a bug.  Anton has a test case for this here:
> 
>   http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
> 
> If that is failing, then there is a bug that we need to fix.
> 

Anton's above DSCR test passed.

> The PPR is the same, except that the kernel can change it over a
> syscall.
> 
>>> Over syscall PPR and DSCR may change.
> 
> Sorry, this should be only PPR.  DSCR shouldn't change over a syscall,
> at least that's the intention.
> 
>>> Depending on your test case, that may
>>> be your problem.
>>
>> I would guess when the tracee process stops for ptrace analysis, tm_reclaim or
>> tm_recheckpoint path might be crossed which is causing this dscr_default value
>> to go into thread_struct.
> 
> That shouldn't happen.  If that's happening, it's a bug.

I would believe this is happening. Also after reverting the commit
e9bdc3d6143d1c4b8d8ce5231, thread.dscr reflects the same value as that
of thread.tm_dscr which is the check pointed DSCR register value just
before the transaction started. So even the NIP has moved passed the point
where the user changes DSCR inside the transaction, thread.dscr is unable
to capture that latest value. But thread.dscr must contain the latest user
changed value of DSCR which is definitely not happening here. So there is
a problem we need to fix. 

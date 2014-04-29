Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0058140098
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 22:24:06 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 22:24:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B6A6D2CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 22:24:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3TCNkkb9634188
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 22:23:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3TCO0E3016182
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 22:24:00 +1000
Message-ID: <535F997B.3000500@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 17:52:19 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com>	<535F4E10.2020300@linux.vnet.ibm.com>
 <CAEjGV6yi5YY95tM-HY4akN4BGXGn4chA8_sCaqvWx3HPSu2V3w@mail.gmail.com>
 <535F5BDE.2030309@linux.vnet.ibm.com>
 <CAEjGV6y8MRiCfRBtWjNfrwKMccROEAJw2rPVc_u+r=tAo2EcHQ@mail.gmail.com>
In-Reply-To: <CAEjGV6y8MRiCfRBtWjNfrwKMccROEAJw2rPVc_u+r=tAo2EcHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 avagin@openvz.org, roland@redhat.com, oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2014 01:52 PM, Michael Neuling wrote:
> That's not what that patch does. It shouldn't make any user visible changes
> to DSCR or PPR.

It may not when it runs uninterrupted but after the tracee process has stopped,
thread.dscr reflects the default DSCR value as mentioned before. This can be
proved by changing the "dscr_default" value in arch/powerpc/sysfs.c file.

> 
> Over syscall PPR and DSCR may change. Depending on your test case, that may
> be your problem.

I would guess when the tracee process stops for ptrace analysis, tm_reclaim or
tm_recheckpoint path might be crossed which is causing this dscr_default value
to go into thread_struct.

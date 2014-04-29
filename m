Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF0551400B7
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 17:02:20 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 12:32:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 56061E0044
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 12:32:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T7275m55050446
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 12:32:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T72B0v011862
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 12:32:11 +0530
Message-ID: <535F4E10.2020300@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 12:30:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com>
In-Reply-To: <533BD922.4070009@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, avagin@openvz.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, linuxppc-dev@ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2014 03:02 PM, Anshuman Khandual wrote:
> On 04/02/2014 12:32 PM, Anshuman Khandual wrote:
>> 	This patch series adds new ELF note sections which are used to
>> create new ptrace request macros for various transactional memory and
>> miscellaneous registers on PowerPC. Please find the test case exploiting
>> the new ptrace request macros and it's results on a POWER8 system.
>>
>> RFC: https://lkml.org/lkml/2014/4/1/292
>>
>> ============================== Results ==============================
>> -------TM specific SPR------
>> TM TFHAR: 100009dc
>> TM TEXASR: de000001ac000001
>> TM TFIAR: c00000000003f386
>> TM CH ORIG_MSR: 900000050000f032
>> TM CH TAR: 6
>> TM CH PPR: c000000000000
>> TM CH DSCR: 1
>> -------TM checkpointed GPR-----
>> TM CH GPR[0]: 1000097c
>> TM CH GPR[1]: 5
>> TM CH GPR[2]: 6
>> TM CH GPR[7]: 1
>> TM CH NIP: 100009dc
>> TM CH LINK: 1000097c
>> TM CH CCR: 22000422
>> -------TM running GPR-----
>> TM RN GPR[0]: 1000097c
>> TM RN GPR[1]: 7
>> TM RN GPR[2]: 8
>> TM RN GPR[7]: 5
>> TM RN NIP: 100009fc
>> TM RN LINK: 1000097c
>> TM RN CCR: 2000422
>> -------TM running FPR-----
>> TM RN FPR[0]: 1002d3a3780
>> TM RN FPR[1]: 7
>> TM RN FPR[2]: 8
>> TM RN FPSCR: 0
>> -------TM checkpointed FPR-----
>> TM CH FPR[0]: 1002d3a3780
>> TM CH FPR[1]: 5
>> TM CH FPR[2]: 6
>> TM CH FPSCR: 0
>> -------Running miscellaneous registers-------
> TM RN DSCR: 0
> 
> There is a problem in here which I forgot to mention. The running DSCR value
> comes from thread->dscr component of the target process. While we are inside the
> transaction (which is the case here as we are stuck at "b ." instruction and
> have not reached TEND) thread->dscr should have the running value of the DSCR
> register at that point of time. Here we expect the DSCR value to be 5 instead
> of 0 as shown in the output above. During the tests when I moved the "b ." after
> TEND, the thread->dscr gets the value of 5 while all check pointed reg values are
> thrown away. I believe there is some problem in the way thread->dscr context
> is saved away inside the TM section. Will look into this problem further and
> keep informed.

Reason behind this inconsistent DSCR register value is because of the following commit
where the kernel reverts the DSCR register into a default value to avoid running with
the user set value for a long time, thus preventing any potential performance degradation.
Same reason applies to the PPR register as well. So its not a problem but an expected
behaviour.

commit e9bdc3d6143d1c4b8d8ce5231fc958268331f983
Author: Michael Neuling <mikey@neuling.org>
Date:   Thu Sep 26 13:29:09 2013 +1000

    powerpc/tm: Switch out userspace PPR and DSCR sooner

    When we do a treclaim or trecheckpoint we end up running with userspace
    PPR and DSCR values.  Currently we don't do anything special to avoid
    running with user values which could cause a severe performance
    degradation.

    This patch moves the PPR and DSCR save and restore around treclaim and
    trecheckpoint so that we run with user values for a much shorter period.
    More care is taken with the PPR as it's impact is greater than the DSCR.

    This is similar to user exceptions, where we run HTM_MEDIUM early to
    ensure that we don't run with a userspace PPR values in the kernel.

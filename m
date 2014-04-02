Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C1BB41400F6
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 20:34:13 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 15:04:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CF880125805E
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2014 15:06:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s329XsPC39714966
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2014 15:03:54 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s329Xnpm018225
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2014 15:03:50 +0530
Message-ID: <533BD922.4070009@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2014 15:02:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, avagin@openvz.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2014 12:32 PM, Anshuman Khandual wrote:
> 	This patch series adds new ELF note sections which are used to
> create new ptrace request macros for various transactional memory and
> miscellaneous registers on PowerPC. Please find the test case exploiting
> the new ptrace request macros and it's results on a POWER8 system.
> 
> RFC: https://lkml.org/lkml/2014/4/1/292
> 
> ============================== Results ==============================
> -------TM specific SPR------
> TM TFHAR: 100009dc
> TM TEXASR: de000001ac000001
> TM TFIAR: c00000000003f386
> TM CH ORIG_MSR: 900000050000f032
> TM CH TAR: 6
> TM CH PPR: c000000000000
> TM CH DSCR: 1
> -------TM checkpointed GPR-----
> TM CH GPR[0]: 1000097c
> TM CH GPR[1]: 5
> TM CH GPR[2]: 6
> TM CH GPR[7]: 1
> TM CH NIP: 100009dc
> TM CH LINK: 1000097c
> TM CH CCR: 22000422
> -------TM running GPR-----
> TM RN GPR[0]: 1000097c
> TM RN GPR[1]: 7
> TM RN GPR[2]: 8
> TM RN GPR[7]: 5
> TM RN NIP: 100009fc
> TM RN LINK: 1000097c
> TM RN CCR: 2000422
> -------TM running FPR-----
> TM RN FPR[0]: 1002d3a3780
> TM RN FPR[1]: 7
> TM RN FPR[2]: 8
> TM RN FPSCR: 0
> -------TM checkpointed FPR-----
> TM CH FPR[0]: 1002d3a3780
> TM CH FPR[1]: 5
> TM CH FPR[2]: 6
> TM CH FPSCR: 0
> -------Running miscellaneous registers-------
TM RN DSCR: 0

There is a problem in here which I forgot to mention. The running DSCR value
comes from thread->dscr component of the target process. While we are inside the
transaction (which is the case here as we are stuck at "b ." instruction and
have not reached TEND) thread->dscr should have the running value of the DSCR
register at that point of time. Here we expect the DSCR value to be 5 instead
of 0 as shown in the output above. During the tests when I moved the "b ." after
TEND, the thread->dscr gets the value of 5 while all check pointed reg values are
thrown away. I believe there is some problem in the way thread->dscr context
is saved away inside the TM section. Will look into this problem further and
keep informed.

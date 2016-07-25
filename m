Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryPJ03XctzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:46:56 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P1iAih070179
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:46:54 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4nq97rp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:46:54 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 11:46:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCCE83578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:46:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P1kl0O28770428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:46:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P1kkEr003299
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:46:47 +1000
Date: Mon, 25 Jul 2016 11:46:41 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc,
 benh@kernel.crashing.org, paulus@samba.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87fuqy1r3i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fuqy1r3i.fsf@concordia.ellerman.id.au>
Message-Id: <20160725014641.GA21781@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 25, 2016 at 10:47:13AM +1000, Michael Ellerman wrote:
>"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>
>> This is a very minor/trivial fix for the output of PCI address on EEH logs.
>> The PCI address on "OF node" field currently is using ":" as a separator
>> for the function, but the usual separator is ".". This patch changes the
>> separator for dot, so the PCI address is printed as usual.
>>
>> No functional changes were introduced.
>
>What consumes the log? Can it cope with us changing the formatting?
>

The log is printed by pr_warn() as part of the EEH kernel log. Also,
it's argument passed to RTAS call "ibm,slot-error-detail" and it's
put into the user data section of the RTAS call's output, which is
used by RTAS daemon (rtasd) then. I don't see anyone expects fixed
format for it in the user data section.

The format was ever adjusted in commit 0ed352dddbfc ("powerpc/eeh:
Reduce lines of log dump") on Jul 17 2014. No complains received
against it so far. I guess nobody cares about the format or there
is a alarm isn't raised yet :)

Thanks,
Gavin

Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tz0L96D0czDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 18:06:25 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B74Fdv137754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 02:06:23 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27wfkes4un-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 02:06:23 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 12:36:19 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C98CBE006A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:37:17 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B75Rrl22347938
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:35:27 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B76EiN005370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:36:15 +0530
Subject: Re: [PATCH v3 04/15] livepatch/x86: add TIF_PATCH_PENDING thread flag
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2017 12:36:07 +0530
MIME-Version: 1.0
In-Reply-To: <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f3e38a07-c53b-3860-a59e-2d6f69a2e700@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 08 December 2016 11:38 PM, Josh Poimboeuf wrote:
> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for x86_64.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
>
> The bit is placed in the _TIF_ALLWORK_MASK macro, which results in
> exit_to_usermode_loop() calling klp_update_patch_state() when it's set.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
cheers,
Kamalesh.

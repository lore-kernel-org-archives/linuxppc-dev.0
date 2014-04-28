Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D66D140079
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 20:32:25 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 28 Apr 2014 20:32:21 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 913932CE8047
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 20:32:16 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3SAW1ug9306442
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 20:32:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3SAWFjb007586
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 20:32:15 +1000
Message-ID: <535E2DC9.7080602@linux.vnet.ibm.com>
Date: Mon, 28 Apr 2014 16:00:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH 2/3] powerpc, ptrace: Add new ptrace request macros for
 transactional memory
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1396422144-11032-3-git-send-email-khandual@linux.vnet.ibm.com>
 <535AF2E9.1000005@redhat.com>
In-Reply-To: <535AF2E9.1000005@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, avagin@openvz.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2014 05:12 AM, Pedro Alves wrote:
> On 04/02/2014 08:02 AM, Anshuman Khandual wrote:
>> This patch adds following new sets of ptrace request macros for transactional
>> memory expanding the existing ptrace ABI on PowerPC.
>>
>> 	/* TM special purpose registers */
>> 	PTRACE_GETTM_SPRREGS
>> 	PTRACE_SETTM_SPRREGS
>>
>> 	/* TM checkpointed GPR registers */
>> 	PTRACE_GETTM_CGPRREGS
>> 	PTRACE_SETTM_CGPRREGS
>>
>> 	/* TM checkpointed FPR registers */
>> 	PTRACE_GETTM_CFPRREGS
>> 	PTRACE_SETTM_CFPRREGS
>>
>> 	/* TM checkpointed VMX registers */
>> 	PTRACE_GETTM_CVMXREGS
>> 	PTRACE_SETTM_CVMXREGS
> 
> Urgh, we're _still_ adding specialized register specific calls?
> Why aren't these exported as new register sets, accessible through
> PTRACE_GETREGSET /  PTRACE_SETREGSET?  That's supposed to be the
> Modern Way to do things.

All these new register sets can be accessed through PTRACE_GETREGSET
/SETREGSET requests with the new NT_PPC_* core note types added in the
previous patch. PowerPC already has some register specific ptrace
requests, so thought of adding some new requests for transactional
memory purpose. But yes these are redundant and can be dropped.

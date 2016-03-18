Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRStT32sbzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 01:54:41 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 19 Mar 2016 00:54:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A08362CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 01:54:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2IEsFrs7143732
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 01:54:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2IErphF030439
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 01:53:51 +1100
Message-ID: <56EC1664.8020905@linux.vnet.ibm.com>
Date: Fri, 18 Mar 2016 20:23:24 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@ozlabs.org>
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 mahesh@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] powerpc/powernv: Encapsulate idle preparation steps
 in a macro
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1456748580-10519-3-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160317111534.GD28728@fergus.ozlabs.ibm.com>
In-Reply-To: <20160317111534.GD28728@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On 03/17/2016 04:45 PM, Paul Mackerras wrote:
> On Mon, Feb 29, 2016 at 05:52:59PM +0530, Shreyas B. Prabhu wrote:
>> Before entering any idle state which can result in a state loss
>> we currently save the context in the stack before entering idle.
>> Encapsulate these steps in a macro IDLE_STATE_PREP. Move this
>> and other macros to commonly accessible location.
> 
> There are two problems with this.  First, your new macro does much
> more than create a stack frame and save some registers.  It also
> messes with interrupts and potentially executes a blr instruction.
> That is not what people would expect from the name of the macro or the
> comments around it.  It also means that it would be hard to reuse the
> macro in another place.
> 
> Secondly, I don't think this change helps readability.  Since the
> macro is only used in one place, it doesn't reduce the total number of
> lines of code, in fact it increases it slightly. 

This patch was in preparation for support for new POWER ISA v3 idle
states. The idea was to have the common idle preparation steps in a
macro which be reused while adding support for the new idle states. With
this context do you think this macro with better comments make sense?


Thanks,
Shreyas

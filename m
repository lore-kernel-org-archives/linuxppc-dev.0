Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A74B1A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 14:53:52 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 21:53:50 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D055C19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 21:41:58 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9G3qUBb9634058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 20:52:30 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9G3rlBJ024498
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 21:53:47 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, thuth@redhat.com, stable@vger.kernel.org,
 paulus@samba.org, dgibson@redhat.com, jstancek@redhat.com
Subject: Re: [PATCH] PPC: fix LOGMPP instruction opcode and inline asm
In-Reply-To: <1444961451.28419.0.camel@ellerman.id.au>
References: <1444958435-18808-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1444961451.28419.0.camel@ellerman.id.au>
Date: Fri, 16 Oct 2015 14:53:35 +1100
Message-ID: <m3si5bh3k0.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> On Fri, 2015-10-16 at 12:20 +1100, Stewart Smith wrote:
>> Back in 9678cda when we started using the Micro Partition Prefetch Engine
>> in POWER8 for KVM, there were two mistakes introduced from the original
>> patch used for investigation and microbenchmarks.
>> 
>> One mistake was that the opcode was constructed incorrectly, putting
>> the register in the wrong field in the opcode, meaning that we were
>> asking the chip to read the memory address from some other register than
>> what we intended - probably r0.
>
> Where is the logmpp instruction documented?

BookIV Section 5.1 - although I think this is now meant to all be in the
"P8 User Manual".

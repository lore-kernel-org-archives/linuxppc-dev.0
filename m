Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAAE11A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:01:46 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FEC51400D5
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 22:01:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 16 Mar 2015 21:01:45 +1000
Message-ID: <5506B7DC.80702@linux.vnet.ibm.com>
Date: Mon, 16 Mar 2015 16:30:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
References: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
 <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxram@us.ibm.com, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2015 12:27 PM, Michael Ellerman wrote:
> This adds a test of the switch_endian() syscall we added in the previous
> commit.
> 
> We test it by calling the endian switch syscall, and then executing some
> code in the other endian to check everything went as expected. That code
> checks registers we expect to be maintained are, and then writes to
> stdout. If the endian switch failed to happen that code sequence will be
> illegal and cause the test to abort.
> 
> We then switch back to the original endian, do the same checks and
> finally write a success message and exit(0).
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Hey Michael,

Did a quick test, passes on LE but seems like failing on BE.

On LE:

Hello wrong-endian world
Hello right-endian world
success: switch_endian_test


on BE:

Hello wrong-endian world (returns 176)

The previous version of the test was passing both on LE
and BE (after applying the compiler trick in the assembly)

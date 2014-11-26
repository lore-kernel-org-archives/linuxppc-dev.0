Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B8121A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:10:48 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 27A3C140139
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 16:10:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 15:10:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 039313578077
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 16:10:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ5AewE39583776
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 16:10:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ5AcxJ022580
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 16:10:40 +1100
Message-ID: <547560C3.1090907@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 10:40:27 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shuah Khan <shuahkh@osg.samsung.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [V5 7/7] selftests, powerpc: Add test case for TM related ptrace
 interface
References: <1416902731-22446-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1416902731-22446-8-git-send-email-khandual@linux.vnet.ibm.com>
 <5474B72A.7040403@osg.samsung.com>
In-Reply-To: <5474B72A.7040403@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com, kirjanov@gmail.com,
 davej@redhat.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2014 10:36 PM, Shuah Khan wrote:
> On 11/25/2014 01:05 AM, Anshuman Khandual wrote:
>> > This patch adds one more test case called 'tm-ptrace' targeting TM
>> > related ptrace interface. This test creates one child process to
>> > run some basic TM transactions and the parent process attaches the
>> > child to do some ptrace probing using the recently added regset
>> > interfaces. The parent process then compares the received values
>> > against the expected values to verify whether it has passed the
>> > given test or not.
>> > 
>> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> > ---
>> >  tools/testing/selftests/powerpc/tm/Makefile    |   2 +-
>> >  tools/testing/selftests/powerpc/tm/tm-ptrace.c | 542 +++++++++++++++++++++++++
>> >  2 files changed, 543 insertions(+), 1 deletion(-)
>> >  create mode 100644 tools/testing/selftests/powerpc/tm/tm-ptrace.c
>> > 
>> > diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
>> > index 2cede23..71d400a 100644
>> > --- a/tools/testing/selftests/powerpc/tm/Makefile
>> > +++ b/tools/testing/selftests/powerpc/tm/Makefile
>> > @@ -1,4 +1,4 @@
>> > -PROGS := tm-resched-dscr
>> > +PROGS := tm-resched-dscr tm-ptrace
>> >  
> Could you please add .gitignore for the binaries in this directory
> to avoid git status including the binaries it in its output.

Sure, will add one.

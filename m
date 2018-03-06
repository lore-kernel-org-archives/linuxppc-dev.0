Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwc5j1bTRzF1Gt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 23:48:40 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w26CeSb2008701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 07:48:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ght7b2y05-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 07:48:36 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 6 Mar 2018 12:48:32 -0000
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras
 <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com,
 Parisc List <linux-parisc@vger.kernel.org>,
 gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
 <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
 <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Mar 2018 13:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/06/2018 01:46 PM, Arnd Bergmann wrote:
> On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>>> All the current architecture specific defines for these
>>> are the same. Refactor these common defines to a common
>>> header file.
>>>
>>> The new common linux/compat_time.h is also useful as it
>>> will eventually be used to hold all the defines that
>>> are needed for compat time types that support non y2038
>>> safe types. New architectures need not have to define these
>>> new types as they will only use new y2038 safe syscalls.
>>> This file can be deleted after y2038 when we stop supporting
>>> non y2038 safe syscalls.
>>
>> You are now include a <linux/*.h> from several asm files
>> (
>>  arch/arm64/include/asm/stat.h
>>  arch/s390/include/asm/elf.h
>>  arch/x86/include/asm/ftrace.h
>>  arch/x86/include/asm/sys_ia32.h
>> )
>> It works, and it is done in many places, but it looks somewhat weird.
>> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
>> opinions here.
> 
> I don't think we have such a rule. If a header file is common to all
> architectures (i.e. no architecture uses a different implementation),
> it should be in include/linux rather than include/asm-generic, regardless
> of whether it can be used by assembler files or not.
> 
>>> --- a/drivers/s390/net/qeth_core_main.c
>>> +++ b/drivers/s390/net/qeth_core_main.c
>>> @@ -32,7 +32,7 @@
>>>  #include <asm/chpid.h>
>>>  #include <asm/io.h>
>>>  #include <asm/sysinfo.h>
>>> -#include <asm/compat.h>
>>> +#include <linux/compat.h>
>>>  #include <asm/diag.h>
>>>  #include <asm/cio.h>
>>>  #include <asm/ccwdev.h>
>>
>> Can you move that into the other includes (where all the other <linux/*> includes are.
> 
> Good catch, this is definitely a rule we have ;-)

FWIW, this was also broken for 
arch/x86/include/asm/sys_ia32.h

Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL8Tj3v0dzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:20:09 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9N8Ist7111386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 04:20:07 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dscmk0g58-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 04:20:06 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 09:20:04 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9N8K1qi26870006
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 08:20:02 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9N8JrTo004003
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:19:54 +1100
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Balbir Singh <bsingharora@gmail.com>, Torsten Duwe <duwe@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Mon, 23 Oct 2017 13:49:57 +0530
MIME-Version: 1.0
In-Reply-To: <1508547548.5662.2.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 21 October 2017 06:29 AM, Balbir Singh wrote:
> On Fri, 2017-10-20 at 14:07 +0200, Torsten Duwe wrote:
>> On Wed, Oct 18, 2017 at 11:47:35AM +0530, Kamalesh Babulal wrote:
>>>
>>> Consider a trivial patch, supplied to kpatch tool for generating a
>>> livepatch module:
>>>
>>> --- a/fs/proc/meminfo.c
>>> +++ b/fs/proc/meminfo.c
>>> @@ -132,7 +132,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>         seq_printf(m, "VmallocTotal:   %8lu kB\n",
>>>                    (unsigned long)VMALLOC_TOTAL >> 10);
>>>         show_val_kb(m, "VmallocUsed:    ", 0ul);
>>> -       show_val_kb(m, "VmallocChunk:   ", 0ul);
>>> +       show_val_kb(m, "VMALLOCCHUNK:   ", 0ul);
>>>
>>
>> Am I assuming correctly that "kpatch tool" simply recompiles all code the
>> way it would get compiled in a regular kernel build?
>
> kpatch is open source and is available on github. This patch is specific
> to the way kpatch works
>
>> My understanding is
>> that live patching modules need to be carefully prepared, which involves
>> source code reorganisation and recompilation. In that process, you can
>> easily declare show_val_kb() extern, and get the suitable instruction sequence
>> for the call.
>
> Yes, we agree. For the current versions of kpatch, which involve a process of
> applying the patch and building the kernel without and with the patch and doing
> an elf diff (programatically), we cannot deviate from that process as it's
> architecture independent. This patch solves arch specific issues related
> to that process.

Yes, that's the essence of the kpatch tool on building livepatchable
kernel module, by doing an elf diff on the kernel with and without the
patch applied. show_val_kb() is a simple example, consider more complex
patch(s), if they need to be prepared manually as suggested. It beats
the whole purpose of a kpatch tool, which programmatically prepares a
livepatch module with close to no manual preparation required. It's
the architecture limitation, which is addressed in this patch.

This patch is outcome of long discussion at kpatch
https://github.com/dynup/kpatch/pull/650

-- 
cheers,
Kamalesh.

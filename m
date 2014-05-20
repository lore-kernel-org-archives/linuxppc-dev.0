Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27EBD1A0858
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:16:18 +1000 (EST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72F64140083
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 18:16:17 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 May 2014 13:46:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7C3E5E0053
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 13:46:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K8GZWv45809900
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 13:46:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K8G9Md013866
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 13:46:10 +0530
Message-ID: <537B0EE0.4080406@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 13:44:24 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
 <53735044.5030008@redhat.com> <537479FD.2010200@linux.vnet.ibm.com>
 <5374AE24.1030302@redhat.com> <5379EF0E.6090504@linux.vnet.ibm.com>
 <537A1889.8030801@redhat.com>
In-Reply-To: <537A1889.8030801@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, avagin@openvz.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2014 08:13 PM, Pedro Alves wrote:
> On 05/19/2014 12:46 PM, Anshuman Khandual wrote:
> 
>>>> I couldn't actually find any arch that currently returns -ENODEV in
>>>> the "active" hook.  I see that binfmt_elf.c doesn't handle
>>>> regset->active() returning < 0.  Guess that may be why.  Looks like
>>>> something that could be cleaned up, to me.
>>>>
>> Also it does not consider the return value of regset->active(t->task, regset)
>> (whose objective is to figure out whether we need to request regset->n number
>> of elements or less than that) in the subsequent call to regset->get function.
> 
> Indeed.
> 
> TBC, do you plan on fixing this?  Otherwise ...

Sure, thinking something like this as mentioned below. But still not sure how to use
the return type of -ENODEV from the function regset->active(). Right now if any
regset does have the active hook and it returns anything but positive value, it will
be ignored and the control moves to the next regset in view. This prevents the thread
core note type being written to the core dump.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index aa3cb62..80672fb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1553,7 +1553,15 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
                if (regset->core_note_type && regset->get &&
                    (!regset->active || regset->active(t->task, regset))) {
                        int ret;
-                       size_t size = regset->n * regset->size;
+                       size_t size;
+
+                       /* Request only the active elements in the regset */
+                       if (!regset->active)
+                               size = regset->n * regset->size;
+                       else
+                               size = regset->active(t->task, regset)
+                                                               * regset->size;
+
                        void *data = kmalloc(size, GFP_KERNEL);
                        if (unlikely(!data))
                                return 0;

> 
>> Now coming to the installation of the .active hooks part for all the new regsets, it
>> should be pretty straight forward as well. Though its optional and used for elf_core_dump
>> purpose only, its worth adding them here. Example of an active function should be something
>> like this. The function is inexpensive as required.
>>
>> +static int tm_spr_active(struct task_struct *target,
>> +                               const struct user_regset *regset)
>> +{
>> +       if (!cpu_has_feature(CPU_FTR_TM))
>> +               return -ENODEV;
> 
> ... unfortunately this will do the wrong thing.

I am not sure whether I understand this correctly. Are you saying that its wrong to return
-ENODEV in this case as above ?

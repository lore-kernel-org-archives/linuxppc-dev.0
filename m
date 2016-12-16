Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgHCP0SwFzDwDf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 04:21:04 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBGHJ2o2028586
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 12:21:02 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27cg7gxs30-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 12:21:02 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 10:21:00 -0700
Subject: Re: [PATCH V2 0/4] OPTPROBES for powerpc
To: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
 <fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, paulus@samba.org,
 mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 22:50:51 +0530
MIME-Version: 1.0
In-Reply-To: <fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------507D26ACD236A9771250DCE3"
Message-Id: <5454f661-f33a-9d0c-6e18-deaf7687db0b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------507D26ACD236A9771250DCE3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Balbir,



On Friday 16 December 2016 08:16 PM, Balbir Singh wrote:
>
> On 15/12/16 03:18, Anju T Sudhakar wrote:
>> This is the V2 patchset of the kprobes jump optimization
>> (a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
>> for kernel developers, enhancing the performance of kprobe has
>> got much importance.
>>
>> Currently kprobes inserts a trap instruction to probe a running kernel.
>> Jump optimization allows kprobes to replace the trap with a branch,
>> reducing the probe overhead drastically.
>>
>> In this series, conditional branch instructions are not considered for
>> optimization as they have to be assessed carefully in SMP systems.
>>
>> The kprobe placed on the kretprobe_trampoline during boot time, is also
>> optimized in this series. Patch 4/4 furnishes this.
>>
>> The first two patches can go independently of the series. The helper
>> functions in these patches are invoked in patch 3/4.
>>
>> Performance:
>> ============
>> An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.
>>   
>> Example:
>>   
>> Placed a probe at an offset 0x50 in _do_fork().
>> *Time Diff here is, difference in time before hitting the probe and
>> after the probed instruction. mftb() is employed in kernel/fork.c for
>> this purpose.
>>   
>> # echo 0 > /proc/sys/debug/kprobes-optimization
>> Kprobes globally unoptimized
>>   [  233.607120] Time Diff = 0x1f0
>>   [  233.608273] Time Diff = 0x1ee
>>   [  233.609228] Time Diff = 0x203
>>   [  233.610400] Time Diff = 0x1ec
>>   [  233.611335] Time Diff = 0x200
>>   [  233.612552] Time Diff = 0x1f0
>>   [  233.613386] Time Diff = 0x1ee
>>   [  233.614547] Time Diff = 0x212
>>   [  233.615570] Time Diff = 0x206
>>   [  233.616819] Time Diff = 0x1f3
>>   [  233.617773] Time Diff = 0x1ec
>>   [  233.618944] Time Diff = 0x1fb
>>   [  233.619879] Time Diff = 0x1f0
>>   [  233.621066] Time Diff = 0x1f9
>>   [  233.621999] Time Diff = 0x283
>>   [  233.623281] Time Diff = 0x24d
>>   [  233.624172] Time Diff = 0x1ea
>>   [  233.625381] Time Diff = 0x1f0
>>   [  233.626358] Time Diff = 0x200
>>   [  233.627572] Time Diff = 0x1ed
>>   
>> # echo 1 > /proc/sys/debug/kprobes-optimization
>> Kprobes globally optimized
>>   [   70.797075] Time Diff = 0x103
>>   [   70.799102] Time Diff = 0x181
>>   [   70.801861] Time Diff = 0x15e
>>   [   70.803466] Time Diff = 0xf0
>>   [   70.804348] Time Diff = 0xd0
>>   [   70.805653] Time Diff = 0xad
>>   [   70.806477] Time Diff = 0xe0
>>   [   70.807725] Time Diff = 0xbe
>>   [   70.808541] Time Diff = 0xc3
>>   [   70.810191] Time Diff = 0xc7
>>   [   70.811007] Time Diff = 0xc0
>>   [   70.812629] Time Diff = 0xc0
>>   [   70.813640] Time Diff = 0xda
>>   [   70.814915] Time Diff = 0xbb
>>   [   70.815726] Time Diff = 0xc4
>>   [   70.816955] Time Diff = 0xc0
>>   [   70.817778] Time Diff = 0xcd
>>   [   70.818999] Time Diff = 0xcd
>>   [   70.820099] Time Diff = 0xcb
>>   [   70.821333] Time Diff = 0xf0
>>
>> Implementation:
>> ===================
>>   
>> The trap instruction is replaced by a branch to a detour buffer. To address
>> the limitation of branch instruction in power architecture, detour buffer
>> slot is allocated from a reserved area . This will ensure that the branch
>> is within ± 32 MB range. The current kprobes insn caches allocate memory
>> area for insn slots with module_alloc(). This will always be beyond
>> ± 32MB range.
>>   
> The paragraph is a little confusing. We need the detour buffer to be within
> +-32 MB, but then you say we always get memory from module_alloc() beyond
> 32MB.

The last two lines in the paragraph talks about the*current 
*method**which the regular kprobe uses
for allocating instruction slot. So in our case, we can't use 
module_alloc() since there is no guarantee that the slot allocated will 
be within +/- 32MB range.
>> The detour buffer contains a call to optimized_callback() which in turn
>> call the pre_handler(). Once the pre-handler is run, the original
>> instruction is emulated from the detour buffer itself. Also the detour
>> buffer is equipped with a branch back to the normal work flow after the
>> probed instruction is emulated.
> Does the branch itself use registers that need to be saved? I presume
> we are going to rely on the +-32MB, what are the guarantees of success
> of such a mechanism?

For branching back to the next instruction, after the execution of the 
kprobe's pre-handler,
we place the branch instruction in the detour buffer itself. Hence we 
don't have to clobber any registers
after restoring them.
Before optimizing the kprobe we make sure that , 'branch to detour 
buffer' and 'branch back from detour buffer' is within +/- 32MB range. 
This ensures the working of optimized kprobe.


Thanks ,
Anju

>
> Balbir Singh.
>


--------------507D26ACD236A9771250DCE3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hi Balbir,</p>
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Friday 16 December 2016 08:16 PM,
      Balbir Singh wrote:<br>
    </div>
    <blockquote
      cite="mid:fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com"
      type="cite">
      <pre wrap="">

On 15/12/16 03:18, Anju T Sudhakar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This is the V2 patchset of the kprobes jump optimization
(a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
for kernel developers, enhancing the performance of kprobe has
got much importance.

Currently kprobes inserts a trap instruction to probe a running kernel.
Jump optimization allows kprobes to replace the trap with a branch,
reducing the probe overhead drastically.

In this series, conditional branch instructions are not considered for
optimization as they have to be assessed carefully in SMP systems.

The kprobe placed on the kretprobe_trampoline during boot time, is also
optimized in this series. Patch 4/4 furnishes this.

The first two patches can go independently of the series. The helper 
functions in these patches are invoked in patch 3/4.

Performance:
============
An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.
 
Example:
 
Placed a probe at an offset 0x50 in _do_fork().
*Time Diff here is, difference in time before hitting the probe and
after the probed instruction. mftb() is employed in kernel/fork.c for
this purpose.
 
# echo 0 &gt; /proc/sys/debug/kprobes-optimization
Kprobes globally unoptimized
 [  233.607120] Time Diff = 0x1f0
 [  233.608273] Time Diff = 0x1ee
 [  233.609228] Time Diff = 0x203
 [  233.610400] Time Diff = 0x1ec
 [  233.611335] Time Diff = 0x200
 [  233.612552] Time Diff = 0x1f0
 [  233.613386] Time Diff = 0x1ee
 [  233.614547] Time Diff = 0x212
 [  233.615570] Time Diff = 0x206
 [  233.616819] Time Diff = 0x1f3
 [  233.617773] Time Diff = 0x1ec
 [  233.618944] Time Diff = 0x1fb
 [  233.619879] Time Diff = 0x1f0
 [  233.621066] Time Diff = 0x1f9
 [  233.621999] Time Diff = 0x283
 [  233.623281] Time Diff = 0x24d
 [  233.624172] Time Diff = 0x1ea
 [  233.625381] Time Diff = 0x1f0
 [  233.626358] Time Diff = 0x200
 [  233.627572] Time Diff = 0x1ed
 
# echo 1 &gt; /proc/sys/debug/kprobes-optimization
Kprobes globally optimized
 [   70.797075] Time Diff = 0x103
 [   70.799102] Time Diff = 0x181
 [   70.801861] Time Diff = 0x15e
 [   70.803466] Time Diff = 0xf0
 [   70.804348] Time Diff = 0xd0
 [   70.805653] Time Diff = 0xad
 [   70.806477] Time Diff = 0xe0
 [   70.807725] Time Diff = 0xbe
 [   70.808541] Time Diff = 0xc3
 [   70.810191] Time Diff = 0xc7
 [   70.811007] Time Diff = 0xc0
 [   70.812629] Time Diff = 0xc0
 [   70.813640] Time Diff = 0xda
 [   70.814915] Time Diff = 0xbb
 [   70.815726] Time Diff = 0xc4
 [   70.816955] Time Diff = 0xc0
 [   70.817778] Time Diff = 0xcd
 [   70.818999] Time Diff = 0xcd
 [   70.820099] Time Diff = 0xcb
 [   70.821333] Time Diff = 0xf0

Implementation:
===================
 
The trap instruction is replaced by a branch to a detour buffer. To address
the limitation of branch instruction in power architecture, detour buffer
slot is allocated from a reserved area . This will ensure that the branch
is within ± 32 MB range. The current kprobes insn caches allocate memory 
area for insn slots with module_alloc(). This will always be beyond 
± 32MB range.
 
</pre>
      </blockquote>
      <pre wrap="">
The paragraph is a little confusing. We need the detour buffer to be within
+-32 MB, but then you say we always get memory from module_alloc() beyond
32MB.
</pre>
    </blockquote>
    <br>
    The last two lines in the paragraph talks about the<b> current </b>method<b>
    </b>which the regular kprobe uses<br>
    for allocating instruction slot. So in our case, we can't use
    module_alloc() since there is no guarantee that the slot allocated
    will be within +/- 32MB range.<br>
    <blockquote
      cite="mid:fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">The detour buffer contains a call to optimized_callback() which in turn
call the pre_handler(). Once the pre-handler is run, the original
instruction is emulated from the detour buffer itself. Also the detour
buffer is equipped with a branch back to the normal work flow after the
probed instruction is emulated.
</pre>
      </blockquote>
      <pre wrap="">
Does the branch itself use registers that need to be saved? I presume
we are going to rely on the +-32MB, what are the guarantees of success
of such a mechanism?</pre>
    </blockquote>
    <br>
    For branching back to the next instruction, after the execution of
    the kprobe's pre-handler,<br>
    we place the branch instruction in the detour buffer itself. Hence
    we don't have to clobber any registers<br>
    after restoring them.<br>
    Before optimizing the kprobe we make sure that , 'branch to detour
    buffer' and 'branch back from detour buffer' is within +/- 32MB
    range. This ensures the working of optimized kprobe.<br>
    <br>
    <br>
    Thanks ,<br>
    Anju <br>
    <br>
    <blockquote
      cite="mid:fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com"
      type="cite">
      <pre wrap="">

Balbir Singh.

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------507D26ACD236A9771250DCE3--

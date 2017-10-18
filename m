Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH20s6JmfzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:17:49 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9I6G6oX054597
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:17:47 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnya9d5vq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:17:47 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 07:17:44 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9I6HeCc31391872
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 06:17:41 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9I6HW8j006990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:17:33 +1100
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Torsten Duwe <duwe@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 11:47:35 +0530
MIME-Version: 1.0
In-Reply-To: <20171017144733.GB2136@lst.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 17 October 2017 08:17 PM, Torsten Duwe wrote:
> On Fri, Oct 06, 2017 at 11:27:42AM +0530, Kamalesh Babulal wrote:
>>
>> Consider the livepatch sequence[1]. Where function A calls B, B is the
>> function which has been livepatched and the call to function B is
>> redirected to patched version P. P calls the function C in M2, whereas
>> C was local to the function B and have became SHN_UNDEF in function P.
>> Local call becoming global.
>>
>>   +--------+            +--------+    +--------+      +--------+
>>   |        |   +--------+--------+--->|        |  +-->|        |
>>   |  A     |   |        |  B     |    |  F     |  |   |  P     |
>>   |        |   |        |        |    |        +--+   |        |
>>   |        +---+        |        |    |        |<-+   |        |
>>   |        |<--+   +----+   C    |    |        |  |   |        |
>>   |        |   |   | +->|        |    |        |  |   |        |<---+
>>   | K / M1 |   |   | |  | K / M2 |  +-+ Kernel |  +---+ Mod3   +--+ |
>>   +--------+   |   | |  +--------+  | +--------+      +--------+  | |
>>                |   | |              |                             | |
>>                +---+-+--------------+                             | |
>>                    | |                                            | |
>>                    | +--------------------------------------------+ |
>>                    +------------------------------------------------+
>>
>>
>> Handling such call with regular stub, triggers another error:
>>
>> module_64: kpatch_meminfo: Expect noop after relocate, got 3d220000
>>
>> Every branch to SHN_UNDEF is followed by a nop instruction, that gets
>> overwritten by an instruction to restore TOC with r2 value that get
>> stored onto the stack, before calling the function via global entry
>> point.
>>
>> Given that C was local to function B, it does not store/restore TOC as
>> they are not expected to be clobbered for functions called via local
>> entry point.
> 
> Can you please provide example source code of Mod3 and C? If P calls C, this
> is a regular global call, the TOC is saved by the stub and restored after the
> call instruction. Why do you think this is not the case? 
> 

Consider a trivial patch, supplied to kpatch tool for generating a
livepatch module:

--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -132,7 +132,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
        seq_printf(m, "VmallocTotal:   %8lu kB\n",
                   (unsigned long)VMALLOC_TOTAL >> 10);
        show_val_kb(m, "VmallocUsed:    ", 0ul);
-       show_val_kb(m, "VmallocChunk:   ", 0ul);
+       show_val_kb(m, "VMALLOCCHUNK:   ", 0ul);

 #ifdef CONFIG_MEMORY_FAILURE
        seq_printf(m, "HardwareCorrupted: %5lu kB\n",

# readelf -s -W ./fs/proc/meminfo.o
Symbol table '.symtab' contains 54 entries:
Num: Value Size Type Bind  Vis     Ndx Name
...
23:  0x50  224  FUNC LOCAL DEFAULT [<localentry>: 8] 1 show_val_kb
...

# objdump -dr ./fs/proc/meminfo.o
0000000000000140 <meminfo_proc_show>:
 204:   01 00 00 48     bl      204 <meminfo_proc_show+0xc4>
                        204: R_PPC64_REL24      si_mem_available
 208:   00 00 00 60     nop
 ...
 220:   01 00 00 48     bl      220 <meminfo_proc_show+0xe0>
                        220: R_PPC64_REL24      show_val_kb
 224:   88 00 a1 e8     ld      r5,136(r1)
 228:   00 00 82 3c     addis   r4,r2,0

show_val_kb() is called by meminfo_proc_show() frequently to print memory
statistics, is also defined in meminfo.o. Which means both the functions
share the same TOC base and is accessed via local entry point by
calculating the offset with respect to current TOC.

A nop instruction is only excepted after every branch to a global call.
That gets overwritten by an instruction to restore TOC with r2 value of
callee. Given function show_val_kb() is local to meminfo_proc_show(),
any call to show_val_kb() doesn't requires setting up/restoring TOC as
they are not expected to be clobbered for local function call (via local
entry point).

kpatch identifies the patched function to be meminfo_proc_show() and copies
it into livepatch module, along with required symbols and livepatch hooks
but doesn't copies show_val_kb(). The reason being, it can be called like
any other global function and is marked with SHN_LIVEPATCH symbol section
index. show_val_kb() which is local to meminfo_proc_show(), is global to
patched version of meminfo_proc_show().

Symbol table '.symtab' contains 91 entries:
Num: Value Size Type Bind  Vis     Ndx Name
...
82:  0x0   0    FUNC LOCAL DEFAULT OS [0xff20] .klp.sym.vmlinux.show_val_kb,1
...

apply_relocate_add() should be modified to handle show_val_kb() via global
entry point (through stub) like SHN_UNDEF. Branch to a global function, is
excepted to be followed by a nop instruction. Whereas patched version of
meminfo_proc_show() code is not modified to add a nop after every branch to
show_val_kb(). Nop instruction is required for setting up r2 with the TOC
of livepatch module, which is clobbered by TOC base, required to access
show_val_kb() and fails with error:

module_64: kpatch_meminfo: Expect noop after relocate, got 3d220000

Approach is to setup klp_stub mimicking the functionality of
entry_64.S::livepatch_handler to store/restore TOC/LR values, other than
the stub setup and branching code.

-- 
cheers,
Kamalesh.

Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb7tb1HkhzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 22:38:14 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vADBamSV006207
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 06:38:13 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e791pvp59-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 06:38:12 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 11:38:09 -0000
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Balbir Singh <bsingharora@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>
References: <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de> <20171107045419.aozlfdo7tpnubz72@treble>
 <8760am4hd6.fsf@concordia.ellerman.id.au> <20171107113105.GA19204@lst.de>
 <20171107145233.lmlg5lkfcczkxj4d__32032.512050546$1510066460$gmane$org@treble>
 <1510225685.pzdd3dgj9m.naveen@linux.ibm.com>
 <20171109151955.gl3z3l2ary4ayj7b@treble>
 <CAKTCnznuZFHgVjjnx+gBAk3RSenxS=PJLFBsxOq4Zzw=ru=HMg@mail.gmail.com>
 <20171110032823.nnpqsrrfwr6ye4uc@treble>
 <CAKTCnzm63vVGctVarw24v1JY2N7Kc3WdmoW88q2fniEAqXkP_w@mail.gmail.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Torsten Duwe <duwe@lst.de>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Jessica Yu <jeyu@kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 17:08:02 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzm63vVGctVarw24v1JY2N7Kc3WdmoW88q2fniEAqXkP_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f5353c3d-ba9a-fa2e-17ca-3f460c3f2b61@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 13 November 2017 02:08 PM, Balbir Singh wrote:
> On Fri, Nov 10, 2017 at 2:28 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> On Fri, Nov 10, 2017 at 01:06:25PM +1100, Balbir Singh wrote:
>>> On Fri, Nov 10, 2017 at 2:19 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>> FWIW, I think it won't matter anyway.  I'm currently pursuing the option
>>>> of inserting nops after local calls, because it has less runtime
>>>> complexity than using a stub.
>>>>
>>>> I think I've figured out a way to do it with a GCC plugin, but if that
>>>> doesn't work I'll try the asm listing sed approach suggested by Michael.
>>>>
>>>
>>> A plugin that runs for the new kernel with the patch? Just for
>>> specific files involved in the patch?
>>
>> The plugin will affect the code generation of all functions in the patch
>> module.  So all calls in all replacement functions will have the nops.
>>
>> Here's a prototype (not yet fully tested):
>>
>>   https://github.com/jpoimboe/kpatch/blob/TODO-ppc-fix/kpatch-build/gcc-plugins/ppc64le-plugin.c
>>
>

[...]

> I'd have to look closer, but I wonder what happens if a
> function has no global entry
> point
>
> (See http://mpe.github.io/posts/2016/05/23/kernel-live-patching-for-ppc64le/)
> section
> Understanding the TOC & entry points and the example of int_to_scsilun()
>

int_to_scsilun() is accessed via global entry point, but the TOC setup
part in the function prologue is skipped as the function doesn't have a
need to save/restore TOC. The reason begin, it doesn't calls any global
functions, thus the r2 register is not clobbered.

As per my understanding, the plug-in inserts a nop instruction after
branch to a function called via localentry a.k.a call to local
function. In case of int_to_scsilun(), the plug-in will not modify the
function in any way, as there are no local calls also made by the
int_to_scsilun().

-- 
cheers,
Kamalesh.

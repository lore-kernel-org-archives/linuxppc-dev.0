Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yf7YT2hYjzDrSP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 19:33:48 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAI8Uvf2101246
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 03:33:46 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eaehc5s33-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 03:33:45 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 18 Nov 2017 08:33:43 -0000
Date: Sat, 18 Nov 2017 14:03:36 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4.2] powerpc/modules: Don't try to restore r2 after a
 sibling call
To: Josh Poimboeuf <jpoimboe@redhat.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
 <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
 <20171114155323.3sjxx3eykinnl2ea@treble>
 <1510737417.g8rnjuztlf.naveen@linux.ibm.com>
 <20171116012628.6ajxlychto365sf6@treble>
 <1510837263.5d3ac8knzo.naveen@linux.ibm.com>
 <20171116174537.duz4x6vfzhp44lfh@treble>
 <2094a573-d236-e1b7-6f4d-47049f3d0dfb@linux.vnet.ibm.com>
In-Reply-To: <2094a573-d236-e1b7-6f4d-47049f3d0dfb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1510992250.emxjvilqnz.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> On Thursday 16 November 2017 11:15 PM, Josh Poimboeuf wrote:
>> On Thu, Nov 16, 2017 at 06:39:03PM +0530, Naveen N. Rao wrote:
>>> Josh Poimboeuf wrote:
>>>> On Wed, Nov 15, 2017 at 02:58:33PM +0530, Naveen N. Rao wrote:
>>>>>> +int instr_is_link_branch(unsigned int instr)
>>>>>> +{
>>>>>> +	return (instr_is_branch_iform(instr) || instr_is_branch_bform(inst=
r)) &&
>>>>>> +	       (instr & BRANCH_SET_LINK);
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Nitpicking here, but since we're not considering the other branch for=
ms,
>>>>> perhaps this can be renamed to instr_is_link_relative_branch() (or ma=
ybe
>>>>> instr_is_relative_branch_link()), just so we're clear :)
>>>>
>>>> My understanding is that the absolute/relative bit isn't a "form", but
>>>> rather a bit that can be set for either the b-form (conditional) or th=
e
>>>> i-form (unconditional).  And the above function isn't checking the
>>>> absolute bit, so it isn't necessarily a relative branch.  Or did I mis=
s
>>>> something?
>>>
>>> Ah, good point. I was coming from the fact that we are only considering=
 the
>>> i-form and b-form branches and not the lr/ctr/tar based branches, which=
 are
>>> always absolute branches, but can also set the link register.
>>
>> Hm, RISC is more complicated than I realized ;-)

As long as 'RISC' gets people to take a look ;D

>>
>>> Thinking about this more, aren't we only interested in relative branche=
s
>>> here (for relocations), so can we actually filter out the absolute bran=
ches?
>>> Something like this?
>>>
>>> int instr_is_relative_branch_link(unsigned int instr)
>>> {
>>> 	return ((instr_is_branch_iform(instr) || instr_is_branch_bform(instr))=
 &&
>>> 	       !(instr & BRANCH_ABSOLUTE) && (instr & BRANCH_SET_LINK));
>>
>> Yeah, makes sense to me.  Here's another try (also untested).  If this
>> looks ok, Kamalesh would you mind testing again?

Thanks. That looks good to me.
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

>>
>> ----8<----
>>
>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>> Subject: [PATCH v4.2] powerpc/modules: Don't try to restore r2 after a s=
ibling call
>>
>> When attempting to load a livepatch module, I got the following error:
>>
>>   module_64: patch_module: Expect noop after relocate, got 3c820000
>>
>> The error was triggered by the following code in
>> unregister_netdevice_queue():
>>
>>   14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
>>                          14c: R_PPC64_REL24      net_set_todo
>>   150:   00 00 82 3c     addis   r4,r2,0
>>
>> GCC didn't insert a nop after the branch to net_set_todo() because it's
>> a sibling call, so it never returns.  The nop isn't needed after the
>> branch in that case.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>=20
> Reviewed-and-tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Thanks, Kamalesh!


- Naveen

=

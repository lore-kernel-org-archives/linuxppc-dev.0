Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtDzM6C4gzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 17:18:07 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6I7DcG3018472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 03:18:05 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 248ncnf2fj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 03:18:05 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Mon, 18 Jul 2016 08:18:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 70A6117D805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 08:19:28 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6I7HxkO2818394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 07:17:59 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6I7HwYw021753
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 03:17:59 -0400
Subject: Re: [PATCH V2 4/5] kvm/stats: Add provisioning for 64-bit vcpu
 statistics
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-4-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=e=hScxto3c=4rJ88Phg989UZhk+O44rV56obFP3v1SFg@mail.gmail.com>
 <9253603f-fbfb-09f1-9576-9291d1587397@redhat.com>
 <CALzav=cueDab=SQ0WmL6JcAY-18SLvcaVF9Zc1Ezs_f-eP7HOA@mail.gmail.com>
 <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
 <578681D6.8070801@de.ibm.com>
 <46eaef93-af3a-4dbb-eb3e-df3d63b1eb1c@redhat.com>
 <57889634.9030302@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Jul 2016 09:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <57889634.9030302@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <578C82A6.6090201@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2016 09:52 AM, Suraj Jitindar Singh wrote:
> 
> 
> On 14/07/16 19:42, Paolo Bonzini wrote:
>>
>> On 13/07/2016 20:00, Christian Borntraeger wrote:
>>>>>>> I thought u64 still existed on 32-bit architectures. unsigned long
>>>>>>> would be fine but with the caveat that certain stats would overflow on
>>>>>>> 32-bit architectures.
>>>>> Yes, but not all 32-bit architectures can do atomic read-modify-write
>>>>> (e.g. add) operations on 64-bit values.
>>> So what about only doing it for the VCPU events? Those should be only
>>> modified by one CPU. We would have some odd values on 32bit overflow, but
>>> this will be certainly better than just start with 0
>> If that's good enough for PPC, that's fine.
>>
>> Paolo
> 
> I'm don't feel great about having vcpu_stats as u64 and vm_stats still as u32
> it's just a bit inconsistent.
> 
> That being said, it's only the vcpu_stats which I require to be u64 at this
> stage so it's possible to just upgrade those.

Yes, its not nice, but we probably want to avoid the overhead of atomics.
What about using u64 for vcpu_stats and unsigned long for vm_stats. This will be
correct for anyone and on 64bit systems we get 64 bits for everything?

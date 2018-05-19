Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ntn95FXSzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 15:26:21 +1000 (AEST)
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: Andy Lutomirski <luto@kernel.org>, linuxram@us.ibm.com
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>
References: <53828769-23c4-b2e3-cf59-239936819c3e@redhat.com>
 <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
 <CALCETrWMP9kTmAFCR0WHR3YP93gLSzgxhfnb0ma_0q=PCuSdQA@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <b5875cbf-16f6-41cd-1f9e-cb94b0eb3a18@redhat.com>
Date: Sat, 19 May 2018 07:26:17 +0200
MIME-Version: 1.0
In-Reply-To: <CALCETrWMP9kTmAFCR0WHR3YP93gLSzgxhfnb0ma_0q=PCuSdQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2018 03:50 AM, Andy Lutomirski wrote:
> Now another thread calls pkey_alloc(), so UAMR is asynchronously changed,
> and the thread will write zero to the relevant AMR bits.  If I understand
> correctly, this means that the decision to mask off unallocated keys via
> UAMR effectively forces the initial value of newly-allocated keys in other
> threads in the allocating process to be zero, whatever zero means.  (I
> didn't get far enough in the POWER docs to figure out what zero means.)  So

(Note that this belongs on the other thread, here I originally wanted to 
talk about the lack of reset of AMR to the default value on execve.)

I don't think UAMOR is updated asynchronously.  On pkey_alloc, it is 
only changed for the current thread, and future threads launched from 
it.  Existing threads are unaffected.  This still results in a 
programming model which is substantially different from x86.

> I don't think you're doing anyone any favors by making UAMR dynamic.

This is still true, I think.

Thanks,
Florian

Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ngrc0gLlzDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 07:13:36 +1000 (AEST)
Subject: Re: pkeys on POWER: Default AMR, UAMOR values
To: Andy Lutomirski <luto@amacapital.net>, linuxram@us.ibm.com
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>
References: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
 <20180518174448.GE5479@ram.oc3035372033.ibm.com>
 <CALCETrV_wYPKHna8R2Bu19nsDqF2dJWarLLsyHxbcYD_AgYfPg@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <27e01118-be5c-5f90-78b2-56bb69d2ab95@redhat.com>
Date: Fri, 18 May 2018 23:13:30 +0200
MIME-Version: 1.0
In-Reply-To: <CALCETrV_wYPKHna8R2Bu19nsDqF2dJWarLLsyHxbcYD_AgYfPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2018 09:39 PM, Andy Lutomirski wrote:
> The difference is that x86 starts out with deny-all instead of allow-all.
> The POWER semantics make it very hard for a multithreaded program to
> meaningfully use protection keys to prevent accidental access to important
> memory.

And you can change access rights for unallocated keys (unallocated at 
thread start time, allocated later) on x86.  I have extended the 
misc/tst-pkeys test to verify that, and it passes on x86, but not on 
POWER, where the access rights are stuck.

I believe this is due to an incorrect UAMOR setting.

Thanks,
Florian

Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8h4N0cXCzDvRC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 21:27:47 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3ANgvW010832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 06:27:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26g0rpcgkm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 06:27:41 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 06:27:40 -0400
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten> <581ACDF2.1010409@linux.vnet.ibm.com>
 <8737j8opwb.fsf@concordia.ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, duwe@lst.de, ast@kernel.org,
 viro@zeniv.linux.org.uk, chris@distroguy.com, oss@buserror.net,
 paul.gortmaker@windriver.com, oohall@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 3 Nov 2016 15:57:27 +0530
MIME-Version: 1.0
In-Reply-To: <8737j8opwb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <581B110F.9050805@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 03 November 2016 03:18 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> On Thursday 03 November 2016 02:34 AM, Anton Blanchard wrote:
>>> Hi Ravi,
>>>
>>>> emulate_step() uses a number of underlying kernel functions that were
>>>> initially not enabled for LE. This has been rectified since. So, fix
>>>> emulate_step() for LE for the corresponding instructions.
>>> Thanks. Should this be queued up for stable?
>> Thanks Anton. Yes, this should go in stable.
> It's fairly big for stable. Does it fix an actual bug? If so what, and
> how bad is it, what's the user impact.

Hi Michael,

Yes, kernel-space hw-breakpoint feature is broken on LE without this.

Actually, there is no specific commit that introduced this. Back
in 2010, Paul Mackerras has added emulation support for load/store
instructions for BE. hw-breakpoint was also develpoed by K.Prasad
in the same timeframe.

Kernel-space hw-breakpoint emulates causative instruction before
notifying to user. As emulate_step is never enabled for LE, kernel-
space hw-breakpoint is always broken on LE.

-Ravi

> Can you also pinpoint which commit it "fixes"?
>
> cheers
>

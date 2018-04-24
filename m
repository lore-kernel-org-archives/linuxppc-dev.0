Return-Path: <sukadev@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vwyl1VFpzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 07:12:43 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3OLARV8016012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:12:40 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hj8gd210d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:12:40 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.ibm.com>;
 Tue, 24 Apr 2018 15:12:39 -0600
Date: Tue, 24 Apr 2018 14:12:32 -0700
From: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
 felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
 <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
Message-Id: <20180424211231.GA25392@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan [andrew.donnellan@au1.ibm.com] wrote:
> [+ Sukadev, Christophe]
> 
> On 18/04/18 11:08, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The current implementation of TID allocation, using a global IDR, may
> > result in an errant process starving the system of available TIDs.
> > Instead, use task_pid_nr(), as mentioned by the original author. The
> > scenario described which prevented it's use is not applicable, as
> > set_thread_tidr can only be called after the task struct has been
> > populated.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> So it's too late in the evening for me to completely get my head around
> what's going on here enough to give my Reviewed-by:, but my current thinking
> is:
> 
> - In the first version of the patch to add TIDR support
> (https://patchwork.ozlabs.org/patch/799494/), it was originally proposed to
> call assign_thread_id() (as it was then called) from copy_thread()
> 
> - The comment block documents the reason why we can't use task_pid_nr() but
> assumes that we're trying to assign a TIDR from within copy_thread()
> 
> - The final patch that was accepted
> (https://patchwork.ozlabs.org/patch/835552/,
> ec233ede4c8654894610ea54f4dae7adc954ac62) instead sets the TIDR to 0 from
> copy_thread(), so the original reasoning regarding not using task_pid_nr()
> within copy_thread() is no longer applicable.
> 
> Sukadev: does this sound right?

Yes. Like with PIDR, was trying to assign TIDR initially to all threads.
But since only a subset of threads need/use TIDR, we can assign the
value later (when set_thread_tidr() is called). So we should be able to
use task_pid_nr() then.

Sukadev

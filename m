Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Br0X2QNjzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 17:33:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5M7TKq8003484
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:33:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jruuv2bmd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:33:45 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 22 Jun 2018 08:33:43 +0100
Subject: Re: [PATCH] ocxl: Fix page fault handler in case of fault on dying
 process
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@d-silva.org,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.ibm.com, vaibhav@linux.ibm.com
References: <20180618121436.20479-1-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 21 Jun 2018 18:07:26 +1000
MIME-Version: 1.0
In-Reply-To: <20180618121436.20479-1-fbarrat@linux.ibm.com>
Message-Id: <1df943c8-88f8-91e2-e133-d6d578d1bb77@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/06/18 22:14, Frederic Barrat wrote:
> If a process exits without doing proper cleanup, there's a window
> where an opencapi device can try to access the memory of the dying
> process and may trigger a page fault. That's an expected scenario and
> the ocxl driver holds a reference on the mm_struct of the process
> until the opencapi device is notified of the process exiting.
> However, if mm_users is already at 0, i.e. the address space of the
> process has already been destroyed, the driver shouldn't try resolving
> the page fault, as it will fail, but it can also try accessing already
> freed data.
> 
> It is fixed by only calling the bottom half of the page fault handler
> if mm_users is greater than 0 and get a reference on mm_users instead
> of mm_count. Otherwise, we can safely return a translation fault to
> the device, as its associated memory context is being removed. The
> opencapi device will be properly cleaned up shortly after when closing
> the file descriptors.
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Cc: stable@vger.kernel.org # v4.16+
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

I think I understand what's going on here and it looks right.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

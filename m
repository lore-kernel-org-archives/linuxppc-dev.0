Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZGGH0VKFzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:21:26 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v234Ir6s012515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 23:21:24 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8ckbkm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 23:21:23 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 09:51:20 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9DC5C125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 09:51:29 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v234KAx020316210
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 09:50:10 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v234LFFS026808
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 09:51:16 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
In-Reply-To: <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
Date: Fri, 03 Mar 2017 09:51:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r32f6ldy.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Russell,

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> This patch introduces function eeh_pe_reset_freeze_counter() which can
> be used to reset the PE's freeze count variable outside eeh code. This
> is useful for devices that can acquire a different personality after
> a PERST event (e.g FPGA Adapters). Presently an existing freeze
> count for an adapter with personality N will be taken into account
> when the adapter acquired personality N+1.
>
> By calling eeh_pe_reset_freeze_counter() drivers can reset the freeze
> counter for an adapter once it has acquired a new personality and
> ideally wont be plagued by the failures similar to the one before.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
Had a short chat discussion with Gavin Shan on this patchset and he
preffers restoring the freeze_count on the eeh_pe once FRESET is done.
He expects a the flow to be similar to one below

1. module caches the value of freeze_count and resets it
2. Issue warm reset
3. During eeh error-detected callback module restores the freeze_count
from the cached value.

Russell, what do you think? 

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

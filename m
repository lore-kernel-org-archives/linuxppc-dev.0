Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNZ1s4ZGGzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 20:37:05 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F9Xrno044628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 04:37:01 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mh7cxxuq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 04:37:00 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 15:06:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6BFF4E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:08:22 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1F9anri25755804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:06:49 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1F9amT8015125
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:06:49 +0530
Subject: Re: [PATCH v6 00/12]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <43cad35a-e19b-49e0-b4d1-9372c8a2d372@linux.vnet.ibm.com>
 <87y3xg97io.fsf@concordia.ellerman.id.au>
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 15:06:47 +0530
MIME-Version: 1.0
In-Reply-To: <87y3xg97io.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3666477c-64c1-2a6e-7f67-88fb3aaf1289@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 08 February 2017 06:14 PM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> Hi mpe,
>>
>> Any update on this series. Have also fixed the naming issue with patch 12
>> and with this series applied,
>>
>> "paca->soft_enabled"  becomes "paca->soft_disabled_mask"
> Yeah sorry I've been putting off dealing with it.
>
> Ideally we'd do the naming change earlier in the series, but maybe
> that's not worth it.
>
> The one thing I wanted to make sure was that regs->softe is never
> exposed to userspace. Because we're changing its semantics, and user
> space has no business knowing about it.
>
> So I just checked the code, and we do allow userspace to see the softe
> value. So I think we should fix that before this goes in.
>
> The safest option is to just hardwire it to 1, as that's the value it
> should always have in a userspace pt_regs.
Ok let me look at this, currently  I do see the "softe" used
to decide on the return_irq path and does not look straight
forward change.

Maddy


>
> cheers
>

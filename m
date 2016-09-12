Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZtv1hhtzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:43:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8C4h8FB119575
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:43:17 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ceawvfn9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:43:16 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 12 Sep 2016 14:43:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DB7E23578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:43:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8C4h9Mp53280884
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:43:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8C4h9XE020894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:43:09 +1000
Subject: Re: [PATCH 2/3] powernv/eeh: Skip finding bus for VF resets
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20160912041724.16646-1-ruscur@russell.cc>
 <20160912041724.16646-2-ruscur@russell.cc>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 12 Sep 2016 14:43:09 +1000
MIME-Version: 1.0
In-Reply-To: <20160912041724.16646-2-ruscur@russell.cc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <75e21325-0a01-f2a4-c4dd-196e3926eeed@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/16 14:17, Russell Currey wrote:
> When the PE used in pnv_eeh_reset() is that of a VF,
> pnv_eeh_reset_vf_pe() is used.  Unlike the other reset functions called
> in pnv_eeh_reset(), the VF reset doesn't require a bus, and if a bus was
> missing the function would error out before resetting the VF PE.
>
> To avoid this, reorder the VF reset function to occur before finding and
> checking the bus.
>
> Cc: stable #3.10+
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Looks good to me. Personally I'd put all 3 of these patches into one, 
not that I care too much.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

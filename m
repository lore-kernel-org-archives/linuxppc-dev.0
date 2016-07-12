Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpbdr4h0XzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:05:19 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C8x5vW058594
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 05:05:17 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243eddjwgp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 05:05:17 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jul 2016 19:05:14 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 540CA2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:05:12 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6C95CCr21037256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:05:12 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6C95BiO025435
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:05:12 +1000
Subject: Re: [PATCH 06/15] cxl: Do not create vPHB if there are no AFU
 configuration records
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-7-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jul 2016 19:05:10 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-7-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5cb9b9c7-45be-3fe1-a0b0-dc1ac9e5d53d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The vPHB model of the cxl kernel API is a hierarchy where the AFU is
> represented by the vPHB, and it's AFU configuration records are exposed
> as functions under that vPHB. If there are no AFU configuration records
> we will create a vPHB with nothing under it, which is a waste of
> resources and will opt us into EEH handling despite not having anything
> special to handle.
>
> This also does not make sense for cards using the peer model of the cxl
> kernel API, where the other functions of the device are exposed via
> additional peer physical functions rather than AFU configuration
> records. This model will also not work with the existing EEH handling in
> the cxl driver, as that is designed around the vPHB model.
>
> Skip creating the vPHB for AFUs without any AFU configuration records,
> and opt out of EEH handling for them.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

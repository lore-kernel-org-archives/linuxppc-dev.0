Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3vW738HyzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 07:46:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DLhSiH044375
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:46:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t1rkad3s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:46:19 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 17:46:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 10/17] cxlflash: Fence EEH during probe
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <5393e552-5c08-2b76-9a42-c7225ac11877@au1.ibm.com>
Date: Thu, 13 Apr 2017 16:46:06 -0500
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1492024215-55579-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1492024491-55992-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <5393e552-5c08-2b76-9a42-c7225ac11877@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <000DC1F9-1C50-4137-94D4-FC6284EB7458@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Apr 13, 2017, at 1:27 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> On 13/04/17 05:14, Uma Krishnan wrote:
>> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>>=20
>> An EEH during probe can lead to a crash as the recovery thread races
>> with the probe thread. To avoid this issue, introduce new states to
>> fence out EEH recovery until probe has completed. Also ensure the =
reset
>> wait queue is flushed during device removal to avoid orphaned =
threads.
>>=20
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
>=20
> The use of the term "fence" in the commit message might be a bit =
confusing given how the term is already used in the context of EEH :)

Hi Andrew,

I agree that it could be a bit misleading but think the commit message =
is
descriptive enough to avoid confusion. If you feel strongly about it I'm =
happy
to reword the commit.


-matt=

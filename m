Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ws9q2FpzzF24j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 19:25:34 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3Q9OhBX130579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 05:25:32 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hk9sv6pcq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 05:25:31 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 26 Apr 2018 10:25:30 +0100
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
 felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
 <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
 <20180424211231.GA25392@us.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 26 Apr 2018 19:25:22 +1000
MIME-Version: 1.0
In-Reply-To: <20180424211231.GA25392@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c793bf59-5670-e01c-fe63-903844650991@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/04/18 07:12, Sukadev Bhattiprolu wrote:
> Yes. Like with PIDR, was trying to assign TIDR initially to all threads.
> But since only a subset of threads need/use TIDR, we can assign the
> value later (when set_thread_tidr() is called). So we should be able to
> use task_pid_nr() then.

OK. Alastair has also confirmed with me that truncating the pid to a u16 
should be safe, so therefore:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

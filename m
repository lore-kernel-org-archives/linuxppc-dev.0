Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8qCg4ZpTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 17:49:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0R6iKPv018335
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 01:49:49 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 287w54f941-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 01:49:48 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Fri, 27 Jan 2017 16:49:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 886703578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 17:49:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0R6nZEW29818886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 17:49:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0R6nBn0022167
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 17:49:11 +1100
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 12:18:40 +0530
MIME-Version: 1.0
In-Reply-To: <87sho58ifo.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL returns OPAL_WRONG_STATE for XSCOM operations

done to read any core FIR which is sleeping, offline.


On Friday 27 January 2017 05:47 AM, Michael Ellerman wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>
>> Added check for OPAL_WRONG_STATE error code returned from OPAL.
>> Currently Linux flashes "unexpected error" over console for this
>> error. This will avoid throwing such message and return I/O error
>> for such OPAL failures.
> Why do we expect to get OPAL_WRONG_STATE ?
>
> cheers
>

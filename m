Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcLZQ3qzVzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:42:54 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4U4cSZS019501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:42:44 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2as0qcsx7j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:42:44 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 30 May 2017 14:42:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4U4gVDw4522324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:42:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4U4fxxo018126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:42:00 +1000
Subject: Re: [PATCH v2] powerpc/fadump: return error when fadump registration
 fails
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.king@canonical.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20170527154615.29684-1-msuchanek@suse.de>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 30 May 2017 10:11:45 +0530
MIME-Version: 1.0
In-Reply-To: <20170527154615.29684-1-msuchanek@suse.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e1caa0a3-50a0-aff3-3687-2ef31841e587@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2017 09:16 PM, Michal Suchanek wrote:
>  - log an error message when registration fails and no error code listed
>  in the switch is returned
>  - translate the hv error code to posix error code and return it from
>  fw_register
>  - return the posix error code from fw_register to the process writing
>  to sysfs
>  - return EEXIST on re-registration
>  - return success on deregistration when fadump is not registered
>  - return ENODEV when no memory is reserved for fadump

Why do we need this ? Userspace can always read back the fadump
registration status from /sys/kernel/fadump_registered (after echo 1 to
it) to find out whether fadump registration succeeded or not.

 /sys/kernel/fadump_registered

    This is used to display the fadump registration status as well
    as to control (start/stop) the fadump registration.
    0 = fadump is not registered.
    1 = fadump is registered and ready to handle system crash.

-Mahesh.

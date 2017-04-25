Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC9174WVbzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 03:19:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PHJ2j1120103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 13:19:03 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a22cehk6a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 13:19:02 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 03:18:45 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PHIaol5767462
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 03:18:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PHI6od025602
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 03:18:06 +1000
Date: Tue, 25 Apr 2017 17:17:49 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: RE: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
To: David Laight <David.Laight@ACULAB.COM>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Paul Clarke <pc@us.ibm.com>
References: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFDB161@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFDB161@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1493140505.ixalh10597.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from David Laight's message of April 25, 2017 22:06:
> From: Naveen N. Rao
>> Sent: 25 April 2017 17:18
>> 1. Fail early for invalid/zero length symbols.
>> 2. Detect names of the form <mod:name> and skip checking for kernel
>> symbols in that case.
>>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>> Masami, Michael,
>> I have added two very simple checks here, which I felt is good to have,
>> rather than the elaborate checks in the previous version. Given the
>> change in module code to use strnchr(), the checks are now safe and
>> further tests are not probably not that useful.
> ...
>> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
>> +		return module_kallsyms_lookup_name(name);
>=20
> Should that be MODULE_NAME_LEN - 1 ?

The ':' character _follows_ the module name, which can itself be upto=20
MODULE_NAME_LEN - 1 characters. So, we should look for it till=20
MODULE_NAME_LEN.

Thanks for the review,
- Naveen

=

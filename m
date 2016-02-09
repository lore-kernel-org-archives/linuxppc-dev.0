Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AEE71A0290
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 16:30:44 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 21837140B93
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 16:30:43 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 9 Feb 2016 15:30:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9155D2BB004D
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 16:30:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u195UWHP6815836
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 16:30:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u195U7SP027591
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2016 16:30:07 +1100
Subject: Re: [1/2] powerpc/powernv: new function to access OPAL msglog
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20160208113149.F33D1140B99@ozlabs.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56B97926.1090304@au1.ibm.com>
Date: Tue, 9 Feb 2016 16:29:10 +1100
MIME-Version: 1.0
In-Reply-To: <20160208113149.F33D1140B99@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/16 22:31, Michael Ellerman wrote:
> Pulling the memcons out of the bin_attr here is not all that nice. This routine
> should really stand on its own without reference to the bin_attr. In theory I
> might want to disable building sysfs but still have this routine available.

Yeah it's a bit ugly, though does disabling sysfs actually break it? I 
can separate it out anyway - there's no reason for the memcons to be 
tied to the sysfs entry.

> It's also a bit fishy if it's called before the bin_attr is initialised or when
> the memcons initialisation fails. In both cases it should be OK, because the
> structs in question are static and so the private pointer will be NULL, but
> that's a bit fragile.
>
> I think the solution is simply to create a:
>
>    static struct memcons *opal_memcons;
>
> And use that in opal_msglog_copy() and so on.

Will respin.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

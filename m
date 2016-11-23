Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNlMZ3kM7zDvHh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 12:37:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAN1XoNn062751
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:37:44 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vuqfy2e4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:37:44 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 23 Nov 2016 11:37:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CB8A52BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 12:37:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAN1bbw67733712
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 12:37:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAN1bbAW031457
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 12:37:37 +1100
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
 <87twazvmfx.fsf@concordia.ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 23 Nov 2016 12:37:36 +1100
MIME-Version: 1.0
In-Reply-To: <87twazvmfx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f9cb1ce3-f636-4b41-4621-47ad742b66ad@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/11/16 21:27, Michael Ellerman wrote:
> Can I suggest:
>  - Fix OPAL
>  - Fix OPAL
>  - Fix OPAL
>
> ...
>
> Oh OK, it's firmware :D

Yep :D

> There's existing logic in kernel/reboot.c to handle a reboot= command
> line parameter, which can set the reboot_mode, so my preference would be
> that we use that.
>
> Currently we completely ignore the reboot_mode, so there's no backward
> compatibility issue.
>
> It looks like the default is REBOOT_COLD, whatever that means. So I
> think we could define that on powernv REBOOT_HARD means "do a full IPL".

Sounds good.

> Or we could use "force", which already exists, though I can't quite see
> what that actually means on x86.

Hmm.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

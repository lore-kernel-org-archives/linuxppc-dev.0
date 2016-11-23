Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNmbq33JGzDvsv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:33:27 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAN2T0GO145891
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:33:24 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vvrnff9f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:33:24 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 23 Nov 2016 12:33:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9B8EB2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:33:19 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAN2XJWu459092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:33:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAN2XJR3009429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:33:19 +1100
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
 <87twazvmfx.fsf@concordia.ellerman.id.au>
 <f9cb1ce3-f636-4b41-4621-47ad742b66ad@au1.ibm.com>
Cc: stewart@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 23 Nov 2016 13:33:18 +1100
MIME-Version: 1.0
In-Reply-To: <f9cb1ce3-f636-4b41-4621-47ad742b66ad@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1f4e106c-3ad6-e81f-184c-56bf61336453@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/11/16 12:37, Andrew Donnellan wrote:
>> There's existing logic in kernel/reboot.c to handle a reboot= command
>> line parameter, which can set the reboot_mode, so my preference would be
>> that we use that.
>>
>> Currently we completely ignore the reboot_mode, so there's no backward
>> compatibility issue.
>>
>> It looks like the default is REBOOT_COLD, whatever that means. So I
>> think we could define that on powernv REBOOT_HARD means "do a full IPL".
>
> Sounds good.

Thinking about this more - you can't change that at runtime. :(

>
>> Or we could use "force", which already exists, though I can't quite see
>> what that actually means on x86.
>
> Hmm.

It looks like that on x86, if reboot_force = 1, we don't call 
machine_shutdown() and go straight to __machine_emergency_restart()?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

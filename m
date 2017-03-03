Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZGjl0gN6zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:41:46 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v234cn76172050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 23:41:44 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8e42ga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 23:41:44 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 3 Mar 2017 14:41:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 81BA32BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:41:38 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v234ekiw43450608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 15:41:37 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v234eLRe016257
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 15:40:22 +1100
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
To: Russell Currey <ruscur@russell.cc>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
 <87r32f6ldy.fsf@vajain21.in.ibm.com> <1488515705.6003.1.camel@russell.cc>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 3 Mar 2017 15:39:57 +1100
MIME-Version: 1.0
In-Reply-To: <1488515705.6003.1.camel@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7418e603-63ff-3670-d475-eb519c82ced9@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/17 15:35, Russell Currey wrote:
> I thought about this but figured it didn't really make sense from a CAPI
> perspective.  If you're flashing the device, it is going to have different
> behaviour to before it was flashed, and that it should be treated differently as
> a result (and thus restoring the freeze_count doesn't make much sense).
>
> Consider a case where there's a buggy FPGA image on an adapter that's failed 4
> times in the past hour, and generally has frequent errors.  You decide to update
> it to something that's less buggy, so you flash the adapter.  The freeze_count
> gets cached and thus is restored to 4 after the flash.  Now even if the new
> image is less buggy and may only fail once an hour instead of multiple times, if
> it happens to fail within an hour of the earlier failures the device is now
> fenced and you need to reboot.
>
> I don't mind either way - I just don't get the logic of restoring the count.

I agree with this logic.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

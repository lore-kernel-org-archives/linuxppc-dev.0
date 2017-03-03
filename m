Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZJ8C19B8zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 16:46:18 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v235iunx063217
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 00:46:16 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8dp9ey-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Mar 2017 00:46:16 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 15:46:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 026EF2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 16:46:12 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v235k35R24051738
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 16:46:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v235jd2m027129
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 16:45:39 +1100
Date: Fri, 3 Mar 2017 16:45:14 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
 <87r32f6ldy.fsf@vajain21.in.ibm.com>
 <1488515705.6003.1.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1488515705.6003.1.camel@russell.cc>
Message-Id: <20170303054514.GA29434@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 03, 2017 at 03:35:05PM +1100, Russell Currey wrote:
>On Fri, 2017-03-03 at 09:51 +0530, Vaibhav Jain wrote:
>> Hi Russell,
>> 
>> Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
>> 
>> > This patch introduces function eeh_pe_reset_freeze_counter() which can
>> > be used to reset the PE's freeze count variable outside eeh code. This
>> > is useful for devices that can acquire a different personality after
>> > a PERST event (e.g FPGA Adapters). Presently an existing freeze
>> > count for an adapter with personality N will be taken into account
>> > when the adapter acquired personality N+1.
>> > 
>> > By calling eeh_pe_reset_freeze_counter() drivers can reset the freeze
>> > counter for an adapter once it has acquired a new personality and
>> > ideally wont be plagued by the failures similar to the one before.
>> > 
>> > Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>> > ---
>> 
>> Had a short chat discussion with Gavin Shan on this patchset and he
>> preffers restoring the freeze_count on the eeh_pe once FRESET is done.
>> He expects a the flow to be similar to one below
>> 
>> 1. module caches the value of freeze_count and resets it
>> 2. Issue warm reset
>> 3. During eeh error-detected callback module restores the freeze_count
>> from the cached value.
>> 
>> Russell, what do you think? 
>> 
>I thought about this but figured it didn't really make sense from a CAPI
>perspective.  If you're flashing the device, it is going to have different
>behaviour to before it was flashed, and that it should be treated differently as
>a result (and thus restoring the freeze_count doesn't make much sense).
>

There are nothing changed on the PHB. This patch is clearing the error count
of PHB PE, not the PE for the CAPI device. We shouldn't clear the error count
of the PHB PE. Otherwise, it's not consistent.

>Consider a case where there's a buggy FPGA image on an adapter that's failed 4
>times in the past hour, and generally has frequent errors.  You decide to update
>it to something that's less buggy, so you flash the adapter.  The freeze_count
>gets cached and thus is restored to 4 after the flash.  Now even if the new
>image is less buggy and may only fail once an hour instead of multiple times, if
>it happens to fail within an hour of the earlier failures the device is now
>fenced and you need to reboot.
>
>I don't mind either way - I just don't get the logic of restoring the count.
>

I don't get your point. FPGA image isn't the only source of EEH error. Also,
it's not related the PHB PE's error count, which the patch is to clear.

Cheers,
Gavin

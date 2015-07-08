Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A10261A190F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:12:20 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 68A1F140787
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:12:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 13:12:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D0DF22BB003F
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:12:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t683C9uD36700382
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:12:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t683BjRL022961
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:11:45 +1000
Reply-To: sam.mj@au1.ibm.com
Subject: Re: [kexec-lite PATCH] trampoline: Reset primary cpu endian to
 big-endian
References: <1436318742-13490-1-git-send-email-sam.mj@au1.ibm.com>
 <20150708115632.725120f1@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@ozlabs.org
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Message-ID: <559C94EE.8050201@au1.ibm.com>
Date: Wed, 8 Jul 2015 13:11:42 +1000
MIME-Version: 1.0
In-Reply-To: <20150708115632.725120f1@kryten>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/15 11:56, Anton Blanchard wrote:
> Hi Sam,
> 
>> Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
>> meaning if we kexec from a little-endian kernel the target kernel will
>> fail to boot.
>> Returning to big-endian before we enter the target kernel ensures that
>> the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> 
> Thanks!
> 
> I wonder if we can do something simpler, and always enter via rfid.
> Avoids the need for the endian trampoline. Something like:
> 
>   	mtsrr0	r4
> 
> 	mfmsr	r5
> 	clrrdi	r5,r5,1 	/* Clear MSR_LE */
> 	mtsrr1	r5
> 
> 	li	r5,0
> 
> 	rfid
> 
> Anton
> 

Ah that's a neat idea, I'll test and send a V2.

Cheers,
Sam

-- 
-----------
LTC Ozlabs
IBM

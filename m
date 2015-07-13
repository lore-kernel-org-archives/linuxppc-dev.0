Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 782781A0065
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 15:24:33 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8ED37140773
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 15:24:32 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 10:54:27 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B5F6F125805D
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 10:57:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6D5OM1H2818348
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 10:54:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6D4BnsA018371
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 09:41:49 +0530
Message-ID: <55A34B85.3090902@linux.vnet.ibm.com>
Date: Mon, 13 Jul 2015 10:54:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH V2] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
References: <1436435189-11152-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1436512241.4895.2.camel@neuling.org>
In-Reply-To: <1436512241.4895.2.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2015 12:40 PM, Michael Neuling wrote:
> What's the performance impact of this?  If you run this test with --fp,
> --altivec or --vector what is the impact of adding this patch?
> 
> http://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> eg 
>   ./context_switch2 --fp 0 0 

Please find the results here which looks similar with or without
the patch being applied.

(A) Floating point context switches (context_switch2 --fp 0 0)

Without the patch	With the patch
=================	==============
320216			323460
324596			318448
321206			316540
321308			316650
318904			316478


(B) AltiVec context switches (context_switch2 --altivec 0 0)

Without the patch	With the patch
=================	==============
352012			342028
345894			345156
354604			345534
354020			354714
353936			364814

(C) Vector context switches (context_switch2 --vector 0 0)

Without the patch	With the patch
=================	==============
354496			344296
361386			346822
361856			354932
344906			348722
343288			355014

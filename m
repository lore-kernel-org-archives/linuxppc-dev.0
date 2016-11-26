Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tR7JT0jh0zDvqj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 09:43:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tR7JS3Wk6z9t2N
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2016 09:43:20 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAQMckTj069750
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2016 17:43:17 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26y5dy9kms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2016 17:43:17 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 27 Nov 2016 08:43:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D3AE22CE8054
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2016 09:43:11 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAQMhBF943384876
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2016 09:43:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAQMhBco017634
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2016 09:43:11 +1100
Subject: Re: [PATCH] adb: properly mark continued kernel messages
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Date: Sun, 27 Nov 2016 09:43:09 +1100
In-Reply-To: <87r35ynzoe.fsf@linux-m68k.org>
References: <87r35ynzoe.fsf@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1480200189.11342.4.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-26 at 14:22 +0100, Andreas Schwab wrote:
>  {
> -       printk(KERN_INFO "adb: starting probe task...\n");
> +       pr_info("adb: starting probe task...\n");
>         do_adb_reset_bus();
> -       printk(KERN_INFO "adb: finished probe task...\n");
> +       pr_info("adb: finished probe task...\n");
>  
>         up(&adb_probe_mutex

While at it, that should probably be pr_debug...

Cheers,
Ben.

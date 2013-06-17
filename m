Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 240C72C02B7
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jun 2013 19:33:02 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 17 Jun 2013 14:58:30 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EC338E0058
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jun 2013 15:02:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5H9Wx3r23986344
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jun 2013 15:03:00 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5H9WpWv003886
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jun 2013 19:32:52 +1000
Message-ID: <51BED7A4.4070900@linux.vnet.ibm.com>
Date: Mon, 17 Jun 2013 15:02:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix emulation of illegal instructions on PowerNV
 platform
References: <20130614100741.GA612@iris.ozlabs.ibm.com>
In-Reply-To: <20130614100741.GA612@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 03:37 PM, Paul Mackerras wrote:
> Normally, the kernel emulates a few instructions that are unimplemented
> on some processors (e.g. the old dcba instruction), or privileged (e.g.
> mfpvr).  The emulation of unimplemented instructions is currently not
> working on the PowerNV platform.  The reason is that on these machines,
> unimplemented and illegal instructions cause a hypervisor emulation
> assist interrupt, rather than a program interrupt as on older CPUs.
> Our vector for the emulation assist interrupt just calls
> program_check_exception() directly, without setting the bit in SRR1
> that indicates an illegal instruction interrupt.  

Hey Paul,

The only difference between (1) Program interrupt and (2) Hypervisor
emulation assist interrupt is that in the earlier, HW sets "illegal
instruction" as the reason code in the SRR1 registers implicitly.
We fix it in the later interrupt vector by doing the same explicitly
in SW ? The cause of the problem before was not having the appropriate
reason code ("illegal instruction") in the SRR1 register for program_
check_exception() function to take it forward ?

Regards
Anshuman

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74DE21A0848
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 18:33:39 +1000 (EST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B4A614009F
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2014 18:33:39 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 Jun 2014 18:33:36 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8601B3578053
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2014 18:33:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s538XCTd63832116
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2014 18:33:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s538XRJW024263
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2014 18:33:28 +1000
Message-ID: <538D87E2.7000301@linux.vnet.ibm.com>
Date: Tue, 03 Jun 2014 14:01:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc, xmon: Enable hardware instruction breakpoint
 support on POWER8
References: <1401451823-25547-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1401603491.13479.11.camel@ale.ozlabs.ibm.com>
 <538C3A49.8030601@linux.vnet.ibm.com>
In-Reply-To: <538C3A49.8030601@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2014 02:18 PM, Anshuman Khandual wrote:
> On 06/01/2014 11:48 AM, Michael Neuling wrote:
>> > On Fri, 2014-05-30 at 17:40 +0530, Anshuman Khandual wrote:
>>> >> This patch enables support for hardware instruction breakpoints on POWER8 with
>>> >> the help of a new register called CIABR (Completed Instruction Address Breakpoint
>>> >> Register). With this patch, single hardware instruction breakpoint can be added
>>> >> and cleared during any active xmon debug session. This hardware based instruction
>>> >> breakpoint mechanism works correctly along with the existing TRAP based instruction
>>> >> breakpoints available on xmon. Example usage as follows.
>> > 
>> > Have you actually tried this on a guest?
>> > 
> Yeah on a guest which runs on PVM.
> 
>> > Please also compile with a range of configs.  It doesn't compile with
>> > ppc64e_defconfig.
> Yeah. Need to change the way we get the "plapr_set_ciabr" function from plpar_wrappers.h
> header file. Will add this hunk of code in "xmon.h" header and remove the CONFIG_PPC64 ifdef
> code from the function write_ciabr.
> 
> +#ifdef CONFIG_PPC_BOOK3S_64

"#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_SPLPAR)" here actually makes it build
on all these configurations listed below.

pseries_defconfig
ppc64_defconfig
ppc64e_defconfig
pmac32_defconfig
ppc44x_defconfig
ppc6xx_defconfig
mpc85xx_smp_defconfig
mpc85xx_defconfig
chroma_defconfig
ps3_defconfig
celleb_defconfig
allnoconfig

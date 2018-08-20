Return-Path: <srs0=gggb=ld=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vBDp4BF9zDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:20:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41vBDp2FlDz8t88
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:20:26 +1000 (AEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41vBDm0vqcz9s89
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 21:20:23 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k19-v6so6614659pfi.1
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 04:20:23 -0700 (PDT)
Date: Mon, 20 Aug 2018 21:20:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth Narayan <ananth@in.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Michal Suchanek <msuchanek@suse.com>
Subject: Re: [PATCH v8 4/5] powerpc/pseries: Dump the SLB contents on SLB
 MCE errors.
Message-ID: <20180820212015.163c12ff@roar.ozlabs.ibm.com>
In-Reply-To: <153469851207.21878.16970346624861719956.stgit@jupiter.in.ibm.com>
References: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
 <153469851207.21878.16970346624861719956.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 19 Aug 2018 22:38:32 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> If we get a machine check exceptions due to SLB errors then dump the
> current SLB contents which will be very much helpful in debugging the
> root cause of SLB errors. Introduce an exclusive buffer per cpu to hold
> faulty SLB entries. In real mode mce handler saves the old SLB contents
> into this buffer accessible through paca and print it out later in virtual
> mode.
> 
> With this patch the console will log SLB contents like below on SLB MCE
> errors:
> 
> [  507.297236] SLB contents of cpu 0x1
> [  507.297237] Last SLB entry inserted at slot 16
> [  507.297238] 00 c000000008000000 400ea1b217000500
> [  507.297239]   1T  ESID=   c00000  VSID=      ea1b217 LLP:100
> [  507.297240] 01 d000000008000000 400d43642f000510
> [  507.297242]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297243] 11 f000000008000000 400a86c85f000500
> [  507.297244]   1T  ESID=   f00000  VSID=      a86c85f LLP:100
> [  507.297245] 12 00007f0008000000 4008119624000d90
> [  507.297246]   1T  ESID=       7f  VSID=      8119624 LLP:110
> [  507.297247] 13 0000000018000000 00092885f5150d90
> [  507.297247]  256M ESID=        1  VSID=   92885f5150 LLP:110
> [  507.297248] 14 0000010008000000 4009e7cb50000d90
> [  507.297249]   1T  ESID=        1  VSID=      9e7cb50 LLP:110
> [  507.297250] 15 d000000008000000 400d43642f000510
> [  507.297251]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297252] 16 d000000008000000 400d43642f000510
> [  507.297253]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297253] ----------------------------------
> [  507.297254] SLB cache ptr value = 3
> [  507.297254] Valid SLB cache entries:
> [  507.297255] 00 EA[0-35]=    7f000
> [  507.297256] 01 EA[0-35]=        1
> [  507.297257] 02 EA[0-35]=     1000
> [  507.297257] Rest of SLB cache entries:
> [  507.297258] 03 EA[0-35]=    7f000
> [  507.297258] 04 EA[0-35]=        1
> [  507.297259] 05 EA[0-35]=     1000
> [  507.297260] 06 EA[0-35]=       12
> [  507.297260] 07 EA[0-35]=    7f000
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> 
> Changes in V8:
> - Limit the slb saving to single level of mce recursion.

Thanks, that looks good now.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

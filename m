Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvhd370TWzDqH9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Apr 2017 00:08:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2VD423c069474
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 09:07:59 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29h4cqbs9u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 09:07:59 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Fri, 31 Mar 2017 10:07:56 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2VD7b5v16318536
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 10:07:43 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2VD7MPW010479
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 10:07:22 -0300
Subject: Re: [PATCH v4 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
To: Paul Mackerras <paulus@ozlabs.org>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
 <20170322192751.30531-3-gpiccoli@linux.vnet.ibm.com>
 <20170331003645.GA12861@fergus.ozlabs.ibm.com>
Cc: xinhui.pan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Fri, 31 Mar 2017 10:06:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170331003645.GA12861@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <38390ee4-b1ea-7be7-1095-2706aca5faae@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2017 09:36 PM, Paul Mackerras wrote:
> On Wed, Mar 22, 2017 at 04:27:50PM -0300, Guilherme G. Piccoli wrote:
>> The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
>> ("[POWERPC] print backtrace when entering xmon"). The problem that time
>> was that during a crash in a machine with USB keyboard, xmon wouldn't
>> respond to commands from the keyboard, so printing the backtrace wouldn't
>> be possible.
>>
>> Idea then was to show automatically the backtrace on xmon crash for the
>> first time it's invoked (if it recovers, next time xmon won't show
>> backtrace automatically). The nobt parameter was added _only_ to prevent
>> this automatic trace show. Seems long time ago USB keyboards didn't work
>> that well!
> 
> Xmon still can't use a USB keyboard.  It's not a question of how well
> USB keyboards work, it's that having a non-interrupt-driven USB stack
> with (at least) an OHCI host controller driver and a keyboard driver
> in xmon is impractical.

That's nice to know Paul, thank you. Fortunately, we kept the automatic
trace showing feature!

Seems my commit message was unfortunate/wrong in this aspect, though.
@mpe, if you wanna change, feel free. Although it's not essential...

Cheers,


Guilherme

> 
> Paul.
> 

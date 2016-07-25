Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryPMk2YT3zDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:50:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P1n6j5018542
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:50:07 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4jwhvq5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:50:07 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Sun, 24 Jul 2016 22:50:05 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C9AF0352005F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:49:44 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P1o3XK4960472
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:50:03 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P1o3IT026163
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:50:03 -0300
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
To: Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc,
 gwshan@linux.vnet.ibm.com
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87fuqy1r3i.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Sun, 24 Jul 2016 22:50:02 -0300
MIME-Version: 1.0
In-Reply-To: <87fuqy1r3i.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5795704A.5000200@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2016 09:47 PM, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>
>> This is a very minor/trivial fix for the output of PCI address on EEH logs.
>> The PCI address on "OF node" field currently is using ":" as a separator
>> for the function, but the usual separator is ".". This patch changes the
>> separator for dot, so the PCI address is printed as usual.
>>
>> No functional changes were introduced.
>
> What consumes the log? Can it cope with us changing the formatting?

Michael, as far as I understand (Russel and Gavin surely knows better 
and can correct me if I'm wrong) the only consumer that doesn't just 
output the error information to screen is pseries' get_log handler, 
which will pass this log information through a rtas_call 
(ibm_slot_error_detail).

Now, I imagine this information might be consumed in the end for the 
FSP, by reporting EEH errors there, but my testing in one LPAR showed me 
no errors in FSP after an EEH (without the patch applied). Maybe I'm 
missing a FSP configuration to be able to show the errors there?

Thanks,


Guilherme


>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Return-Path: <mmlnx@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DFCADDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:07:28 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1CG4xlM027871
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 09:04:59 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1CG73lp203222
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 09:07:07 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1CG6xk2016094
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 09:07:03 -0700
Message-ID: <4994491B.2090306@us.ibm.com>
Date: Thu, 12 Feb 2009 08:06:51 -0800
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
References: <4990EF8B.7060203@us.ibm.com> <4991EDB5.8070803@us.ibm.com>
	<1234309181.8323.12.camel@localhost>
In-Reply-To: <1234309181.8323.12.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2009-02-10 at 13:12 -0800, Mike Mason wrote:
>> I'm resubmitting this patch with a couple changes
>> suggested by Michael Ellerman.  1) the new functions
>> should be static, and 2) some people may object to
>> including unrelated formating changes.
>>
>> =========================================================
>>
>> The EEH code disables and enables interrupts during the
>> device recovery process.  This is unnecessary for MSI
>> and MSI-X interrupts because they are effectively disabled
>> by the DMA Stopped state when an EEH error occurs.  The
>> current code is also incorrect for MSI-X interrupts.  It
>> doesn't take into account that MSI-X interrupts are tracked
>> in a different way than LSI/MSI interrupts.  This patch 
>> ensures only LSI interrupts are disabled/enabled.
>>
>> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
>> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> 
> 
> Looks good. Assuming you've tested it :)

Yes, it's been tested with network devices that use LSI, MSI and MSI-X interrupts.  All recovered fine.

> 
> Acked-by: Michael Ellerman <michael@ellerman.id.au>
> 
> 

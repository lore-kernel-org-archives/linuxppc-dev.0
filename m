Return-Path: <srs0=ylnm=4e=linux.vnet.ibm.com=vaibhav@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDkg46rX0zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:38:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDkg4684kz8t3y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:38:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDkg421TXz9s84
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 16:38:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3S6YFNb167126
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 02:38:50 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a3jjmkfkh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 02:38:49 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 28 Apr 2017 16:38:45 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3S6cZKm1049052
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 16:38:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3S6c5ij010117
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 16:38:05 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: Re: [PATCH v3] cxl: mask slice error interrupts after first occurrence
In-Reply-To: <20170428032015.22872-2-alastair@au1.ibm.com>
References: <20170428032015.22872-2-alastair@au1.ibm.com>
Date: Fri, 28 Apr 2017 12:07:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h91982bx.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alastair,

Thanks for addressing previous review comments. Few additional and very
minor comments.

Alastair D'Silva <alastair@au1.ibm.com> writes:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm,
'interrupt storm of slice-errors,'
> rendering the machine unusable. Since these interrupts are informational
> only, present the interrupt once, then mask it off to prevent it from
> being retriggered until the card is reset.
s|card|card/afu

> @@ -1226,7 +1237,11 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
>  	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
>  	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
>
> +	/* mask off the IRQ so it won't retrigger until the card is reset */
> +	irq_mask = (serr & CXL_PSL_SERR_An_IRQS) >> 32;
> +	serr |= irq_mask;
>  	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +	dev_info(&afu->dev, "Further interrupts will be masked until the
Optional: Just to be explicit, since you are only masking a subset of possible
slice errors hence I would suggest rephrasing the message as:
"Further such interrupts....

> AFU is reset\n");
To be consistent with the patch description  s|AFU|AFU/Card

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

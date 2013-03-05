Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 39EDB2C0348
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 18:44:21 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 5 Mar 2013 13:12:08 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0C7561258059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 13:15:11 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r257iBZI28246114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 13:14:11 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r257iD3c010552
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 18:44:13 +1100
Message-ID: <5135A248.4010205@linux.vnet.ibm.com>
Date: Tue, 05 Mar 2013 15:44:08 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2/3] irq: Add hw continuous IRQs map to virtual continuous
 IRQs support
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130305024110.GB14275@linux-sh.org>
In-Reply-To: <20130305024110.GB14275@linux-sh.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/3/5 10:41, Paul Mundt 写道:
> On Tue, Jan 15, 2013 at 03:38:55PM +0800, Mike Qiu wrote:
>> Adding a function irq_create_mapping_many() which can associate
>> multiple MSIs to a continous irq mapping.
>>
>> This is needed to enable multiple MSI support for pSeries.
>>
>> +int irq_create_mapping_many(struct irq_domain *domain,
>> +		irq_hw_number_t hwirq_base, int count)
>> +{
> Other than the other review comments already made, I think you can
> simplify this considerably by simply doing what irq_create_strict_mappings() does,
> and relaxing the irq_base requirements.
>
> In any event, as you are creating a new interface, I don't think you want
> to carry around half of the legacy crap that irq_create_mapping() has to
> deal with. We made the decision to avoid this with irq_create_strict_mappings()
> intentionally, too.
>
Oh, yes, you are right, I will send out V2 of my patch to make it more 
comfortable , and hope you can review my patch again

Thanks

Mike

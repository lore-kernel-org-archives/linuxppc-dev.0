Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 728751A0C49
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 05:41:45 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47AE1140273
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 05:41:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 Feb 2015 04:41:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 58F12357804C
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 05:41:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t15IfWQa24182986
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 05:41:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t15If6h4008983
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Feb 2015 05:41:07 +1100
Message-ID: <54D3B931.7090102@linux.vnet.ibm.com>
Date: Fri, 06 Feb 2015 00:10:49 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/3] powerpc/nvram: move generic code for nvram and
 pstore
References: <20150130151247.13976.88337.stgit@localhost.localdomain>
 <20150130151400.13976.90106.stgit@localhost.localdomain>
 <1939177.TRC136ehpt@wuerfel>
In-Reply-To: <1939177.TRC136ehpt@wuerfel>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/30/2015 10:12 PM, Arnd Bergmann wrote:
> On Friday 30 January 2015 20:44:00 Hari Bathini wrote:
>> With minor checks, we can move most of the code for nvram
>> under pseries to a common place to be re-used by other
>> powerpc platforms like powernv. This patch moves such
>> common code to arch/powerpc/kernel/nvram_64.c file.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Can you make this y2038-safe in the process, possibly as a
> follow-up patch?

Arnd, sorry for the delayed response.
I will add these changes to this patch-set and re-spin..

Thanks
Hari

>> +extern unsigned long last_rtas_event;
> time64_t
>
>> +	}
>> +	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
>> +	oops_hdr->report_length = cpu_to_be16(zipped_len);
>> +	oops_hdr->timestamp = cpu_to_be64(get_seconds());
>> +	return 0;
> ktime_get_real_seconds()
>
>> +static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>> +				int *count, struct timespec *time, char **buf,
>> +				bool *compressed, struct pstore_info *psi)
> This has to remain timespec for now but can later be changed to timespec64
> when the API gets changed.
>
>> +		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
>> +		oops_hdr->report_length = cpu_to_be16(text_len);
>> +		oops_hdr->timestamp = cpu_to_be64(get_seconds());
> ktime_get_real_seconds()
>
> 	Arnd
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

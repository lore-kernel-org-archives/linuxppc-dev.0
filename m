Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9FE41A038E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 05:27:18 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 11:27:16 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F231B19D8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 11:15:12 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u19IREjp23855246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 11:27:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u19IRDNv023293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 11:27:14 -0700
Subject: Re: [PATCH 2/6] ibmvscsi: Add and use enums for valid CRQ header
 values
To: manoj@linux.vnet.ibm.com, JBottomley@odin.com
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-3-git-send-email-tyreld@linux.vnet.ibm.com>
 <56B3ACC9.60009@linux.vnet.ibm.com> <56B3C1C1.3080804@linux.vnet.ibm.com>
 <56BA24E1.9090808@linux.vnet.ibm.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, hare@suse.de, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <56BA2F80.8090009@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 10:27:12 -0800
MIME-Version: 1.0
In-Reply-To: <56BA24E1.9090808@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/2016 09:41 AM, Manoj Kumar wrote:
>> Yeah, I can see how that is confusing. Since, all three possible valid
>> crq message types have the first bit set I think this was originally a
>> cute hack to grab anything that was likely valid. Then in
>> ibmvscsi_handle_crq() we explicitly match the full header value in a
>> switch statement logging anything that turned out actually invalid.
>>
>>>
>>> If 'valid' will only have one of these four enums defined, would
>>> this be better written as:
>>>
>>> 	if (crq->valid != VIOSRP_CRQ_FREE)
>>
>> This definitely would make the logic easier to read and follow. Also,
>> this would make sure any crq with an invalid header that doesn't have
>> its first bit set will also be logged by the ibmvscsi_handle_crq()
>> switch statement default block and not silently ignored.
>>
>> -Tyrel
> 
> Sounds good, Tyrel. Does this mean I should expect a v2 of this patch
> series?
> 
> - Manoj N. Kumar

Haven't had a chance to clean up and resubmit, but yes there will be a
v2 coming along soon.

-Tyrel

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

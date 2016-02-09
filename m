Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116871A038E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 04:41:59 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 10:41:57 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6AC753E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 10:41:54 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u19Hfr6G34275410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 17:41:53 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u19HceuP008829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 12:38:40 -0500
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH 2/6] ibmvscsi: Add and use enums for valid CRQ header
 values
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-3-git-send-email-tyreld@linux.vnet.ibm.com>
 <56B3ACC9.60009@linux.vnet.ibm.com> <56B3C1C1.3080804@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, hare@suse.de, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56BA24E1.9090808@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 11:41:53 -0600
MIME-Version: 1.0
In-Reply-To: <56B3C1C1.3080804@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Yeah, I can see how that is confusing. Since, all three possible valid
> crq message types have the first bit set I think this was originally a
> cute hack to grab anything that was likely valid. Then in
> ibmvscsi_handle_crq() we explicitly match the full header value in a
> switch statement logging anything that turned out actually invalid.
>
>>
>> If 'valid' will only have one of these four enums defined, would
>> this be better written as:
>>
>> 	if (crq->valid != VIOSRP_CRQ_FREE)
>
> This definitely would make the logic easier to read and follow. Also,
> this would make sure any crq with an invalid header that doesn't have
> its first bit set will also be logged by the ibmvscsi_handle_crq()
> switch statement default block and not silently ignored.
>
> -Tyrel

Sounds good, Tyrel. Does this mean I should expect a v2 of this patch
series?

- Manoj N. Kumar

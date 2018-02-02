Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zY4R22wZPzF0TX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 04:55:57 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12HsMAu004463
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Feb 2018 12:55:56 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fvvsng2w1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 12:55:55 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 10:55:55 -0700
Subject: Re: [PATCH, net] ibmvnic: fix firmware version when no firmware level
 has been provided by the VIOS server
To: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, jallen@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
References: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
 <e82c4a78-37b3-afc5-6250-8ce8bb2ec5ce@linux.vnet.ibm.com>
 <8528e0fe-30d8-9ce9-b791-62a76179666d@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 2 Feb 2018 09:55:51 -0800
MIME-Version: 1.0
In-Reply-To: <8528e0fe-30d8-9ce9-b791-62a76179666d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1fea045a-20bd-8903-98fb-63b970d2e93d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2018 06:37 AM, Desnes Augusto Nunes do Rosário wrote:
> Hello Tyrel,
> 
> I concur with your observations, but since this patch has already been merged, I'll address them in another patch.

Fair enough. I didn't realize David had already merged it till after I sent my review.

-Tyrel

> 
> Thank you for your review,
> 
> On 02/01/2018 07:02 PM, Tyrel Datwyler wrote:
>> On 02/01/2018 10:04 AM, Desnes Augusto Nunes do Rosario wrote:
>>> Older versions of VIOS servers do not send the firmware level in the VPD
>>> buffer for the ibmvnic driver. Thus, not only the current message is mis-
>>> leading but the firmware version in the ethtool will be NULL. Therefore,
>>> this patch fixes the firmware string and its warning.
>>>
>>> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
>>>
>>> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
>>> ---
>>>   drivers/net/ethernet/ibm/ibmvnic.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
>>> index b65f5f3ac034..2b3e71b63a7a 100644
>>> --- a/drivers/net/ethernet/ibm/ibmvnic.c
>>> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
>>> @@ -3290,7 +3290,11 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
>>>        */
>>>       substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
>>>       if (!substr) {
>>> -        dev_info(dev, "No FW level provided by VPD\n");
>>> +        dev_info(dev, "Warning - No FW level has been provided in the VPD buffer by the VIOS Server\n");
>>> +        ptr = strncpy((char *)adapter->fw_version, "N/A",
>>
>> Is "N/A" the right thing to report? Would something like "Unknown" or "Unreported" be better?
>>
>>> +                  3 * sizeof(char));
>>> +        if (!ptr)
>>> +            dev_err(dev, "Failed to inform that firmware version is unavailable to the adapter\n");
>>
>> The sentence structure here seems awkward. I would probably just get rid of this error and this one later in the function.
>>
>>     dev_err(dev, "Failed to isolate FW level string\n");
>>
>> Instead just check and report if adapter->fw_version == NULL in the complete: label section.
>>
>> -Tyrel
>>
>>>           goto complete;
>>>       }
>>>
>>
> 

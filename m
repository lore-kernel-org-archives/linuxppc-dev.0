Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC1NJ3VFWzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 07:34:56 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UKTLXK023672
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:34:54 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 289sqxut5u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:34:54 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 15:34:53 -0500
Subject: Re: ibmvtpm byteswapping inconsistency
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michal Suchanek <hramrach@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <d55b06cc-cb7a-1ef1-05b7-d7d4114d0c48@linux.vnet.ibm.com>
 <1485481819.2980.82.camel@kernel.crashing.org>
 <CAOMqctQtspCTTpfEUyUVyE9GKYOavZNhkXnRPUrPZrDZ6-eG0w@mail.gmail.com>
 <73c1e5be-0820-8dca-c86a-8cf3ffeb5efe@linux.vnet.ibm.com>
 <87tw8hw4k7.fsf@concordia.ellerman.id.au>
Cc: Marcel Selhorst <tpmdd@selhorst.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 tpmdd-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 Ashley Lai <ashleydlai@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 12:34:45 -0800
MIME-Version: 1.0
In-Reply-To: <87tw8hw4k7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <d2da4b82-9686-187c-c514-96a506e994cc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2017 08:32 PM, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> 
>> On 01/27/2017 01:03 AM, Michal Suchanek wrote:
>>> On 27 January 2017 at 02:50, Benjamin Herrenschmidt
>>> <benh@kernel.crashing.org> wrote:
>>>> On Thu, 2017-01-26 at 17:42 -0800, Tyrel Datwyler wrote:
>>>>> On 01/26/2017 12:22 PM, Michal Suchánek wrote:
>>>>>> Hello,
>>>>>>
>>>>>> building ibmvtpm I noticed gcc warning complaining that second word
>>>>>> of
>>>>>> struct ibmvtpm_crq in tpm_ibmvtpm_suspend is uninitialized.
>>>>>>
>>>>>> The structure is defined as
>>>>>>
>>>>>> struct ibmvtpm_crq {
>>>>>>         u8 valid;
>>>>>>         u8 msg;
>>>>>>         __be16 len;
>>>>>>         __be32 data;
>>>>>>         __be64 reserved;
>>>>>> } __attribute__((packed, aligned(8)));
>>>>>>
>>>>>> initialized as
>>>>>>
>>>>>>         struct ibmvtpm_crq crq;
>>>>>>         u64 *buf = (u64 *) &crq;
>>>>>> ...
>>>>>>         crq.valid = (u8)IBMVTPM_VALID_CMD;
>>>>>>         crq.msg = (u8)VTPM_PREPARE_TO_SUSPEND;
>>>>>>
>>>>>> and submitted with
>>>>>>
>>>>>>         rc = ibmvtpm_send_crq(ibmvtpm->vdev, cpu_to_be64(buf[0]),
>>>>>>                               cpu_to_be64(buf[1]));
>>>>>
>>>>> These should be be64_to_cpu() here. The underlying hcall made by
>>>>> ibmvtpm_send_crq() requires parameters to be in cpu endian unlike the
>>>>> RTAS interface which requires data in BE.
>>>>
>>>> Hrm... an hcall takes register arguments. Register arguments don't have
>>>> an endianness.
>>>>
>>>> The problem is that we are packing an in-memory structure into 2
>>>> registers and it's expected that this structure is laid out in the
>>>> registers as if it had been loaded by a BE CPU.
>>>>
>>>> So we have two things at play here:
>>>>
>>>>   - The >8-bit fields should be laid out BE in the memory image
>>>>   - That whole 128-bit structure should be loaded into 2 64-bit
>>>> registers MSB first.
>>>>
>>>> So the "double" swap is somewhat needed. The uglyness comes from the
>>>> passing-by-register of the h-call but it should work.
>>>>
>>>> That said, be64_to_cpup(buf) and be64_to_cpup(buf+1) might give you
>>>> better result (though recent gcc's might not make a difference).
>>>
>>> If this should work then the below case that swaps the fields separately is
>>> broken.
>>>
>>> Anyway, structures have no endianess so when they start with a byte they
>>> start with that byte no matter the host endian.
>>> crq.valid is the first byte always. And then each field is to be swapped
>>> separately.
>>>
>>> On the other hand, bitfields are part of an integer and the field should be
>>> swapped as part of the integer.
>>>
>>> That is,
>>> #define CRQ_VALID ((buf[0] >> 56) & 0xff)
>>> CRQ_VALID is part of an integer in buf and would be laid out differently
>>> on start or end depending on the host being BE or LE.
>>>
>>> And the question is what the PAPR actually defines because both ways are
>>> used in the code. You can describe an in-memory layout either way.
>>
>> Byte  |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7
>> -----------------------------------------------------------------------
>> Word0 | Valid | Type  |     Length    |              Data
>> -----------------------------------------------------------------------
>> Word1 |				Reserved
>> -----------------------------------------------------------------------
>>
>> The following definition looks to match:
>>
>> struct ibmvtpm_crq {
>>         u8 valid;
>>         u8 msg;
>>         __be16 len;
>>         __be32 data;
>>         __be64 reserved;
>> } __attribute__((packed, aligned(8)));
> 
> Well it's a partial match.
> 
> Your layout above doesn't define which byte of Length or Data is the MSB
> or LSB. So going by that we still don't know the endianness of either

I should have been explicit that PAPR uses Big Endian bit and byte
numbering throughout the spec unless otherwise noted.

-Tyrel

> field.
> 
> cheers
> 

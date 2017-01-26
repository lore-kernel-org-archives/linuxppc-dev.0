Return-Path: <ashleydlai@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8clb3yhnzDq61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 09:58:19 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id u143so19357178oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 14:58:19 -0800 (PST)
Subject: Re: ibmvtpm byteswapping inconsistency
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Michal Such??nek <msuchanek@suse.de>, Nayna Jain <nayna@linux.vnet.ibm.com>,
 honclo@linux.vnet.ibm.com
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Ashley Lai <ashleydlai@gmail.com>
Message-ID: <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
Date: Thu, 26 Jan 2017 16:58:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170126220536.GB31937@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding Vicky from IBM.


On 01/26/2017 04:05 PM, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2017 at 09:22:48PM +0100, Michal Such??nek wrote:
>
>> This is repeated a few times in the driver so I added memset to quiet
>> gcc and make behavior deterministic in case the unused fields get some
>> meaning in the future.
> Yep, reserved certainly needs to be zeroed.. Can you send a patch?
> memset is overkill...
>
>> However, in tpm_ibmvtpm_send the structure is initialized as
>>
>> 	struct ibmvtpm_crq crq;
>>          __be64 *word = (__be64 *)&crq;
>> ...
>>          crq.valid = (u8)IBMVTPM_VALID_CMD;
>>          crq.msg = (u8)VTPM_TPM_COMMAND;
>>          crq.len = cpu_to_be16(count);
>>          crq.data = cpu_to_be32(ibmvtpm->rtce_dma_handle);
>>
>> and submitted with
>>
>> 	rc = ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>>                                be64_to_cpu(word[1]));
>> meaning it is swapped twice.
> No idea, Nayna may know.
>
> My guess is that '__be64 *word' should be 'u64 *word'...
>
> Jason

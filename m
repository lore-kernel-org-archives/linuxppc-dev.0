Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s90J423SCzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 17:38:44 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so4280001pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 00:38:44 -0700 (PDT)
Subject: Re: [PATCH 0/7] ima: carry the measurement list across kexec
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
 <1470746204.2881.101.camel@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <46d115a8-de96-1e9f-9d08-b0e9b6cca93a@gmail.com>
Date: Thu, 11 Aug 2016 17:38:35 +1000
MIME-Version: 1.0
In-Reply-To: <1470746204.2881.101.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/08/16 22:36, Mimi Zohar wrote:
> On Tue, 2016-08-09 at 15:19 +1000, Balbir Singh wrote:
>>
>> On 04/08/16 22:24, Mimi Zohar wrote:
>>> The TPM PCRs are only reset on a hard reboot.  In order to validate a
>>> TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
>>> of the running kernel must be saved and then restored on the subsequent
>>> boot.
>>>
>>> The existing securityfs binary_runtime_measurements file conveniently
>>> provides a serialized format of the IMA measurement list. This patch
>>> set serializes the measurement list in this format and restores it.
>>>
>>> This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
>>> hand-over for the next kernel" patch set* for actually carrying the
>>> serialized measurement list across the kexec.
>>>
>>> Mimi
>>>
>>
>> Hi, Mimi
>>
>> I am trying to convince myself of the security of the solution. I asked
>> Thiago as well, but may be I am be lagging behind in understanding.
>>
>> We trust the kernel to hand over PCR values of the old kernel (which
>> cannot be validated) to the IMA subsystem in the new kernel for storage.
>> I guess the idea is for ima_add_boot_aggregate to do the right thing?
>> How do we validate what the old kernel is giving us? Why do we care for
>> the old measurement list? Is it still of significance in the new kernel?
>>
> 
> Hi Balbir,
> 
> To validate the hardware TPM PCR values requires walking the measurement
> list simulating the TPM extend operation.  The resulting values should
> match the hardware TPM PCRs.
> 
> In the case of a soft reboot, the TPM PCRs are not reset to 0, so all
> the measurements of the running system, including those from previous
> soft reboots, need to be included in the measurement list.   Without
> these measurements, the simulated PCR values will not match the hardware
> TPM PCR values.  Thus the need for this patch set.
> 
> Measurements can not be added/removed/changed in the measurement list
> without it being detectable.
> 

Thanks Mimi

I think that makes sense

So effectively we do

first kernel boot -> <measurements match PCR and measurements are saved>
second kernel boot -> <new PCR = first save measurements + new measurements>

and so on

Balbir Singh

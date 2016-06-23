Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbGT66npgzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 08:33:30 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id ts6so7425780pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:33:30 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2895031.4C8tZ3BP2G@hactar> <576B25FF.1010307@gmail.com>
 <1612090.Qxo4UiJulB@hactar>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <576C63B4.8060302@gmail.com>
Date: Fri, 24 Jun 2016 08:33:24 +1000
MIME-Version: 1.0
In-Reply-To: <1612090.Qxo4UiJulB@hactar>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/06/16 02:44, Thiago Jung Bauermann wrote:
> Am Donnerstag, 23 Juni 2016, 09:57:51 schrieb Balbir Singh:
>> On 23/06/16 03:02, Thiago Jung Bauermann wrote:
>>>>> 3. have IMA pass-on its event log (where integrity measurements are
>>>>>
>>>>>    registered) accross kexec to the second kernel, so that the event
>>>>>    history is preserved.
>>>>
>>>> OK.. and this is safe? Do both the kernels need to be signed by the
>>>> same certificate?
>>>
>>> They don't. The integrity of the event log (assuming that is what you
>>> mean by "this" in "this is safe") is guaranteed by the TPM device. Each
>>> event in the measurement list extends a PCR and records its PCR value.
>>> It is cryptographically guaranteed that if you replay the PCR extends
>>> recorded in the event log and in the end of the process they match the
>>> current PCR values in the TPM device, then that event log is correct.
>>
>> What I meant was how does the new kernel know that the old kernel did not
>> cheat while passing on the values? I presume because we trust that kernel
>> via a signature.
> 
> Sorry, I still don't understand your concern. What kind of cheating? Which 
> values? If it's the values in the event log, there's no need to trust the 
> old kernel. The new kernel knows that the old kernel didn't pass wrong 
> measurement values in the event log because it can recalculate the PCR 
> extend operations recorded in the log and compare the results of the replay 
> with the current PCR values stored in the TPM device. If they match, then 
> the event log is guaranteed to be correct. If they don't match, either the 
> memory was corrupted somehow during the kexec process, or the old kernel 
> tried to pass a falsified event log.
> 

Yep, get it/got it. My concern was anything using passed on the values should
compare the results with the current PCR values.

BTW, what do we gain by passing the values if we are relying on the PCR registers
anyway, can't we directly read them off from there? Aren't we going to ready anyway
to compare, what does passing the values gain?

[snip]

>> and
>>
>> How do we know the new kernel is safe to load - I guess via a signature
>> that the new kernel is signed with (assuming it is present in the key
>> ring).
> 
> Correct. That goal is met by signature verification, not by integrity 
> assurance.
> 
> I'll note that even with both of my patch series there's still code missing 
> for kernel signature verification in PowerPC. I believe there's not a file 
> format defined yet for how to store a signature in a PowerPC kernel image.
> 
> Integrity assurance doesn't depend on kernel signature verification though. 
> There's value in both my patch series even without kernel signature 
> verification support. They're complementary features.
>  

Thanks for clarifying

Balbir Singh.

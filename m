Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZhP163rZzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 09:57:57 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t190so5191069pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:57:57 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622232946.793d6c04@350D> <2895031.4C8tZ3BP2G@hactar>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <576B25FF.1010307@gmail.com>
Date: Thu, 23 Jun 2016 09:57:51 +1000
MIME-Version: 1.0
In-Reply-To: <2895031.4C8tZ3BP2G@hactar>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/06/16 03:02, Thiago Jung Bauermann wrote:
> Hello Balbir,
>
Hi Thiago
 
>>> 3. have IMA pass-on its event log (where integrity measurements are
>>>
>>>    registered) accross kexec to the second kernel, so that the event
>>>    history is preserved.
>>
>> OK.. and this is safe? Do both the kernels need to be signed by the
>> same certificate?
> 
> They don't. The integrity of the event log (assuming that is what you mean 
> by "this" in "this is safe") is guaranteed by the TPM device. Each event in 
> the measurement list extends a PCR and records its PCR value. It is 
> cryptographically guaranteed that if you replay the PCR extends recorded in 
> the event log and in the end of the process they match the current PCR 
> values in the TPM device, then that event log is correct.


What I meant was how does the new kernel know that the old kernel did not
cheat while passing on the values? I presume because we trust that kernel
via a signature.


and

How do we know the new kernel is safe to load - I guess via a signature that
the new kernel is signed with (assuming it is present in the key ring).

Balbir Singh

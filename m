Return-Path: <mohan@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A62C41007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 23:54:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nARCse6p005842
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 23:54:40 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nARCp6Xq1585358
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 23:51:06 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nARCsdYW005172
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 23:54:39 +1100
Message-ID: <4B0FCC0C.8060103@in.ibm.com>
Date: Fri, 27 Nov 2009 18:24:36 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
MIME-Version: 1.0
To: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com> <4B0D7CF4.8040402@bwalle.de>
	<4B0E628A.9070009@in.ibm.com> <4B0ED674.6050501@bwalle.de>
In-Reply-To: <4B0ED674.6050501@bwalle.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

As of now the kdump kernel base is fixed to be 32MB. The intention of 
this patch is to modify that behaviour (for relocatable kernels)

* Regular kernel size may exceed 32MB, in this case we can't have kdump 
kernelbase as 32MB.

* crashkernel=auto also assumes that kdump kernelbase as 32MB, and it 
may also fail in reserving memory for kdump kernel.

On 11/27/2009 12:56 AM, Bernhard Walle wrote:
> M. Mohan Kumar schrieb:
>> On 11/26/2009 12:22 AM, Bernhard Walle wrote:
>>> M. Mohan Kumar schrieb:
>>>> Reserve memory for kdump kernel within RMO region
>>>>
>>>> When the kernel size exceeds 32MB(observed with some distros), memory
>>>> for kdump kernel can not be reserved as kdump kernel base is assumed to
>>>> be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
>>>> provide the feature to reserve the memory for kdump kernel anywhere in
>>>> the RMO region.
>>
>> Hi Bernhard,
>>
>>> Correct me if I'm wrong, but: CONFIG_RELOCATABLE is for the kernel that
>>> gets loaded as crashkernel, not for the kernel that loads the
>>> crashkernel. So it would be perfectly fine that a kernel that has not
>>> CONFIG_RELOCATABLE set would load another kernel that has
>>> CONFIG_RELOCATABLE set on an address != 32 M.
>>
>> No, with relocatable option, the same kernel is used as both production
>> and kdump kernel.
>
> Can be, but it's not strictly necessary. It depends what userland does.
> Especially it's possible that a non-relocatable, self-compiled kernel
> loads a relocatable distribution kernel as capture kernel.
>
> Also, it would make sense to make the behaviour symmetric across
> platforms. Currently we have:
>
>   - x86 and ia64: Without offset on command line, use any offset
>                   With offset on command line, use that offset and fail
>                   if no memory is available at that offset.
>   - ppc64: Always use 32M and ignore the offset.
>
> If your patch gets applied, we have:
>
>   - ppc64: With CONFIG_RELOCATABLE, use any offset
>            With offset on command
>
> I don't see why the behaviour on ppc64 should be completely different.
>
> Having maintained kdump for SUSE for x86, ia64 and partly ppc64 in the
> past, I always felt that ppc64 is more different from x86 than ia64 is
> from x86. That's one more step into that direction without a technical
> reason.
>
> Having that all said: If your patch gets in mainline kernel, than we
> should change the behaviour also for x86 and ia64.
>
>
>
> Regards,
> Bernhard
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

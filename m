Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7cXc4PC4zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 15:46:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Possible LMB hot unplug bug in 4.13+ kernels
In-Reply-To: <a3846937-53e4-e2be-fe82-3a5765647fa4@linux.vnet.ibm.com>
References: <94618f16-b47f-b714-9cb5-4bbbf7fdccdf@linux.vnet.ibm.com>
 <a3846937-53e4-e2be-fe82-3a5765647fa4@linux.vnet.ibm.com>
Date: Fri, 06 Oct 2017 15:46:07 +1100
Message-ID: <8760bszxww.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 10/04/2017 03:21 PM, Daniel Henrique Barboza wrote:
...
>> It appears that the hot unplug is failing because lmb_is_removable(lmb) is returning
>> false inside dlpar_remove_lmb, triggering the hotplug of the LMBs again:
...
>> 
>> I am not aware of anything that I can do from QEMU side to fix this. Can anyone take a look or provide
>> guidance? Am I missing something in my tests?
>> 
>
> I don't think you are missing anything in your tests and am not sure that this is a bug.
> DLPAR memory remove operations are not guaranteed, memory remove requests fail quite often
> because the LMBs we are trying to remove are not removable.
>
> From the added printks you put in this appears to be what is happening. When trying to
> remove the range of LMBs, one of the memory sections in one of the LMBs is not removbable,
> this is seen when lmb_is_removable() returns false.

Yeah I agree.

Unless you (Daniel) think there's some reason lmb_is_removable() is
incorrectly returning false. But most likely it's correct and there's
just an unmovable allocation in that range.

cheers

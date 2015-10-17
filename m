Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58CD21A025B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:34:09 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 10:04:06 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 079CDE0024
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 10:04:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9H4Y23Y13828400
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 10:04:02 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9H4Y19r015565
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 10:04:02 +0530
Message-ID: <5621CFB8.2050306@linux.vnet.ibm.com>
Date: Sat, 17 Oct 2015 10:04:00 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH] rtas: Validate rtas entry before calling enter_rtas
References: <20151016102327.6010.50184.stgit@hegdevasant.in.ibm.com>
 <CAOJe8K03v_0MULL_pxX=CgSaFTTDmS8aJe1j+aFO9HHxhZ7d4Q@mail.gmail.com>
 <56211459.1060006@linux.vnet.ibm.com>
 <CAOJe8K0Mva7+12k1eJjineUTfaPQiyae9HEnxRG+=2FkyrnmVA@mail.gmail.com>
In-Reply-To: <CAOJe8K0Mva7+12k1eJjineUTfaPQiyae9HEnxRG+=2FkyrnmVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2015 11:49 PM, Denis Kirjanov wrote:
> On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
>> On 10/16/2015 04:02 PM, Denis Kirjanov wrote:
>>> On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
>>>> Currently we do not validate rtas entry before calling enter_rtas().
>>>> This
>>>> is resulting in a kernel oops (see below) when user space calls rtas
>>>> system
>>>> call on PowerNV platform. We hit below oops when we ran trinity (system
>>>> call
>>>> fuzzer) on PowerNV. This patch adds code to validate rtas entry before
>>>> making
>>>> enter_rtas() call.
>>>
>>> Hi,
>>> have you figured out why we have null entry?
>>
>> Denis,

Denis,

>>
>> Yes... On PowerNV platform we don't have RTAS.. Hence it's not initialized.
> But why do we have CONFIG_PPC_RTAS on OPAL machines then?


Sorry. I should have elaborated little bit..

Today we use single config to build kernel for both PowerNV and PAPR guest. So
that same ISO can be used in different environment (PAPR LPAR, PowerNV host,
guest). I believe most distro also following this method. Hence we need this
validation.

-Vasant

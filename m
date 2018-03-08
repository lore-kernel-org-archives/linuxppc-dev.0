Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxlgR73ZmzF1cd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 20:33:23 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id e25so3458236uam.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Mar 2018 01:33:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87ina7qs5r.fsf@linux.vnet.ibm.com>
References: <20180308003606.10721-1-bsingharora@gmail.com>
 <87ina7qs5r.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 8 Mar 2018 20:33:20 +1100
Message-ID: <CAKTCnzkN0tACTcxCSzS=-SjRYOkhRHbX-hf-m0GyikYqnFDx0w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/mce: Don't silently restart the machine
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 8, 2018 at 12:20 PM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>> On MCE the current code will restart the machine with
>> ppc_md.restart(). This case was extremely unlikely since
>> prior to that a skiboot call is made and that resulted in
>> a checkstop for analysis.
>>
>> With newer skiboots, on P9 we don't checkstop the box by
>> default, instead we return back to the kernel to extract
>> useful information at the time of the MCE. While we still
>> get this information, this patch converts the restart to
>> a panic(), so that if configured a dump can be taken and
>> we can track and probably debug the potential issue causing
>> the MCE.
>
> This will likely change again, but I can send a patch that changes the
> comment (along with the logic of decoding it all and having enough
> information to make sensible decisions). But... I kind of don't want to
> bikeshed a comment to death :)
>
> I reckon the panic() here is the right thing to do no matter
> what.
>
> Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Thanks!

Balbir Singh.

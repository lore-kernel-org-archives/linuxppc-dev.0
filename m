Return-Path: <chris@distroguy.com>
Received: from mx-out02.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwGw60mx7zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 09:52:05 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out02.mykolab.com (Postfix) with ESMTPS id 9A57760149
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 01:51:58 +0200 (CEST)
Date: Thu, 28 Apr 2016 09:51:52 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add support for userspace P9 copy paste
Message-ID: <20160427235151.GA5362@distroguy.com>
References: <20160426002844.GA9198@x1.distroguy.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4AB9A0@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4AB9A0@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 03:25:59PM +0000, David Laight wrote:
>From: Chris Smart
>> Sent: 26 April 2016 01:29
>> The copy paste facility introduced in POWER9 provides an optimised
>> mechanism for a userspace application to copy a cacheline. This is
>> provided by a pair of instructions, copy and paste, while a third,
>> cp_abort (copy paste abort), provides a clean up of the state in case of
>> a failure.
>>
>> The copy instruction will read a 128 byte cacheline and store it in an
>> internal buffer. The subsequent paste instruction will store this
>> internal buffer to memory and set a CR field if the paste succeeds.
>>
>> Since the state of the copy paste buffer is internal (and not
>> architecturally visible), in the unlikely event of a context switch, the
>> state cannot be stored and the paste should therefore fail.
>>
>> The cp_abort instruction exists to fail and clean up any such
>> interrupted copy paste sequence and is to be called by the kernel as
>> part of the context switch. Doing so prevents data from a preceding copy
>> in one process leaking into the paste of another.
>>
>> This code enables use of the cp_abort instruction if a supported
>> processor is detected.
>
>In that case what actually completes the copy?
>I think you'd need to be inside a 'restartable atomic sequence'
>in which case the cp_abort need only be done when the/a RAS
>block is detected.
>
>Or have I missed something??

It's up to the userspace process that's doing the copy paste to check
the CR field after the paste to see whether it has succeeded. If it has
not succeeded, then the process can choose to re-do the copy and paste.

This is very similar to a lwarx stwcx where the user checks the CR after
the stwcx to verify whether it has succeeded.

Hope that makes sense.

-c

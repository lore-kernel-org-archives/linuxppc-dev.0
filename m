Return-Path: <srs0=fyum=ee=redhat.com=jcm@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG1qT0Sb3zDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 17:06:29 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zG1qS5n9rz8t72
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 17:06:28 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zG1qS2STXz9sRW
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 17:06:28 +1100 (AEDT)
Subject: Re: [PATCH 09/11] powerpc/64s: Allow control of RFI flush via sysfs
To: Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-9-mpe@ellerman.id.au>
 <alpine.DEB.2.20.1801081818060.1735@nanos>
 <87y3l880js.fsf@concordia.ellerman.id.au>
Cc: mikey@neuling.org, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 npiggin@gmail.com, linuxppc-dev@ozlabs.org, oohall@gmail.com,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <f4a66b7c-0ee0-07da-b327-42ba6a8c704b@redhat.com>
Date: Tue, 9 Jan 2018 01:06:23 -0500
MIME-Version: 1.0
In-Reply-To: <87y3l880js.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2018 05:09 PM, Michael Ellerman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
>> On Tue, 9 Jan 2018, Michael Ellerman wrote:
>>
>> Sorry, I wasn't aware about your efforts and did not cc you. I've just
>> queued a more generic sysfs interface for this whole mess:
> 
> No worries.
> 
>> https://lkml.kernel.org/r/20180107214913.096657732@linutronix.de
>>
>> It should be simple to extend for write and it would be great if all
>> affected architectures could share it.
> 
> As you say this has all been a bit of a mess

Indeed. All of us wish this went very differently.

I've been testing various versions of these patches since before the
holidays. For those doing backports to older kernels, a note that the
IBM team added OOL (Out Of Line) exception handlers and reworked all of
that code over the years since older kernels (e.g. 3.10) so you might
get problems on those if you enable the debug entry. I've got notes on
how to backport the OOL exceptions to older kernels if anyone cares.

> and as a result we already have people running kernels with this patch,
> so we don't want to remove the 'rfi_flush' file.

Knowing that the IBM team was going to post with this sysfs interface,
our trees contain the rfi_flush file. I mentioned it to some folks on
this end (because we know we don't want to add things in sysfs
generally, debugfs is a good substitute, per Andrea, and I raised this
with him yesterday as a concern in the backport here) but in the end it
seemed reasonable to pull this in because it was what got posted, and as
Michael says, it's gone into other distro kernels beyond just ours.

> But we will certainly add support on powerpc for the files you have
> created, in addition to 'rfi_flush'.

Thanks,

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

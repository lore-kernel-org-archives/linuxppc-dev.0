Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwdy821hbzDrH3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 18:11:44 +1000 (AEST)
Subject: Re: [PATCH] Revert "KVM: Don't accept obviously wrong gsi values via
 KVM_IRQFD"
To: Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Jan_H._Sch=c3=b6nherr?= <jschoenh@amazon.de>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: sachinp@linux.vnet.ibm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
 <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
 <871sn4jyjz.fsf@concordia.ellerman.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31ff0f44-b380-62b3-4a8a-d3c1e49c7c3c@redhat.com>
Date: Mon, 18 Sep 2017 10:11:24 +0200
MIME-Version: 1.0
In-Reply-To: <871sn4jyjz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/09/2017 08:44, Michael Ellerman wrote:
> "Jan H. Schönherr" <jschoenh@amazon.de> writes:
> 
>> This reverts commit 36ae3c0a36b7456432fedce38ae2f7bd3e01a563.
>>
>> The commit broke compilation on !CONFIG_HAVE_KVM_IRQ_ROUTING. Also,
>> there may be cases with CONFIG_HAVE_KVM_IRQ_ROUTING, where larger
>> gsi values make sense.
>>
>> As the commit was meant as an early indicator to user space that
>> something is wrong, reverting just restores the previous behavior
>> where overly large values are ignored when encountered (without
>> any direct feedback).
>>
>> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
>> ---
>>  virt/kvm/eventfd.c | 2 --
>>  1 file changed, 2 deletions(-)
> 
> Can someone merge this or preferably just send it straight to Linus, the
> original patch has broken the powerpc build in mainline.

I can send it later today.

Paolo

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1V583l78zDsPC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 15:34:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Cc: "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org,
 raji@linux.vnet.ibm.com
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
In-Reply-To: <1506383986.2918.4.camel@gmail.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com>
Date: Tue, 26 Sep 2017 15:34:36 +1000
Message-ID: <87k20mf2fn.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:

> On Sun, 2017-09-24 at 05:18 +0800, Simon Guo wrote:
>> Hi Cyril,
>> On Sat, Sep 23, 2017 at 12:06:48AM +1000, Cyril Bur wrote:
>> > On Thu, 2017-09-21 at 07:34 +0800, wei.guo.simon@gmail.com wrote:
>> > > From: Simon Guo <wei.guo.simon@gmail.com>
>> > > 
>> > > This patch add VMX primitives to do memcmp() in case the compare size
>> > > exceeds 4K bytes.
>> > 
>> > Sorry I didn't see this sooner, I've actually been working on a kernel
>> > version of glibc commit dec4a7105e (powerpc: Improve memcmp performance
>> > for POWER8) unfortunately I've been distracted and it still isn't done.
>> 
>> Thanks for sync with me. Let's consolidate our effort together :)
>> 
>> I have a quick check on glibc commit dec4a7105e. 
>> Looks the aligned case comparison with VSX is launched without rN size
>> limitation, which means it will have a VSX reg load penalty even when the 
>> length is 9 bytes.
>> 
>
> This was written for userspace which doesn't have to explicitly enable
> VMX in order to use it - we need to be smarter in the kernel.

Well the kernel has to do it for them after a trap, which is actually
even more expensive, so arguably the glibc code should be smarter too
and the threshold before using VMX should probably be higher than in the
kernel (to cover the cost of the trap).

But I digress :)

cheers

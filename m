Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com
 [IPv6:2a00:1450:4013:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2474C2C0097
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 18:46:29 +1000 (EST)
Received: by mail-ee0-f50.google.com with SMTP id d51so227036eek.9
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Oct 2013 01:46:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <524BDD73.3020106@redhat.com>
Date: Wed, 02 Oct 2013 10:46:43 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com> <1380620338.645.22.camel@pasglop>
 <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
In-Reply-To: <20131002050940.GA25363@drongo>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 agraf@suse.de, herbert@gondor.hengli.com.au, mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 02/10/2013 07:09, Paul Mackerras ha scritto:
> On Tue, Oct 01, 2013 at 01:19:06PM +0200, Paolo Bonzini wrote:
> 
>> Anyhow, I would like to know more about this hwrng and hypercall.
>>
>> Does the hwrng return random numbers (like rdrand) or real entropy (like
>> rdseed that Intel will add in Broadwell)?  What about the hypercall?
> 
> Well, firstly, your terminology is inaccurate.  Real entropy will give
> you random numbers.  I think when you say "random numbers" you
> actually mean "pseudo-random numbers".

Yes---I meant pseudo-random numbers where the generator is periodically
seeded by a random number.

> Secondly, the RNG produces real entropy.

Good to know, thanks.

> Not sure why they are particularly "precious"; we get 64 bits per
> microsecond whether we use them or not.  What are you suggesting
> arch_get_random_long() should do instead?

If you are running rngd, there is no need to have arch_get_random_long()
at all.

>> 3) If the hypercall returns random numbers, then it is a pretty
>> braindead interface since returning 8 bytes at a time limits the
>> throughput to a handful of MB/s (compare to 200 MB/sec for x86 rdrand).
>>  But more important: in this case drivers/char/hw_random/pseries-rng.c
>> is completely broken and insecure, just like patch 2 in case (1) above.
> 
> Assuming that by "random numbers" you actually mean "pseudo-random
> numbers", then this doesn't apply.

Indeed.

>> 4) If the hypercall returns entropy (same as virtio-rng), the same
>> considerations on speed apply.  If you can only produce entropy at say 1
>> MB/s (so reading 8 bytes take 8 microseconds---which is actually very
>> fast), it doesn't matter that much to spend 7 microseconds on a
>> userspace roundtrip.  It's going to be only half the speed of bare
>> metal, not 100 times slower.
> 
> 8 bytes takes at most 1 microsecond, so the round-trip to userspace is
> definitely noticeable.

Thanks.  Any chance you can give some numbers of a kernel hypercall and
a userspace hypercall on Power, so we have actual data?  For example a
hypercall that returns H_PARAMETER as soon as possible.

Paolo

Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-ea0-x236.google.com (mail-ea0-x236.google.com
 [IPv6:2a00:1450:4013:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90FA32C016E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 19:58:02 +1000 (EST)
Received: by mail-ea0-f182.google.com with SMTP id o10so3256523eaj.41
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Oct 2013 02:57:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <524A9CB3.6030103@redhat.com>
Date: Tue, 01 Oct 2013 11:58:11 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
In-Reply-To: <20131001083426.GB27484@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, herbert@gondor.apana.org.au, gleb@redhat.com,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, agraf@suse.de,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 01/10/2013 10:34, Michael Ellerman ha scritto:
>> If you really want to have the hypercall, implementing it in QEMU means
>> that you can support it on all systems, in fact even when running
>> without KVM.  
> 
> Sure, I can add a fallback to /dev/hwrng for full emulation.
> 
>> The QEMU command line would be something like "-object
>> rng-random,filename=/dev/random,id=rng0 -device spapr-rng,rng=rng0".
> 
> We can't use /dev/random like that. The PAPR specification, which is
> what we're implementing, implies that H_RANDOM provides data from a
> hardware source.

Then use /dev/hwrng.

I don't have POWER machines, but I still want to be able to test as much
as possible using emulation.

Paolo

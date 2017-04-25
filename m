Return-Path: <srs0=wnro=4b=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBlCr3wQ1zDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 10:56:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBlCr38rPz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 10:56:56 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBlCq6b28z9s7f
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 10:56:55 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id v14so5843305pfd.3
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 17:56:55 -0700 (PDT)
Message-ID: <1493081807.21623.7.camel@gmail.com>
Subject: Re: [kernel-hardening] Re: [PATCH v2] powerpc/mm: Add support for
 runtime configuration of ASLR limits
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: bhsharma@redhat.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Date: Tue, 25 Apr 2017 10:56:47 +1000
In-Reply-To: <8737cxswuk.fsf@concordia.ellerman.id.au>
References: <1492698980-19510-1-git-send-email-mpe@ellerman.id.au>
 <1492995750.2418.4.camel@gmail.com>
 <8737cxswuk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-25 at 00:29 +1000, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > On Fri, 2017-04-21 at 00:36 +1000, Michael Ellerman wrote:
> > > Add powerpc support for mmap_rnd_bits and mmap_rnd_compat_bits, which are two
> > > sysctls that allow a user to configure the number of bits of randomness used for
> > > ASLR.
> 
> ...
> > 
> > Could we please suggest that this should not be sent to stable or back-ported
> > as the 128T default is new?
> 
> I'm not sure I follow. I didn't tag it for stable. Do you mean we should
> explicitly mark it as not-for-stable?
> 

Yeah.. I am concerned someone might backport it without looking at
the dependencies :)

> If someone sends it to stable@vger I'll be pinged before it goes in and
> nak it, if someone wants to backport it (incorrectly) to their own tree
> then good luck to them :)

Fair enough

<snip>

> > > +	rnd = get_random_long() % (1 << shift);
> > 
> > Nitpick, 1 should be 1UL?
> 
> No, shift can only be 29 at most IIRC?
> 
> But it's a bit fragile, so I'll change it.
> 
> cheers

Cheers and I agree with Kees, a lot of the arch_mmap_rnd() code is beginning
to look similar :)

Balbir Singh

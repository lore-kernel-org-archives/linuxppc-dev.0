Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVGSk2PWJzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 20:16:06 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id l65so7094505wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 03:16:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc/mm: Speed up computation of base and
 actual page size for a HPTE
To: Paul Mackerras <paulus@ozlabs.org>,
 Michael Ellerman <michael@ellerman.id.au>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <20160907061709.GD21443@fergus.ozlabs.ibm.com>
 <20160908100836.GA4965@fergus.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
Date: Thu, 8 Sep 2016 12:16:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160908100836.GA4965@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/09/2016 12:08, Paul Mackerras wrote:
>> > 
>> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 37 ++++++++++++
>> >  arch/powerpc/include/asm/kvm_book3s_64.h      | 87 +++------------------------
>> >  arch/powerpc/include/asm/mmu.h                |  1 +
>> >  arch/powerpc/mm/hash_native_64.c              | 42 +------------
>> >  arch/powerpc/mm/hash_utils_64.c               | 55 +++++++++++++++++
> This of course touches two maintainers' areas.  Michael and Paolo, how
> do you want to proceed here?  Can this just go through Michael's tree?
> Or should I make a topic branch off Linus' tree that you can both
> pull, or should I split the patch into two (i.e. everything except the
> kvm_book3s_64.h change in the first patch, and the kvm_book3s_64.h
> change in the second) and get Michael to put the first one in a topic
> branch that I can then pull and apply the second patch onto?

This patch seems separate from the other two (I can't really tell since
there wasn't a cover letter on linuxppc-dev).  Can you place it in a
pull request for both Michael and myself?

Paolo

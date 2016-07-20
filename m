Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvRqH22TBzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 16:30:19 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id l69so2911581lfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 23:30:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
 <20534.8713825972$1468993677@news.gmane.org>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org, paulus@samba.org,
 david@gibson.dropbear.id.au, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee83aaeb-40cf-4b46-4ae0-bb4265a0e610@redhat.com>
Date: Wed, 20 Jul 2016 08:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <20534.8713825972$1468993677@news.gmane.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/07/2016 07:46, Michael Ellerman wrote:
> Thanks.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Or do you want me to merge this before Paul gets back?

No, this should be merged through the KVM tree.  Please Cc the KVM
maintainers before offering to apply a patch that formally belongs to
another tree.

I don't care if Paul merges the patch or Radim and I do, but we're
getting lots of unnecessary conflicts from patches that go through the
main architecture tree and that shouldn't really happen.  Please let's
keep some discipline, as I want to minimize the number of conflicts that
reach Linus (and 4.8 is going to be *bad* in this respect, with both PPC
and s390 having conflicts between the KVM and arch tree).

In particular this patch would indeed have a conflict, because you have

+#define KVM_CAP_PPC_HTM 129

but cap numbers 129 and 130 are already taken.  So whoever applies it
should bump the number to 131.

Paolo

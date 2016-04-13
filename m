Return-Path: <jeyu@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlXGP27zczDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 04:22:37 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qlXGM4Skgz9t3t
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2016 04:22:35 +1000 (AEST)
Date: Wed, 13 Apr 2016 14:22:28 -0400
From: Jessica Yu <jeyu@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: Live patching for powerpc
Message-ID: <20160413182228.GA16776@packer-debian-8-amd64.digitalocean.com>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+++ Miroslav Benes [13/04/16 15:01 +0200]:
>On Wed, 13 Apr 2016, Michael Ellerman wrote:
>
>> This series adds live patching support for powerpc (ppc64le only ATM).
>>
>> It's unchanged since the version I posted on March 24, with the exception that
>> I've dropped the first patch, which was a testing-only patch.
>>
>> If there's no further comments I'll put this in a topic branch in the next day
>> or two and Jiri & I will both merge that into next.
>
>Hi,
>
>I'll definitely give it a proper look today or tomorrow, but there is one
>thing that needs to be solved. The patch set from Jessica reworking
>relocations for live patching is now merged in our for-next branch. This
>means that we need to find out if there is something in struct
>mod_arch_specific for powerpc which needs to be preserved and do it.
>

I took a look around the powerpc module.c code and it looks like the
mod_arch_specific stuff should be fine, since it is statically allocated
in the module struct (unlike the situation in s390, where
mod->arch.syminfo was vmalloc'd and we had to delay the free).
However I'm not familiar with the powerpc code so I need to dig around
a bit more to be 100% sure.

A second concern I have is that apply_relocate_add() relies on
sections like .stubs and .toc (for 64-bit) and .init.plt and .plt
sections (for 32-bit). In order for apply_relocate_add() to work for
livepatch, we must make sure these sections aren't thrown away and are
not in init module memory since this memory will be freed at the end
of module load (see how INIT_OFFSET_MASK is used in kernel/module.c).
As long as these sections are placed in module core memory, we will be
OK. I need to think about this a bit more.

Third and unrelated comment: the klp_write_module_reloc stub isn't
needed anymore :-)

Thanks,
Jessica

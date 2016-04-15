Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmW0d1F43zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 18:29:05 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qmW0c5JJPz9sDb
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2016 18:29:03 +1000 (AEST)
Date: Fri, 15 Apr 2016 10:28:58 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Jessica Yu <jeyu@redhat.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: Live patching for powerpc
In-Reply-To: <20160414192031.GB25297@packer-debian-8-amd64.digitalocean.com>
Message-ID: <alpine.LNX.2.00.1604151018220.4334@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <20160413182228.GA16776@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1604141514420.10605@pobox.suse.cz>
 <20160414192031.GB25297@packer-debian-8-amd64.digitalocean.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Apr 2016, Jessica Yu wrote:

> +++ Miroslav Benes [14/04/16 15:28 +0200]:
> > On Wed, 13 Apr 2016, Jessica Yu wrote:
> 
> > > A second concern I have is that apply_relocate_add() relies on
> > > sections like .stubs and .toc (for 64-bit) and .init.plt and .plt
> > > sections (for 32-bit). In order for apply_relocate_add() to work for
> > > livepatch, we must make sure these sections aren't thrown away and are
> > > not in init module memory since this memory will be freed at the end
> > > of module load (see how INIT_OFFSET_MASK is used in kernel/module.c).
> > > As long as these sections are placed in module core memory, we will be
> > > OK. I need to think about this a bit more.
> > 
> > I knew I shouldn't have opened arch/powerpc/kernel/module*.c.
> > 
> > We could always hack sh_flags of those sections in
> > module_arch_frob_sections() to make them stay.
> > 
> 
> I think we are fine here too. The onus would be on the patch build
> tool (e.g., kpatch) to set the sh_flags to SHF_ALLOC, like we
> already do to keep the klp relocation sections in memory :-)

Yes, this is probably the best way.

> For the 32-bit module code, I don't believe we would need to preserve
> the .init.plt section for livepatch's call to apply_relocate_add(),
> since relocations to init sections should've been applied during
> module initialization, and we don't patch those types of functions.
> Please correct me if my understanding is off.

I think you are right, but I also think we don't have to worry about 
32-bit powerpc anyway. This patch set supports ppc64le only so we can 
leave it for now.

Miroslav

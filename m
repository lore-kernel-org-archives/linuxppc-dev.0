Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DCB1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 01:17:42 +1100 (AEDT)
Received: by wgs2 with SMTP id 2so66083225wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 07:17:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 26 Mar 2015 15:17:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150326141730.GA23060@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com>
 <1427317867.6468.87.camel@kernel.crashing.org>
 <20150326094330.GA15407@gmail.com>
 <5513E16D.1030101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5513E16D.1030101@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> > I argue we should use the right condition to clear vdso_base: if 
> > the vDSO gets at least partially unmapped. Otherwise there's 
> > little point in the whole patch: either correctly track whether 
> > the vDSO is OK, or don't ...
> 
> That's a good option, but it may be hard to achieve in the case the 
> vDSO area has been splitted in multiple pieces.
>
> Not sure there is a right way to handle that, here this is a best 
> effort, allowing a process to unmap its vDSO and having the 
> sigreturn call done through the stack area (it has to make it 
> executable).
> 
> Anyway I'll dig into that, assuming that the vdso_base pointer 
> should be clear if a part of the vDSO is moved or unmapped. The 
> patch will be larger since I'll have to get the vDSO size which is 
> private to the vdso.c file.

At least for munmap() I don't think that's a worry: once unmapped 
(even if just partially), vdso_base becomes zero and won't ever be set 
again.

So no need to track the zillion pieces, should there be any: Humpty 
Dumpty won't be whole again, right?

> > There's also the question of mprotect(): can users mprotect() the 
> > vDSO on PowerPC?
> 
> Yes, mprotect() the vDSO is allowed on PowerPC, as it is on x86, and 
> certainly all the other architectures. Furthermore, if it is done on 
> a partial part of the vDSO it is splitting the vma...

btw., CRIU's main purpose here is to reconstruct a vDSO that was 
originally randomized, but whose address must now be reproduced as-is, 
right?

In that sense detecting the 'good' mremap() as your patch does should 
do the trick and is certainly not objectionable IMHO - I was just 
wondering whether we could make a perfect job very simply.

Thanks,

	Ingo

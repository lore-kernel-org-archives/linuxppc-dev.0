Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B57881A039D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 10:03:24 +1100 (AEDT)
Message-ID: <1455059004.7576.1.camel@ellerman.id.au>
Subject: Re: build regression from c153693: Simplify module TOC handling
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dinar Valeev <dinarv@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: amodra@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kernel@lists.fedoraproject.org
Date: Wed, 10 Feb 2016 10:03:24 +1100
In-Reply-To: <CADqALGTumTqorBs2sok54EHLA7PeHREKjQjudZBGPfhx3Suh6A@mail.gmail.com>
References: <CALeDE9Pc6z5Ed=92u47VPpQ9V-bKsUg95vy1pDSQ805U0R=z-g@mail.gmail.com>
 <CADqALGTumTqorBs2sok54EHLA7PeHREKjQjudZBGPfhx3Suh6A@mail.gmail.com>
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

On Tue, 2016-02-09 at 22:02 +0100, Dinar Valeev wrote:

> On Tue, Feb 9, 2016 at 5:28 PM, Peter Robinson <pbrobinson@gmail.com> wrote:

> > Hi Alan,
> >
> > Your patch for "powerpc: Simplify module TOC handling" is causing the
> > Fedora ppc64le to fail to build with depmod failures. Reverting the
> > commit fixes it for us on rawhide.

> Anton's patch [1] fixes it.
>
> [1] https://build.opensuse.org/package/view_file/Base:System/kmod/depmod-Ignore_PowerPC64_ABIv2_.TOC.symbol.patch

Yep, you need an updated depmod.

Anton sent a patch to linux-modules, reproduced below for the benefit of the
list archive:

depmod: Ignore PowerPC64 ABIv2 .TOC. symbol

The .TOC. symbol on the PowerPC64 ABIv2 identifies the GOT
pointer, similar to how other architectures use _GLOBAL_OFFSET_TABLE_.

This is not a symbol that needs relocation, and should be ignored
by depmod.

---
 tools/depmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/depmod.c b/tools/depmod.c
index 6e9bb4d..a2e07c1 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2153,6 +2153,8 @@ static void depmod_add_fake_syms(struct depmod *depmod)
 	depmod_symbol_add(depmod, "__this_module", true, 0, NULL);
 	/* On S390, this is faked up too */
 	depmod_symbol_add(depmod, "_GLOBAL_OFFSET_TABLE_", true, 0, NULL);
+	/* On PowerPC64 ABIv2, .TOC. is more or less _GLOBAL_OFFSET_TABLE_ */
+	depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
 }

 static int depmod_load_symvers(struct depmod *depmod, const char *filename)
--
2.5.0

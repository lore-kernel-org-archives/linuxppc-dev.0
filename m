Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNlGJ63GDzDwCk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 12:33:12 +1100 (AEDT)
Date: Wed, 23 Nov 2016 09:32:58 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
Message-ID: <20161123013258.GA3222@dhcp-128-65.nay.redhat.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <5009580.5GxAkTrMYA@morokweng>
 <87ziksuk7t.fsf@concordia.ellerman.id.au>
 <2486176.qfzlYnJWAn@morokweng>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2486176.qfzlYnJWAn@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/16 at 11:44am, Thiago Jung Bauermann wrote:
> Am Dienstag, 22. November 2016, 17:01:10 BRST schrieb Michael Ellerman:
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > > Am Sonntag, 20. November 2016, 10:45:46 BRST schrieb Dave Young:
> > >> On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
> > >> > powerpc's purgatory.ro has 12 relocation types when built as
> > >> > a relocatable object. To implement support for them requires
> > >> > arch_kexec_apply_relocations_add to duplicate a lot of code with
> > >> > module_64.c:apply_relocate_add.
> > >> > 
> > >> > When built as a Position Independent Executable there are only 4
> > >> > relocation types in purgatory.ro, so it becomes practical for the
> > >> > powerpc
> > >> > implementation of kexec_file to have its own relocation implementation.
> > >> > 
> > >> > Also, the purgatory is an executable and not an intermediary output
> > >> > from
> > >> > the compiler so it makes sense conceptually that it is easier to build
> > >> > it as a PIE than as a partially linked object.
> > >> > 
> > >> > Apart from the greatly reduced number of relocations, there are two
> > >> > differences between a relocatable object and a PIE:
> > >> > 
> > >> > 1. __kexec_load_purgatory needs to use the program headers rather than
> > >> > the
> > >> > 
> > >> >    section headers to figure out how to load the binary.
> > >> > 
> > >> > 2. Symbol values are absolute addresses instead of relative to the
> > >> > 
> > >> >    start of the section.
> > >> > 
> > >> > This patch adds the support needed in generic code for the differences
> > >> > above and allows powerpc to load and relocate a position independent
> > >> > purgatory.
> > >> 
> > >> [snip]
> > >> 
> > >> The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it is
> > >> not that complex. So could you look into simplify your kexec_file
> > >> implementation?
> > > 
> > > I can try, but there is one fundamental issue here: powerpc
> > > position-dependent code relies more on relocations than x86
> > > position-dependent code does, so there's a limit to how simple it can be
> > > made without switching to position- independent code. And it will always
> > > be more involved than it is on x86.
> > I think we need to go back to the drawing board on this one.
> > 
> > My hope was that building purgatory as PIE would reduce the amount of
> > complexity, but instead it's just added more. Sorry for sending you in
> > that direction.
> 
> It added complexity because in my series powerpc was using a PIE purgatory but 
> x86 kept using a partially-linked object (because of the problem I mentioned I 
> had when trying out a PIE x86 purgatory), so generic code needed two purgatory 
> loaders.
> 
> I'll see if I can make the PIE x86 purgatory to work so that generic code can 
> have only one loader implementation. Then it will indeed be simpler.

Do we really need the PIE purgatory, after moving generic code out of
x86, there will be no much benefit, no? Anyway, the first step should be
making the purgatory code more generic so that it can be easier for
other arches to support kexec_file in the future. 

> 
> 
> Am Dienstag, 22. November 2016, 14:16:22 BRST schrieb Dave Young:
> > Hi Michael
> > 
> > On 11/22/16 at 05:01pm, Michael Ellerman wrote:
> > > In general I dislike the level of complexity of the kexec-tools
> > > purgatory, and in particular I'm not comfortable with things like:
> > > 
> > > diff --git a/arch/powerpc/purgatory/sha256.c
> > > b/arch/powerpc/purgatory/sha256.c new file mode 100644
> > > index 000000000000..6abee1877d56
> > > --- /dev/null
> > > +++ b/arch/powerpc/purgatory/sha256.c
> > > @@ -0,0 +1,6 @@
> > > +#include "../boot/string.h"
> > > +
> > > +/* Avoid including x86's boot/string.h in sha256.c. */
> > > +#define BOOT_STRING_H
> > > +
> > > +#include "../../x86/purgatory/sha256.c"
> > 
> > Agreed, include x86 code in powerpc looks bad
> > 
> > > I think the best way to get this over the line would be to take the
> > > kexec-lite purgatory implementation and use that to begin with. I know
> > > it doesn't have all the features of the kexec-tools version, but it
> > > should work, and we can look at adding the extra features later.
> > 
> > Instead of adding other implementation, moving the purgatory sha256 code
> > out of x86 sounds better so that we can reuse them cleanly..
> 
> Do you have a suggestion of where that code can live so that it can be shared 
> between purgatories for different arches?

Maybe it is better to stay in lib/purgatory/

> 
> Do we need a purgatory with generic and arch-specific code like in kexec-
> tools?

Yes, if we have more arches to add kexec_file, this should be
necessary..

> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

Thanks
Dave

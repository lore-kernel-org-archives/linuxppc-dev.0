Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNFFy4sTfzDvtd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 17:01:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
In-Reply-To: <5009580.5GxAkTrMYA@morokweng>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20161120024546.GA4413@dhcp-128-65.nay.redhat.com>
 <5009580.5GxAkTrMYA@morokweng>
Date: Tue, 22 Nov 2016 17:01:10 +1100
Message-ID: <87ziksuk7t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> Am Sonntag, 20. November 2016, 10:45:46 BRST schrieb Dave Young:
>> On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
>> > powerpc's purgatory.ro has 12 relocation types when built as
>> > a relocatable object. To implement support for them requires
>> > arch_kexec_apply_relocations_add to duplicate a lot of code with
>> > module_64.c:apply_relocate_add.
>> > 
>> > When built as a Position Independent Executable there are only 4
>> > relocation types in purgatory.ro, so it becomes practical for the powerpc
>> > implementation of kexec_file to have its own relocation implementation.
>> > 
>> > Also, the purgatory is an executable and not an intermediary output from
>> > the compiler so it makes sense conceptually that it is easier to build
>> > it as a PIE than as a partially linked object.
>> > 
>> > Apart from the greatly reduced number of relocations, there are two
>> > differences between a relocatable object and a PIE:
>> > 
>> > 1. __kexec_load_purgatory needs to use the program headers rather than the
>> > 
>> >    section headers to figure out how to load the binary.
>> > 
>> > 2. Symbol values are absolute addresses instead of relative to the
>> > 
>> >    start of the section.
>> > 
>> > This patch adds the support needed in generic code for the differences
>> > above and allows powerpc to load and relocate a position independent
>> > purgatory.
>> 
>> [snip]
>> 
>> The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it is
>> not that complex. So could you look into simplify your kexec_file
>> implementation?
>
> I can try, but there is one fundamental issue here: powerpc position-dependent 
> code relies more on relocations than x86 position-dependent code does, so 
> there's a limit to how simple it can be made without switching to position-
> independent code. And it will always be more involved than it is on x86.

I think we need to go back to the drawing board on this one.

My hope was that building purgatory as PIE would reduce the amount of
complexity, but instead it's just added more. Sorry for sending you in
that direction.


In general I dislike the level of complexity of the kexec-tools
purgatory, and in particular I'm not comfortable with things like:

diff --git a/arch/powerpc/purgatory/sha256.c b/arch/powerpc/purgatory/sha256.c
new file mode 100644
index 000000000000..6abee1877d56
--- /dev/null
+++ b/arch/powerpc/purgatory/sha256.c
@@ -0,0 +1,6 @@
+#include "../boot/string.h"
+
+/* Avoid including x86's boot/string.h in sha256.c. */
+#define BOOT_STRING_H
+
+#include "../../x86/purgatory/sha256.c"


I think the best way to get this over the line would be to take the
kexec-lite purgatory implementation and use that to begin with. I know
it doesn't have all the features of the kexec-tools version, but it
should work, and we can look at adding the extra features later.

I'll try and get that working tonight.

cheers

Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [65.50.211.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHmHW1LC0zDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 06:02:46 +1000 (AEST)
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <201707261927.v6QJR228008075@mail.zytor.com>
Date: Wed, 26 Jul 2017 21:26:58 +0200
In-Reply-To: <ed6d4ce7-97a6-f664-d7d7-4ff48bc6f06a@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-14-brijesh.singh@amd.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003FB85@AcuExch.aculab.com>
 <CAK8P3a3h7JpmkW7W=HwqAuWWmro=ngj6HSeiiML_=T82x-FtZQ@mail.gmail.com>
 <ed6d4ce7-97a6-f664-d7d7-4ff48bc6f06a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV is
 active
To: Brijesh Singh <brijesh.singh@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 David Laight <David.Laight@aculab.com>
CC: brijesh.singh@amd.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Christoph Lameter <cl@linux.com>, Jonathan Corbet <corbet@lwn.net>,
 =?ISO-8859-1?Q?Radim_Krcm=E1r?= <rkrcmar@redhat.com>,
 Piotr Luc <piotr.luc@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Airlie <airlied@redhat.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Laura Abbott <labbott@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Ard.Biesheuvel@zytor.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<ard.biesheuvel@linaro.org>,Eric Biederman <ebiederm@xmission.com>,Tejun Heo <tj@kernel.org>,Paolo Bonzini <pbonzini@redhat.com>,Andrew Morton <akpm@linux-foundation.org>,"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,Lu Baolu <baolu.lu@linux.intel.com>
From: hpa@zytor.com
Message-ID: <AF533772-BD88-4EDA-AD26-7EFA2878F123@zytor.com>

On July 26, 2017 9:24:45 PM GMT+02:00, Brijesh Singh <brijesh=2Esingh@amd=
=2Ecom> wrote:
>
>Hi Arnd and David,
>
>On 07/26/2017 05:45 AM, Arnd Bergmann wrote:
>> On Tue, Jul 25, 2017 at 11:51 AM, David Laight
><David=2ELaight@aculab=2Ecom> wrote:
>>> From: Brijesh Singh
>>>> Sent: 24 July 2017 20:08
>>>> From: Tom Lendacky <thomas=2Elendacky@amd=2Ecom>
>>>>
>>>> Secure Encrypted Virtualization (SEV) does not support string I/O,
>so
>>>> unroll the string I/O operation into a loop operating on one
>element at
>>>> a time=2E
>>>>
>>>> Signed-off-by: Tom Lendacky <thomas=2Elendacky@amd=2Ecom>
>>>> Signed-off-by: Brijesh Singh <brijesh=2Esingh@amd=2Ecom>
>>>> ---
>>>>   arch/x86/include/asm/io=2Eh | 26 ++++++++++++++++++++++----
>>>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/io=2Eh b/arch/x86/include/asm/io=2E=
h
>>>> index e080a39=2E=2E2f3c002 100644
>>>> --- a/arch/x86/include/asm/io=2Eh
>>>> +++ b/arch/x86/include/asm/io=2Eh
>>>> @@ -327,14 +327,32 @@ static inline unsigned type in##bwl##_p(int
>port)                       \
>>>>                                                                   =20
>   \
>>>>   static inline void outs##bwl(int port, const void *addr, unsigned
>long count) \
>>>>   {
>>=20
>> This will clash with a fix I did to add a "memory" clobber
>> for the traditional implementation, see
>> https://patchwork=2Ekernel=2Eorg/patch/9854573/
>>=20
>>> Is it even worth leaving these as inline functions?
>>> Given the speed of IO cycles it is unlikely that the cost of calling
>a real
>>> function will be significant=2E
>>> The code bloat reduction will be significant=2E
>>=20
>> I think the smallest code would be the original "rep insb" etc, which
>> should be smaller than a function call, unlike the loop=2E Then again,
>> there is a rather small number of affected device drivers, almost all
>> of them for ancient hardware that you won't even build in a 64-bit
>> x86 kernel, see the list below=2E The only user I found that is
>actually
>> still relevant is drivers/tty/hvc/hvc_xen=2Ec, which uses it for the
>early
>> console=2E
>
>
>There are some indirect user of string I/O functions=2E The following
>functions
>defined in lib/iomap=2Ec calls rep version of ins and outs=2E
>
>- ioread8_rep, ioread16_rep, ioread32_rep
>- iowrite8_rep, iowrite16_rep, iowrite32_rep
>
>I found that several drivers use above functions=2E
>
>Here is one approach to convert it into non-inline functions=2E In this
>approach,
>I have added a new file arch/x86/kernel/io=2Ec which provides non rep
>version of
>string I/O routines=2E The file gets built and used only when
>AMD_MEM_ENCRYPT is
>enabled=2E On positive side, if we don't build kernel with
>AMD_MEM_ENCRYPT support
>then we use inline routines, when AMD_MEM_ENCRYPT is built then we make
>a function
>call=2E Inside the function we unroll only when SEV is active=2E
>
>Do you see any issue with this approach ? thanks
>
>diff --git a/arch/x86/include/asm/io=2Eh b/arch/x86/include/asm/io=2Eh
>index e080a39=2E=2E104927d 100644
>--- a/arch/x86/include/asm/io=2Eh
>+++ b/arch/x86/include/asm/io=2Eh
>@@ -323,8 +323,9 @@ static inline unsigned type in##bwl##_p(int port) =20
>                \
>      unsigned type value =3D in##bwl(port);                            \
>      slow_down_io();                                                 \
>      return value;                                                   \
>-}                                                                    =20
>\
>-                                                                     =20
>\
>+}
>+
>+#define BUILDIO_REP(bwl, bw, type)                                   =20
>\
>static inline void outs##bwl(int port, const void *addr, unsigned long
>count) \
>{                                                                    =20
>\
>      asm volatile("rep; outs" #bwl                                   \
>@@ -335,12 +336,31 @@ static inline void ins##bwl(int port, void *addr,
>unsigned long count)    \
>{                                                                    =20
>\
>      asm volatile("rep; ins" #bwl                                    \
>                   : "+D"(addr), "+c"(count) : "d"(port));            \
>-}
>+}                                                                    =20
>\
> =20
>  BUILDIO(b, b, char)
>  BUILDIO(w, w, short)
>  BUILDIO(l, , int)
> =20
>+#ifdef CONFIG_AMD_MEM_ENCRYPT
>+extern void outsb_try_rep(int port, const void *addr, unsigned long
>count);
>+extern void insb_try_rep(int port, void *addr, unsigned long count);
>+extern void outsw_try_rep(int port, const void *addr, unsigned long
>count);
>+extern void insw_try_rep(int port, void *addr, unsigned long count);
>+extern void outsl_try_rep(int port, const void *addr, unsigned long
>count);
>+extern void insl_try_rep(int port, void *addr, unsigned long count);
>+#define outsb  outsb_try_rep
>+#define insb   insb_try_rep
>+#define outsw  outsw_try_rep
>+#define insw   insw_try_rep
>+#define outsl  outsl_try_rep
>+#define insl   insl_try_rep
>+#else
>+BUILDIO_REP(b, b, char)
>+BUILDIO_REP(w, w, short)
>+BUILDIO_REP(l, , int)
>+#endif
>+
>  extern void *xlate_dev_mem_ptr(phys_addr_t phys);
>  extern void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>
>diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>index a01892b=2E=2E3b6e2a3 100644
>--- a/arch/x86/kernel/Makefile
>+++ b/arch/x86/kernel/Makefile
>@@ -42,6 +42,7 @@ CFLAGS_irq=2Eo :=3D -I$(src)/=2E=2E/include/asm/trace
> =20
>  obj-y                  :=3D process_$(BITS)=2Eo signal=2Eo
>  obj-$(CONFIG_COMPAT)   +=3D signal_compat=2Eo
>+obj-$(CONFIG_AMD_MEM_ENCRYPT) +=3D io=2Eo
>obj-y                  +=3D traps=2Eo irq=2Eo irq_$(BITS)=2Eo
>dumpstack_$(BITS)=2Eo
>  obj-y                  +=3D time=2Eo ioport=2Eo dumpstack=2Eo nmi=2Eo
>  obj-$(CONFIG_MODIFY_LDT_SYSCALL)       +=3D ldt=2Eo
>diff --git a/arch/x86/kernel/io=2Ec b/arch/x86/kernel/io=2Ec
>new file mode 100644
>index 0000000=2E=2Ef58afa9
>--- /dev/null
>+++ b/arch/x86/kernel/io=2Ec
>@@ -0,0 +1,87 @@
>+#include <linux/types=2Eh>
>+#include <linux/io=2Eh>
>+#include <asm/io=2Eh>
>+
>+void outsb_try_rep(int port, const void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned char *value =3D (unsigned char *)addr;
>+               while (count) {
>+                       outb(*value, port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; outsb" : "+S"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}
>+
>+void insb_try_rep(int port, void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned char *value =3D (unsigned char *)addr;
>+               while (count) {
>+                       *value =3D inb(port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; insb" : "+D"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}
>+
>+void outsw_try_rep(int port, const void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned short *value =3D (unsigned short *)addr;
>+               while (count) {
>+                       outw(*value, port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; outsw" : "+S"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}
>+void insw_try_rep(int port, void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned short *value =3D (unsigned short *)addr;
>+               while (count) {
>+                       *value =3D inw(port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; insw" : "+D"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}
>+
>+void outsl_try_rep(int port, const void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned int *value =3D (unsigned int *)addr;
>+               while (count) {
>+                       outl(*value, port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; outsl" : "+S"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}
>+
>+void insl_try_rep(int port, void *addr, unsigned long count)
>+{
>+       if (sev_active()) {
>+               unsigned int *value =3D (unsigned int *)addr;
>+               while (count) {
>+                       *value =3D inl(port);
>+                       value++;
>+                       count--;
>+               }
>+       } else {
>+               asm volatile("rep; insl" : "+D"(addr), "+c"(count) :
>"d"(port));
>+       }
>+}

What the heck?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

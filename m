Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGtml3xkwzDqm1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 19:51:34 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brijesh Singh' <brijesh.singh@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming
 <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>, "Paul
 Mackerras" <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "Christoph
 Lameter" <cl@linux.com>, Jonathan Corbet <corbet@lwn.net>,
 =?iso-8859-2?Q?Radim_Krcm=E1r?= <rkrcmar@redhat.com>, Piotr Luc
 <piotr.luc@intel.com>, Ingo Molnar <mingo@redhat.com>, Dave Airlie
 <airlied@redhat.com>, Borislav Petkov <bp@suse.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann
 <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric
 Biederman" <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A
 . Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>
Subject: RE: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV
 is active
Date: Tue, 25 Jul 2017 09:51:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD003FB85@AcuExch.aculab.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-14-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-14-brijesh.singh@amd.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Brijesh Singh
> Sent: 24 July 2017 20:08
> From: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> Secure Encrypted Virtualization (SEV) does not support string I/O, so
> unroll the string I/O operation into a loop operating on one element at
> a time.
>=20
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/io.h | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index e080a39..2f3c002 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -327,14 +327,32 @@ static inline unsigned type in##bwl##_p(int port)		=
	\
>  									\
>  static inline void outs##bwl(int port, const void *addr, unsigned long c=
ount) \
>  {

Is it even worth leaving these as inline functions?
Given the speed of IO cycles it is unlikely that the cost of calling a real
function will be significant.
The code bloat reduction will be significant.

	David

Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcGp718v5zDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 02:53:02 +1000 (AEST)
Date: Tue, 22 Aug 2017 18:52:48 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radim =?utf-8?Q?Krcm=C3=A1r?= <rkrcmar@redhat.com>,
 Piotr Luc <piotr.luc@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Airlie <airlied@redhat.com>, Kees Cook <keescook@chromium.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Laura Abbott <labbott@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Ard.Biesheuvel@zytor.com
Subject: Re: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV is
 active
Message-ID: <20170822165248.rkbluikdgduu7ucy@pd.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-14-brijesh.singh@amd.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003FB85@AcuExch.aculab.com>
 <CAK8P3a3h7JpmkW7W=HwqAuWWmro=ngj6HSeiiML_=T82x-FtZQ@mail.gmail.com>
 <ed6d4ce7-97a6-f664-d7d7-4ff48bc6f06a@amd.com>
 <201707261927.v6QJR228008075@mail.zytor.com>
 <589d65a4-eb09-bae9-e8b4-a2d78ca6b509@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <589d65a4-eb09-bae9-e8b4-a2d78ca6b509@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 03:07:14PM -0500, Brijesh Singh wrote:
> Are you commenting on amount of code duplication ? If so, I can certainly improve
> and use the similar macro used into header file to generate the functions body.

So the argument about having CONFIG_AMD_MEM_ENCRYPT disabled doesn't
bring a whole lot because distro kernels will all have it enabled.

Optimally, it would be best if when SEV is enabled, we patch those IO
insns but we can't patch at arbitrary times - we just do it once, at
pre-SMP time.

And from looking at the code, we do set sev_enabled very early, as
part of __startup_64() -> sme_enable() so I guess we can make that
set a synthetic X86_FEATURE_ bit and then patch REP IN/OUT* with a
CALL, similar to what we do in arch/x86/include/asm/arch_hweight.h with
POPCNT.

But there you need to pay attention to registers being clobbered, see

  f5967101e9de ("x86/hweight: Get rid of the special calling convention")

Yap, it does sound a bit more complex but if done right, we will be
patching all call sites the same way we patch hweight*() calls and there
should be no change to kernel size...

As always, the devil is in the detail.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

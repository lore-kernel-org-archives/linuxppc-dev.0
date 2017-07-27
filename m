Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJClY3lK7zDqmg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:40:09 +1000 (AEST)
Date: Thu, 27 Jul 2017 15:39:27 +0200
From: Borislav Petkov <bp@suse.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 03/17] x86/mm: Secure Encrypted
 Virtualization (SEV) support
Message-ID: <20170727133927.GC28553@nazgul.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-4-brijesh.singh@amd.com>
 <20170726042840.GB30702@nazgul.tnic>
 <facf3ac6-ebda-57a7-f961-6029b3ac7be7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <facf3ac6-ebda-57a7-f961-6029b3ac7be7@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 11:47:32AM -0500, Tom Lendacky wrote:
> If it's made static then the sme_active()/sev_active() inline functions
> would need to be turned into functions within the mem_encrypt.c file. So
> there's a trade-off to do that, which is the better one?

Simple: why do we have functions if the variables are exported?

The reasoning for sme_me_mask is more or less obvious but for sev_enabled...

IOW, either make the bool static and unlinine the function - this way
you're free to change how you determine whether SEV is enabled later as
callers will be using the function.

Or, if it doesn't really matter because you can always change callers
later, simply drop sev_active() the function and use a bool sev_active
everywhere.

> The kernel needs to distinguish between running under SME and running
> under SEV. SME and SEV are similar but not the same. The trampoline code
> is a good example.  Before paging is activated, SME will access all
> memory as decrypted, but SEV will access all memory as encrypted.  So
> when APs are being brought up under SME the trampoline area cannot be
> encrypted, whereas under SEV the trampoline area must be encrypted.

I guess you're sensing by now that we need this clarification in a
comment above it...

:-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

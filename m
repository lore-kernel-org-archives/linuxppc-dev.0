Return-Path: <brijesh.singh@amd.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0067.outbound.protection.outlook.com [104.47.42.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmHP02F5BzDqZs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 03:47:31 +1000 (AEST)
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 David Howells <dhowells@redhat.com>, Matt Fleming
 <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 16/17] X86/KVM: Provide support to create
 Guest and HV shared per-CPU variables
To: Borislav Petkov <bp@suse.de>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-17-brijesh.singh@amd.com>
 <20170829102258.gxk227js4yw47qi3@pd.tnic>
 <0810a732-9c77-a543-ffeb-7fd2d8f46266@amd.com>
 <20170830174655.ehrnmynotmp7laka@pd.tnic>
 <8155b5b2-b2b3-bc8f-33ae-b81b661a2e38@amd.com>
 <20170904170525.toyulxwaevef42qe@pd.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a059fbc9-5eb7-41c9-bcdc-86ae069f21a5@amd.com>
Date: Mon, 4 Sep 2017 12:47:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170904170525.toyulxwaevef42qe@pd.tnic>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 9/4/17 12:05 PM, Borislav Petkov wrote:
> On Fri, Sep 01, 2017 at 05:52:13PM -0500, Brijesh Singh wrote:
>>  So far, we have not seen the need for having such functions except
>> this cases. The approach we have right now works just fine and not
>> sure if its worth adding new functions.
> Then put the call to kvm_map_hv_shared_decrypted() into
> kvm_smp_prepare_boot_cpu() to denote that you're executing this whole
> stuff only once during guest init.
>
> Now you're doing additional jumping-through-hoops with that once static
> var just so you can force something which needs to execute only once but
> gets called in a per-CPU path.
>
> See what I mean?

Yes, I see your point. I will address this issue in next rev.


-Brijesh

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snzzK6K9rzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:18:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton  <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Denys Vlasenko <dvlasenk@redhat.com>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] powerpc: Do not make the entire heap executable
In-Reply-To: <CAGXu5j+haCUW_AEPLPcVGtrnv4ojQ79FDpspUurYJSX_-TXeow@mail.gmail.com>
References: <20161003161322.3835-1-dvlasenk@redhat.com>
 <CAGXu5j+haCUW_AEPLPcVGtrnv4ojQ79FDpspUurYJSX_-TXeow@mail.gmail.com>
Date: Tue, 04 Oct 2016 11:18:37 +1100
Message-ID: <877f9p55lu.fsf@concordia.ellerman.id.au>
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

Kees Cook <keescook@chromium.org> writes:

> On Mon, Oct 3, 2016 at 9:13 AM, Denys Vlasenko <dvlasenk@redhat.com> wrote:
>> On 32-bit powerpc the ELF PLT sections of binaries (built with --bss-plt,
>> or with a toolchain which defaults to it) look like this:
...
>>
>> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Oleg Nesterov <oleg@redhat.com>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Florian Weimer <fweimer@redhat.com>
>> CC: linux-mm@kvack.org
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>> Changes since v5:
>> * made do_brk_flags() error out if any bits other than VM_EXEC are set.
>>   (Kees Cook: "With this, I'd be happy to Ack.")
>>   See https://patchwork.ozlabs.org/patch/661595/
>
> Excellent, thanks for the v6! Should this go via the ppc tree or the -mm tree?

-mm would be best, given the diffstat I think it's less likely to
 conflict if it goes via -mm.

cheers

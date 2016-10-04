Return-Path: <keescook@google.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com
 [IPv6:2a00:1450:4010:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spQ490y9xzDrFn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 03:54:16 +1100 (AEDT)
Received: by mail-lf0-x230.google.com with SMTP id b75so57723074lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 09:54:16 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <877f9p55lu.fsf@concordia.ellerman.id.au>
References: <20161003161322.3835-1-dvlasenk@redhat.com>
 <CAGXu5j+haCUW_AEPLPcVGtrnv4ojQ79FDpspUurYJSX_-TXeow@mail.gmail.com>
 <877f9p55lu.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 4 Oct 2016 09:54:12 -0700
Message-ID: <CAGXu5jJ3PpvNBYyBWa_M8ELLPuJOcJt-KuH0uRK66peJM_CnSg@mail.gmail.com>
Subject: Re: [PATCH v6] powerpc: Do not make the entire heap executable
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 3, 2016 at 5:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Mon, Oct 3, 2016 at 9:13 AM, Denys Vlasenko <dvlasenk@redhat.com> wrote:
>>> On 32-bit powerpc the ELF PLT sections of binaries (built with --bss-plt,
>>> or with a toolchain which defaults to it) look like this:
> ...
>>>
>>> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
>>> Acked-by: Kees Cook <keescook@chromium.org>
>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> CC: Paul Mackerras <paulus@samba.org>
>>> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>> CC: Kees Cook <keescook@chromium.org>
>>> CC: Oleg Nesterov <oleg@redhat.com>
>>> CC: Michael Ellerman <mpe@ellerman.id.au>
>>> CC: Florian Weimer <fweimer@redhat.com>
>>> CC: linux-mm@kvack.org
>>> CC: linuxppc-dev@lists.ozlabs.org
>>> CC: linux-kernel@vger.kernel.org
>>> ---
>>> Changes since v5:
>>> * made do_brk_flags() error out if any bits other than VM_EXEC are set.
>>>   (Kees Cook: "With this, I'd be happy to Ack.")
>>>   See https://patchwork.ozlabs.org/patch/661595/
>>
>> Excellent, thanks for the v6! Should this go via the ppc tree or the -mm tree?
>
> -mm would be best, given the diffstat I think it's less likely to
>  conflict if it goes via -mm.

Okay, excellent. Andrew, do you have this already in email? I think
you weren't on the explicit CC from the v6...

-Kees

-- 
Kees Cook
Nexus Security

Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rYnK6RXSzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 23:50:44 +1000 (AEST)
Subject: Re: [PATCH bpf-next v3 10/10] tools: bpftool: add delimiters to
 multi-function JITed dumps
To: Sandipan Das <sandipan@linux.vnet.ibm.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: ast@kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 Quentin Monnet <quentin.monnet@netronome.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
 <88b61b11ebca5b44bad0c34225b6f2383e5983a5.1527008647.git.sandipan@linux.vnet.ibm.com>
 <20180522125544.541c68c8@cakuba>
 <2dabfa7f-15b8-236c-7724-33bc3da7e549@iogearbox.net>
 <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <024d9f55-2382-8080-c0c2-e3acfbfb9590@iogearbox.net>
Date: Wed, 23 May 2018 15:50:33 +0200
MIME-Version: 1.0
In-Reply-To: <7142939b-515e-50ac-bc0b-50444bf9cc97@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/23/2018 12:37 PM, Sandipan Das wrote:
[...]
> Other than that, for powerpc64, there is a problem with the way the
> binutils disassembler code (in "opcodes/ppc-dis.c") passes arguments
> to the callback fprintf_json().
> 
> In fprintf_json(), we always expect the va_list elements to resolve
> to strings (char *). But for powerpc64, the register or immediate
> operands are always passed as integers. So, when the code attempts
> to resolve these operands using va_arg(ap, char *), bpftool crashes.
> For now, I am using a workaround based on vsnprintf() but this does
> not get the semantics correct for memory operands. You can probably
> see that for the store instructions in the JSON dump above this.
> 
> Daniel,
> 
> Would it be okay if I send out a fix for this in a different series?

I'm fine either way with regards to the fix. Feels like a portability bug
in the binutils disassembler?

We could probably have a feature test like in test-disassembler-four-args
and select a workaround in bpftool based on that outcome.

Thanks Sandipan!

  [1] tools/build/feature/test-disassembler-four-args.c

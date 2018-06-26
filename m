Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FDxB5fD9zF1Hv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 15:24:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] selftests/powerpc: Fix strncpy usage
In-Reply-To: <1529962249-24774-1-git-send-email-leitao@debian.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <1529962249-24774-1-git-send-email-leitao@debian.org>
Date: Tue, 26 Jun 2018 15:24:13 +1000
Message-ID: <87lgb286iq.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:

> There is a buffer overflow in dscr_inherit_test.c test. In main(), strncpy()'s
> third argument is the length of the source, not the size of the destination
> buffer, which makes strncpy() behaves like strcpy(), causing a buffer overflow
> if argv[0] is bigger than LEN_MAX (100).
>
> This patch allocates 'prog' according to the argv[0] length, avoiding LEN_MAX
> restriction.
>
> CC: Segher Boessenkool <segher@kernel.crashing.org>
> CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
> index 08a8b95e3bc1..ecac4900c7dd 100644
> --- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
> @@ -19,7 +19,7 @@
>   */
>  #include "dscr.h"
>  
> -static char prog[LEN_MAX];
> +static char *prog;
>  
>  static void do_exec(unsigned long parent_dscr)
>  {
> @@ -104,6 +104,13 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	strncpy(prog, argv[0], strlen(argv[0]));
> +	prog = malloc(strlen(argv[0]) + 1);
> +	if (prog == NULL) {
> +		fprintf(stderr, "Unable to allocate enough memory\n");
> +		exit(1);
> +	}
> +
> +	strcpy(prog, argv[0]);

Why do we need to copy it at all?

Can't we just save a pointer it? ie, prog = argv[0];

What am I missing?

cheers

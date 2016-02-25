Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F101A0549
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:30:47 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C18C914031F
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 11:30:46 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id x65so22152082pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 16:30:46 -0800 (PST)
Subject: Re: [PATCH 05/12] powerpc/ftrace: ftrace_graph_caller() needs to
 save/restore toc
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-5-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE4B2E.7070505@gmail.com>
Date: Thu, 25 Feb 2016 11:30:38 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/entry_64.S | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Squash.
>
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 2a7313cfbc7d..9e77a2c8f218 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1237,6 +1237,11 @@ _GLOBAL(ftrace_graph_caller)
>  	std	r5, 64(r1)
>  	std	r4, 56(r1)
>  	std	r3, 48(r1)
> +
> +	/* Save callee's TOC in the ABI compliant location */
> +	std	r2, 24(r1)
R2_STACK_OFFSET for readability?
> +	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
> +
>  	mfctr	r4		/* ftrace_caller has moved local addr here */
>  	std	r4, 40(r1)
>  	mflr	r3		/* ftrace_caller has restored LR from stack */
> @@ -1262,6 +1267,9 @@ _GLOBAL(ftrace_graph_caller)
>  	ld	r4, 56(r1)
>  	ld	r3, 48(r1)
>  
> +	/* Restore callee's TOC */
> +	ld	r2, 24(r1)
> +
>  	addi	r1, r1, 112
>  	mflr	r0
>  	std	r0, LRSAVE(r1)

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Balbir Singh.

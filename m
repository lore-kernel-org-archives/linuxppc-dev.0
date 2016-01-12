Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0F281A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 02:42:29 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0135.hostedemail.com
 [216.40.44.135])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 57532140297
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2016 02:42:28 +1100 (AEDT)
Date: Tue, 12 Jan 2016 10:42:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 amodra@gmail.com, ulrich.weigand@de.ibm.com
Subject: Re: [PATCH 1/2] scripts/recordmcount.pl: support data in text
 section on powerpc
Message-ID: <20160112104223.4317df9c@gandalf.local.home>
In-Reply-To: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
References: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jan 2016 23:14:22 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> 
> If a text section starts out with a data blob before the first
> function start label, disassembly parsing doing in recordmcount.pl
> gets confused on powerpc, leading to creation of corrupted module
> objects.
> 
> This was not a problem so far since the compiler would never create
> such text sections.  However, this has changed with a recent change
> in GCC 6 to support distances of > 2GB between a function and its
> assoicated TOC in the ELFv2 ABI, exposing this problem.
> 
> There is already code in recordmcount.pl to handle such data blobs
> on the sparc64 platform.  This patch uses the same method to handle
> those on powerpc as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  scripts/recordmcount.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Steve can we get an ack for this one, to go via powerpc? cheers

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 826470d7f000..96e2486a6fc4 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -263,7 +263,8 @@ if ($arch eq "x86_64") {
>  
>  } elsif ($arch eq "powerpc") {
>      $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
> -    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?.*?)>:";
> +    # See comment in the sparc64 section for why we use '\w'.
> +    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?\\w*?)>:";
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
>  
>      if ($bits == 64) {

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D03B1A081F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:29:25 +1000 (EST)
Message-ID: <1400545752.3986.93.camel@pasglop>
Subject: Re: [PATCH] selftests: PAGE_SIZE may not be defined
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Thierry Fauck ( thierry @ linux.vnet.ibm.com )"
 <thierry@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 10:29:12 +1000
In-Reply-To: <5374E532.10002@linux.vnet.ibm.com>
References: <5374E532.10002@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org-
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-15 at 18:02 +0200, Thierry Fauck ( thierry @
linux.vnet.ibm.com ) wrote:
> Hi Ben,
> 
> The following patch seems relevant for Ubuntu and Debian distro
> testing.
> I know it's minor but I need to know if you do you care about it or
> sif I should remove it from the bugs info.

You should send it to whoever maintains that file... 

Cheers,
Ben.


> Thanks
> 
> Best regards
> Thierry 
> 
> #---------------------------------------------------------------------------------------------------
> 
> From 48a9a9834377a74b603be12dcc76cda24105e33c Mon Sep 17 00:00:00 2001
> 
> 
> From: Thierry Fauck <thierry@linux.vnet.ibm.com>
> Date: Fri, 28 Feb 2014 16:17:50 +0100
> Subject: [PATCH] selftests: PAGE_SIZE may not be defined
> 
> Some systems have a dynamic PAGE_SIZE value and do not add a
> definition
> for PAGE_SIZE. This value will have to be retrieved using
> getpagesize()
> or sysconf().
> 
> Signed-off-by: Thierry Fauck <thierry@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/ptrace/peeksiginfo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c
> b/tools/testing/selftests/ptrace/peeksiginfo.c
> index d46558b..f2ccbbd 100644
> --- a/tools/testing/selftests/ptrace/peeksiginfo.c
> +++ b/tools/testing/selftests/ptrace/peeksiginfo.c
> @@ -35,7 +35,9 @@ static int sys_ptrace(int request, pid_t pid, void
> *addr, void *data)
>    fprintf(stderr, \
>     "Error (%s:%d): " fmt, \
>     __FILE__, __LINE__, ##__VA_ARGS__)
> -
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE sysconf(_SC_PAGESIZE)
> +#endif
>  static int check_error_paths(pid_t child)
>  {
>   struct ptrace_peeksiginfo_args arg;
> --
> 1.9.0
> 
> -- 
> Thierry Fauck (thierry@linux.vnet.ibm.com)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

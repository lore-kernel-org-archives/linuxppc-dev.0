Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A11041007D9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 09:50:10 +1000 (EST)
Date: Thu, 22 Jul 2010 19:50:08 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] powerpc:  fix .data..init_task output section
Message-ID: <20100722195008.72fe2e71@lappy.seanm.ca>
In-Reply-To: <20100713095024.GA10494@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
	<20100713095024.GA10494@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jul 2010 11:50:24 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> From 851e645a7eee68380caaf026eb6d3be118876370 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 13 Jul 2010 11:39:42 +0200
> Subject: [PATCH] vmlinux.lds: fix .data..init_task output section
> (fix popwerpc boot)
> 
> The .data..init_task output section was missing
> a load offset causing a popwerpc target to fail to boot.
> 
> Sean MacLennan tracked it down to the definition of
> INIT_TASK_DATA_SECTION().
> 
> There are only two users of INIT_TASK_DATA_SECTION()
> in the kernel today: cris and popwerpc.
> cris do not support relocatable kernels and is thus not
> impacted by this change.
> 
> Fix INIT_TASK_DATA_SECTION() to specify load offset like
> all other output sections.
> 
> Reported-by: Sean MacLennan <smaclennan@pikatech.com>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> On the assumption that Sean reports that it fixes
> the warnings/boot issue here is a real patch.
> 
> Ben - will you take it via the popwerpc tree
> or shall I ask Michal to take it via kbuild?
> 
> 	Sam
> 
>  include/asm-generic/vmlinux.lds.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h
> b/include/asm-generic/vmlinux.lds.h index 48c5299..cdfff74 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -435,7 +435,7 @@
>   */
>  #define
> INIT_TASK_DATA_SECTION(align)
> \ . = ALIGN(align);						\
> -	.data..init_task :
> {						\
> +	.data..init_task :  AT(ADDR(.data..init_task) - LOAD_OFFSET)
> {	\
> INIT_TASK_DATA(align)					\ }
>  

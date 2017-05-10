Return-Path: <srs0=l4vm=4q=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNLZq2QnDzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 02:01:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNLZp5tmpz8tnb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 02:01:38 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wNLZn55cwz9s9c
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:01:37 +1000 (AEST)
Date: Wed, 10 May 2017 18:01:32 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Message-ID: <20170510180132.1fa0c1ec@kitsune.suse.cz>
In-Reply-To: <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
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

Hello,

On Wed, 03 May 2017 23:52:52 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> With the introduction of 'fadump_append=' parameter to pass additional
> parameters to fadump (capture) kernel, update documentation about it.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
> 
> Changes from v4:
> * Based on top of patchset that includes
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=05f383cdfba8793240e73f9a9fbff4e25d66003f
> 
> 
>  Documentation/powerpc/firmware-assisted-dump.txt |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
> b/Documentation/powerpc/firmware-assisted-dump.txt index
> 8394bc8..6327193 100644 ---
> a/Documentation/powerpc/firmware-assisted-dump.txt +++
> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7 +162,15
> @@ How to enable firmware-assisted dump (fadump): 
>  1. Set config option CONFIG_FA_DUMP=y and build kernel.
>  2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
> -3. Optionally, user can also set 'crashkernel=' kernel cmdline
> +3. A user can pass additional command line parameters as a comma
> +   separated list through 'fadump_append=' parameter, to be enforced
> +   when fadump is active. For example, if parameters like nr_cpus=1,
> +   numa=off & udev.children-max=2 are to be enforced when fadump is
> +   active, 'fadump_append=nr_cpus=1,numa=off,udev.children-max=2'
> +   can be passed in command line, which will be replaced with
> +   "nr_cpus=1 numa=off udev.children-max=2" when fadump is active.
> +   This helps in reducing memory consumption during dump capture.
> +4. Optionally, user can also set 'crashkernel=' kernel cmdline
>     to specify size of the memory to reserve for boot memory dump
>     preservation.
>  
> 

Writing your own deficient parser for comma separated arguments when
perfectly fine parser for space separated quoted arguments exists in
the kernel and the bootloader does not seem like a good idea to me.

I also do not see how this addresses 

On Wed, 26 Apr 2017 20:32:55 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/fadump.c
> > b/arch/powerpc/kernel/fadump.c index 8ff0dd4..87edc7b 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -338,6 +343,36 @@ unsigned long __init
> > arch_reserved_kernel_pages(void) return memblock_reserved_size() /
> > PAGE_SIZE; }
> >  
> > +static void __init parse_fadump_append_params(const char *p)
> > +{
> > +	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
> > +	char *token;
> > +
> > +	strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
> > +	token = strchr(fadump_cmdline, ',');
> > +	while (token) {
> > +		*token = ' ';
> > +		token = strchr(token, ',');
> > +	}
> > +
> > +	pr_info("enforcing additional parameters (%s) passed
> > through "
> > +		"'fadump_append=' parameter\n", fadump_cmdline);
> > +	parse_early_options(fadump_cmdline);  
> 
> Using parse_early_options() means it only works for parameters defined
> with early_param() or __setup() doesn't it?
> 
> That might be OK but at least you need to clearly document it.

which was your gripe with v4 of the patchset. Unfortunately the flags
in Documentation/kernel-parameters.txt do not include a flag that
denotes parameters available with parse_early_options - unless it is
the KNL flag and is quite bitrotten.

Thanks

Michal

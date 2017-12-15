Return-Path: <srs0=gpzr=dl=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz2f5458YzDqhd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:51:25 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yz2f5389Zz8tMk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:51:25 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yz2f46PNcz9sCZ
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2017 07:51:24 +1100 (AEDT)
Date: Fri, 15 Dec 2017 21:51:21 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Andrew Morton
 <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 1/8] lib/cmdline.c: remove quotes symmetrically
Message-ID: <20171215215121.0560e669@kitsune.suse.cz>
In-Reply-To: <151075900967.14434.2860376398321506569.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
 <151075900967.14434.2860376398321506569.stgit@hbathini.in.ibm.com>
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

On Wed, 15 Nov 2017 20:46:56 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> From: Michal Suchanek <msuchanek@suse.de>
> 
> Remove quotes from argument value only if there is qoute on both
> sides.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  lib/cmdline.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 171c19b..6d398a8 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -227,14 +227,12 @@ char *next_arg(char *args, char **param, char
> **val) *val = args + equals + 1;
>  
>  		/* Don't include quotes in value. */
> -		if (**val == '"') {
> -			(*val)++;
> -			if (args[i-1] == '"')
> -				args[i-1] = '\0';
> +		if ((args[i-1] == '"') && ((quoted) || (**val ==
> '"'))) {
> +			args[i-1] = '\0';
> +			if (!quoted)
> +				(*val)++;
>  		}
>  	}
> -	if (quoted && args[i-1] == '"')
> -		args[i-1] = '\0';
>  
>  	if (args[i]) {
>  		args[i] = '\0';
> 

This was only useful as separate patch with the incremental fadump
update. Since the fadump update is squashed in this refresh series this
can be squashed with the following lib/cmdline patch as well.

Thanks

Michal

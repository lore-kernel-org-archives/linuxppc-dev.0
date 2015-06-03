Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B08E1A0D3A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:32:11 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:32:04 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v13 04/14] perf, tools: Allow events with dot
Message-ID: <20150603103204.GI1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:04AM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel events use a dot to separate event name and unit mask.
> Allow dot in names in the scanner, and remove special handling
> of dot as EOF. Also remove the hack in jevents to replace dot
> with underscore. This way dotted events can be specified
> directly by the user.
> 
> I'm not fully sure this change to the scanner is correct
> (what was the dot special case good for?), but I haven't
> found anything that breaks with it so far at least.

can't see anything either

Robert,
does it ring a bell? seems like you introduced it ;-)

thanks,
jirka


> 
> V2: Add the dot to name too, to handle events outside cpu//
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/parse-events.l |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 09e738f..13cef3c 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -119,8 +119,8 @@ event		[^,{}/]+
>  num_dec		[0-9]+
>  num_hex		0x[a-fA-F0-9]+
>  num_raw_hex	[a-fA-F0-9]+
> -name		[a-zA-Z_*?][a-zA-Z0-9_*?]*
> -name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?]*
> +name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
> +name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.]*
>  /* If you add a modifier you need to update check_modifier() */
>  modifier_event	[ukhpGHSDI]+
>  modifier_bp	[rwx]{1,3}
> @@ -165,7 +165,6 @@ modifier_bp	[rwx]{1,3}
>  			return PE_EVENT_NAME;
>  		}
>  
> -.		|
>  <<EOF>>		{
>  			BEGIN(INITIAL);
>  			REWIND(0);
> -- 
> 1.7.9.5
> 

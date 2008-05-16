Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	by ozlabs.org (Postfix) with ESMTP id 4A38DDDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 19:21:28 +1000 (EST)
Date: Fri, 16 May 2008 09:46:02 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Discourage use of __initcall() in favour of
	device_initcall()
Message-ID: <20080516084602.GA28298@shadowen.org>
References: <547098715b7ba4beb99bf2674a22debca001dc68.1210902536.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547098715b7ba4beb99bf2674a22debca001dc68.1210902536.git.michael@ellerman.id.au>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	rpjday@crashcourse.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 11:49:14AM +1000, Michael Ellerman wrote:
> Add a comment above the definition of __initcall(), just in case
> someone looks here.
> 
> And add a checkpatch warning for new uses of __initcall().
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
> How's this? My perl skills are not good, but this seems to work.
> 
>  include/linux/init.h  |    1 +
>  scripts/checkpatch.pl |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 21d658c..6390e22 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -193,6 +193,7 @@ extern void (*late_time_init)(void);
>  #define late_initcall(fn)		__define_initcall("7",fn,7)
>  #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
>  
> +/* Please use device_initcall() directly in new code */
>  #define __initcall(fn) device_initcall(fn)
>  
>  #define __exitcall(fn) \
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b6bbbcd..3faff3f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2026,6 +2026,10 @@ sub process {
>  		if ($line =~ /\bsimple_(strto.*?)\s*\(/) {
>  			WARN("consider using strict_$1 in preference to simple_$1\n" . $herecurr);
>  		}
> +# check for __initcall(), use device_initcall() explicitly please
> +		if ($line =~ /^.\s*__initcall\(/) {

Well you should probabally allow spaces before the ( but otherwise its
in the spirit.

Checkpatch has its own tree as it has an extensive regression test
suite.  So I'll suck this half up into my tree and it'll be in the 0.20
update.

> +			WARN("please use device_initcall() instead of __initcall()\n" . $herecurr);
> +		}
>  
>  # use of NR_CPUS is usually wrong
>  # ignore definitions of NR_CPUS and usage to define arrays as likely right

-apw

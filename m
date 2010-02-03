Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33047B7D47
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 10:22:05 +1100 (EST)
Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on
	unsigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
References: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 10:21:27 +1100
Message-ID: <1265239287.8287.125.camel@pasglop>
Mime-Version: 1.0
Cc: gorcunov@gmail.com, linuxppc-dev@ozlabs.org, roel.kluin@gmail.com,
	waite@skycomputers.com, galak@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-02-02 at 14:40 -0800, akpm@linux-foundation.org wrote:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> count is unsigned and cannot be less than 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Kumar Gala <galak@gate.crashing.org>
> Cc: Brian Waite <waite@skycomputers.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

I still have a hard time figuring out what this sky CPU actually is :-) 

The whole drivers/misc/hdpuftrs is only built when CONFIG_HDPU_FEATURES
is set and git grep HDPU_FEATURES doesn't show anybody ever setting
it :-)

Is that just dead code ? I'm happy to carry it in powerpc.git if you
wish so but you it would be nice to figure out what's going on there...

Cheers,
Ben.

>  drivers/misc/hdpuftrs/hdpu_cpustate.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff -puN drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned drivers/misc/hdpuftrs/hdpu_cpustate.c
> --- a/drivers/misc/hdpuftrs/hdpu_cpustate.c~powerpc-sky-cpu-redundant-or-incorrect-tests-on-unsigned
> +++ a/drivers/misc/hdpuftrs/hdpu_cpustate.c
> @@ -121,8 +121,6 @@ static ssize_t cpustate_read(struct file
>  {
>  	unsigned char data;
>  
> -	if (count < 0)
> -		return -EFAULT;
>  	if (count == 0)
>  		return 0;
>  
> @@ -137,9 +135,6 @@ static ssize_t cpustate_write(struct fil
>  {
>  	unsigned char data;
>  
> -	if (count < 0)
> -		return -EFAULT;
> -
>  	if (count == 0)
>  		return 0;
>  
> _

Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8BD02C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 05:55:53 +1100 (EST)
Date: Mon, 10 Dec 2012 18:55:27 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: Shuah Khan <shuah.khan@hp.com>
Message-ID: <20121210185527.GI13292@decadent.org.uk>
References: <1354932445.7407.15.camel@lorien2>
 <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
 <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
 <1355160196.2739.12.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1355160196.2739.12.camel@lorien2>
Subject: Re: [PATCH v2] powerpc: fix wii_memory_fixups() compile error on
 3.0.y tree
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>,
 paulus@samba.org, shuahkhan@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2012 at 10:23:16AM -0700, Shuah Khan wrote:
> Fix wii_memory_fixups() the following compile error on 3.0.y tree with 
> wii_defconfig on 3.0.y tree.
> 
>   CC      arch/powerpc/platforms/embedded6xx/wii.o
> arch/powerpc/platforms/embedded6xx/wii.c: In function ‘wii_memory_fixups’:
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
> make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
> make: *** [arch/powerpc/platforms] Error 2
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> CC: stable@vger.kernel.org 3.0.y
> ---
>  arch/powerpc/platforms/embedded6xx/wii.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> index 1b5dc1a..d8ff38f 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -85,9 +85,11 @@ void __init wii_memory_fixups(void)
>  	wii_hole_start = p[0].base + p[0].size;
>  	wii_hole_size = p[1].base - wii_hole_start;
>  
> -	pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
> +	pr_info("MEM1: <%08ulx %08ulx>\n",
> +		(phys_addr_t) p[0].base, (phys_addr_t) p[0].size);
[...]

This is incorrect in exactly the same way as the last version,
but with extra redundant casts.

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus

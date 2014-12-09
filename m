Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E833E1A05D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:29:59 +1100 (AEDT)
Message-ID: <1418102997.527.3.camel@concordia>
Subject: Re: [PATCH] arch: powerpc: kernel: vio.c:  Remove unused function
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Tue, 09 Dec 2014 16:29:57 +1100
In-Reply-To: <1417991502-20223-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1417991502-20223-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Daniel Walter <dwalter@google.com>,
 Alistair Popple <alistair@popple.id.au>,
 Grant Likely <grant.likely@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-12-07 at 23:31 +0100, Rickard Strandqvist wrote:
> Remove the function cmo_high_show() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  arch/powerpc/kernel/vio.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 5bfdab9..11657d2 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1032,11 +1032,6 @@ viobus_cmo_pool_rd_attr(reserve, size);
>  viobus_cmo_pool_rd_attr(excess, size);
>  viobus_cmo_pool_rd_attr(excess, free);
>  
> -static ssize_t cmo_high_show(struct bus_type *bt, char *buf)
> -{
> -	return sprintf(buf, "%lu\n", vio_cmo.high);
> -}


from ../arch/powerpc/kernel/vio.c:17:
../arch/powerpc/kernel/vio.c:1046:20: error: 'cmo_high_show' undeclared here (not in a function)
static BUS_ATTR_RW(cmo_high);
^
../include/linux/sysfs.h:76:10: note: in definition of macro '__ATTR'
.show = _show,      \
^
../include/linux/device.h:53:42: note: in expansion of macro '__ATTR_RW'
struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
^
../arch/powerpc/kernel/vio.c:1046:8: note: in expansion of macro 'BUS_ATTR_RW'
static BUS_ATTR_RW(cmo_high);
^

cheers

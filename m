Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 850D0B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:01:58 +1000 (EST)
Subject: Re: [PATCH 14/14] arm/include/asm/io.h : added macros to
	read/write big/little endian register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pratyush Anand <pratyush.anand@st.com>
In-Reply-To: <335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Sep 2011 21:01:43 +1000
Message-ID: <1314961303.13112.1.camel@pasglop>
Mime-Version: 1.0
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-30 at 17:28 +0530, Pratyush Anand wrote:
> There are some peripheral(e.g dwc otg) whose registers can be configured to
> work in either little or big endian mode. Therefor macros like out_be32,
> in_be32, out_le32 and in_le32 have been added to support such peripherals.

Yuck.

Don't copy those ppc specific historical accessors :-)

Doesn't arm have writel_be ? If not , define those, it's a bit more
common, or better, switch to the newer iomap variants which should be
provided in both endianness.

Cheers,
Ben.


> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  arch/arm/include/asm/io.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 815efa2..32282b4 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -297,6 +297,14 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
>  extern int devmem_is_allowed(unsigned long pfn);
>  #endif
>  
> +/* Big Endian */
> +#define out_be32(a, v) writel(__cpu_to_be32(v), a)
> +#define in_be32(a) __be32_to_cpu(readl(a))
> +
> +/* Little endian */
> +#define out_le32(a, v) writel(__cpu_to_le32(v), a)
> +#define in_le32(a) __le32_to_cpu(readl(a))
> +
>  /*
>   * Convert a physical pointer to a virtual kernel pointer for /dev/mem
>   * access

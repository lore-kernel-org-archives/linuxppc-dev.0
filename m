Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 717802C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 08:03:45 +1100 (EST)
Date: Wed, 8 Jan 2014 20:57:54 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 2/3] ARM: kernel: add support for cpu cache information
Message-ID: <20140108205754.GN27432@n2100.arm.linux.org.uk>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
 Rob Herring <robh@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 07:26:07PM +0000, Sudeep Holla wrote:
> +#if __LINUX_ARM_ARCH__ < 7 /* pre ARMv7 */
> +
> +#define MAX_CACHE_LEVEL		1	/* Only 1 level supported */
> +#define CTR_CTYPE_SHIFT		24
> +#define CTR_CTYPE_MASK		(1 << CTR_CTYPE_SHIFT)
> +
> +static inline unsigned int get_ctr(void)
> +{
> +	unsigned int ctr;
> +	asm volatile ("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
> +	return ctr;
> +}
> +
> +static enum cache_type get_cache_type(int level)
> +{
> +	if (level > MAX_CACHE_LEVEL)
> +		return CACHE_TYPE_NOCACHE;
> +	return get_ctr() & CTR_CTYPE_MASK ?
> +		CACHE_TYPE_SEPARATE : CACHE_TYPE_UNIFIED;

So, what do we do for CPUs that don't implement the CTR?  Just return
random rubbish based on decoding the CPU Identity register as if it
were the cache type register?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

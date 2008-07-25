Return-Path: <ntl@pobox.com>
Date: Fri, 25 Jul 2008 17:00:38 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: can't boot mpc5200, powerpc: Enable AT_BASE_PLATFORM aux vector
Message-ID: <20080725220038.GI9594@localdomain>
References: <9e4733910807251451s623b87cetcf7ed5ff6a12f012@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807251451s623b87cetcf7ed5ff6a12f012@mail.gmail.com>
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> I've lost my ability to boot on the mpc5200. Reverting this patch fixes it.

How does it fail?


> @@ -1652,6 +1655,14 @@ struct cpu_spec * __init identify_cpu(unsigned
> long offset, unsigned int pvr)
>  			} else
>  				*t = *s;
>  			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
> +
> +			/*
> +			 * Set the base platform string once; assumes
> +			 * we're called with real pvr first.
> +			 */
> +			if (powerpc_base_platform == NULL)
> +				powerpc_base_platform = t->platform;
> +

Hmm, maybe this needs RELOC/PTRRELOC tricks?

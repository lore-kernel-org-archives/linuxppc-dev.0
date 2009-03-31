Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49D1C624.2050502@grandegger.com>
References: <49D1C624.2050502@grandegger.com>
Date: Tue, 31 Mar 2009 01:33:37 -0600
Message-ID: <fa686aa40903310033n4284ab8l35147ee6f8b0db63@mail.gmail.com>
Subject: Re: Inconsistent fsl_get_sys_freq() implementation
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 1:28 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>
> Hello,
>
> we realized an inconsistent implementation of fsl_get_sys_freq():
>
> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>
> For 826x and 827x boards, the function is available but it cannot be
> used because the "bus-frequency" property is not defined for the SOC and
> U-Boot also does not try to do a fixup. I think that's a mistake, and
> the DTS files and U-Boot should be fixed, right?
> Furthermore, I find the name confusing. fsl_get_soc_bus_freq() would be
> more appropriate also to distinguish from the frequencies of the CPU.
> And why does the MPC52xx use a different name mpc52xx_find_ipb_freq()
> for that frequency? It makes support for common hardware like I2C awkward.

I haven't looked at fsl_get_soc_bus_freq(), but if the functions are
duplicated, then I've got no problem changing the 52xx support to use
common code.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

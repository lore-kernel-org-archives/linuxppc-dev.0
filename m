Return-Path: <wg@grandegger.com>
Message-ID: <49D1C624.2050502@grandegger.com>
Date: Tue, 31 Mar 2009 09:28:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>
Subject: Inconsistent fsl_get_sys_freq() implementation
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

we realized an inconsistent implementation of fsl_get_sys_freq():

http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80

For 826x and 827x boards, the function is available but it cannot be
used because the "bus-frequency" property is not defined for the SOC and
U-Boot also does not try to do a fixup. I think that's a mistake, and
the DTS files and U-Boot should be fixed, right?
Furthermore, I find the name confusing. fsl_get_soc_bus_freq() would be
more appropriate also to distinguish from the frequencies of the CPU.
And why does the MPC52xx use a different name mpc52xx_find_ipb_freq()
for that frequency? It makes support for common hardware like I2C awkward.

Thanks.

Wolfgang.

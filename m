Return-Path: <julia@diku.dk>
Date: Wed, 1 Sep 2010 17:51:10 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: question about arch/powerpc/platforms/cell/celleb_scc_uhc.c
Message-ID: <Pine.LNX.4.64.1009011748050.32566@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, joe@perches.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The file arch/powerpc/platforms/cell/celleb_scc_uhc.c contains the 
following function:

static inline int uhc_clkctrl_ready(u32 val)
{
        const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
        return((val & mask) == mask);
}

The variable mask is a bit or of two identical constants.  Later in the 
same file in the function enable_scc_uhc, I see the code:

val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);

Should the code in uhc_clkctrl_ready also be SCC_UHC_USBCEN | SCC_UHC_USBEN?
Or something else?

thanks,
julia

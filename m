Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNvJb35dpzDw1y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:35:43 +1100 (AEDT)
Date: Wed, 23 Nov 2016 01:35:28 -0600
From: Scott Wood <oss@buserror.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org, pku.leo@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <20161123073528.GA3785@home.buserror.net>
References: <1475032531-10263-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475032531-10263-1-git-send-email-qiang.zhao@nxp.com>
Subject: Re: [v7] QE: remove PPCisms for QE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 11:15:31AM +0800, Zhao Qiang wrote:
> QE was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms. so remove PPCisms.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---

Changelog should be something like:

soc/fsl/qe: Cleanups and portability fixes

QE was supported on PowerPC, and dependent on PPC.  In preparation for
supporting on other platforms, remove some PPCisms.

The PPC kconfig dependency is moved from the QE core into the individual
QE peripheral drivers, to allow portability work to occur on them
separately.
    
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index 70339d7..f7a14f2 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -21,7 +21,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> -#include <asm/cpm.h>
>  #include <soc/fsl/qe/immap_qe.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>

When building corenet32_smp_defconfig, I get this:

/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:262:31: error: 'BD_SC_READY' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:266:31: error: 'BD_SC_WRAP' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:348:3: error: 'BD_SC_READY' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:350:31: error: 'BD_SC_WRAP' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:477:16: error: 'BD_SC_EMPTY' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:501:9: error: 'BD_SC_BR' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:501:20: error: 'BD_SC_FR' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:501:31: error: 'BD_SC_PR' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:501:42: error: 'BD_SC_OV' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:512:3: error: 'BD_SC_ID' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:514:31: error: 'BD_SC_WRAP' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:605:26: error: 'BD_SC_EMPTY' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:605:40: error: 'BD_SC_INTRPT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:613:25: error: 'BD_SC_WRAP' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:926:27: error: 'BD_SC_EMPTY' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:926:41: error: 'BD_SC_OV' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:928:29: error: 'BD_SC_FR' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:928:40: error: 'BD_SC_PR' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/drivers/tty/serial/ucc_uart.c:930:29: error: 'BD_SC_BR' undeclared (first use in this function)

-Scott

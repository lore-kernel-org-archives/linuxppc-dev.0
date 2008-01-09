Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id A802BDE0FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 05:07:32 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so244172agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jan 2008 10:07:31 -0800 (PST)
Message-ID: <fa686aa40801091007h4bc65804h9a7b562a49478deb@mail.gmail.com>
Date: Wed, 9 Jan 2008 11:07:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: Linux for ml310
In-Reply-To: <524275432@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <524275432@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/9/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi again
>
> In which xparams* files should i look for the right definition?
> In the xparameters.h from the BSP I can't find it, it looks like this:
> -------------------------------------------------------------------
> /*
>  * include/asm-ppc/xparameters.h
>  *
>  * This file includes the correct xparameters.h for the CONFIG'ed board
>  *
>  * Author: MontaVista Software, Inc.
>  *         source@mvista.com
>  *
>  * 2004 (c) MontaVista Software, Inc.  This file is licensed under the terms
>  * of the GNU General Public License version 2.  This program is licensed
>  * "as is" without any warranty of any kind, whether express or implied.
>  */
>
> #include <linux/config.h>
>
> #if defined(CONFIG_XILINX_ML300)
> #include <platforms/4xx/xparameters/xparameters_ml300.h>

<--- Add fixups here.

> #endif
> #if defined(CONFIG_XILINX_ML40x)
> #include <platforms/4xx/xparameters/xparameters_ml40x.h>
> #endif

The fixups should look like this:

#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ \
                XPAR_<real-name-from-xparams-ml300>_FREQ_HZ
#define XPAR_INTC_0_UARTNS550_0_VEC_ID \
                XPAR_<real-name-from-xparams-ml300>_VEC_ID
#define XPAR_UARTNS550_0_BASEADDR \
                XPAR_<real-name-from-xparams-ml300>_BASEADDR

Note: when you generate the EDK bsp, *make sure* you generated it for
the "linux 2.6" target; not "standalone".  If you don't then
xparams_ml300 will be missing stuff.

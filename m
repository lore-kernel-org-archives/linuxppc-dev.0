Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6911A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 09:30:36 +1100 (AEDT)
Date: Tue, 15 Dec 2015 17:29:50 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, Anton
 Blanchard <anton@samba.org>,
 David Brown <davidb@codeaurora.org>, Jiri Slaby <jslaby@suse.com>,
 Kumar Gala <galak@codeaurora.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicolas
 Ferre <nicolas.ferre@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-serial@vger.kernel.org>,
 <linux-soc@vger.kernel.org>
Subject: Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Message-ID: <20151215222950.GH2772@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[[PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 18/10/2015 (Sun 18:21) Paul Gortmaker wrote:

> This next set of patches to drivers/tty fixes up more drivers that would
> perhaps appear modular when looking at the code, but are controlled by
> a bool Kconfig.  We make sure they don't look modular and get rid
> of module related code in the drivers that would never be used.

[...]

> Paul Gortmaker (5):
>   drivers/tty: make hvc/hvc_vio.c explicitly non-modular
>   drivers/tty: make ehv_bytechan.c explicitly non-modular
>   drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
>   drivers/tty/serial: make msm_serial.c explicitly non-modular
>   drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular

Hi Greg,

You've merged the #3 atmel patch and #5 the 8250_mtk patch; the msm_serial
patch (#4) is no longer applicable since the authors changed it to tristate.

That leaves the top two patches; both for PPC hardware.  Did you skip
those because you wanted them pushed through the powerpc tree?

If so, that is fine, I can do that.  Just let me know.

Thanks,
Paul.
--

> 
>  drivers/tty/ehv_bytechan.c         | 40 +++------------------------------
>  drivers/tty/hvc/hvc_vio.c          | 29 ++++--------------------
>  drivers/tty/serial/8250/8250_mtk.c | 35 ++++++-----------------------
>  drivers/tty/serial/atmel_serial.c  | 45 ++++----------------------------------
>  drivers/tty/serial/msm_serial.c    | 30 ++++---------------------
>  5 files changed, 22 insertions(+), 157 deletions(-)
> 
> -- 
> 2.6.1
> 

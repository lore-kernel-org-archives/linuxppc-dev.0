Return-Path: <julian.calaby@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC39E1A0741
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 09:28:12 +1100 (AEDT)
Received: by wibgn9 with SMTP id gn9so83897658wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2015 15:28:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427871888-27331-2-git-send-email-joel@jms.id.au>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
 <1427871888-27331-2-git-send-email-joel@jms.id.au>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 2 Apr 2015 09:27:48 +1100
Message-ID: <CAGRGNgUBy0gRZADXmbFzmcAGEf-en=D-rD4Cjoh67Y=iF8puvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: rusty@rustcorp.com.au,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabian Frederick <fabf@skynet.be>, jk@ozlabs.org,
 sparclinux <sparclinux@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joel,

On Wed, Apr 1, 2015 at 6:04 PM, Joel Stanley <joel@jms.id.au> wrote:
> The kernel has orderly_poweroff which allows the kernel to initiate a
> graceful shutdown of userspace, by running /sbin/poweroff. This adds
> orderly_reboot that will cause userspace to shut itself down by calling
> /sbin/reboot.
>
> This will be used for shutdown initiated by a system controller on
> platforms that do not use ACPI.
>
> orderly_reboot() should be used when the system wants to allow userspace
> to gracefully shut itself down. For cases where the system may
> imminently catch on fire, the existing emergency_restart() provides an
> immediate reboot without involving userspace.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> V2:
>  - remove unused return value from orderly_*
>  - use correct command in orderly_poweroff
>  - the reboot command will not have a proc knob to control it, so
>    it can be made const and static
>
>  include/linux/reboot.h |  3 ++-
>  kernel/reboot.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 48bf152..dc5e3bd 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -67,7 +67,8 @@ void ctrl_alt_del(void);
>  #define POWEROFF_CMD_PATH_LEN  256
>  extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
>
> -extern int orderly_poweroff(bool force);
> +extern void orderly_poweroff(bool force);

Should making orderly_poweroff() void be in a separate patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

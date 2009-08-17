Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05F0CB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 23:53:43 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 76766DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 23:53:41 +1000 (EST)
Date: Mon, 17 Aug 2009 17:53:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Message-ID: <20090817135337.GA6251@oksana.dev.rtsoft.ru>
References: <20090814222453.GA9568@oksana.dev.rtsoft.ru>
	<20090814222549.GD14458@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090814222549.GD14458@oksana.dev.rtsoft.ru>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 15, 2009 at 02:25:49AM +0400, Anton Vorontsov wrote:
[....]
> +#ifdef CONFIG_CPM
>  int cpm_command(u32 command, u8 opcode);
> +#else
> +static inline int cpm_command(u32 command, u8 opcode)
> +{
> +	return -ENOSYS;
> +}
> +#endif /* CONFIG_CPM */

It appers that fsl_qe_udc.h defines its own inlined version, and so
fsl_qe_udc.c's build breaks:

In file included from drivers/usb/gadget/fsl_qe_udc.c:44:
fsl_qe_udc.h:432: error: redefinition of ‘qe_issue_cmd’
arch/powerpc/include/asm/qe.h:153: error: previous definition of ‘qe_issue_cmd’ was here

I didn't notice that earlier because USB_GADGET_FSL_QE isn't enabled
in any defconfig.

I'll send v2 soon.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

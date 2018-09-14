Return-Path: <srs0=r/+u=l4=suse.cz=ptesarik@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BdDD4ZhxzF3WZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 00:28:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42BdDC6lL6z8wTg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 00:28:27 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42BdDC2Pppz9s1x
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2018 00:28:27 +1000 (AEST)
Date: Fri, 14 Sep 2018 16:28:22 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH] powerpc/fadump: re-register firmware-assisted dump if
 already registered
Message-ID: <20180914162822.6b489d57@ezekiel.suse.cz>
In-Reply-To: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
References: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2018 19:36:02 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> Firmware-Assisted Dump (FADump) needs to be registered again after any
> memory hot add/remove operation to update the crash memory ranges. But
> currently, the kernel returns '-EEXIST' if we try to register without
> uregistering it first. This could expose the system to racing issues
> while unregistering and registering FADump from userspace during udev
> events. Spare the userspace of this and let it be taken care of in the
> kernel space for a simpler interface.
> 
> Since this change, running 'echo 1 > /sys/kernel/fadump_registered'
> would result in re-regisering (unregistering and registering) FADump,
> if it was already registered.

Great improvement to the API!

Any suggestions what should be done in a client which tries to be
compatible with kernels before this change and after this change?

Petr T

> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index a711d22..761b28b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1444,8 +1444,8 @@ static ssize_t fadump_register_store(struct kobject *kobj,
>  		break;
>  	case 1:
>  		if (fw_dump.dump_registered == 1) {
> -			ret = -EEXIST;
> -			goto unlock_out;
> +			/* Un-register Firmware-assisted dump */
> +			fadump_unregister_dump(&fdm);
>  		}
>  		/* Register Firmware-assisted dump */
>  		ret = register_fadump();
> 

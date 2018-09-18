Return-Path: <srs0=hxr8=ma=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F85d38FhzF3CZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:46:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42F85d1XLhz8xJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:46:29 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42F85c3BtHz9s9G
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2018 02:46:27 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8IGfLT5026445
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2018 12:48:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mk32wpywp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2018 12:48:26 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 18 Sep 2018 17:46:22 +0100
Subject: Re: [PATCH] powerpc/fadump: re-register firmware-assisted dump if
 already registered
To: Hari Bathini <hbathini@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>,
 Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 18 Sep 2018 22:16:17 +0530
MIME-Version: 1.0
In-Reply-To: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <05238fb0-6c4d-338f-0027-8564b477f56c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2018 07:36 PM, Hari Bathini wrote:
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
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Looks good to me.

Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

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

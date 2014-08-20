Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5D8E1A004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 10:20:47 +1000 (EST)
Message-ID: <1408494032.4058.61.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/4] powerpc/fsl_msi: spread msi ints across different
 MSIRs
From: Scott Wood <scottwood@freescale.com>
To: Laurentiu Tudor <b10716@freescale.com>
Date: Tue, 19 Aug 2014 19:20:32 -0500
In-Reply-To: <53F33413.3050009@freescale.com>
References: <53F33413.3050009@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A couple nits that don't necessarily warrant a respin:

On Tue, 2014-08-19 at 14:25 +0300, Laurentiu Tudor wrote:
> Allocate msis such that each time a new
> interrupt is requested, the SRS (MSIR
> register select) to be used is allocated
> in a round-robin fashion.
> The end result is that the msi interrupts
> will be spread across distinct MSIRs with
> the main benefit that now users can set
> affinity to each msi int through the mpic
> irq backing up the MSIR register.
> This is achieved with the help of a newly
> introduced msi bitmap api that allows
> specifying the starting point when
> searching for a free msi interrupt.

Please wrap at around 60-70 columns.

> +			} else {
> +				off = (atomic_inc_return(&msi_data->msi_alloc_cnt) %
> +					msi_data->msir_num);
> +				off *= (1 << msi_data->srs_shift);

This is an unusual way to write "off <<= msi->data->srs_shift"...

-Scott

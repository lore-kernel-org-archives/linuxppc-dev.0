Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Rss6KVCzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 23:07:13 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arvind Yadav' <arvind.yadav.cs@gmail.com>, "zajec5@gmail.com"
 <zajec5@gmail.com>, "leoli@freescale.com" <leoli@freescale.com>
CC: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux@roeck-us.net" <linux@roeck-us.net>
Subject: RE: [v5.1] ucc_fast: Fix to avoid IS_ERR_VALUE abuses and dead code
 on 64bit systems.
Date: Fri, 5 Aug 2016 13:04:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50B336@AcuExch.aculab.com>
References: <1470329563-5464-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1470329563-5464-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arvind Yadav
> Sent: 04 August 2016 17:53
> IS_ERR_VALUE() assumes that parameter is an unsigned long.
> It can not be used to check if 'unsigned int' is passed insted.
> Which tends to reflect an error.
> In 64bit architectures sizeof (int) =3D=3D 4 && sizeof (long) =3D=3D 8.
> IS_ERR_VALUE(x) is ((x) >=3D (unsigned long)-4095).
> IS_ERR_VALUE() of 'unsigned int' is always false because the 32bit
> value is zero extended to 64 bits.
>=20
> Now Problem In UCC fast protocols -: drivers/soc/fsl/qe/ucc_fast.c
>=20
>         /* Allocate memory for Tx Virtual Fifo */
>         uccf->ucc_fast_tx_virtual_fifo_base_offset =3D
>           qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT=
);
>         if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
>                 printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n"=
,
>                         __func__);
>                 uccf->ucc_fast_tx_virtual_fifo_base_offset =3D 0;
>                 ucc_fast_free(uccf);
>                 return -ENOMEM;
>         }
>=20
>         /* Allocate memory for Rx Virtual Fifo */
>         uccf->ucc_fast_rx_virtual_fifo_base_offset =3D
>            qe_muram_alloc(uf_info->urfs +
>                            UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTO=
R,
>                            UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>         if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
>                 printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n"=
,
>                         __func__);
>                 uccf->ucc_fast_rx_virtual_fifo_base_offset =3D 0;
>                 ucc_fast_free(uccf);
>                 return -ENOMEM;
>         }
>=20
> qe_muram_alloc (a.k.a. cpm_muram_alloc) returns unsigned long.
> Return value store in a u32 (ucc_fast_tx_virtual_fifo_base_offset
> and ucc_fast_rx_virtual_fifo_base_offset).If qe_muram_alloc will
> return any error, Then IS_ERR_VALUE will always return 0. it'll not
> call ucc_fast_free for any failure. Inside 'if code' will be a dead
> code on 64bit.
> This patch is to avoid this problem on 64bit machine.

That is really far too wordy for a commit message.

My suspicion is that qe_muram_alloc() always returns a value that is much
less than 2^32 - even though the return type is 'long'.

Looking further all this code is a bag of worms.

The 'fail' return value from qe_muram_alloc() (aka cpm_muram_alloc()) is
never returned to an outer level.
It might be better to return a constant CPM_MURAL_ALLOC_FAIL (say 0x7ffffff=
f)
and have the callers check that (via a #define).

That is only the start of the problems...

It looks very likely that cpm_muram_free() will be called in tidy up paths
when cpm_muram_alloc() either failed, or hasn't been called.
Since 0 is a valid return value, and there is no check for -ENOMEM it is
all an 'accident waiting to happen'.

>From my quick scan (grep -B2 -A6) I'm not at all sure most of the error pat=
hs
at best leak memory.

	David

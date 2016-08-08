Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7L2S2W8szDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 00:51:12 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arvind Yadav' <arvind.yadav.cs@gmail.com>, "zajec5@gmail.com"
 <zajec5@gmail.com>, "leoli@freescale.com" <leoli@freescale.com>
CC: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [5.3] ucc_geth: Fix to avoid IS_ERR_VALUE abuses and dead code
 on 64bit systems.
Date: Mon, 8 Aug 2016 14:49:11 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50C493@AcuExch.aculab.com>
References: <1470386442-7208-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1470386442-7208-1-git-send-email-arvind.yadav.cs@gmail.com>
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

From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org] On=
 Behalf Of Arvind Yadav
> IS_ERR_VALUE() assumes that parameter is an unsigned long.
> It can not be used to check if 'unsigned int' is passed insted.
> Which tends to reflect an error.
> In 64bit architectures sizeof (int) =3D=3D 4 && sizeof (long) =3D=3D 8.
> IS_ERR_VALUE(x) is ((x) >=3D (unsigned long)-4095).
> IS_ERR_VALUE() of 'unsigned int' is always false because the 32bit
> value is zero extended to 64 bits.

You are being far too wordy above, and definitely below.

>=20
> Now problem in Freescale QEGigabit Ethernet-:
>                                  drivers/net/ethernet/freescale/ucc_geth.=
c
>=20
...
>          qe_muram_addr(init_enet_pram_offset);
>=20
> qe_muram_alloc (a.k.a. cpm_muram_alloc) returns unsigned long.
> Return value store in a u32 (init_enet_offset, exf_glbl_param_offset,
> rx_glbl_pram_offset, tx_glbl_pram_offset, send_q_mem_reg_offset,
> thread_dat_tx_offset, thread_dat_rx_offset, scheduler_offset,
> tx_fw_statistics_pram_offset, rx_fw_statistics_pram_offset,
> rx_irq_coalescing_tbl_offset, rx_bd_qs_tbl_offset, tx_bd_ring_offset,
> init_enet_pram_offset and rx_bd_ring_offset).

Inpenetrable...

> If qe_muram_alloc will return any error, Then IS_ERR_VALUE will always
> return 0. it'll not call ucc_fast_free for any failure. Inside 'if code'
> will be a dead code on 64bit. Even qe_muram_addr will return wrong
> virtual address. Which can cause an error.
>=20
>  kfree((void *)ugeth->tx_bd_ring_offset[i]);

Erm, kfree() isn't the right function for things allocated by qe_muram_allo=
c().

I still thing you need to stop this code using IS_ERR_VALUE() at all.

	David

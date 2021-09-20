Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 14:53:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7EB60F21
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 14:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C7EB60F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HCnc34bxpz301B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 00:53:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux-m68k.org
 (client-ip=195.130.137.77; helo=leibniz.telenet-ops.be;
 envelope-from=geert@linux-m68k.org; receiver=<UNKNOWN>)
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HCnbY0Pxsz2yL7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2021 00:52:38 +1000 (AEST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4HCnbN3G1mzMqcNy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2021 16:52:32 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.186.194])
 by xavier.telenet-ops.be with bizsmtp
 id wEsX2500R4C55Sk01EsXsB; Mon, 20 Sep 2021 16:52:31 +0200
Received: from geert (helo=localhost)
 by ramsan.of.borg with local-esmtp (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mSKel-007FCD-72; Mon, 20 Sep 2021 16:52:31 +0200
Date: Mon, 20 Sep 2021 16:52:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.15-rc2
In-Reply-To: <20210920115603.3455841-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2109201639480.1726079@ramsan.of.borg>
References: <20210920115603.3455841-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 20 Sep 2021, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.15-rc2[1] to v5.15-rc1[3], the summaries are:
>  - build errors: +9/-49

   + /kisskb/src/arch/sparc/lib/iomap.c: error: redefinition of 'pci_iounmap':  => 22:6

sparc64/sparc64-allnoconfig

   + /kisskb/src/drivers/iio/test/iio-test-format.c: error: the frame size of 2128 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 98:1

powerpc-gcc{5,9,11}/powerpc-allyesconfig

   + /kisskb/src/drivers/scsi/lpfc/lpfc_init.c: error: 'struct lpfc_sli4_hba' has no member named 'c_stat':  => 8280:28
   + /kisskb/src/drivers/scsi/lpfc/lpfc_scsi.c: error: 'start' undeclared (first use in this function):  => 5587:2

powerpc-gcc5/skiroot_defconfig

   + /kisskb/src/drivers/thunderbolt/test.c: error: the frame size of 3104 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 2207:1

powerpc-gcc5/powerpc-allyesconfig

   + /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_getc' defined but not used [-Werror=unused-function]:  => 1109:12
   + /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_putc' defined but not used [-Werror=unused-function]:  => 1095:13

powerpc-gcc5/ppc32_allmodconfig

   + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]: 1496:12, 970:13, 842:13 => 842:13, 970:13, 1496:33, 1496:12, 970:41, 842:41
   + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]: 1497:27, 843:28, 971:28 => 971:28, 843:56, 971:56, 843:28, 1497:27, 1497:48

powerpc-gcc{5,9,11}/ppc64_book3e_allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e4e737bb5c170df6135a127739a9e6148ee3da82/ (90 out of 182 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f/ (all 182 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

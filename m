Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 01:50:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385772081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 01:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uu2hpiZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385772081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42psv80hc6zF36C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:50:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="uu2hpiZY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="uu2hpiZY"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42psrQ59zKzF36B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 12:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yD2Kn6zCqGM9XM2r+MV3pzy6/nGXxCSzxHkKfnLJIKQ=; b=uu2hpiZYb2hrGizUF0EIScHv2Q
 c7ol08m63g1QbeOcnPMrL5Fjj9MWF8wPNi3IRPNx6eeeaNJtvQ+PwiNzqFq2jhdPAK48bdtwj6Ub2
 bHAfij7ifldYQ+W1vyQu8zU//0ZmyG1X/XZ72h+bU7wePdtBfReq4oudEkxRm6hbLVV9OMR5UTdJZ
 NUyMAdKfGXw4cZ7ZtEDyQ9jdGOJKBE+HayUFOX9BXX//0JhlpcMSvZbCOV2Dp+fkw8VrKKN1c98Sy
 12x6VHQPXxv+q7Yo0+QCHHjXwl/no0FU9dq1TSMYcMowucBZ/Pc6r7nM4pUXcLHgtBIttHUhphvLk
 vDtF/ZLw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=dragon.dunlab)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gJpnZ-0002PW-BA; Tue, 06 Nov 2018 01:04:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Message-ID: <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
Date: Mon, 5 Nov 2018 17:04:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v4.20-rc1[1] compared to v4.19[2].
>>
>> Summarized:
>>   - build errors: +3/-0
>>   - build warnings: +449/-2712
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
>>
>>
>> *** ERRORS ***
>>
>>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> 
> sh4-all{mod,yes}config
> 
> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> pci_iomap() on SH")
> is not sufficient?

Different problem.  This is about "select":

config SND_SOC_ALL_CODECS
	tristate "Build all ASoC CODEC drivers"

That enables (sets):
	select SND_SOC_HDAC_HDA
which selects SND_HDA even though CONFIG_PCI is not enabled.

After SND_HDA is selected (above), the Kconfig symbols in
sound/pci/hda/Kconfig are available for enabling, so
SND_HDA_CODEC_CA0132 is enabled but will not build.


One simple solution (but possibly too naive) is:

---
 sound/soc/codecs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
+++ lnx-420-rc1/sound/soc/codecs/Kconfig
@@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES7241
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
-	select SND_SOC_HDAC_HDA
+	select SND_SOC_HDAC_HDA if PCI
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C




-- 
~Randy

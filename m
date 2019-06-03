Return-Path: <SRS0=u7tn=UC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73834C28CC6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 09:52:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B652A27B90
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cx2XGIJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B652A27B90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45HVj70VNRzDqM2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 19:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cx2XGIJ1"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45HRdT1kXzzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2019 17:34:21 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 45HRdH0k2Kz9tyqt;
 Mon,  3 Jun 2019 09:34:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=cx2XGIJ1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id t587eiMd2m8w; Mon,  3 Jun 2019 09:34:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 45HRdG6QQQz9v001;
 Mon,  3 Jun 2019 09:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1559547250; bh=mANBXU7+AMcAciQx8IxmQjyNmlJQNbr71aM/BN8dzbo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cx2XGIJ1PTDY17Gl83f5iPGMktLRCTJLM9J6heu4l6yekYPXaaSe8NQ7w8javvDlm
 +Rtvv1EyMvZCS2u4NdeozM2Vz2dIhEX8vNm/TD2Mo+Ag96FfX5XRseZyRmVqril8w0
 6iQcfcnIjOsHS6DrJCAsxiHPl1B4h6/8idxnkiqo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 634B98B7B3;
 Mon,  3 Jun 2019 09:34:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PKsDjkW8A7c6; Mon,  3 Jun 2019 09:34:15 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CA588B7A1;
 Mon,  3 Jun 2019 09:34:14 +0200 (CEST)
Subject: Re: [PATCH 22/22] docs: fix broken documentation links
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <64e136de-1a7b-3436-9675-44ea9fa7b64a@c-s.fr>
Date: Mon, 3 Jun 2019 09:34:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Jun 2019 19:51:26 +1000
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Thomas Preston <thomas.preston@codethink.co.uk>,
 Wolfram Sang <wsa@the-dreams.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Alessia Mantegazza <amantegazza@vaga.pv.it>, Jakub Wilk <jwilk@jwilk.net>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, James Morris <jmorris@namei.org>,
 linux-acpi@vger.kernel.org, Andy Gross <agross@kernel.org>,
 xen-devel@lists.xenproject.org, Jason Wang <jasowang@redhat.com>,
 Alexander Popov <alex.popov@linux.com>, Qian Cai <cai@lca.pw>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kairui Song <kasong@redhat.com>,
 Quentin Perret <quentin.perret@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Jiri Kosina <jkosina@suse.cz>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Feng Tang <feng.tang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Yannik Sembritzki <yannik@sembritzki.me>, Harry Wei <harryxiyou@gmail.com>,
 linux-i2c@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 YueHaibing <yuehaibing@huawei.com>, Robert Moore <robert.moore@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Len Brown <lenb@kernel.org>,
 David Brown <david.brown@linaro.org>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-gpio@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-amlogic@lists.infradead.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Rob Herring <robh+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linux-pci@vger.kernel.org,
 Bhupesh Sharma <bhsharma@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 platform-driver-x86@vger.kernel.org,
 Ding Xiang <dingxiang@cmss.chinamobile.com>, linux-kselftest@vger.kernel.org,
 Alex Shi <alex.shi@linux.alibaba.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Baoquan He <bhe@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Raphael Gault <raphael.gault@arm.com>,
 Joel Stanley <joel@jms.id.au>, Federico Vaga <federico.vaga@vaga.pv.it>,
 Darren Hart <dvhart@infradead.org>, Erik Schmauss <erik.schmauss@intel.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Palmer Dabbelt <palmer@sifive.com>,
 Kees Cook <keescook@chromium.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 SeongJae Park <sj38.park@gmail.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org, devel@acpica.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Olof Johansson <olof@lixom.net>,
 Logan Gunthorpe <logang@deltatee.com>, "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Sven Van Asbroeck <thesven73@gmail.com>, Michal Hocko <mhocko@suse.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thorsten Leemhuis <linux@leemhuis.info>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, devel@driverdev.osuosl.org,
 Manfred Spraul <manfred@colorfullife.com>,
 Luis Chamberlain <mcgrof@kernel.org>, x86@kernel.org,
 Pavel Tatashin <pasha.tatashin@oracle.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
 devicetree@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dmitry Vyukov <dvyukov@google.com>, linux-edac@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Denis Efremov <efremov@ispras.ru>,
 netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Changbin Du <changbin.du@intel.com>, linux-security-module@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy@infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 30/05/2019 à 01:23, Mauro Carvalho Chehab a écrit :
> Mostly due to x86 and acpi conversion, several documentation
> links are still pointing to the old file. Fix them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   Documentation/acpi/dsd/leds.txt                  |  2 +-
>   Documentation/admin-guide/kernel-parameters.rst  |  6 +++---
>   Documentation/admin-guide/kernel-parameters.txt  | 16 ++++++++--------
>   Documentation/admin-guide/ras.rst                |  2 +-
>   .../devicetree/bindings/net/fsl-enetc.txt        |  7 +++----
>   .../bindings/pci/amlogic,meson-pcie.txt          |  2 +-
>   .../bindings/regulator/qcom,rpmh-regulator.txt   |  2 +-
>   Documentation/devicetree/booting-without-of.txt  |  2 +-
>   Documentation/driver-api/gpio/board.rst          |  2 +-
>   Documentation/driver-api/gpio/consumer.rst       |  2 +-
>   .../firmware-guide/acpi/enumeration.rst          |  2 +-
>   .../firmware-guide/acpi/method-tracing.rst       |  2 +-
>   Documentation/i2c/instantiating-devices          |  2 +-
>   Documentation/sysctl/kernel.txt                  |  4 ++--
>   .../translations/it_IT/process/howto.rst         |  2 +-
>   .../it_IT/process/stable-kernel-rules.rst        |  4 ++--
>   .../translations/zh_CN/process/4.Coding.rst      |  2 +-
>   Documentation/x86/x86_64/5level-paging.rst       |  2 +-
>   Documentation/x86/x86_64/boot-options.rst        |  4 ++--
>   .../x86/x86_64/fake-numa-for-cpusets.rst         |  2 +-
>   MAINTAINERS                                      |  6 +++---
>   arch/arm/Kconfig                                 |  2 +-
>   arch/arm64/kernel/kexec_image.c                  |  2 +-
>   arch/powerpc/Kconfig                             |  2 +-
>   arch/x86/Kconfig                                 | 16 ++++++++--------
>   arch/x86/Kconfig.debug                           |  2 +-
>   arch/x86/boot/header.S                           |  2 +-
>   arch/x86/entry/entry_64.S                        |  2 +-
>   arch/x86/include/asm/bootparam_utils.h           |  2 +-
>   arch/x86/include/asm/page_64_types.h             |  2 +-
>   arch/x86/include/asm/pgtable_64_types.h          |  2 +-
>   arch/x86/kernel/cpu/microcode/amd.c              |  2 +-
>   arch/x86/kernel/kexec-bzimage64.c                |  2 +-
>   arch/x86/kernel/pci-dma.c                        |  2 +-
>   arch/x86/mm/tlb.c                                |  2 +-
>   arch/x86/platform/pvh/enlighten.c                |  2 +-
>   drivers/acpi/Kconfig                             | 10 +++++-----
>   drivers/net/ethernet/faraday/ftgmac100.c         |  2 +-
>   .../fieldbus/Documentation/fieldbus_dev.txt      |  4 ++--
>   drivers/vhost/vhost.c                            |  2 +-
>   include/acpi/acpi_drivers.h                      |  2 +-
>   include/linux/fs_context.h                       |  2 +-
>   include/linux/lsm_hooks.h                        |  2 +-
>   mm/Kconfig                                       |  2 +-
>   security/Kconfig                                 |  2 +-
>   tools/include/linux/err.h                        |  2 +-
>   tools/objtool/Documentation/stack-validation.txt |  4 ++--
>   tools/testing/selftests/x86/protection_keys.c    |  2 +-
>   48 files changed, 77 insertions(+), 78 deletions(-)

[...]

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8c1c636308c8..e868d2bd48b8 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -898,7 +898,7 @@ config PPC_MEM_KEYS
>   	  page-based protections, but without requiring modification of the
>   	  page tables when an application changes protection domains.
>   
> -	  For details, see Documentation/vm/protection-keys.rst
> +	  For details, see Documentation/x86/protection-keys.rst

It looks strange to reference an x86 file, for powerpc arch.

Christophe


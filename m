Return-Path: <robherring2@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0209B1A0606
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 05:41:45 +1000 (AEST)
Received: by yhw29 with SMTP id 29so43945874yhw.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2015 12:41:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430817426-5241-2-git-send-email-stripathi@apm.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <1430817426-5241-2-git-send-email-stripathi@apm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 5 May 2015 14:41:21 -0500
Message-ID: <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
To: Suman Tripathi <stripathi@apm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 "jcm@redhat.com" <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>,
 "patches@apm.com" <patches@apm.com>, ddutile@redhat.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 5, 2015 at 4:17 AM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds the arasan sdhc nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)

[...]

> @@ -533,6 +567,16 @@
>                         interrupts = <0x0 0x4f 0x4>;
>                 };
>
> +               sdhc0: sdhc@1c000000 {
> +                       device_type = "sdhc";

device_type generally should not be used (there are a few exceptions).

> +                       compatible = "arasan,sdhci-4.9a";

If you ever have an integration or xgene specific problem, you need a
chip specific compatible.

Rob

Return-Path: <STFD002@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D23A0B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 02:42:24 +1100 (EST)
Received: from mail69-db3 (localhost [127.0.0.1])	by mail69-db3-R.bigfish.com
 (Postfix) with ESMTP id 276233402F9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 15:42:19 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.254])	by
 mail69-db3.bigfish.com (Postfix) with ESMTP id 8822140045	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 15:42:16 +0000 (UTC)
Received: from zro04-ws551.ea.freescale.net (zro04-ws551.ea.freescale.net
 [10.171.73.181])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 q11FgDMr010888	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 09:42:13
 -0600 (CST)
Message-ID: <4F295D54.5080900@freescale.com>
Date: Wed, 1 Feb 2012 17:42:12 +0200
From: Diana CRACIUN <diana.craciun@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH][upstream] Added aliased MSIIR register address to MSI
 node in dts
References: <1328110836-343-1-git-send-email-diana.craciun@freescale.com>
In-Reply-To: <1328110836-343-1-git-send-email-diana.craciun@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please ignore this, I put a wrong subject.

Thanks,

Diana

On 02/01/2012 05:40 PM, Diana Craciun wrote:
> From: Diana CRACIUN<Diana.Craciun@freescale.com>
>
> The MSIIR register for each MSI bank is aliased to a different
> address. The MSI node reg property was updated to contain this
> address:
>
> e.g. reg =<0x41600 0x200 0x44140 4>;
>
> The first region contains the address and length of the MSI
> register set and the second region contains the address of
> the aliased MSIIR register at 0x44140.
>
> Signed-off-by: Diana CRACIUN<Diana.Craciun@freescale.com>
> ---
>   .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |    6 ++++--
>   arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi          |    6 +++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> index 5d586e1..5693877 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> @@ -6,8 +6,10 @@ Required properties:
>     etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
>     the parent type.
>
> -- reg : should contain the address and the length of the shared message
> -  interrupt register set.
> +- reg : It may contain one or two regions. The first region should contain
> +  the address and the length of the shared message interrupt register set.
> +  The second region should contain the address of aliased MSIIR register for
> +  platforms that have such an alias.
>
>   - msi-available-ranges: use<start count>  style section to define which
>     msi interrupt can be used in the 256 msi interrupts. This property is
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
> index b9bada6..08f4227 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
> @@ -53,7 +53,7 @@ timer@41100 {
>
>   msi0: msi@41600 {
>   	compatible = "fsl,mpic-msi";
> -	reg =<0x41600 0x200>;
> +	reg =<0x41600 0x200 0x44140 4>;
>   	msi-available-ranges =<0 0x100>;
>   	interrupts =<
>   		0xe0 0 0 0
> @@ -68,7 +68,7 @@ msi0: msi@41600 {
>
>   msi1: msi@41800 {
>   	compatible = "fsl,mpic-msi";
> -	reg =<0x41800 0x200>;
> +	reg =<0x41800 0x200 0x45140 4>;
>   	msi-available-ranges =<0 0x100>;
>   	interrupts =<
>   		0xe8 0 0 0
> @@ -83,7 +83,7 @@ msi1: msi@41800 {
>
>   msi2: msi@41a00 {
>   	compatible = "fsl,mpic-msi";
> -	reg =<0x41a00 0x200>;
> +	reg =<0x41a00 0x200 0x46140 4>;
>   	msi-available-ranges =<0 0x100>;
>   	interrupts =<
>   		0xf0 0 0 0

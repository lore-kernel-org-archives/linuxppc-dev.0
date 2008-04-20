Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by ozlabs.org (Postfix) with ESMTP id D5DF2DE1DC
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:42:59 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1052023wxd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 15:42:57 -0700 (PDT)
Message-ID: <fa686aa40804201542x534f891q69790973d9fc0ecd@mail.gmail.com>
Date: Sun, 20 Apr 2008 16:42:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
In-Reply-To: <200804161640.42693.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804161640.42693.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 8:40 AM, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
> This patch converts the MII bitband driver to use GPIO lib for GPIO access.
>  The driver can now handle MDC and MDIO on different GPIO banks.
>
>  The patch depends on Anton Vorontsov GPIO lib support scheduled for 2.6.26.
>  It is by no means complete, I just would like to get some feedback on the
>  approach. I'll resubmit it when the CPM2 GPIO support patches will be
>  available in the powerpc git tree.

I agree with Anton; nice rework.  This would be useful on other
platforms too.  Comment below.

>  --- a/Documentation/powerpc/booting-without-of.txt
>  +++ b/Documentation/powerpc/booting-without-of.txt
>  @@ -2030,21 +2030,19 @@ platforms are moved over to use the flattened-device-tree model.
>     fsl,cpm2-mdio-bitbang (reg is port C registers)
>
>     Properties for fsl,cpm2-mdio-bitbang:
>  -   fsl,mdio-pin : pin of port C controlling mdio data
>  -   fsl,mdc-pin : pin of port C controlling mdio clock
>  +   gpios : GPIOs controlling mdio clock and mdio data (in that order).
>
>     Example:
>
>  -       mdio@10d40 {
>  +       mdio {
>                 device_type = "mdio";
>                 compatible = "fsl,mpc8272ads-mdio-bitbang",
>                              "fsl,mpc8272-mdio-bitbang",
>                              "fsl,cpm2-mdio-bitbang";

I think it would be better for the defined binding to use something
like "virtual,mdio-bitbang" or "gpio-mdio".  (I like the first better,
but there is already some precedence with the "gpio-led" driver.  I
think there is less chance of namespace conflicts with the first)

Of course; the *driver* could also accept these additional compatible
values for backwards compatibility.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

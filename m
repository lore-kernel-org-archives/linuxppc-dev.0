Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 6CB1EDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 06:25:35 +1100 (EST)
Message-ID: <4738A8A9.2080503@harris.com>
Date: Mon, 12 Nov 2007 14:25:29 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: PPC440EPx on Sequoia: /proc/iomem acts weird
References: <4734A72B.2070104@harris.com> <20071109123522.072bc1d8@weaponx>
	<4734AAFC.8080907@harris.com> <200711101403.48792.sr@denx.de>
In-Reply-To: <200711101403.48792.sr@denx.de>
Content-Type: multipart/alternative;
	boundary="------------000909070207000306040600"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000909070207000306040600
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

First I will say that I don't understand resources well enough to 
suggest a fix.  But I have done a little poking around.  In file 
arch/powerpc/platforms/44x/ppc4xx-nand.c I see one "struct resource", 
which is referenced by two "struct platform_device" items (ndfc_dev and 
nand_dev).

In routine ppc4xx_setup_nand_node() we have two calls to 
platform_device_register():

    platform_device_register(&ndfc_dev);
    platform_device_register(&nand_dev);

If I comment out the second one, then there is no loop in the resource 
tree, and I can cat /proc/iomem just fine.  If both calls are present, 
then cat /proc/iomem loops forever.

So, just a wild guess - should there be two "struct resource"s, one for 
each platform_device, or is there some other way to break the loop in 
the tree?

    Steve


Stefan Roese wrote:
> Hi Steve,
>
> On Friday 09 November 2007, Steven A. Falco wrote:
>   
>> I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.
>> Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it
>> further.
>>     
>
> Is this arch/ppc or arch/powerpc? I remember fixing this a while ago in 
> arch/ppc:
>
> commit 67a35ce785b1d11d09bf528c166ea26d489a4bd6
> Author: Stefan Roese <sr@denx.de>
> Date:   Thu Aug 2 14:15:22 2007 +0200
>
>     ppc: Fix problem with recursive NDFC platform_device resource management
>
>     This change fixes a problem with a resursive platform_device resource
>     management of the AMCC 4xx NDFC. Without this fix a "cat /proc/iomem"
>     leads to an infinite loop of printing the "ndfc-nand.0" resource.
>
>     Signed-off-by: Stefan Roese <sr@denx.de>
>
> Best regards,
> Stefan
>
>   

--------------000909070207000306040600
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>First I will say that I don't understand resources well enough to
suggest a fix.  But I have done a little poking around.  In file
arch/powerpc/platforms/44x/ppc4xx-nand.c I see one "struct resource",
which is referenced by two "struct platform_device" items (ndfc_dev and
nand_dev).<br>
<br>
In routine ppc4xx_setup_nand_node() we have two calls to
platform_device_register():<br>
<br>
    platform_device_register(&amp;ndfc_dev);<br>
    platform_device_register(&amp;nand_dev);<br>
<br>
If I comment out the second one, then there is no loop in the resource
tree, and I can cat /proc/iomem just fine.  If both calls are present,
then cat /proc/iomem loops forever.<br>
<br>
So, just a wild guess - should there be two "struct resource"s, one for
each platform_device, or is there some other way to break the loop in
the tree?<br>
<br>
    Steve<br>
<br>
</tt><br>
Stefan Roese wrote:
<blockquote cite="mid:200711101403.48792.sr@denx.de" type="cite">
  <pre wrap="">Hi Steve,

On Friday 09 November 2007, Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.
Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it
further.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is this arch/ppc or arch/powerpc? I remember fixing this a while ago in 
arch/ppc:

commit 67a35ce785b1d11d09bf528c166ea26d489a4bd6
Author: Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:sr@denx.de">&lt;sr@denx.de&gt;</a>
Date:   Thu Aug 2 14:15:22 2007 +0200

    ppc: Fix problem with recursive NDFC platform_device resource management

    This change fixes a problem with a resursive platform_device resource
    management of the AMCC 4xx NDFC. Without this fix a "cat /proc/iomem"
    leads to an infinite loop of printing the "ndfc-nand.0" resource.

    Signed-off-by: Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:sr@denx.de">&lt;sr@denx.de&gt;</a>

Best regards,
Stefan

  </pre>
</blockquote>
</body>
</html>

--------------000909070207000306040600--

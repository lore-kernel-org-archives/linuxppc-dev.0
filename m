Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87637B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 23:31:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KDV1HR030468
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 09:31:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KDVMs8230032
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 09:31:22 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KDVLKK021999
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2009 09:31:22 -0400
Date: Thu, 20 Aug 2009 09:31:18 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 2/2] powerpc/405ex: support cuImage via included dtb
Message-ID: <20090820133118.GF2530@zod.rchland.ibm.com>
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<1250562484-16415-3-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250562484-16415-3-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 10:28:04AM +0800, Tiejun Chen wrote:
>To support cuImage, we need to initialize the required sections and 
>ensure that it is built.
>
>-		cuboot-acadia.c cuboot-amigaone.c
>+		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
> src-boot := $(src-wlib) $(src-plat) empty.c
>
> src-boot := $(addprefix $(obj)/, $(src-boot))
>@@ -192,6 +192,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
> image-$(CONFIG_EP405)			+= dtbImage.ep405
> image-$(CONFIG_WALNUT)			+= treeImage.walnut
> image-$(CONFIG_ACADIA)			+= cuImage.acadia
>+image-$(CONFIG_KILAUEA)		+= cuImage.kilauea

I'm not thrilled with this part as cuImage is really the secondary
solution if the U-Boot that comes with a board if FDT aware.  If you
have a different board that needs this, perhaps you could add the
target when that board support gets upstream?

>+static void kilauea_fixups(void)
>+{
>+	/*TODO: Please change this as the real. Note that should be 33MHZ~100MHZ.*/

What does that mean?

josh

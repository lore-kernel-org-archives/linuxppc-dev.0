Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54EFA679F0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 07:52:45 +1000 (EST)
Message-ID: <451AF29D.2030102@garzik.org>
Date: Wed, 27 Sep 2006 17:52:29 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton
	Blanchard's new hvcall interface
References: <200609271847.34258.ossthema@de.ibm.com>
In-Reply-To: <200609271847.34258.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	pmac@au1.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> Hi Jeff, 
> 
> the last patch did not work, so here is the new patch. The patch is build against
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev.2.6.git HEAD today.
> Could you give it a try?

Per the standard patch format in Documentation/SubmittingPatches, these 
sort of comments should go beneath the "---" separator.  Otherwise, if 
they are not hand-edited out, they will go into the final changeset 
description.


> This eHEA patch reflects changes according to Anton's new hvcall interface
> which has been commited in Paul's git tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

When is this going upstream?  I don't want things to get too out-of-sync.


> In addition to the above changes the patch includes a bug fix (port state
> notification) and minor changes (default queue length, coding style updates).

These changes should be in a separate patch.  Makes 'git bisect' work 
better, makes the changes more reviewable, and in general follows the 
"separate logical changes" rule.


> diff -Nurp netdev-2.6/drivers/net/ehea/ehea_ethtool.c netdev-2.6_patched/drivers/net/ehea/ehea_ethtool.c
> --- netdev-2.6/drivers/net/ehea/ehea_ethtool.c	2006-09-26 10:27:38.000000000 +0200
> +++ netdev-2.6_patched/drivers/net/ehea/ehea_ethtool.c	2006-09-26 19:28:22.000000000 +0200
> @@ -270,7 +270,7 @@ static void ehea_get_ethtool_stats(struc
>  	kfree(cb6);
>  }
>  
> -const struct ethtool_ops ehea_ethtool_ops = {
> +struct ethtool_ops ehea_ethtool_ops = {
>  	.get_settings = ehea_get_settings,
>  	.get_drvinfo = ehea_get_drvinfo,
>  	.get_msglevel = ehea_get_msglevel,


This is an obvious regression.

	Jeff

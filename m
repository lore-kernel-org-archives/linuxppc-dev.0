Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F371FDDDB2
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 17:09:49 +1000 (EST)
Date: Mon, 27 Apr 2009 09:09:32 +0200
From: Benjamin Krill <ben@codiert.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: [PATCH] [MTD] ofpart: Partitions at same address cannot have the
	same name v3
Message-ID: <20090427070932.GK14906@codiert.org>
References: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>--- a/drivers/mtd/ofpart.c
>+++ b/drivers/mtd/ofpart.c
>@@ -48,7 +48,9 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
> 
> 		/* check if this is a partition node */
> 		partname = of_get_property(pp, "name", &len);
>-		if (strcmp(partname, "partition") != 0) {
>+		if ((strcmp(partname, "partition") != 0) &&
>+			(of_device_is_compatible(pp, "partition") != 1))
>+		{
> 			nr_parts--;
> 			continue;
> 		}

If this is the way, how to go, you get my ack.

Acked-by: Benjamin Krill <ben@codiert.org>

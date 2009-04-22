Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 37C2EDE0B6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:10:41 +1000 (EST)
Date: Wed, 22 Apr 2009 19:10:30 +0200
From: Benjamin Krill <ben@codiert.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: ofpart:  Partitions at same address cannot have the same name
Message-ID: <20090422171030.GH14906@codiert.org>
References: <874owhoxce.fsf@macbook.be.48ers.dk>
	<1240415535-10939-1-git-send-email-ricardo.ribalda@uam.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1240415535-10939-1-git-send-email-ricardo.ribalda@uam.es>
Cc: David.Woodhouse@intel.com, linuxppc-dev@ozlabs.org
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
>@@ -48,7 +48,7 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
> 
> 		/* check if this is a partition node */
> 		partname = of_get_property(pp, "name", &len);
>-		if (strcmp(partname, "partition") != 0) {
>+		if (strncmp(partname, "partition", strlen("partition") != 0) {

Hi Recardo,

I would suggest to do:

		if (strcmp(partname, "partition") <= 0) {

cheers
 ben

Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id DB9E1679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 23:27:12 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1161933ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 06:27:10 -0700 (PDT)
Message-ID: <82ecf08e0605220627s7118f006if7a66d56df7a2b52@mail.gmail.com>
Date: Mon, 22 May 2006 10:27:10 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: Preferred way to configure MTD physical mapping and partitioning
In-Reply-To: <200605221500.00634.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605221232.14880.laurent.pinchart@tbox.biz>
	<82ecf08e0605220527r4033cff2xbba8a60646f9dfc2@mail.gmail.com>
	<200605221500.00634.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >
> > BTW, you can partition your flash via cmdline
>
> So would that be the preferred way to configure MTD partitions ?
>
> Laurent Pinchart
>
Using the mtdparts option in the boot cmdline. example

mtdparts=256k(partition1)ro,333k(partition2),444k(partition3),-(partition 4)

This will create /dev/mtd1, /dev/mtd2, etc, etc (and the corresponding
mtdblock devices) - you still have to create the inodes manually
(AFAIK) with the corresponding size, etc Using the '-' in the last
option uses all the remaining space. (as the ro option that makes the
partition read only. Useful for not overwriting your bootloader)

-- 
-
Thiago Galesi

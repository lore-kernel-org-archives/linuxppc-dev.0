Return-Path: <ken.kawakami@toshiba.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0CC28B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 19:31:25 +1000 (EST)
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id 97086DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 19:31:24 +1000 (EST)
Received: from imx2.toshiba.co.jp (imx2 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id n6L9VMx8002582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 18:31:22 +0900 (JST)
Received: from arc1.toshiba.co.jp ([133.199.194.235])
	by imx2.toshiba.co.jp  with ESMTP id n6L9VHEf013339
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 18:31:17 +0900 (JST)
Received: (from root@localhost) by arc1.toshiba.co.jp  id n6L9VHmH025743
	for linuxppc-dev@ozlabs.org; Tue, 21 Jul 2009 18:31:17 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp2.toshiba.co.jp  with ESMTP id n6L9VH4Q005601
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 18:31:17 +0900 (JST)
Date: Tue, 21 Jul 2009 18:31:16 +0900 (JST)
Message-Id: <20090721.183116.179965115.kk@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH] powerpc/cell: strncpy does not null terminate string
From: Ken Kawakami <ken.kawakami@toshiba.co.jp>
In-Reply-To: <200907171756.22224.arnd@arndb.de>
References: <4A607185.6020302@gmail.com> <4A608A69.4060204@gmail.com>
	<200907171756.22224.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, roel.kluin@gmail.com,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd-san, Roel-san,

Thanks for pointing us to the redundant cord portion.

> On Friday 17 July 2009, Roel Kluin wrote:
> > 
> >  static int __init celleb_machine_type_hack(char *ptr)
> >  {
> > -       strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> > +       strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> >         celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
> >         return 0;
> 
> This still is pointless as long as you keep the explicit null-termination
> in the next line, the patch still doesn't change anything significant.
> 
> The file is maintained by Ishizaki Kou, if he would prefer to take a
> patch replacing the two lines with one, that's fine with me, otherwise
> I just wouldn't bother. You still only gain a few bytes of inittext, but
> that is discarded at boot time.

We prefer to take the patch which is replacing the two lines with one.
-       strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
+       strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
-       celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;

Thanks,
Ken Kawakami

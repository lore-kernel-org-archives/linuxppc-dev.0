Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F003DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:30:49 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l2G1Uj3O027271
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:30:45 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l2G1UkXQ009096
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:30:46 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l2G1Ujdw016772
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:30:45 +0900 (JST)
Message-Id: <200703160130.l2G1UjE8021399@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 16 Mar 2007 10:32:42 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: (Your message of "Thu, 15 Mar 2007 20:48:42 +0100")
	<200703152048.42972.bzolnier@gmail.com>
References: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
	<200703150608.l2F68JY2026403@toshiba.co.jp>
	<20070315084645.GR4095@ftp.linux.org.uk>
	<200703152048.42972.bzolnier@gmail.com>
Subject: Re: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> Bart wrote:
>> Al wrote:
>> So AFAICS the minimal fix for that sucker is dependency on BLK_DEV_IDE=y;
>> however, I really wonder if
>> 	* it needs to be linked into ide-core (as opposed to being a normal
>> module of its own)
>
>AFAICS there are no legacy device ordering issues with scc_pata so it doesn't
>need to be linked into ide-core but I'll leave the definitive answer to Akira
>
>> 	* alternatively, its init should be called explicitly.

I don't have the answer why scc_pata is linked into ide-core.
Reviewing your comments and codes, I will make the following fixes:
  * remove link to ide-core and make normal module
  * move from ide/ppc to ide/pci

I will send these patches later.

Best regards,
Akira Iguchi

Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A59B168397
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 22:24:15 +1000 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp2.song.fi (Postfix) with ESMTP id 6B9D04DE7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 15:24:08 +0300 (EEST)
Message-ID: <433BDCE7.2060206@iki.fi>
Date: Thu, 29 Sep 2005 14:24:07 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi>
In-Reply-To: <433A6E6D.4070403@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki wrote:

> I guess Linux remaps the RAM as copy-back. But snooping should work 
> with copy-back caches, shouldn't it?

Oh, well. The kernel boots just fine if I add

flags |= _PAGE_WRITETHRU | _PAGE_COHERENT;

in setbat() in arch/ppc/mm/ppc_mmu.c. But this should not depend on this 
kind of a hack, should it?

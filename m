Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4F498DDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 14:27:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c-ibm_iic driver bonus patch
Date: Tue, 19 Feb 2008 04:27:19 +0100
References: <477EF225.4070505@pikatech.com> <47BA38C1.6040609@pikatech.com>
In-Reply-To: <47BA38C1.6040609@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802190427.19763.arnd@arndb.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008, Sean MacLennan wrote:
>  I left in the volatiles, since I don't 
> understand why they where needed. The memory always seems to be access 
> with in_8 and out_8, which are declared volatile. But they could be 
> there to fix a very specific bug.

It's very unlikely that they were really needed, and you certainly
shouldn't mark data as volatile in new code. It's very common to
mark I/O data structures as volatile when they should be __iomem,
because that's what people learn at university, but that is never
the right solution, even if it can hide other bugs in your code.

Of course, unlike the other changes in your patch, it does impact
code generation, so if you want to change it, that should be a
separate patch.

	Arnd <><

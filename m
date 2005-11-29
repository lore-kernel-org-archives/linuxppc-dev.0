Return-Path: <ihornberger@sysgo.de>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 209A3687DE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 02:12:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 2515CFB85F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 15:41:28 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 123C2FB85F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 15:41:28 +0100 (CET)
Received: from iho.sysgo.com (iho.sysgo.com [172.22.47.10])
	by donald.sysgo.com (Postfix) with ESMTP id 565AC1BA977
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 15:41:25 +0100 (CET)
From: Ingo Hornberger <ihornberger@sysgo.de>
To: linuxppc-devel list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 15:39:47 +0100
Message-Id: <1133275187.2664.32.camel@iho.sysgo.com>
Mime-Version: 1.0
Subject: immap with 8xx.
Reply-To: ihornberger@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently porting an old 2.4 kernel driver to 2.6.14. I got some
problems with the immap and idma stuff. The driver is very special and
uses it's own dma handling, because it's too different from the default.

So it strongly depends on the underlying hardware. (In this case 8xx)

With kernel 2.4 it used the headers:
- asm/commproc.h
- asm/8xx_immap.h

But it seems that there was some generalization work done, which didn't
reach the 8xx part. Particularly this means that some parts of
'asm/commproc.h' as well as (at least) 'asm/immap_8260.h' built up a new
header 'asm/immap_cpm2.h'.

Actally I miss a file like 'asm/immap_cpm1.h'.
If it would be the right solution to create a file like this, that's no
problem. I only wanted to make sure that I don't do duplicated work this
time.

regards,
	Ingo

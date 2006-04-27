Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 5907067A3B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 00:24:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 01903FB84C
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 15:59:23 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id E6749FB84C
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 15:59:23 +0200 (CEST)
Received: from kah.ulm.sysgo.com (kah.sysgo.com [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id 3488BD0015D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 15:59:20 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id QAA17528
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 16:05:32 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-dev@ozlabs.org
Subject: do_mmap_pgoff issue...
Date: Thu, 27 Apr 2006 15:59:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604271559.19818.g.jaeger@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi list,

while trying to mmap some flash area on my mpc8541 CDS board, 
I noticed that the overflow case is probably not correctly handled 
within function do_mmap_pgoff in linux/mm/mmap.c

The facts:
- mmap the last page @ 0xFFFFF000, len 4K
- result: mmap says EOVERFLOW...
- the function that failed was do_mmap_pgoff()

Here's the pice of code

/* offset overflow? */
if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
    return -EOVERFLOW;

It's quite clear why it fails in my case:
pgoff + (len >> PAGE_SHIFT) will be 0

I fixed that by inserting the following, to handle that special case:

if ((pgoff + (len >> PAGE_SHIFT)) < pgoff) {
    if ((pgoff + (len >> PAGE_SHIFT)) != 0 )
        return -EOVERFLOW;
}

My question is - is that behaviour a bug or a feature? In fact it's
an off-by-one issue, but I could not believe, that nobody else ever
had problems with that.

TIA for enlighten me
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

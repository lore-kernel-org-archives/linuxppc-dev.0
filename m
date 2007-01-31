Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id F2116DDF83
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 00:53:14 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id A94B1CC144
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:34:16 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 7F925CC03D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:34:16 +0100 (CET)
Received: from gja.ulm.sysgo.com (unknown [172.30.1.130])
	by donald.sysgo.com (Postfix) with ESMTP id 803EB2E42C2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:34:11 +0100 (CET)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mmap bug (all archs) w/ fix
Date: Wed, 31 Jan 2007 14:34:10 +0100
References: <200701310254.l0V2sh3L053534@penguin.ncube.com>
In-Reply-To: <200701310254.l0V2sh3L053534@penguin.ncube.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701311434.10906.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mittwoch, 31. Januar 2007, Michael Galassi wrote:
[SNIPSNAP]
> This clearly applies to all architectures and all versions (at least 2.4
> onward), could someone point me at some document which describes how to
> submit patches to "the right place" please?  I really do not want to
> support any fixes myself so getting fixes to obvious bugs merged into
> the mailine code would be a good thing (tm).
> 
IIRC, the problem is not the code that you try to fix, the problem is
the mmap call, which uses a signed 32 bit integer value for the offset
argument. And this one bites you when having addresses to map > 
0x80000000 (I assume that you try to mmap an area somewhere @
0xF8000000-0xFFFFFFFF).

Try to use mmap2 call which overcomes this problem by using the page
size as unit of the offset argument instead of bytes.

So no patch is needed and you should be able ti map the flash.

HTH
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 886AB67CCA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 19:41:51 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17124.46024.454586.233091@astp0002.localdomain>
Date: Mon, 25 Jul 2005 12:41:28 +0300
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <E5B7BB81-C268-448D-BCEC-6B619D81D793@freescale.com>
References: <17121.14182.92600.906359@home1.localdomain>
	<E5B7BB81-C268-448D-BCEC-6B619D81D793@freescale.com>
Cc: debian-embedded@lists.debian.org, linuxppc-embedded@ozlabs.org
Subject: Re: Experiences with Debian Sarge on MPC8xx ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Kumar Gala writes:

    Kumar> Does that actually work or are you suggesting something to
    Kumar> try?

This actually works, not with Sarge but with Sid, though glibc version
is the same AFAIK. On MPC8xx, I usually use BusyBox for core utilities
and self-compiled glibc (for performance reasons mentioned by Wolfgang),
and add ready Debian packages for more advanced functions (mail server,
for example). The self-compiled glibc is from the Sid source, so the
problem in it and in the Debian pre-compiled library was the same. I
don't know if it's the only problem on MPC8xx, but on our boards the
"fix" which I described was enough. As we already discussed a couple of
weeks ago, assembler version of memset looks broken for cache line sizes
smaller than (not equal to?) 32. Maybe it's the many times mentioned
dcbz problem. Anyway, the "fix" causes glibc to switch in run time to C
version of memset.

Hope this helps,
-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================

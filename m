Return-Path: <haveblue@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93661679F2
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 07:39:12 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1QKd7A1031930
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Feb 2006 15:39:07 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k1QKd7Wh042964
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Feb 2006 15:39:07 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k1QKd6hS027430
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Feb 2006 15:39:07 -0500
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for
	!MULTIPLATFORM
From: Dave Hansen <haveblue@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 12:38:54 -0800
Message-Id: <1140986335.8697.139.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-02-24 at 10:54 -0600, Kumar Gala wrote:
> +       if (strstr(cmd_line, "mem=")) {
> +               char *p, *q;
> +               unsigned long maxmem = 0;
> +
> +               for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
> +                       q = p + 4;
> +                       if (p > cmd_line && p[-1] != ' ')
> +                               continue;
> +                       maxmem = simple_strtoul(q, &q, 0);
> +                       if (*q == 'k' || *q == 'K') {
> +                               maxmem <<= 10;
> +                               ++q;
> +                       } else if (*q == 'm' || *q == 'M') {
> +                               maxmem <<= 20;
> +                               ++q;
> +                       } else if (*q == 'g' || *q == 'G') {
> +                               maxmem <<= 30;
> +                               ++q;
> +                       }
> +               }
> +               memory_limit = maxmem;
> +       } 

You may want to check out lib/cmdline.c's memparse() function.  I think
it does this for you.

-- Dave

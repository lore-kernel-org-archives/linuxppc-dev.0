Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91703B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 01:44:40 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p14EYOJp002532
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 07:34:24 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p14Eiawu250292
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 07:44:36 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p14Eiafb028734
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 07:44:36 -0700
Subject: Re: [PATCH V2 5/6] powerpc/44x: boot wrapper: allow kernel to load
	into non-zero address
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20110204140732.GG17643@zod.rchland.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110204140732.GG17643@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 04 Feb 2011 08:44:34 -0600
Message-ID: <1296830674.19506.22.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-02-04 at 09:07 -0500, Josh Boyer wrote:
> On Tue, Feb 01, 2011 at 12:48:45PM -0600, Dave Kleikamp wrote:
> >+static ibm4xx_memstart;
> >+
> > static void iss_4xx_fixups(void)
> > {
> >-	ibm4xx_sdram_fixup_memsize();
> >+	void *memory;
> >+	u32 reg[3];
> >+
> >+	memory = finddevice("/memory");
> >+	if (!memory)
> >+		fatal("Can't find memory node\n");
> >+	getprop(memory, "reg", reg, sizeof(reg));
> >+	if (reg[1] || reg[2])
> 
> Wouldn't this test allow for a faulty device tree that specified a 0
> size (0x0 in reg[2])?  Maybe just check reg[2] for non-zero instead?

That make sense.

> 
> josh

-- 
Dave Kleikamp
IBM Linux Technology Center

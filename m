Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA313B712B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 01:08:13 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p14Dnge0008515
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 08:49:42 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 168DF4DE8040
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Feb 2011 09:07:30 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p14E88ks417006
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 09:08:09 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p14E88Gv006738
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 07:08:08 -0700
Date: Fri, 4 Feb 2011 09:07:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 5/6] powerpc/44x: boot wrapper: allow kernel to load
	into non-zero address
Message-ID: <20110204140732.GG17643@zod.rchland.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 01, 2011 at 12:48:45PM -0600, Dave Kleikamp wrote:
>+static ibm4xx_memstart;
>+
> static void iss_4xx_fixups(void)
> {
>-	ibm4xx_sdram_fixup_memsize();
>+	void *memory;
>+	u32 reg[3];
>+
>+	memory = finddevice("/memory");
>+	if (!memory)
>+		fatal("Can't find memory node\n");
>+	getprop(memory, "reg", reg, sizeof(reg));
>+	if (reg[1] || reg[2])

Wouldn't this test allow for a faulty device tree that specified a 0
size (0x0 in reg[2])?  Maybe just check reg[2] for non-zero instead?

josh

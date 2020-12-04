Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E9C433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:03:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA3B22B40
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA3B22B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CncvG1BN4zDqk9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 03:03:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.188; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
X-Greylist: delayed 326 seconds by postgrey-1.36 at bilbo;
 Sat, 05 Dec 2020 03:00:55 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0188.hostedemail.com
 [216.40.44.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cncr76js9zDrSN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2020 03:00:53 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 883908004339
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 15:55:29 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 96467100E7B46;
 Fri,  4 Dec 2020 15:55:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: foot04_4212f4e273c5
X-Filterd-Recvd-Size: 5091
Received: from XPS-9350.home (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Fri,  4 Dec 2020 15:55:22 +0000 (UTC)
Message-ID: <189ad2584d80d915d3c9f76c044947f83ca5ebf8.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon: Change printk() to pr_cont()
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>
Date: Fri, 04 Dec 2020 07:55:21 -0800
In-Reply-To: <87h7p1vnym.fsf@mpe.ellerman.id.au>
References: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
 <87h7p1vnym.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-12-04 at 21:56 +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Since some time now, printk() adds carriage return, leading to
> > unusable xmon output:
> > 
> > [   54.288722] sysrq: Entering xmon
> > [   54.292209] Vector: 0  at [cace3d2c]
> > [   54.292274]     pc:
> > [   54.292331] c0023650
> 
> ...
> 
> > diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
> > index 5c1a50912229..9b0d85bff021 100644
> > --- a/arch/powerpc/xmon/nonstdio.c
> > +++ b/arch/powerpc/xmon/nonstdio.c
> > @@ -178,7 +178,7 @@ void xmon_printf(const char *format, ...)
> >  
> > 
> >  	if (n && rc == 0) {
> >  		/* No udbg hooks, fallback to printk() - dangerous */
> > -		printk("%s", xmon_outbuf);
> > +		pr_cont("%s", xmon_outbuf);
> >  	}
> 
> Ah OK, in the case where there's no udbg backend. We basically always
> have a udbg backend on 64-bit, via hvc console. Which explains why we
> haven't noticed it.
> 
> Will pick up the patch.
> 
> cheers

Perhaps all of these bare printks should be inspected for defects:

$ git grep -P -n '\bprintk\s*\(\s*(?!KERN_\w+)"[^\\n]*"' arch/powerpc
arch/powerpc/kernel/process.c:1475:     printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
arch/powerpc/kernel/process.c:1479:     printk("MSR:  "REG" ", regs->msr);
arch/powerpc/kernel/process.c:1513:             printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
arch/powerpc/kernel/process.c:1514:             printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
arch/powerpc/kernel/process.c:2157:                     printk("%s["REG"] ["REG"] %pS",
arch/powerpc/kernel/traps.c:621:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:726:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:766:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:791:        printk("Caused by (from SRR1=%lx): ", reason);
arch/powerpc/kernel/udbg.c:95:          printk("%s", s);
arch/powerpc/math-emu/fabs.c:13:        printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fctiw.c:22:       printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fctiwz.c:29:      printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fmr.c:13: printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fnabs.c:13:       printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fneg.c:13:        printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/lfd.c:15: printk("%s: D %p, ea %p: ", __func__, frD, ea);
arch/powerpc/math-emu/stfd.c:11:        printk("%s: S %p, ea %p: ", __func__, frS, ea);
arch/powerpc/mm/nohash/44x.c:192:                                       printk("%d ", i);
arch/powerpc/platforms/4xx/machine_check.c:19:          printk("Data");
arch/powerpc/platforms/chrp/pci.c:256:                  printk(" at %llx", (unsigned long long)r.start);
arch/powerpc/platforms/embedded6xx/ls_uart.c:47:                                        printk("%c", in_8(avr_addr + UART_RX));
arch/powerpc/platforms/powermac/pfunc_core.c:83:        printk("%s", title);
arch/powerpc/platforms/powermac/pfunc_core.c:85:                printk("%02x ", *((u8 *)blob));
arch/powerpc/platforms/powernv/pci-ioda.c:81:   printk("%spci %s: [PE# %.2x] %pV",
arch/powerpc/sysdev/tsi108_pci.c:63:    printk("PCI CFG write : ");
arch/powerpc/sysdev/tsi108_pci.c:64:    printk("%d:0x%x:0x%x ", bus->number, devfunc, offset);
arch/powerpc/sysdev/tsi108_pci.c:65:    printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
arch/powerpc/sysdev/tsi108_pci.c:164:           printk("PCI CFG read : ");
arch/powerpc/sysdev/tsi108_pci.c:165:           printk("%d:0x%x:0x%x ", bus->number, devfn, offset);
arch/powerpc/sysdev/tsi108_pci.c:166:           printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
arch/powerpc/sysdev/tsi108_pci.c:315:           printk("cfg_ctl=0x%08x ", temp);
arch/powerpc/xmon/nonstdio.c:181:               printk("%s", xmon_outbuf);



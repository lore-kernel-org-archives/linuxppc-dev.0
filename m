Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id F1B17DDE2D
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:04:06 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so702262ele
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:04:05 -0700 (PDT)
Message-ID: <fa686aa40709281304p62fe5e66k99ea934a4896d876@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:04:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 01/18] Virtex: Add uartlite bootwrapper driver
In-Reply-To: <200709282145.09411.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
	<200709282145.09411.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 28 September 2007, Grant Likely wrote:
> > +static void uartlite_putc(unsigned char c)
> > +{
> > +while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
> > +out_be32(reg_base + 0x4, c);
> > +}
>
> When coding a spin-loop, it's better to do a cpu_relax() between
> each attempt.

Is cpu_relax even implemented in the bootwrapper?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

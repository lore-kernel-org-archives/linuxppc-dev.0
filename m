Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A75782C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:20:43 +1100 (EST)
Message-ID: <1393384830.6733.987.camel@snotra.buserror.net>
Subject: Re: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup
 source
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Tue, 25 Feb 2014 21:20:30 -0600
In-Reply-To: <3eba8b896e624b698ab8291399c5a1b0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
 <20140225140705.fe9f7038bbffbfbde899e0f7@linux-foundation.org>
 <3eba8b896e624b698ab8291399c5a1b0@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
 Zhao Chenhui-B35336 <chenhui.zhao@freescale.com>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-25 at 21:09 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Andrew Morton [mailto:akpm@linux-foundation.org]
> > Sent: Wednesday, February 26, 2014 6:07 AM
> > To: rtc-linux@googlegroups.com
> > Cc: Wang Dongsheng-B40534; a.zummo@towertech.it; Zhao Chenhui-B35336; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup
> > source
> > 
> > On Tue, 21 Jan 2014 13:24:51 +0800 Dongsheng Wang <dongsheng.wang@freescale.com>
> > wrote:
> > 
> > > +	if (client->irq != NO_IRQ) {
> > 
> > x86_64 allmodconfig:
> > 
> > drivers/rtc/rtc-ds3232.c: In function 'ds3232_probe':
> > drivers/rtc/rtc-ds3232.c:427: error: 'NO_IRQ' undeclared (first use in this
> > function)
> > drivers/rtc/rtc-ds3232.c:427: error: (Each undeclared identifier is reported
> > only once
> > drivers/rtc/rtc-ds3232.c:427: error: for each function it appears in.)
> > 
> > Not all architectures implement NO_IRQ.
> > 
> > I think this should be
> > 
> > 	if (client->irq > 0) {
> > 
> > but I'm not sure - iirc, x86 (at least) treats zero as "not an IRQ".
> > But I think some architectures permit IRQ 0.  There was discussion many
> > years ago but I don't think anything got resolved.
> > 
> I think this is why NO_IRQ is defined in kernel, that should be resolved this issue.
> 
> Sorry, I don't know why some architectures didn't define this macro?

NO_IRQ is deprecated (see "git log -SNO_IRQ" for the trend of removing
uses of it, as well as situations where it gives the wrong results).
"if (client->irq > 0)" is correct.

-Scott

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34655DDF39
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:47:17 +1000 (EST)
Subject: Re: [patch 4/7] ps3: Storage Driver Probing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705251818.03964.arnd@arndb.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.474400000@sonycom.com>
	<200705251818.03964.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:47:09 +1000
Message-Id: <1180133229.19517.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 18:18 +0200, Arnd Bergmann wrote:
> > +static u64 ps3stor_wait_for_completion(u64 devid, u64 tag,
> > +                                    unsigned int timeout)
> > +{
> > +     unsigned int retries = 0;
> > +     u64 res = -1, status;
> > +
> > +     for (retries = 0; retries < timeout; retries++) {
> > +             res =
> lv1_storage_check_async_status(NOTIFICATION_DEVID, tag,
> > +                                                  &status);
> > +             if (!res)
> > +                     break;
> > +             set_current_state(TASK_INTERRUPTIBLE);
> > +             schedule_timeout(1);
> > +     }
> 
> Any reason not to use msleep(1) instead of the schedule_timeout? 

Both look equally ugly though... do you really have to poll ?

Ben.

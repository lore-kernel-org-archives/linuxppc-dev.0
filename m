Return-Path: <htejun@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.231])
	by ozlabs.org (Postfix) with ESMTP id 415A8DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 18:27:08 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1673169qbe
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 01:27:06 -0700 (PDT)
Message-ID: <46EE0F14.8070008@gmail.com>
Date: Mon, 17 Sep 2007 07:22:28 +0200
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: SYSFS: need a noncaching read
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
	<20070912100123.GA23182@kroah.com>
In-Reply-To: <20070912100123.GA23182@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>,
	linux-kernel@vger.kernel.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg KH wrote:
> On Wed, Sep 12, 2007 at 07:32:07AM +0200, Robert Schwebel wrote:
>> On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
>>> I have developed a device driver and use the sysFS to export some
>>> registers to userspace.
>> Uuuh, uggly. Don't do that. Device drivers are there to abstract things,
>> not to play around with registers from userspace.
>>
>>> I opened the sysFS File for one register and did some reads from this
>>> File, but I alwas becoming the same value from the register, whats not
>>> OK, because they are changing. So I found out that the sysFS caches
>>> the reads ... :-(
>> Yes, it does. What you can do is close()ing the file handle between
>> accesses, which makes it work but is slow.
> 
> Do an lseek back to 0 and then re-read, you will get called in your
> driver again.

There should be an intervening sysfs_notify() call from kernel side to
make sysfs re-populate its cache on read again.  sysfs bin files buffer
the result but don't cache the result but this again doesn't really fit
the usage case.

Thanks.

-- 
tejun

Return-Path: <jacmet@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.182])
	by ozlabs.org (Postfix) with ESMTP id 185DADDF8D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 06:01:44 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c21so107658ika.1
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 13:01:42 -0700 (PDT)
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] rtc: rtc-ds1374: fix 'no irq' case handling
References: <20080812161733.GA32164@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 19 Aug 2008 22:01:37 +0200
In-Reply-To: <20080812161733.GA32164@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Tue\, 12 Aug 2008 20\:17\:33 +0400")
Message-ID: <87d4k4n59a.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

 Anton> On a PowerPC board with ds1374 RTC I'm getting this error while
 Anton> RTC tries to probe:

 Anton> rtc-ds1374 0-0068: unable to request IRQ

 Anton> This happens because I2C probing code (drivers/of/of_i2c.c) is
 Anton> specifying IRQ0 for 'no irq' case, which is correct.

 Anton> The driver handles this incorrectly, though. This patch fixes it.

Great, I was just about to send a similar patch. Another advantage of
using 0 for 'no irq' is for I2C_BOARD_INFO(). With that you can simply
not assign anything to .irq instead of having to set it to -1.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard

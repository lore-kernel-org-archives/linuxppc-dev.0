Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 19372DDF34
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 21:42:33 +1000 (EST)
Date: Wed, 24 Sep 2008 15:42:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a
	dedicated function
Message-ID: <20080924114231.GA8469@oksana.dev.rtsoft.ru>
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<20080924000336.GB29733@oksana.dev.rtsoft.ru>
	<B8BAAB1F-10B5-419D-84A7-F724A7E77F41@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <B8BAAB1F-10B5-419D-84A7-F724A7E77F41@kernel.crashing.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 11:07:00PM -0500, Kumar Gala wrote:
>
> On Sep 23, 2008, at 7:03 PM, Anton Vorontsov wrote:
>
>> qe_gpio_set_dedicated() is a platform specific function, which is used
>> to revert a pin to a dedicated function. Caller should have already
>> obtained the gpio via gpio_request().
>>
>> This is needed to support Freescale USB Host Controller.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> arch/powerpc/include/asm/qe.h     |    1 +
>> arch/powerpc/sysdev/qe_lib/gpio.c |   46 ++++++++++++++++++++++++++++ 
>> +++++++++
>> 2 files changed, 47 insertions(+), 0 deletions(-)
>
> what do you mean by dedicated function.. be a bit clearer in the commit 
> log.

This term is from the QE spec, I didn't invent anything. ;-)

"Each pin in the I/O ports can be configured as a general-purpose
I/O signal or as a dedicated peripheral interface signal. ...many
dedicated peripheral functions are multiplexed onto the ports."

> Also, does this depend on gpio_to_chip() patch?

Yeah, the point of exported gpio_to_chip is to let us write
this function.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E202DDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:11:06 +1000 (EST)
Date: Wed, 24 Sep 2008 18:11:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a
	dedicated function
Message-ID: <20080924141104.GA7873@oksana.dev.rtsoft.ru>
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<20080924000336.GB29733@oksana.dev.rtsoft.ru>
	<B8BAAB1F-10B5-419D-84A7-F724A7E77F41@kernel.crashing.org>
	<20080924114231.GA8469@oksana.dev.rtsoft.ru>
	<E8A37756-794A-4829-ABEC-AACA9DB54620@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <E8A37756-794A-4829-ABEC-AACA9DB54620@kernel.crashing.org>
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

On Wed, Sep 24, 2008 at 09:00:03AM -0500, Kumar Gala wrote:
>
> On Sep 24, 2008, at 6:42 AM, Anton Vorontsov wrote:
>
>> On Tue, Sep 23, 2008 at 11:07:00PM -0500, Kumar Gala wrote:
>>>
>>> On Sep 23, 2008, at 7:03 PM, Anton Vorontsov wrote:
>>>
>>>> qe_gpio_set_dedicated() is a platform specific function, which is  
>>>> used
>>>> to revert a pin to a dedicated function. Caller should have already
>>>> obtained the gpio via gpio_request().
>>>>
>>>> This is needed to support Freescale USB Host Controller.
>>>>
>>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>> ---
>>>> arch/powerpc/include/asm/qe.h     |    1 +
>>>> arch/powerpc/sysdev/qe_lib/gpio.c |   46 ++++++++++++++++++++++++++ 
>>>> ++
>>>> +++++++++
>>>> 2 files changed, 47 insertions(+), 0 deletions(-)
>>>
>>> what do you mean by dedicated function.. be a bit clearer in the  
>>> commit
>>> log.
>>
>> This term is from the QE spec, I didn't invent anything. ;-)
>>
>> "Each pin in the I/O ports can be configured as a general-purpose
>> I/O signal or as a dedicated peripheral interface signal. ...many
>> dedicated peripheral functions are multiplexed onto the ports."
>
> I understand but I think 'dedicated' could be interpreted in another way 
> (like the GPIO pin is dedicated, not that the pin is used for a  
> dedicated SoC block).
>
> If it the commit message had said 'to a dedicated on chip peripheral' it 
> would be clearer.

Ah, ok, I'll fix that.

>>> Also, does this depend on gpio_to_chip() patch?
>>
>> Yeah, the point of exported gpio_to_chip is to let us write
>> this function.
>
> I meant can I take this patch w/o the gpio_to_chip() patch? (not clear  
> from your response)

No, unfortunately you can't. It would be great if we could pass the
whole patchset via single tree (USB? Or -mm to Linus directly?),
so Acks are more than appreciated.


Thanks again,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

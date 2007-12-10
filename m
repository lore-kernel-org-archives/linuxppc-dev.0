Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id CD219DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:19:54 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so90903uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:19:53 -0800 (PST)
Date: Tue, 11 Dec 2007 02:10:52 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071210231052.GB1141@zarina>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210230453.GB5495@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210230453.GB5495@localhost.localdomain>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 10:04:53AM +1100, David Gibson wrote:
> On Mon, Dec 10, 2007 at 11:47:05PM +0300, Anton Vorontsov wrote:
> > Hi all,
> > 
> > Here are patches to support NAND on UPM. That driver is generic for
> > all processors with FSL UPMs. And because of that, few more patches are
> > needed -- GPIO API and generic FSL UPM functions.
> > 
> > This is early RFC, all patches are in single thread, so everyone could
> > make up overall picture of what is going on. I'll split the thread by
> > topics after that RFC.
> > 
> > Ok, the patches and what they are for:
> > 
> > 1,2,3,4. GPIO API:
> > ------------------
> > Usually NAND chips exports RNB (Ready-Not-Busy) pin, so drivers
> > could read it and get a hint when chip is ready.
> > 
> > Often, WP (write protect) pin is also connected to GPIO. So, GPIO API
> > is mandatory for generic drivers.
> > 
> > OF device tree GPIOs bindings are similar to IRQs:
> > 
> > node {
> > 	gpios = <bank pin bank pin bank pin>;
> > 	gpio-parent = <&par_io_controller>;
> > };
> > 
> > "bank pin" scheme is controller specific, so controllers that want
> > to implement flat mappings or any other could do so.
> 
> It might be safest to do as is done for interrupts, and not define the
> internal format at all.

This is how it is done already. Take a look into second and third patches:

+static int par_io_xlate(struct device_node *np, int index)
+{
+       return __of_parse_gpio_bank_pin(np, index, 32, num_par_io_ports);
+}
+
+static struct of_gpio_chip of_gpio_chip = {
+       .xlate = par_io_xlate,
+};

__of_parse_gpio_bank_pin() is helper function, I just factored
it out, because both QE and CPM2 using same format.

But generally, controllers are encouraged to do their own xlates.

Or am I missing the point?

> The gpio within the gpio controller would be
> defined by a gpio-descriptor whose format is determined by the
> controller.  You would need to add a #gpio-cells property in this
> case, so you can at least determine the size of the descriptors
> associated with a particular gpio controller.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

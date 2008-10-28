Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40810280715m3275a302jd43ab517d2d455fc@mail.gmail.com>
Date: Tue, 28 Oct 2008 08:15:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Konstantinos Margaritis" <markos@codex.gr>
Subject: Re: GPIO - marking individual pins (not) available in device tree
In-Reply-To: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 7:31 AM, Konstantinos Margaritis
<markos@codex.gr> wrote:
>
> Pardon my intrusion in the conversation, but I just couldn't not comment on
> this:
>
> On Tue, 28 Oct 2008 12:50:03 +1100, David Gibson
> <david@gibson.dropbear.id.au> wrote:
>>> So now my qualm is back to the beginning of the discussion. How do
>>> we encode the purpose of those pins reliably and within some
>>> standard framework, without getting *driver* specific?
>>
>> Um.. I fail to see how the purpose of a pin can be not driver
>> specific.
>
> GPIO stands for _General_ Purpose IO. The driver should just expose that
> info to user space and it should be up to the userspace application to
> decide what to do with that. The programmer should require absolutely
> no other intervention to the driver whatsoever.
> Anyone that has worked on data mining scientific equipment -eg.
> particle/photon scanners on VME boards with lots of GPIO pins- will tell
> you that meddling with kernel coding is totally unneeded, in fact it's
> stupid to require the student to do so. Usually some Windows API is given
> and the students write the programs on Windows to collect the data and
> control the device. I guess GPIOLIB and the new framework would have
> similar application in Linux -ie, requiring the programmer to write only
> a userspace to access the GPIO pins. From my understanding of the
> conversation, there are some people who fail to see the necessity of
> doing extra work to abstract this information away from the driver. A walk
> to a nearby experimental physicists lab with students working on such
> devices will convince you of the right way to do it actually.

All this already exists.   All GPIO pins using GPIOLIB are exportable
and usable from userspace with no kernel coding whatsoever.  However,
some of those GPIO pins are also used by in-kernel driver to implement
things like i2c, spi, mdio and jtag which use in-kernel
infrastructure, so it is critical to support both kernel and user
space users.

As far as David's comment about pins being driver specific; that
really is true.  Once a GPIO pin is wired to something it becomes
specific purpose which is device/board/connection specific, regardless
of if the driver is in kernel or a user space application (Just
because it is user space code doesn't mean it isn't a device driver).
If the driver willfully uses the wrong GPIO pins then things simply
won't work and it is critical for the device tree to contain valid
data about GPIO connections.

For Matt's purposes, I think he wants to describe which GPIO pins are
available to be used, but are not yet connected to anything.  In such
a case I think it does make sense to add a node for available GPIO
pins and give it a gpios property with a list of the pins wired to the
header.

Thanks for the comments.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

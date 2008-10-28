Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40810281039v4f22a464u3eb1d421e1226fc8@mail.gmail.com>
Date: Tue, 28 Oct 2008 11:39:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
In-Reply-To: <4907436D.2060209@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024044511.GI4267@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
	<20081027183421.GA1009@oksana.dev.rtsoft.ru>
	<49060EC3.1070704@genesi-usa.com>
	<20081027201023.GA18642@oksana.dev.rtsoft.ru>
	<49063929.3060900@genesi-usa.com>
	<20081027231221.GA22008@oksana.dev.rtsoft.ru>
	<490666B0.2010500@genesi-usa.com>
	<20081028023722.GA30057@oksana.dev.rtsoft.ru>
	<4907436D.2060209@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 10:53 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Is it still possible to perhaps create a node under lcd-controller which
> describes the pin groupings? Maybe we should call it a gpio-group.
>
> That way lcd-controller looks like
>
> lcd-controller {
>        compatible = "crystalfontz,something-gpio";
>        data-bus {
>                compatible - "gpio-group";
>                gpios = <gpioc 1 gpioc 8 gpioc 42 ... >
>        }
>        rw-ctrl {
>                compatible = "gpio-group";
>                gpios = <gpioc 2>
>        }

At this level, the 'compatible = "gpio-group";' is completely
irrelevant.  The binding for "crystalfontz,something-gpio" must
specify that there are two subnodes; one named data-bus and one named
rw-ctrl.  The driver, which binds against compatible in the parent
node, would know to go looking for those child nodes and to use the
gpios property inside them.  Simple.

>> Does this mean "hard-coding"?
>
> No. If you have an array of GPIO pins (gpios property) then how do you
> determine which is for data and which is some control pin? Do you
> associate these numbers in the driver somehow? Maybe a matchlist or
> an array? Given pins A B C D E F G H I J where does the data bus
> start and the control pins live? A and B? A and J? I and J?

You know because you document it in the binding.

> It would be definitely frivolous to define a whole device tree binding
> for the *order in which you MUST specify the gpios for this particular
> device*. There is obviously an implicit ordering of the GPIOs to make
> up the data bus (you'd expect an order from MSB to LSB.. or perhaps
> LSB to MSB... that might be better defined than undefined)

Why is it frivolous?  We do this all the time for reg and irqs.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

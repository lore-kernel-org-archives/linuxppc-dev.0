Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id A1F56DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 06:46:41 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so2308570qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 12:46:41 -0700 (PDT)
Message-ID: <49076C1E.8090501@genesi-usa.com>
Date: Tue, 28 Oct 2008 14:46:38 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: GPIO - marking individual pins (not) available in device tree
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
	<fa686aa40810281039v4f22a464u3eb1d421e1226fc8@mail.gmail.com>
In-Reply-To: <fa686aa40810281039v4f22a464u3eb1d421e1226fc8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
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



Grant Likely wrote:

> At this level, the 'compatible = "gpio-group";' is completely
> irrelevant.  The binding for "crystalfontz,something-gpio" must
> specify that there are two subnodes; one named data-bus and one named
> rw-ctrl.  The driver, which binds against compatible in the parent
> node, would know to go looking for those child nodes and to use the
> gpios property inside them.  Simple.

Point taken.

>>> Does this mean "hard-coding"?
>> No. If you have an array of GPIO pins (gpios property) then how do you
>> determine which is for data and which is some control pin? Do you
>> associate these numbers in the driver somehow? Maybe a matchlist or
>> an array? Given pins A B C D E F G H I J where does the data bus
>> start and the control pins live? A and B? A and J? I and J?
> 
> You know because you document it in the binding.

I think having a working device tree and a seperate binding document
sometimes slows things down. If it is not patently obvious what you
mean from a device tree, in order to write a new driver, the device
tree is not doing it's job..

Where the binding must take it's cue from established documentation,
and follows existing procedures and semantics, the binding is important
(for instance there are a few ways to check an interrupt fired on
MPC5200B, and Linux/dts encodes them per ONE table in the docs, this
must be referenced somewhere at least)

>> It would be definitely frivolous to define a whole device tree binding
>> for the *order in which you MUST specify the gpios for this particular
>> device*. There is obviously an implicit ordering of the GPIOs to make
>> up the data bus (you'd expect an order from MSB to LSB.. or perhaps
>> LSB to MSB... that might be better defined than undefined)
> 
> Why is it frivolous?  We do this all the time for reg and irqs.

See above. Does every driver require a ratified device tree binding
which is collaborated and agreed upon even though it may be in use on
one or two boards which actually may never see the light of day (I
bet none of you will ever see the CPLD core I'm sitting in front of
right now..)

I think it should be obvious both from the tree and inside the driver
what magical little sections of code do without cross-referencing, I
do far too much cross-referencing in Linux as it is, and it's one thing
I'm a little sore to see keep reoccurring, that I have to have 3 windows
open to understand the intent of a 10 line snippet in a driver..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

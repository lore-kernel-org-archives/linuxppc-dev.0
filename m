Return-Path: <Hollis_Blanchard@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Date: Thu, 6 Jan 2011 13:52:30 -0800
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FA8FD@na3-mail.mgc.mentorg.com>
In-Reply-To: <20110105170725.1a82c5a6@udp111988uds.am.freescale.net>
References: <4D12F171.7010103@mentor.com>	<20101223185623.GA20384@angua.secretlab.ca>	<4D13C402.2090209@mentor.com>	<20101223223325.GK20384@angua.secretlab.ca>	<20110103135120.32aeb60d@udp111988uds.am.freescale.net>	<4D24E99F.90908@mentor.com>	<20110105160918.2b530fea@udp111988uds.am.freescale.net>	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E4@na3-mail.mgc.mentorg.com>
	<20110105170725.1a82c5a6@udp111988uds.am.freescale.net>
From: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: "Inge, Meador" <meador_inge@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2011 03:07 PM, Scott Wood wrote:
> On Wed, 5 Jan 2011 14:49:40 -0800
> "Blanchard, Hollis"<Hollis_Blanchard@mentor.com>  wrote:
>
>> On 01/05/2011 02:09 PM, Scott Wood wrote:
>>> On Wed, 5 Jan 2011 15:58:55 -0600
>>> Meador Inge<meador_inge@mentor.com>   wrote:
>>>
>>>> We need some sort of mapping between a message register and a =
message
>>>> register number so that the message registers can be referenced =
through
>>>> some sort of API (e.g. 'mpic_msgr_read(0)').  One way to do that =
would
>>>> be by putting an order on the registers.  Maybe there is a better =
way,
>>>> though ...
>>> A message register is uniquely identified by a reference to the =
device
>>> tree node, plus a 0-3 index into that node's message registers.
>> Really what we're talking about is software configuration, not =
hardware
>> description.
> Part of that software configuration involves identifying the hardware
> being referenced.
>
>> We've gone back and forth on representing this information
>> in the device tree, and most recently decided against it. Outside the
>> kernel, a device node reference isn't really practical.
> Global enumeration isn't much fun either.  For something like this
> where it's very unlikely that additional MPIC message units will be
> added to the system dynamically, it's managable, but it's not a good
> habit to get into.  Look at the pain that's been caused by such
> assumptions in the i2c subsystem, in kernel interrupt management, etc.
>
> A reference to a node is just a pointer to a software message driver
> object, which can be obtained from looking up an alias.  It's a little
> less simple than just using a number, but it's not impractical. It =
also
> provides a natural place to put a layer of indirection in the code =
that
> isolates the upper-layer protocol from the details of what sort of
> message transport it is using.
>
> Now, if you don't care about this, and want to just use numbers in =
your
> application, go ahead.  But I don't think that such an assumption
> should go into the device tree binding.  Have the software number the
> message register banks in increasing physical address order, or based
> on numbered aliases similar to how U-Boot enumerates ethernet nodes, =
or
> something similar.
Using physical addresses doesn't solve the enumeration problem either,=20
but I think it's beside the point: userspace must refer to the device.=20
There is a rich history of userspace *not* walking /proc/device-tree in=20
order to refer to a physical device. Are you suggesting this case is=20
special?

Hollis Blanchard
Mentor Graphics, Embedded Systems Division

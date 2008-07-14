Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by ozlabs.org (Postfix) with ESMTP id 07E6CDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 10:50:39 +1000 (EST)
Message-ID: <487AA17E.6000808@gmail.com>
Date: Sun, 13 Jul 2008 20:44:46 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Mikrotik RouterBoard 333
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca>
In-Reply-To: <20080709040925.GA13810@secretlab.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Tue, Jul 08, 2008 at 02:26:32PM +1000, David Gibson wrote:
>> Does anyone on this list have contacts with the makers of this board?
>>
>> Its firmware apparently provides a flattened device tree to the OS.
>> And while this step towards world domination is flattering, it's an
>> example of what I feared when people first got enthusiastic about the
>> idea of including flattened device trees in firmwares.  The tree has
>> not, AFAIK, been past this list, and has apparently not been reviewed
>> by someone knowledgeable about device trees.  In short, it's crap, and
>> now that it's embedded in the firware we can't really fix it.
>>
>> So, to any embedded hardware/firmware vendors doing Linux ports out
>> there.  I certainly encourage you to use flattened device trees, but
>> can I please suggest you put the blob into your kernel image (in the
>> bootwrapper strictly speaking), rather than into the flashed firmware.
>> It's a lot easier to fix mistakes that way.
>>
>> There are situations where it's nice to have the device tree in
>> firmware, but there are many others where it buys little to nothing.
>> People seem to be a bit overenthusaistic on the concept at the moment.
> 
> Total Ack!  Allow me second that opinion.
> 
> g.

I'm a half-ack.  ;-)  I'm partial to u-boot's implementation rather than 
using a bootwrapper for obvious reasons.  The u-boot implementation 
takes the blob as a boot parameter and passes it along to the kernel 
after doing appropriate (optional) fixups.  The usual implementation is 
to burn it into a block of flash separate from u-boot itself or use tftp 
to load it from the server.

Other than that quibble, I agree that burning the blob into the firmware 
so that the firmware must be recompiled and reburned to change the blob 
is very undesirable.

Best regards,
gvb

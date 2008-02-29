Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ED306DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 22:53:50 +1100 (EST)
Message-ID: <47C7F209.9030907@s5r6.in-berlin.de>
Date: Fri, 29 Feb 2008 12:52:41 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] firewire: endianess fix
References: <20080220220326.GA22328@uranus.ravnborg.org>	<200802272221.38985.jwilson@redhat.com>	<1204179959.15052.372.camel@pasglop>	<200802281342.06493.jwilson@redhat.com>	<1204241162.15052.393.camel@pasglop>	<47C79CB1.6050104@redhat.com>
	<18375.60394.166769.540668@cargo.ozlabs.ibm.com>
In-Reply-To: <18375.60394.166769.540668@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Jarod Wilson <jwilson@redhat.com>, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Jarod Wilson writes:
>> I wonder how many people still actually 1) have a machine 
>> with this controller, 2) are running Linux on it and 3) use firewire 
>> devices with it. Both of you, please speak up, we're trying to help you! 
>> (if only out of morbid curiosity to see this mythical goofy controller).
> 
> I have a first-generation titanium powerbook that has this controller
> (assuming we're talking about vendor/device id = 0x106b / 0x18), and
> yes I run Linux (only) on it and use firewire disks. :)

I actually have a TiBook 400 myself, but so far without Linux, and its 
FireWire PHY is dead.  But I can use CardBus FireWire cards on it to do 
basic testing on a big endian PC, and I can test the selfID 
byte-swapping by the PHY-less onboard controller.

I now started a Fedora 8 live CD (self-test says the medium is 
corrupt... need to burn another one) and dmesg says:
firewire_ohci: Added fw-ohci device 0002:24:0e.0, OHCI version 1.0
firewire_ohci: recursive bus reset detected, discarding self ids
[...]

The second line looks like this is indeed one of those which needs the 
header byte-swap workaround which ohci1394 has but firewire-ohci hasn't yet.

On the weekend I'm going to attempt to put Linux on this PowerBook, at last.
-- 
Stefan Richter
-=====-==--- --=- ===-=
http://arcgraph.de/sr/

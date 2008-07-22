Return-Path: <neko@genesi-usa.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.228])
	by ozlabs.org (Postfix) with ESMTP id BDD94DDF3D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 18:31:39 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so7290319hue.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 01:31:37 -0700 (PDT)
Message-ID: <48859AD2.6050404@genesi-usa.com>
Date: Tue, 22 Jul 2008 09:31:14 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: radeonfb, dedicate memory to something else
References: <48830D56.2080704@genesi-usa.com>
	<9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>
In-Reply-To: <9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 7/20/08, Matt Sealey <matt@genesi-usa.com> wrote:
>> Hi guys,
>>
>>  I know this isn't a PPC question, but since some of the RadeonFB developers
>>  live here I thought best (and it's about a PPC platform).
>>
>>  Is there any way to hack up the RadeonFB driver - or anything related - to
>>  reserve portions of the memory for a "fake" MTD or so, and still use the
>>  Radeon as a graphics device? What I am talking about basically is turning
>>  a 64MB Radeon card into a 32MB Radeon card, or a 128MB one into a 64MB
>>  card..
> 
> Somebody write this long ago. Maybe around 2000. That's all I
> remember. I think they made the video memory into a ram disk.

Yeah making it into a ramdisk precludes the use of the card as a video card
though.. this is what I am trying to get around. If fbdev and X can cooperate
on believing that a 64MB card is a 32MB card, then the upper 32MB can be used
to attach the MTD "ram" driver at a certain address (maybe we can even make a
hacky stub driver that recognizes this configuration based on OF tree..)

There are obvious limitations in that the Pegasos/Efika firmware only will
map 128MB of video memory, and the PCI BAR is limited to 256MB chunks anyway,
but that shouldn't matter. I just wonder, how it can be done that radeonfb
or other graphics drivers can be told "please only use the first 32MB" and
then either manually or automatically, map the rest as ramdisk.

> I believe there is more to it, the GART window may be smaller than the
> total RAM on the card. You need to use the GART to map in the
> appropriate pieces.

The problem here is the PCI bus on the Efika is a PCI bus, with an AGP
riser. It doesn't add any AGP functionality like real GART on the host
controller side, so there is nothing to map system memory into AGP's
view of the system.. it always confused me how "pcigart" is meant to
work and how an AGP GART does anything different to how PCI works in
the first place (the documentation/spec doesn't make it that clear in
my opinion :)

You would certainly know better than I..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

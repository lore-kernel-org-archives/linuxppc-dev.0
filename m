Return-Path: <neko@genesi-usa.com>
Message-ID: <48E02FD0.8000809@genesi-usa.com>
Date: Sun, 28 Sep 2008 20:30:56 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: USB support on mpc5200 broken
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop>
In-Reply-To: <1222307447.8277.147.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin Herrenschmidt wrote:
> On Wed, 2008-09-24 at 21:09 -0400, Jon Smirl wrote:
>>> Last time I noticed it was working was about ten days ago. I don't use
>>> it everyday.
>> Efika is broken because of this:
>>
>> ohci-ppc-of.c...
>> 	is_bigendian =
>> 		of_device_is_compatible(dn, "ohci-bigendian") ||
>> 		of_device_is_compatible(dn, "ohci-be");
>>
>> Efika doesn't have either of those in it's compatible string.
>>
>> This doesn't look to me like a very reliable way to determine bigendian.
> 
> You mean it's not reliable to expect people device-trees not to
> suck ? :-)

It's reasonable to expect that device-trees do not get updated with the
kernel for certain platforms (it does not fit into most quality assurance
schedules to reflash every user's firmware every time they want to move up
one revision to another, given the kernel release schedule of every 3-4
months) and when updating the search for compatible entries it should
take into account these platforms.

We had this discussion a few months back (just before I released the
last version of the device tree supplement script) when patches were
being submitted that broke detection. It was agreed that at least one
of the Efika compatibles should stay in there, mostly likely the least
insane one.

The same patch also introduced a big-endian property to replace the
stupid encoding of endianness into the controller compatible entries,
and we all though that was a great idea. "ohci-bigendian" is simply
wrong by this regard, and if the policy has changed since then, then
we are looking at yet another device tree policy flip-flop which is
starting to move more towards annoying, than being simply an acceptable
fact of life due to the Linux development process.

Jon, just use efika.forth from http://www.powerdeveloper.org/ and add
in the appropriate entry, or make a snippet for it and add it to nvramrc.

If it doesn't work, bug me about it and I will release an update as I
have one which goes way overboard and includes every variation for
compatible USB drivers and tries to make gpio fit the new gpio specs
and i2c and can buses exposed.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

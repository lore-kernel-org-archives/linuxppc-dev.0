Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <14772.1186002066@falcon10.austin.ibm.com>
References: <31368.1185909681@falcon10.austin.ibm.com>
	<18095.56272.4647.158912@cargo.ozlabs.ibm.com>
	<18071.1185935876@bebe.enoyolf.org>
	<5682bc7e60187e64d80fd99b4ad573df@kernel.crashing.org>
	<14772.1186002066@falcon10.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca5af1386c47bdf03146b1d3ac2cff39@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ipv6 in yaboot
Date: Mon, 6 Aug 2007 20:42:35 +0200
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Paul Nasrat <pnasrat@redhat.com>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The network address is passed to OF as (part of) the device
>> argument for the network device; and colons aren't legal
>> characters in a device argument,
>
> yeah, pretty thoughtless of the IETF for not consulting the 1275WG. :)

Heh.  That's not an issue; it just means that OF implementations
need to use a (slightly) different spelling for IPV6 addresses.
However, see below.

>> so any OF implementation that
>> would use colons in IPv6 addresses is terminally broken.
>
> Ok.  What is your proposed resolution that does not violate the rfcs?
> Namely RFCs 3986, 4038, and especially 4291.

Quotes from those RFCs would have been helpful.

>> This
>> is completely analogous to the fact that filesystem paths cannot
>> use forward slashes.  (The third disallowed character is the
>> at-sign, for completeness).
>
> Not really.  I don't expect to the the "device path" contain any ipv6
> info.  Just the parameters that follow on the end,

There can be parameters at *any* path component though, not just
the final component.  It isn't too farfetched to imagine devices as
child devices under a network device IMHO.  Not the common case, sure.

> There is no ppc64 OFW that supports this yet, but a version is
> expected soon.

There is an x86 OFW that supports it now.  Some good news, too:

The requirement for device arguments to not contain colons or
at-signs has been deemed overly strict, since any defined use
for those arguments should follow the path resolution algorithm
that is spelled out in the specification itself; and that algorithm
can deal with it just fine.  Therefore, it now is an (unpublished :-) )
recommended practice for OF implementations to allow it.

Forward slashes are right out, though :-)

> BTW, I don't really have any real input into how the OFW is designed,
> just try to adapt to what is implemented.

Yeah I understand :-)


Segher

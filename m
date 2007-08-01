Return-Path: <dwm@austin.ibm.com>
In-reply-to: <5682bc7e60187e64d80fd99b4ad573df@kernel.crashing.org>
References: <31368.1185909681@falcon10.austin.ibm.com>
	<18095.56272.4647.158912@cargo.ozlabs.ibm.com>
	<18071.1185935876@bebe.enoyolf.org>
	<5682bc7e60187e64d80fd99b4ad573df@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ipv6 in yaboot
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Aug 2007 16:01:06 -0500
Message-ID: <14772.1186002066@falcon10.austin.ibm.com>
From: Doug Maxey <dwm@austin.ibm.com>
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


On Wed, 01 Aug 2007 07:12:15 +0200, Segher Boessenkool wrote:
>>>> I just got asked about ipv6 support in yaboot and a quick
>>>> investigation
>>>> showed _no_ knowledge of the address formats in the code.
>>>>
>>>> Should I be submitting an RFC for a full parser that can pick that
>>>> apart?  Or does has someone have code lurking in the shadows, that
>>>> just needed some prompting?  :)
>>>
>>> I would have thought that yaboot would just be passing any network
>>> addresses in text form to some OF method, so it's up to OF to
>>> understand ipv6 address formats.  No?
>>
>> Yes, yaboot _should_ just pass the text representation around.
>> However, there are places that the context determination, for
>> disklabels, is a simple check for the presence of ':'.
>
>The network address is passed to OF as (part of) the device
>argument for the network device; and colons aren't legal
>characters in a device argument,

yeah, pretty thoughtless of the IETF for not consulting the 1275WG. :)

> so any OF implementation that
>would use colons in IPv6 addresses is terminally broken.

Ok.  What is your proposed resolution that does not violate the rfcs?
Namely RFCs 3986, 4038, and especially 4291.

>This
>is completely analogous to the fact that filesystem paths cannot
>use forward slashes.  (The third disallowed character is the
>at-sign, for completeness).

Not really.  I don't expect to the the "device path" contain any ipv6
info.  Just the parameters that follow on the end, e.g., not a real
example, just an extrapolation from current usage using the existing
addresses from a client and a server:

> boot network1:ipv6,fe80::202:55ff:fed3:9e20/64,KERNEL-NAME,fe80::21a:64ff:fe44:1713/64,GWADDR,...

The above addrs after the first colon is the part that yaboot would
have to deal with, if only to treat it as opaque token.

There is no ppc64 OFW that supports this yet, but a version is
expected soon.

BTW, I don't really have any real input into how the OFW is designed,
just try to adapt to what is implemented.

++doug

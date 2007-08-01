Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <18071.1185935876@bebe.enoyolf.org>
References: <31368.1185909681@falcon10.austin.ibm.com>
	<18095.56272.4647.158912@cargo.ozlabs.ibm.com>
	<18071.1185935876@bebe.enoyolf.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5682bc7e60187e64d80fd99b4ad573df@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ipv6 in yaboot 
Date: Wed, 1 Aug 2007 07:12:15 +0200
To: Doug Maxey <dwm@enoyolf.org>
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

>>> I just got asked about ipv6 support in yaboot and a quick 
>>> investigation
>>> showed _no_ knowledge of the address formats in the code.
>>>
>>> Should I be submitting an RFC for a full parser that can pick that
>>> apart?  Or does has someone have code lurking in the shadows, that
>>> just needed some prompting?  :)
>>
>> I would have thought that yaboot would just be passing any network
>> addresses in text form to some OF method, so it's up to OF to
>> understand ipv6 address formats.  No?
>
> Yes, yaboot _should_ just pass the text representation around.
> However, there are places that the context determination, for
> disklabels, is a simple check for the presence of ':'.

The network address is passed to OF as (part of) the device
argument for the network device; and colons aren't legal
characters in a device argument, so any OF implementation that
would use colons in IPv6 addresses is terminally broken.  This
is completely analogous to the fact that filesystem paths cannot
use forward slashes.  (The third disallowed character is the
at-sign, for completeness).


Segher

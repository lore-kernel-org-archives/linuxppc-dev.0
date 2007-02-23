Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 2A769DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 01:33:13 +1100 (EST)
Message-ID: <45DEFB22.9070607@smiths-aerospace.com>
Date: Fri, 23 Feb 2007 09:33:06 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: a fix but still broken
References: <45DD9A41.7060900@smiths-aerospace.com>	<20070223034734.GA18698@localhost.localdomain>
	<45DEE524.6010704@smiths-aerospace.com>
In-Reply-To: <45DEE524.6010704@smiths-aerospace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:
> David Gibson wrote:
>> On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
>>> Hi Dave,
>>>
>>> I have good news and bad news. ;-)  The good news is that the 
>>> incompatibility between libfdt and jdl's dtc is that libfdt has the 
>>> name offset and the length of the name switched.  
>>> booting_without_of.txt says the length comes first, so libfdt is in 
>>> the wrong.
>>
>> Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
>> came from: I was looking at flat_dt.h from dtc, which also gets this
>> wrong (but the declaration in question is unused).  Of course, I also
>> wrote flat_dt.h ...
>>
>>> The bad news is that, when I fix this, nearly all of the tests fail 
>>> (but they fail the same way for both tree.S and jdl's dtc).  I have 
>>> not started on that layer of the onion yet.
>>
>> Found it, there was a direct use of the position of the length in
>> _fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
>> along with some other small fixes which I found while tracking this
>> one down.
>>
>> Oh, incidentally, I applied your patch by eye rather than with
>> patch(1), which was handy, because it appears to have been whitespace
>> damaged.
> 
> Hi David,
> 
> Sorry about the whitespace, I actually generated it at home, emailed it 
> to my day job, and edited and forwarded it from there (I'm not 
> subscribed at home - probably should be).
> 
> It sounds like we found and fixed the same bug last night.
> 
> I went quite a bit further (before finding and fixing the real bug).  I 
> was looking at the *_type "function like" #defines that generate a 
> temporary variable of indeterminate (until compile time) type.  An example:
> 
> #define fdt_setprop_inplace_typed(fdt, nodeoffset, name, val) \
>     ({ \
>         typeof(val) x = val; \
>         fdt_setprop_inplace(fdt, nodeoffset, name, &x, sizeof(x)); \
>     })
> 
> IMHO this is borderline evil and unnecessary, and I removed all of them 
> by replacing the call of the *_type macros with the equivalent actual 
> function.  What I was suspicious of is when I changed all the calls to 
> use proper endian by calling cpu_to_fdt32(), the parameter "val" is no 
> longer a simple constant or variable but is, instead, a function call or 
> macro or nothing at all, depending on the host endian and compiler 
> implementation.  It turns out that this apparently wasn't a problem, but 
> I'm still of the opinion that those #defines have minimal value and 
> makes the code baroque. ;-)
> 
> I've attached a patch file that shouldn't be whitespace damaged this 
> time.  :-/  I can also make my git repository accessible if that is 
> helpful.
> 
> Best regards,
> gvb

Hi David,

I exposed my git repository for my hacks on libfdt:
<http://www.cideas.us/cgi-bin/gitweb.cgi?p=linux/libfdt.git;a=summary>

BTW, a patch I didn't publish (yet)added some comments:
<http://www.cideas.us/cgi-bin/gitweb.cgi?p=linux/libfdt.git;a=commitdiff;h=775fee94444b4cda010e3d55f8c2aa1a0efe8856>

I also neglected to mention that, in the patch that was attached to the 
parent email, I added a configuration option to tests/Makefile to more 
easily select trees.S vs. dtc (now it is just ugly instead of fugly).

Best regards,
gvb

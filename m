Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 783CC100807
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 15:39:57 +1000 (EST)
Message-ID: <4C146F18.9030008@firmworks.com>
Date: Sat, 12 Jun 2010 19:39:36 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request review of device tree documentation
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
In-Reply-To: <AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	Olof Johansson <olof@lixom.net>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sat, Jun 12, 2010 at 4:52 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>   
>> On Sat, 2010-06-12 at 06:30 -1000, Mitch Bradley wrote:
>>
>>     
>>> I'm certainly going to try keeping OFW alive.  On the x86 OLPC machines,
>>> the ability to
>>> dive into OFW via a SysRq key combo was very helpful for debugging some
>>> difficult
>>> problems.  The team has asked me to support the feature on ARM.
>>>       
>> Oh well, if you can and can convince the ARM kernel folks to do the
>> necessary changes ... :-)
>>     
>
> What is needed to keep OFW alive?  I've got no problem with doing so
> if it isn't invasive, and as long as the same boot entry interface can
> be used.
>   

Minimally, OFW needs to own some memory that the kernel won't steal.  
OFW on ARM
is position-independent, so it can be tucked up at the top of memory 
fairly easily.

To call back into OFW, the virtual mapping for that memory needs to be 
reestablished.
Or perhaps the MMU and caches can be turned off for the duration of the 
callback.
I don't have the details of ARM MMUs and caches reloaded into my head 
yet.  Maybe next week...

Also, for debugging, OFW typically needs access to a UART.  If the OS is 
using the UART,
it's often possible for OFW to use it just by turning off interrupts and 
polling the UART.

>   
>> One thing tho, you will only benefit from the whole infrastructure we
>> have created accross platforms in linux if the device-tree is "sucked"
>> into linux at boot. IE. Linux will not do constant accesses to OF for
>> the DT. Even sparc converted to that now.
>>
>> That means that if your device-tree has a dynamic nature, we'll need to
>> come up with a way to inform the kernel of changes in it so it can
>> update it's copy accordingly.
>>     
>
> What is the use-case for having a dynamic device tree? 

The use case for a dynamic device tree is not compelling.

In SPARC / Solaris land, Open Boot managed the non-volatile 
configuration variables, which the OS could access and modify 
dynamically as properties in /options.  The OS didn't have to know the 
storage layout nor the hardware details of the storage device.  
Convenient, but not hugely important.

>  I can see
> keeping OFW alive being useful for some debug facilities, but once the
> kernel has started, I'm really not interested in relying on firmware
> to manage the hardware. 

That's sort of a self-fulfilling prophecy.  If the OS doesn't trust the 
firmware, there is no pressure for the firmware to "get it right".

In PC land, the current status quo is that Windows depends on ACPI so 
heavily that BIOS vendors pretty much have to get that part of the 
puzzle right.  Microsoft did a thorough job of creating certification 
tests and enforcing their use.  I'm not praising ACPI, just pointing out 
the dynamics that result from assignment of responsibility.

That said, I'm not interested in pushing the issue.  It's okay with me 
if the device tree is static as far as the kernel is concerned, and 
callbacks to OFW are only used for debugging purposes.

>  (but then again it's no secret that I'm
> suspicious of anything that depends on runtime interaction with
> firmware).
>
> g.
>
>   

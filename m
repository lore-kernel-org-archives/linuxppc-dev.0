Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D53C1007DD
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 02:30:36 +1000 (EST)
Message-ID: <4C13B618.1030006@firmworks.com>
Date: Sat, 12 Jun 2010 06:30:16 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Request review of device tree documentation
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>	
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>	
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>	
	<4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
In-Reply-To: <1276339684.1962.186.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sat, 2010-06-12 at 20:45 +1000, Benjamin Herrenschmidt wrote:
>   
>> On Fri, 2010-06-11 at 22:19 -1000, Mitch Bradley wrote:
>>     
>>> It seems that many of the differences at the CPU level can be determined 
>>> by looking at "coprocessor" registers.  For what purpose(s) do we need 
>>> to identify the core?  That will inform our choice of a core ID schema.
>>>       
>> The primary thing I see would be architecture version compliance,
>> though this is better carried additionally via a binary field in
>> the header or a GPR at the entry point, to help the initial asm
>> code to setup the MMU etc... before getting into C code.
>>     
>
> Also, if you're going to revive a "real" OF port to ARM (with client
> interface etc...), should we start considering moving some of powerpc's
> prom_init.c to a generic place ?
>
> IE. prom_init is a trampoline that uses the client interface to
> essentially create a flatten device-tree and enter the kernel via the
> common "epapr" style entry point.
>
> The main drawback is that it doesn't allow to keep OF alive along with
> the OS, but then, only sparc does that successfully and I'm not sure
> it's something that would be practical to do on ARM either.
>   

I'm certainly going to try keeping OFW alive.  On the x86 OLPC machines, 
the ability to
dive into OFW via a SysRq key combo was very helpful for debugging some 
difficult
problems.  The team has asked me to support the feature on ARM.

> Cheers,
> Ben.
>  
>
>   

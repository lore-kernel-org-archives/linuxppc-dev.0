Message-Id: <v04003a00b5a8c0b923e3@[24.66.67.194]>
In-Reply-To: <20000729093817.C4552@opus.bloom.county>
References: <39821DD7.ED0DA0A2@embeddededge.com>; from dan@netx4.com on
 Fri, Jul 28, 2000 at 07:57:11PM -0400 <39821DD7.ED0DA0A2@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 29 Jul 2000 12:26:32 -0500
To: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: CONFIG_PPC != Mac
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:38 AM -0500 7/29/2000, Tom Rini wrote:
>On Fri, Jul 28, 2000 at 07:57:11PM -0400, Dan Malek wrote:
>
>> So, the 2.4.0 PowerPC tree is now Mac workstation only?  Please,
>> we can't make the assumption that CONFIG_PPC is a Macintosh.  It
>> breaks all PowerPC embedded systems (or anything that isn't a recent
>> Mac with USB).  There is a CONFIG_MAC, isn't that enough to do the same
>> thing?
>
>Well, where are the specific breakages?  (CONFIG_MAC is used for 68k only
>right now, IIRC.)

Add a CONFIG_PMAC maybe? I don't really object to sharing CONFIG_MAC with
PPC, except that it would be easy to assume that CONFIG_MAC == CONFIG_MAC
&& __powerpc__, and vice versa CONFIG_MAC == CONFIG_MAC && __m68k__.

On the other hand, using a CONFIG option all over the place is probably the
wrong answer for this. I'd rather see something along the lines of:

#ifdef CONFIG_PMAC
#define MACH_IS_PMAC (machtype == MACH_PMAC)
#else
#define MACH_IS_PMAC 0
#endif

...

if (MACH_IS_PMAC) {
	/* do powermac stuff here */
}

which may already exist, I haven't ever bothered to look. Anyways, it would
let you either strip out powermac code, or build a kernel that works both
on powermacs and non-powermacs alike, depending on which you want.


Or whatever.

Cheers - Tony :)


--
Tony Mantler       Renaissance Nerd Extraordinaire     nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada                     http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E4299264459540C109862@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Bare bones filesytem using Karim's book
Date: Tue, 3 Jun 2003 06:55:07 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the feedback Wolfgang and Karim...

Regarding the ELDK target filesytem, all I did was try to strip it down using 'ppc_4xx-rpm -e package' as far as I could go. The remaining packages below are there because the above command would could not remove them because of package dependencies. So, the reason busybox and sysvinit are both shown in the list is because they were part of the initial ppc_4xx target filesystem provided with the ELDK.

Based on your responses, it sounds like the steps provided in Karim's book should work. I'll try the suggestions provided.

Regarding my tool chain, for and x86-host --> ppc-target setup, the following packages were suggested in the book:

gcc - 2.95.3
binutils - 2.10.1
glibc - 2.2.1

When I tried to build this tool chain (on RH8.0 system) glibc would not compile. I then checked the versions used in the ELDK tool-chain which were as follows:

gcc - 2.95.4-4j
Binutils - 2.11.93.0.2-3b
glibc - 2.2.5-0.19a

So, I tried building the tool-chain again using versions obtainable from gnu.org that were as close to the ELDK as possible without being more recent:

gcc - 2.95.3
binutils - 2.11.2
glibc - 2.2.5

If anyone has any suggestions as to a different combination of version, please let me know.

-- Brian

> -----Original Message-----
> From: Karim Yaghmour [mailto:karim@opersys.com]
> Sent: Monday, June 02, 2003 7:56 PM
> To: brian.auld@adic.com
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Bare bones filesytem using Karim's book
>
>
> Hello Brian,
>
> Apart from what Wolfgang has already said, I would add the following
> gotchas:
> - Make sure the library you are linking your init to, whichever one it
> may be, is actually functional. I have seen some glibc versions
> compile fine and fail to work on the target. See the 4th paragraph
> on p. 112 for an example. Suggestion: try a different C library
> version.
> - Your libs may not be properly located. Suggestions: try linking
> your init statically.
> - Try putting something else as init. Use the init= kernel boot param
> to pass some custom statically linked program that does something
> obvious (while(1) printf(...); for example) and check if that works.
>
> brian.auld@adic.com wrote:
> > Any quick thoughts on why this might be happening? To provide a
> comparison benchmark as I worked through this, I copied the (i) dev files,
> (ii) inittab and (iii) rc.sysinit from chapter 6 of the book (my "from
> scratch filesytem") to the ELDK stripped down target filesystem and this
> setup still boots.
>
> Right, this sounds like a library thing. Though I may be wrong.
>
> > Most of the above were left in as I felt they needed to be there or they
> were "required" sysVinit or initscripts, which I didn't want to remove...
>
> Better watch out for having both sysVinit and BusyBox-init as Wolfgang
> already pointed out.
>
> HTH,
>
> Karim
>
> --
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 514-812-4145

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

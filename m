Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 9368067B62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 02:18:54 +1000 (EST)
Message-ID: <44A2ABE9.1060309@dlasys.net>
Date: Wed, 28 Jun 2006 12:18:49 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to get individual patches
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>	
	<20060627212448.7d048b7a@White64> <44A23488.7030606@dlasys.net>
	<528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
In-Reply-To: <528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 6/28/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>>
>>     The bsp I am working on works with 2.6.16.21 but fails with 2.6.17.
>>
>>     How can I find the individual patches that make up the transition
>> from 2.6.16.21 to 2.6.17 ?
>
> Unfortunately, there isn't a direct line between .16.21 and .17 which
> makes it complicated.  Does your bsp work with .16?  If so; you can
> use the 'git bisect' command to figure out exactly where the
> regression occured.
>
> If it doesn't work on .16; you can do a bisect between .16 and .16.21
> to figure out what patch is missing between .16 and .17.
>
> $ git bisect good v2.6.16
> $ git bisect bad           # the head of the tree
> compile, test, etc.
> $ git bisect good|bad    # depends on whether it works or not
> compile, test, etc
> $ git bisect good|bad    # you get the idea... repeat until it's
> narrowed down
> $ git log                          # see where you are in the git tree.
    Thanks,

       At the moment I am not working out of a git tree - but I was
previously.
   
       What I have works with everything from 2.6.15 through 2.6.16.21 -
or atleast the 15+ odd interim steps I tried.
    It fails if I go from 2.6.16 to 2.6.17.

       I can probably actually check into why it is not working - looks
alot like an ml403 mmu hang posted earlier (I am working with a Xilinx V4).
    But I was hoping I could get away with brute force/divide and
conquer and isolate it to a single patch before actually trying to
figure out the problem.

    I am going to have to get better at git.
>
> Cheers,
> g.
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

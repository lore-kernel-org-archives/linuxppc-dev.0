Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 1426867BC3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 13:46:42 +1000 (EST)
Message-ID: <44BB080E.6060107@dlasys.net>
Date: Sun, 16 Jul 2006 23:46:22 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: how to get individual patches
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>	
	<20060627212448.7d048b7a@White64> <44A23488.7030606@dlasys.net>	
	<528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>	
	<44B7DEC3.1090308@dlasys.net>
	<528646bc0607141122t53adeb30h8c2acb4e26ba0ddf@mail.gmail.com>
In-Reply-To: <528646bc0607141122t53adeb30h8c2acb4e26ba0ddf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
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
> On 7/14/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>
> AFAIK, yes you will have to repatch every time; I typically write a
> little helper script to lessen the pain:
>
> git bisect good|bad # depends on whether it works or not
> patch < [patchfile]
> compile, test, etc
> cg restore -f     # Remove the patches
> git bisect good|bad   # lather, rinse, repeate
>
    Alright, I have bisected my way down to the problem.
    Well sort of.
    I think the real problem I started looking for eventually got fixed
in the kernel tree on its own.

    But I did find a real problem. I have found my own work around - but
this problem may effect others.

    The zlib library was updated within the past month.
    The new zlib code does not work in my environment.
    I have guesses as to why, but I am not a zlib expert and not looking
to be one.
    I have solved my personal problem by reverting to the older zlib code.
    With that I have 2.6.18-rc4 or whatever is in the linux-2.6 git tree
as of today working for me.
    I was stuck at 2.6.16.21 before.
   
    So my questions:

    How/where do I report a problem ? I would be perfectly happy to help
whoever is responsible for zlib to work this out.
    But I am not up to doing it myself.

    git bisect got me down to a good/bad scenario. But I could not
provoke git to either pull the offending patch or export the change as a
patch so that I could back it out myself.
    Now that the final git bisect screen is gone all I have (besides a
fixed 2.6.18-xx kernel) is I guess the sha has number for the particular
commit.
    I suspect that would have been enough to yank just that patch but I
googled every permutation of git backout or similar things I could think
of and browsed the git tutorials etc.
    and could not seem to decipher how to do anything usefull with the
sha id of a single patch.
    I am sure that is a knowledge problem.






-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

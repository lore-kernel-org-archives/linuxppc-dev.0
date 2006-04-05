Return-Path: <dalang@cs.ubc.ca>
Received: from mail-relay1.cs.ubc.ca (mail-relay1.cs.ubc.ca [142.103.6.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2705D67A5C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 23:20:55 +1000 (EST)
Date: Wed, 5 Apr 2006 06:20:51 -0700 (PDT)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Usha Rani Konudula <UshaRani.Konudula@borland.com>
Subject: Re: Dynamically linking to pthread library
In-Reply-To: <C9CDA704CB0EEA4DBE2EFC05AE11851C1C6A8A@SGSGS-EXCH01.apac.borl.net>
Message-ID: <Pine.LNX.4.60.0604050603250.2128@tin.icics.ubc.ca>
References: <C9CDA704CB0EEA4DBE2EFC05AE11851C1C6A8A@SGSGS-EXCH01.apac.borl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> Do you need to explicitly specify -pthread option to g++ to make the 
> target library link with pthread dynamically. Otherwise does it 
> statically link to pthread library on ppc64 power5.

You can use "ldd" to tell you which libraries are dynamically linked to an 
executable.  Read "man ldd" for more details.  You can add the "-v" 
(verbose) flag to your g++ link command, which will tell you the full 
details of what it's linking in.

My guess is that you need to specify "-pthread" explicitly.  What happens 
if you create a program that calls a pthread function and you don't 
specify "-pthread".  Does it link?  If it does, then the compiler is 
getting that pthread definition from _somewhere_.  What does "g++ -v" tell 
you?  What does "ldd" tell you?

By the way, a better way to ask questions on a mailing list is to explain 
what you're trying to do, what you've tried to do to achieve it, and why 
it didn't work.  It usually helps to be explicit about each step.  Show 
that you've tried to figure it out for yourself.

Cheers,
dstn.

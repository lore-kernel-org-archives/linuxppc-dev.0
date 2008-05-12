Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B92DDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 May 2008 20:33:36 +1000 (EST)
Date: Mon, 12 May 2008 12:27:28 +0200
From: Alessandro Rubini <rubini@gnudd.com>
To: ramkumarj2000@gmail.com
Subject: Re: Compiling applications using cross compiler packs libc
Message-ID: <20080512102728.GA26806@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com>
References: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com> 
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> the glibc is also packed
> up as a part of application though I never make any calls to the glibc
> libraries.

As already pointed out by Marco Stornelli, you shouldn't get concerned
about glibc as it's a standard library and you expect it to be part of
the target system (again, use uclibc if size is an issue).

If however you really want to build an application without library, you
should change the linker script. The kernel is not calling main() directly,
there is some initial setup involved, and this is where glibc (or uclibc)
is involved, even if you do no library calls yourself.

Look at a boot loader, or at the kernel, and then to proper
documentation, to find how to provide your own linker script to avoid
a library. But I doubt you really need it.

/alessandro

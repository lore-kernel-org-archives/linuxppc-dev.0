Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 42700DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 May 2008 20:02:54 +1000 (EST)
Message-ID: <482815D3.8020309@coritel.it>
Date: Mon, 12 May 2008 12:02:59 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Ramkumar J <ramkumarj2000@gmail.com>
Subject: Re: Compiling applications using cross compiler packs libc
References: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com>
In-Reply-To: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Ramkumar J ha scritto:
> Hi All,
> 
> I am trying to execute a compiled simple stand-alone application (
> TestApp_Memory.c compiled with gcc 4.1.0 cross compiler for ppc [ I have
> installed this through crosstool on a Linux PC ] ) on the ML403 Board
> instead of using the compiler-set provided by XPS. I tried many options (
> like --static to gcc) to make the object file little as produced by the XPS
> Compiler Set. I find that when static is provided, the glibc is also packed
> up as a part of application though I never make any calls to the glibc
> libraries. If I dont provide the --static, the gcc produces a code assuming
> the library as shared and hence I get an interp section.
> Is there any way to produce the code  with only the application and NOT the
> glibc ( As XPS compilers does). Am I missing out something. Is there any
> specific flags. I find even nodefaultlib does not work.
> 
> For Eg: This is another example I tried
> 
> int main()
> {
>     int a = 5;
>     int b = 10;
>     int c = 15;
> 
>     c = a + b;
> 
>     c += 12;
> 
>     return 0;
> }
> 
> With --static compilation, size is about 500K for the above code though the
> useful content is too less. objdump reveals unneccessary calls to the libc.
> Any suggestions would be helpful.
> 
> Thanks and Regards,
> Ramkumar
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
You shouldn't use --static but -Os to have a "little" program. With 
static you include all the libraries in your application therefore you 
have a bigger application. In addition libc are basic libraries so you 
have to use it. If you have size problems you can use uclibc.

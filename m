Date: Wed, 19 May 1999 23:04:58 +0200
To: "Thomas C. Allison" <allison@dirac.nist.gov>
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: possible egcs c compiler bug
Message-ID: <19990519230458.C29936@isis.isis.de>
References: <199905192019.QAA00884@dirac.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199905192019.QAA00884@dirac.nist.gov>; from Thomas C. Allison on Wed, May 19, 1999 at 04:19:17PM -0400
From: Hartmut.Koptein@t-online.de (Hartmut Koptein)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have found what *appears* to be a bug in the C compiler.  I have experienced
> this bug in R4 (regardless of the compiler/library installed) as well as in
> the latest (i.e. all the latest packages through 5/15/1999) pre-R5
> installation.  I include a short program below which illustrates the problem
> I am having.  The code compiles without error on my i386 machine
> running RHL 5.2.  The version of EGCS on the PC is 1.0.3 versus 1.1.2 on my
> PowerMac, so I don't know if this is a PPC problem or an EGCS problem.
> Any input is greatly appreciated.
> 
> The code is as follows:
> 
> test.c:
> 
>      #include <stdio.h>
>      #include <stdarg.h>
> 
>      static int myFunction(va_list inList)
>      {
>         va_list newList;
>         newList = inList;
>      }


Try this:

      #include <stdio.h>
      #include <stdarg.h>

      static int myFunction(va_list inList)
      {
         va_list newList;
         
	 __va_copy(newList, inList);
      }




-- 
 Dipl.-Ing. (FH) Hartmut Koptein                       EMail:
 Friedrich-van-Senden-Str. 7                           
 26603 Aurich   
 Tel.: +49-4941-10390                                  koptein@debian.org

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

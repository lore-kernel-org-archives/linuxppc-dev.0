Return-Path: <medp@primagraphics.com>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 3B61C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 00:43:31 +1000 (EST)
Message-ID: <4177CB07.4000302@primagraphics.com>
Date: Thu, 21 Oct 2004 15:43:19 +0100
From: Mark Powell <medp@primagraphics.com>
MIME-Version: 1.0
To: jonathan@jonmasters.org
References: <41777D14.7090108@primagraphics.com>
	<35fb2e5904102106303edb204b@mail.gmail.com>
In-Reply-To: <35fb2e5904102106303edb204b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Masters wrote:

>On Thu, 21 Oct 2004 10:10:44 +0100, Mark Powell <medp@primagraphics.com> wrote:
>  
>
>>The system seems to basically run fine apart from the fact that gdb
>>doesn't stop at any breakpoints.
>>    
>>
>Can you please provide an example? How are you running the program
>being debugged? If it's a daemon, are you running it interactively or
>trying to let it detach itself?
>  
>
Even the most simple scenario doesn't work, e.g.:

    dev245:medp LinuxTestProgs> gcc -g -Wall -o hello hello.c
    dev245:medp LinuxTestProgs> gdb hello
    GNU gdb Yellow Dog Linux (5.2.1-4b_3)
    ...
    (gdb) l
    1       #include <stdio.h>
    2      
    3       int main(int argc, char* argv[])
    4       {
    5               printf ("Hello world\n");
    6               return 0;
    7       }
    (gdb) break 5
    Breakpoint 1 at 0x100004a8: file hello.c, line 5.
    (gdb) run
    Starting program:
    /central/Build/MEDP/Sentric576/Code/LinuxTestProgs/hello
    Hello world

    Program exited normally.
    (gdb)

As you can see, it just doesn't break.
I did some more checking. The same card running a 4xx file system from 
MontaVista 2.1 behaves the same. A 405GP card running the MVL2.1 behaves 
properly. So it points to something about the 440.
As I said, kernel is 2.4.25 from ELDK3.0. I cloned the basic platform 
init code from the Ebony pretty closely, just changed the external 
interrupt configs, RTC type and things like that.

I would appreciate any ideas.
thanks

-- 
Mark Powell, Senior Software Engineer
Curtiss-Wright Controls Embedded Computing
Tel: +44 (0) 1763 852222
Email: medp@primagraphics.com

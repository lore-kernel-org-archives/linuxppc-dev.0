Message-ID: <3F1D5B74.8040604@mvista.com>
Date: Tue, 22 Jul 2003 10:42:44 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: C Doyle <cdoyle35@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boa Cross Compile for MPC8266ADS?
References: <Law10-F14oFLaqSOc7w000291b9@hotmail.com>
In-Reply-To: <Law10-F14oFLaqSOc7w000291b9@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Slightly off subject, but any reason you are working on Boa.  (I have
not used it myself.)  But I know thttpd is small and is capable of
running CGI applications.  (It also cross compiles properly.)  :)

Back to your original question...

Assuming the application build infrastructure isn't on crack
(unfortunatly a lot of apps are...) you will need to set:

CC=cross compiler
AS=cross assembler
LD=cross linker
AR=cross ar (optional)
RANLIB=cross ranlib (optional)
CPP=cross cpp (optional)
CXX=cross C++ (g++) compiler
NM=cross nm (optional)
STRIP=cross strip

Then make sure that when you run configure you have --host= set to
"powerpc-linux".  You may also want to set --build= to whatever your
host architecture is.  ("gcc -dumpmachine" is an easy way to get the
fill canonical name.)

Now ASSUMING the application's configure script is correct the system
should be now setup to build.  Just type make and your should get a
working application.  (Of course it's rarely this simple.. For instance
you may have to manually pass configure values into the configure step
to work around things it can't automatically determine for cross
compilation.)

--Mark

C Doyle wrote:
>
> Hello all,
> I'm a student working with Motorola for a dissertation project. I'm
> using the MPC8266ADS-PCI development board to write a device driver for
> a usb peripheral. What I'm intending to do is use the Boa Webserver to
> throw up a webpage and run cgi-scripts to configure the device driver
> from a remote host and also give some Tx/Rx/Error reporting. I'm quite
> new to the embedded world and I can't seem to get Boa to cross compile
> for the board. I'm using the hardahat devkit cross compiler but when I
> point the Make file to the compiler its not happy. Is there anyone who
> has already compiled this for the MPC8266 and can I use the ./configure
> shell script with flags to tell it I want to cross compile? Any help
> would be greatly appreciated as the homepage only describes the setup
> with the default ./configure script. Thanx
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

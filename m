Return-Path: <carlos@kenati.com>
Message-ID: <45196562.50409@kenati.com>
Date: Tue, 26 Sep 2006 10:37:38 -0700
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Iwan Koenig <iwankoenig@yahoo.de>
Subject: Re: Asterisk on Embedded Linux
References: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
In-Reply-To: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Iwan Koenig wrote:

>Does anyone known how to compile Asterisk for a
>powerpc-processor?
>I have tryed:
>./configure --target=powerpc-linux
>--host=powerpc-604-linux-gnu --prefix=/opt/packages
>And it gives following error:
> /root/pwlib/include/ptlib.h... configure: error:
>cannot check for file existence when cross compiling
>
>Ok! I see that it is trying to find the PWLIB-Library.
>Also, i have tryed to compile the pwlib.
>But it didn't work :(. For PWLIB i need the OpenLDAP,
>and when i have compiled the OpenLDAP, than needs
>PWLIB other packages.......
>Also, have anyone ideas, how to compile Asterisk für a
>powerpc-processor with another way?
>
>Thanks!!!!
>
>  
>
I'm not sure if our experience applies to you since we use asterisk as a 
TA instead of a PBX in our embedded gateways. We ran into a lot of 
problems when trying to cross-compile a trimmed down version of 
asterisk. Basically, we only needed the sip stack, fxs support, and some 
codecs. It was a big effort, but we are currently successfully 
cross-compiling asterisk for several platforms. We had to change 
Makefiles, source code, etc.

I would start by removing the references to PWLIB and anything I don't 
need from the makefiles and #ifdefing code that uses it until I get it 
to compile. Then start testing it and adding features as needed.

This is the command line we use to compile asterisk (just to give you 
and idea. It won't work with your sources. We don't run configure):

make CC=powerpc-uclibc-gcc CONFIG_TA=y OPTIMIZE="-mcpu=603e -Os" 
HOSTCC=gcc all


Carlos

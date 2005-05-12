Return-Path: <jjboor@aimsys.nl>
Received: from smtp04.wanadoo.nl (smtp04.wanadoo.nl [194.134.35.144])
	by ozlabs.org (Postfix) with ESMTP id 1D18067B14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 20:26:31 +1000 (EST)
In-Reply-To: <25101.1115889218@www45.gmx.net>
References: <20050512074615.30BE8C1512@atlas.denx.de>
	<25101.1115889218@www45.gmx.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <d2163c240d3070ac810975f1346a0d88@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 12 May 2005 12:26:26 +0200
To: "Peter Gehirnforce" <Gehirnmann@gmx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK/DENX: doesn't find iostream-lib when linking
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

you should use g++ as compiler front end when compiling C++ programs
> compiler =3D ${CROSS_COMPILE}g++

best regards,

Jaap-Jan

On 12-mei-05, at 11:13, Peter Gehirnforce wrote:

> I use a makefile with dependencies:
>
> --------------------------------------------------
> # Makefile for simple test program
> # The CROSS_COMPILE is set globally, as well as ELDK gcc-paths
>
> compiler =3D ${CROSS_COMPILE}gcc
> simple_server_objects =3D ServerSocket.o Socket.o simple_server_main.o
> simple_client_objects =3D ClientSocket.o Socket.o simple_client_main.o
>
>
> all : Socket ServerSocket simple_server_main simple_server =
ClientSocket
> simple_c
> lient_main simple_client
>
> simple_server: $(simple_server_objects)
>         $(compiler) -o simple_server $(simple_server_objects)
>
>
> simple_client: $(simple_client_objects)
>         $(compiler) -o simple_client $(simple_client_objects)
>
> #ppc_gcc dependencies, added for compiling with ppc only!!
> Socket:
>         $(compiler) -o Socket.o -c Socket.cpp
>
> ServerSocket: Socket.o
>         $(compiler) -o ServerSocket.o -c ServerSocket.cpp
>
> ClientSocket: Socket.o
>         $(compiler) -o ClientSocket.o -c ClientSocket.cpp
>
> simple_server_main: ServerSocket.o
>         $(compiler) -o simple_server_main.o -c simple_server_main.cpp
>
> simple_client_main: ClientSocket.o
>         $(compiler) -o simple_client_main.o -c simple_client_main.cpp
>
> clean:
>         rm -f *.o simple_server simple_client
> ------------------------------------------------
>
> The program itself is using <string> <iostream> and other STL libs =
with
> namespaces in use.
> It compiles for i686 on my host machine.
> BUT I had to change the Makefile!!! (that is why I posted it)
> The dependencies starting from "gcc-ppc" dependencies are added.
> Are they defined wrong?
>
> Peter
>
>> --- Urspr=FCngliche Nachricht ---
>> Von: Wolfgang Denk <wd@denx.de>
>> An: "Peter Gehirnforce" <Gehirnmann@gmx.de>
>> Kopie: etux@embeddedtux.org
>> Betreff: Re: ELDK/DENX: doesn't find iostream-lib when linking
>> Datum: Thu, 12 May 2005 09:46:10 +0200
>>
>> In message <28918.1115882747@www45.gmx.net> you wrote:
>>>
>>> when compiling for ppc_6xx architecture, the linker doesn't find the
>> lib's
>>> for iostream headers.
>>> Do I have to use other headers than the standard <iostream> ones, or=20=

>>> do
>> they
>>> simply not exist?
>>
>> I guess this is a usage  error.  Can  you  please  provide  a  simple
>> example which shows the problem?
>>
>> Best regards,
>>
>> Wolfgang Denk
>>
>> --=20
>> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>> What is research but a blind date with knowledge?      -- Will Harvey
>> _______________________________________________
>> etux mailing list
>> etux@embeddedtux.org
>> http://www.embeddedtux.org/mailman/listinfo/etux
>>
>
> --=20
> +++ Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS +++
> GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

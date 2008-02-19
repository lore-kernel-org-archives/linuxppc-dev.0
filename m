Return-Path: <raul.moreno@telvent.abengoa.com>
In-Reply-To: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
Subject: Re: 2.6.24 for mpc8458amc
To: "maxime louvel" <m.louvel@gmail.com>
Message-ID: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
Date: Tue, 19 Feb 2008 13:19:08 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello Maxime,

if your board is still running, although you can't see the messages tha=
t
means you don't have any console. Try to set one (I think you can use a=
 SCM
of the CPM) in the kernel configuration (characters devices)  or in the=

command line (console=3D).

Anyway, if you want to be sure if the  kernel is booting up, look up th=
e
buffer where the messages are saved before the console is enabled. Find=
 the
function __log_buffer in the System.map file and throu the bootloader, =
have
a look at this address.

Ra=FAl Moreno



"maxime louvel" <m.louvel@gmail.com>
"maxime louvel"
Enviado por:
linuxppc-embedded-bounces+raul.moreno=3Dtelvent.abengoa.com@ozlabs.org
19/02/2008 12:59
                                                                       =
                                                
 Para:   linuxppc-embedded@ozlabs.org                                  =
                                                
                                                                       =
                                                
 cc:                                                                   =
                                                
                                                                       =
                                                
 Asunto: 2.6.24 for mpc8458amc                                         =
                                                
                                                                       =
                                                





Hi,

I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a sec=
ond
time) on a mpc8548amc board.
I have add the platform specific stuff from the sources of the current
kernel running on the cards.
What I have basically add is:
- a folder mpc8548amc, in the config/platform directory, which allow to=

select the mpc8548amc as the supported platform
- add the following files:
  - arch/ppc/configs/mpc8548amc_defconfig
  - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c
- I have used the dts of an another platform (mpc8548cds) which seems q=
uite
the same, but I haven't got any confirmation of that yet.

When I am booting the kernel image I get:

AMC=3D> dhcp 0x1000000 uImage.amc.2.6.24
Speed: 1000, full duplex
BOOTP broadcast 1
DHCP client bound to address 10.255.255.2
Using eTSEC0 device
TFTP from server 0.0.0.0; our IP address is 10.255.255.2; sending throu=
gh
gateway 10.1.1.1
Filename 'uImage.amc.2.6.24'.
Load address: 0x1000000
Loading: ##############################
###################################
        ###############################################################=
##
        ###############################################################=
##
        ###############################################################=
##
        ###############################################################=
##
        ###########################
done
Bytes transferred =3D 1802102 (1b7f76 hex)
AMC=3D> bootm 0x1000000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.24
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1802038 Bytes =3D  1.7 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

No further messages...

Does someone has an idea ?

thanks,
Maxime


--
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom _______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded=

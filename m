Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 743C2DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 May 2007 03:34:40 +1000 (EST)
Message-ID: <4659C10D.7070107@anagramm.de>
Date: Sun, 27 May 2007 19:34:05 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
Subject: Re: ML403 2.6 kernel, root file system on NFS, stops after freeing
	unused kernel memory
References: <BAY115-W15A8C3F50BF6AA5251BAB9B22A0@phx.gbl>
In-Reply-To: <BAY115-W15A8C3F50BF6AA5251BAB9B22A0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Mohammed!

Mohammad Sadegh Sadri schrieb:
> ok! problem solved
> problem was kernel command line
> mine was:
> 
> CONFIG_CMDLINE="console=ttyS0,9600 console=tty0 root=/dev/nfs rw nfsroot=10.10.10.10:/home/sadri/hdl/eldk_rootfs/ppc_4xx ip=dhcp"
> 
> by default 2.6.21 CMDLINE contains two console parameters, 
> the correct one should be 
> 
> CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/nfs rw nfsroot=10.10.10.10:/home/sadri/hdl/eldk_rootfs/ppc_4xx ip=dhcp"
> 
> well , rootfs comes up until login prompt,
> I enter root as the password but it gives "incorrect login" message/

I have had the same symptoms.
Some device node was missing. I guess it was something like:

crw--w--w- 1 root tty      5,   1 May  1 09:30 console
crw-rw-rw- 1 root tty      5,   0 May 27 10:14 tty

Also check
-----8<-----
#
# /etc/securetty: defines which devices root can log in on
#

console
ttyS0
tty1
tty2
tty3
tty4
tty5
tty6

# End of file
-----8<-----

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19

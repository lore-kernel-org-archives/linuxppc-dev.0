Return-Path: <adrian@it-live.co.uk>
Received: from ns1.it-live.co.uk (ns1.it-live.co.uk [195.10.233.36])
	by ozlabs.org (Postfix) with ESMTP id B8A7167BB4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 21:48:06 +1000 (EST)
Received: from adrianlaptop (63.Red-83-37-241.dynamicIP.rima-tde.net
	[83.37.241.63])
	by ns1.it-live.co.uk (8.13.6/8.13.3) with SMTP id k9CBlsQH020162
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 Oct 2006 11:48:00 GMT
Message-ID: <005b01c6edf4$452f03b0$3a0da8c0@adrianlaptop>
From: "Adrian" <adrian@it-live.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Subject: PPChameleonEVB Newbie question
Date: Thu, 12 Oct 2006 13:47:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Reply-To: Adrian <adrian@it-live.co.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Wolfgang.

I have now got the target compiling modules, kernel and everything.

For the record, I found it very difficult and time consuming.

To get to this stage I had to :-

Install Slack 8.1 kernel 2.4.18
Install ELDK version 4
as per docs add /usr/local/eldk/usr/bin:/usr/local/eldk/bin to PATH

set and export ARCH=ppc, CROSS_COMPILE=ppc_4xx-

make mrproper

make PPChameleon_defconfig

edit arch/ppc/platforms/4xx/Kconfig and add

'select WANT_EARLY_SERIAL'

to PPChameleonEVB definition

make menuconfig

make
then copy kernel to /tftpboot dir.

Board then booted ok provided the ELDK instructions about NFS shares were 
followed.

Under Slack 9 + 10.1 the kernel cross-compile barfed with 'clobber list' 
errors.

The dev host would cross-compile the modules, but wouldn't install them 
(INSTALL_MOD_PATH set).

After that i wanted to build the Kernel and modules on the target to make 
sure it was all ok, so :-

Installed Perl 5.6.4 with etc/Digest/MD5 copied from Perl 5.8.2 tree
(make modules_install wouldn't work without perl, and it isn't supplied 
AFAICS)
cd /usr/src/linux/include

ln -s asm-ppc asm

make mrproper
make PPChameleon_defconfig

edit arch/ppc/platforms/4xx/Kconfig and add

'select WANT_EARLY_SERIAL'

to PPChameleonEVB definition

make menuconfig

make
make modules
make modules_install

On the target it is (naturally) slow and you have to set up some NFS shared 
swap if you don't have much ram (i have 32mb and the kernel compile ran out 
of memory).

Out of the box i couldn't get ELDK 3.1.1 working at all, and the 
linux-2.4.20-pelk- thing wouldn't compile under either.

The main hurdle was needing to retro-grade the dev host.

Anyway. It is working happily now. Thanks for your help.

Adrian Atkins
IT Live Limited

tel: 0161 408 3327
fax: 08702 360 443
skype: adrianitlive
ES mob: (0034) 606806236 

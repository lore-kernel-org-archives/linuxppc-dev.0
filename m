Message-ID: <3E399D8C.1090808@bluewin.ch>
Date: Thu, 30 Jan 2003 22:47:56 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP
References: <995FF289C9D69747A09E42992644595405B23636@penguin.adic.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

this problem has already been reported some time ago. Search the
linuxppc-embedded mailing list for kbuild_2_4_nostdinc. It's fixed in
the DENX linuxppc_2_4_devel tree.

Hope it helps.

Wolfgang.


On 01/30/2003 10:27 PM brian.auld@adic.com wrote:
> I ran a checksum on the ELDK ISO image with the following result:
>
> [root@ppc-dev bauld]# mount -o loop eldk-ppc-linux-x86.ISO /mnt/eldk
> [root@ppc-dev bauld]# cd /mnt/eldk/
> [root@ppc-dev eldk]# cd 2.0.2/
> [root@ppc-dev 2.0.2]# ls
> ELDK_FIXOWNER  ELDK_MAKEDEV  etc  install  MD5SUM  ppc_4xx  ppc_4xxFP
> ppc_74xx  ppc_7xx  ppc_82xx  ppc_8xx  README.html  RPMS  tools
> [root@ppc-dev 2.0.2]# md5sum -c MD5SUM | grep -v OK
> [root@ppc-dev 2.0.2]#
>
> -- Brian
>
>
> -----Original Message-----
> From: Matt Porter [mailto:porter@cox.net]
> Sent: Thursday, January 30, 2003 4:17 PM
> To: brian.auld@adic.com
> Cc: porter@cox.net; linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Trying to use ELDK to build Ebony/440GP
>
> On Thu, Jan 30, 2003 at 01:02:59PM -0800, brian.auld@adic.com wrote:
>> Matt,
>>
>> Thanks for the response. I was pretty surprised myself and to say the
> least
>> am not having a very good day.
>>
>> Regarding the linuxppc_2_4_devel build attempt, these were the steps I
> took:
>>
>> In fact, I'm going to run it again on my linux box as I regurgitate the
>> steps I previuosly took:
>>
>> Prerequisites:
>> ==============
>> - running RH8.0
>> - ELDK 2.0.2 installed with ppc_4xx tool chain (check)
>> - linuxppc_2_4_devel obtained from monte vista mirror (check)
>> (1) top-level Makefile hacked to read:
>>     - ARCH := ppc
>>     - CROSS_COMPILE = ppc_4xx-
>> (1) make mrproper
>> (2) make ebony_config
>> (3) make oldconfig
>>     - I accept default(s) for about 10 options I'm prompted for.
>> (4) make dep
>> (5) make zImage
>>
>> When I run make zImage, I get the following error message:
>
>> /opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h:
> No
>> such file or directory
>
> Interesting, it's not picking up stdarg.h from down in the gcc-lib/
> hierarchy.  Probably an ELDK install problem...hopefully Wolfgang
> is reading this thread since he should have a suggestion on what have
> might gone wrong with your installation.
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

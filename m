To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Issues configuring the network interafce on a 8260 board with multiple eth ports 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Feb 2004 14:45:06 GMT."
             <DEF39A0710293E489D45B10E06645CBD02842EEF@dub-msx1.spectelcorp.com>
Date: Tue, 03 Feb 2004 23:45:23 +0100
Message-Id: <20040203224528.D4A92C10A3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DEF39A0710293E489D45B10E06645CBD02842EEF@dub-msx1.spectelcorp.com> you wrote:
>
> I am trying to bring up a second network interface, on a MPC8260 based custom board

You have to decide if you want to use manual IP configuration, or the
kernel's IP autoconfiguration, or  a  mix  of  both.  Note  that  the
kernel's  IP  autoconfiguration  seems  to be capable of handling ONE
interface only.

> I was also looking for details/examples on the kernel cmdline. All
> I could find was a brief reference on the kernel folder
> Documentation/kernel-parameters.txt. Does anybody know of good
> reference for selecting kernel parameters.

See also Documentation/nfsroot.txt for  documentation  of  the  "ip="
boot argument.

> Find below the boot-up sequence that I get when I have both FCC1 and FCC2 eth interfaces enabled.

Please explain EXACTLY what you want to do.  I  _guess_  (but  I  may
guess  wrong)  that  you  will only need one interface enabled by the
kernel's autoconfig mechanism.

...
> Kernel command line: root=/dev/ram rw ip=10.121.10.21:10.121.10.150:10.121.10.254:255.255.255.0:voip_lnx_joao::off mem=32M console=ttyS3,115200 ramdisk_size=8192k

If you check with Documentation/nfsroot.txt, you will note  that  the
empty  string  between  the two colons in "voip_lnx_joao::off" is the
"<device>" part of the IP parameters. You don't specify WHICH of your
two interfaces you want to configure. In the result you get:

...
> IP-Config: Incomplete network configuration information.
> IP-Config: Downing eth0
> IP-Config: Downing eth1

Don't be surprised - this is what you asked for.

Assume you want to use the kernel's IP  autoconfiguration  for  eth0,
then   you   will  have  to  pass  the  kernel  a  boot  argument  of
"...voip_lnx_joao:eth0:off". The eth0 will be properly configured and
up and running  when  your  applications  start.  You  can  then  use
"ifconfig"  to  (manually)  configure  the second ethernet interface,
eth1.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"What if" is a trademark of Hewlett Packard, so stop using it in your
sentences without permission, or risk being sued.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

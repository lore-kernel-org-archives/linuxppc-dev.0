To: "Kamalesh B" <kamal@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK Problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Mar 2003 17:49:23 +0530."
             <3E63484A.6340720C@tataelxsi.co.in>
Date: Mon, 03 Mar 2003 13:30:51 +0100
Message-Id: <20030303123056.178AFC6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E63484A.6340720C@tataelxsi.co.in> you wrote:
>
> Iam working on MPC8260ADS and trying to boot linux-2.4.1 in a standalone
> mode without NFS support.

2.4 1. is very old.  Did  you  make  sure  that  the  "clocks_in_mhz"
variable is set in your PPCBoot environment?

> I loaded both kernel image which was booting earlier with NFS system and

I understand the NFS based kernel was working on your system?

> newly downloaded ramdisk at address 100000 and 200000 respectively. And
> i also updated the bootargs environment variable as
> ---
> setenv bootargs root=/dev/ram
> ip=10.1.40.176:10.1.40.175:10.1.1.1:255.255.0.0:10.1.40.175::off
> ---
>
> where,
> target ip = 10.1.40.176
> server ip = 10.1.40.175
> gateway ip = 10.1.1.1

You should not configure a gateway address when you need none.

> netmask = 255.255.0.0
> host name = 10.1.40.175

This is an IP address, but not a host name.

[Not that teither of these would cause the boot to fail.]

>      Verifying Checksum ... OK
>      Loading Ramdisk to 00ed4000, end 00f5eab4 ... OK
>
>     [After this, no messages]

If your NFS based kernel was working correctly, you should  at  least
see  the  same  boot  messages  until  it  tires  to  mount  the root
filesystem.

> I am stuck at this point and don't know what could be the reason. Can
> somebody help me?

Attach a debugger (BDI2000) and check where it's hanging.

As a poor man's solution, try to find out if a  post-mortem  dump  of
the  log_buf area contains some information: grep the System.map file
in your kernel directory for the virtual  address  of  "log_buf"  and
subtract 0xC0000000 to get the physical address; when you board hangs
press  the  reset  button  and  use PPCBoot's "md" command to print a
memory dump of this area.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Put your Nose to the Grindstone!
                 -- Amalgamated Plastic Surgeons and Toolmakers, Ltd.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

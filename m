Message-ID: <3EE8D12D.4020507@bluewin.ch>
Date: Thu, 12 Jun 2003 21:14:53 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: Christophe.LINDHEIMER@fr.thalesgroup.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running Linux with 2Mo of Ram.
References: <D96E2AFA0DF3D211B139009027454948037362FE@helios.gnv.tcc.thomson-csf.com> <3EE8A746.7010901@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 06/12/2003 06:16 PM Mark Hatle wrote:
> Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
>> Hi.
>>
>> I am trying to run linux on a custom board ( Mpc8xx )
>> There is only 2Mo of RAM.
>> I use romfs to save RAM.
>>
>> I use U-boot to start the kernel.
>>
>> The kernel starts correctly.
>> the kernel is launched with init=/bin/sh
>>
>> The kernel stops to tell me to press enter to activate the console ( to
>> launch the sh ) and then crash because it is running out of memory.
>>
>> The question is to know if it is really impossible to make Linux work on
>> this target or is I have missed something that could explain that there is
>> no more memory available.
>
> You will need some type of "execute in place", i.e. run the kernel and/or
> userspace applications out of ROM in order to work with 2MB of RAM.
>
> This type of thing is generally very board, processor and application specific.
>   So I don't believe there is existing (open source) code to do it.

Some time ago I got XIP working for MPC 8xx with our DENX Linux 2.4.4
kernel by collecting and integrating the various pieces already around.
Below are some results about the amount of memory you can save. Note
that this is for our standard, normally RAMdisk based run time
environment SELF (see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/). If
you have little RAM and plenty of Flash memory XIP might be an option.

Hope it's useful.

Wolfgang.



Normal kernel + linear cramfs (patched):

  pImage:  538062
  cramfs: 1081344

          total:    used:    free:  shared: buffers:  cached:
  Mem:  14921728  3866624 11055104  2781184        0  2240512

XIP kernel + linear cramfs:

  pImage: 1395952
  cramfs: 1081344

          total:    used:    free:  shared: buffers:  cached:
  Mem:  16175104  3940352 12234752  2822144        0  2240512


XIP kernel + XIP cramfs (chmod +t: busybox, initd, libc)

  pImage: 1395952
  cramfs: 1871872

          total:    used:    free:  shared: buffers:  cached:
  Mem:  16175104  2367488 13807616   610304        0   671744

The net saving is > 1.1MB + 1.5M = 2.6 MB.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <geoff@infradead.org>
Subject: Re: Getting kernel 4.14 to run on PS3
To: Sascha Schroeder <sascha.schroeder@aethyx.com>
Cc: Linuxppc-dev@lists.ozlabs.org, petitboot@lists.ozlabs.org
References: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
Date: Fri, 8 Dec 2017 09:37:54 -0800
MIME-Version: 1.0
In-Reply-To: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sascha,

On 12/08/2017 01:24 AM, Sascha Schroeder wrote:
> I yesterday tried to compile the newest kernel 4.14 for my PS3 running
> OtherOS++ and "Red Ribbon GNU Linux" from 2014. I even succeeded and
> created the three *.deb files and installed them afterwards.
> 
> Unfortunately, my machine did not boot.
> 
> As far as I read in very old sources, this could be that my machine is
> using OtherOS++ on firmware 3.55.2 and not the Sony OtherOS prior
> firmware 3.2x.
> 
> I'm in contact with the creator from "Red Ribbon" and he mentioned we
> have to manually patch PS3 linux kernel.
> 
> So, my question 1 would be: which patches would I need to get the newest
> kernel 4.14 running on my PS3 machine?

I don't know about your machine with OtherOS++ on firmware 3.55.2,
but for FAT and DECR-1400 models with firmware 3.15 or lower the
otheros.bld built from the latest ps3-queue-v4.14 branch of my
ps3-linux repo using either ps3_petitboot_defconfig or
ps3_petitboot_nfs_defconfig will boot if written to flash memory
using ps3-flash-util or the XMB [Install Other OS].

  https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git

Be aware that there was a kernel ABI breakage effecting kexec and
that the ps3-petitboot-09.11.30 I released cannot boot kernels newer
than linux-v3.15. See:

  https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg126348.html (Boot new kernel on PS3)
  https://www.mail-archive.com/debian-powerpc@lists.debian.org/msg66884.html (PS3?)

I'm working towards an updated petitboot release.

> Question 2 would be: maybe there exists a second tree where we can get
> the kernel for OtherOS++ too?

Sorry, I don't know.  You'll need to ask for help in the hacker
community for OtherOS++.

> Maybe there is other stuff I am missing, but as far as I can tell the
> sources compile beautifully on the PS3 powerpc machine. Only downside:
> it takes 4-5 hours depending on what you selected in the step of "make
> menuconfig"...

I highly recommend you cross compile on a PC.

-Geoff 

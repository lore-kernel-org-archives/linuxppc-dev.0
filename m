Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: hangs after "Freeing unused kernel memory"
Date: Wed, 19 Dec 2007 16:19:27 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF58C@corpexc01.corp.networkrobots.com>
In-Reply-To: <20071119175144.GD4670@austin.ibm.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
	<20071119175144.GD4670@austin.ibm.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Linas Vepstas" <linas@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linas,

I found it hard way. You are correct. I am just loosing the console, and
all the programs are executing fine. I could put a printk in execve and
see all the programs executing (printk's work fine).

I am using a PowerPC based system with my own kernel and initrd (not
RedHat system). Can you please elaborate on what exactly you are
suggesting me to do. Are you trying to copy /dev/<files> from build
machine to the ramdisk? I am confused.

Further, I could not find /dev/hv* files in any of the systems. What are
they for?

You also mentioned about tweaking initrd and udev. Appreciate some help
with this console loosing.=20

Thanks in advance for your help.

- Siva


-----Original Message-----
From: Linas Vepstas [mailto:linas@austin.ibm.com]=20
Sent: Monday, November 19, 2007 9:52 AM
To: Siva Prasad
Cc: linuxppc-embedded@ozlabs.org; linuxppc-dev@ozlabs.org
Subject: Re: hangs after "Freeing unused kernel memory"

On Thu, Nov 15, 2007 at 04:00:09PM -0800, Siva Prasad wrote:
> Hi,
>=20
> This sounds like a familiar problem, but could not get answers in
posts
> that came up in google search.
>=20
> My system hangs after printing the message "Freeing unused kernel
> memory". It should execute init after that, but not sure what exactly
is
> happening. Appreciate if some one can throw few ideas to try out.

It might not be a hang, it might be simply that you loose the console.
If this is a redhat system, and you didn't tweak initrd and udev just=20
right, this can happen.

Try doing this:

      mount --bind / /mnt
      cp -a /dev/null /mnt/dev
      cp -a /dev/console /mnt/dev
      cp -a /dev/hv* /mnt/dev
      umount /mnt

> Seems it is actually hanging when it makes the call "
> run_init_process(ramdisk_execute_command)" in init/main.c

Then again, your initrd might be corrupted.

--linas

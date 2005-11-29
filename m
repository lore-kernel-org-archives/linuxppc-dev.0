Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id CADB96881C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 12:06:37 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i23so2520592wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 17:06:36 -0800 (PST)
Message-ID: <4dd15d180511281706q388def30r42d3452c392bc92@mail.gmail.com>
Date: Mon, 28 Nov 2005 20:06:36 -0500
From: David Ho <davidkwho@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050920180758.9020C353AB3@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200509201117.40454.david.jander@protonic.nl>
	<20050920180758.9020C353AB3@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, just catching up on this problem as I have another unit that
showed the same symptom.
My system looks like this

MPC852T
128Mbytes SDRAM
64Mbytes Flash

Flash partitions
2*1.25Mbytes partitions for Kernel
61.5Mbytes for rootfs and applications.
Remaining 1Mbyte for U-boot, u-boot env and spare.

I get that same problem as well.  kernel BUG at gc.c: 139

I have compiled Perl, Openssl, Openssh, etc running NFS so SDRAM is
definitely not the issue.

David: have you gotten any new insights since?

Regards,
David Ho


On 9/20/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <200509201117.40454.david.jander@protonic.nl> you wrote:
> >
> > Is there something like memtest86 for linux-ppc (i.e. written in portab=
le C)?
>
> Yes, there is. Run the system with root file system mounted over NFS,
> and then put some load on the system, like  by  compiling  the  linux
> kernel  on  the  target.  Anything  else which adds DMA load does not
> hurt, either. In such a situation, with a lots of  context  switches,
> stress  on  the  memory  management  system  and having a lots of DMA
> traffic going on you may see some memory problems. Unfortunately none
> of the standard memory tests will catch thse, as  the  tests  usually
> provide  only plain read / write accesses, while the problems show up
> only in burst mode, i. e. when filling the caches and/or doing DMA.
>
> There is an attempt of a burst mode memory test in the  U-Boot  code,
> but  I  have to admit that I didn't work to show the exact problem on
> the system it was written for.
>
> > Hmm, but.... there is no data corruption. I have not seen one file on f=
lash
> > that had other data than intended, and that inspite of the GC freaking =
out.
>
> Maybe there is no corruption of the data in flash. But are  you  sure
> that  correct  data are loaded to and read from RAM? We had a similar
> problem on a board where data got corrupted only when doing a lot  of
> transfers flash->RAM.
>
> > That commit only changed 3 files, non of them directly related to jffs2=
 code,
>
> This is correct.
>
> > and only seemed to add support for FUJITSU flash chips. What am I missi=
ng?
> > MTD developers say that cvs from march-2005 _is_ broken, so there must =
be some
>
> Yes, of course it's broken. Like  all  computer  code.  There  are  a
> couple  of  known  issues  (especially  with NAND flash), but I don't
> think they could explain the type of problems you are seeing.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Einstein argued that there must be simplified explanations of nature,
> because God is not capricious or arbitrary. No  such  faith  comforts
> the software engineer.                             - Fred Brooks, Jr.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

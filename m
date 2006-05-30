Return-Path: <adgospod@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id 5596E67B36
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 08:15:19 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so139976wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 15:15:18 -0700 (PDT)
Message-ID: <bdfc5d6e0605301515r4940ac72n8a7b1bfede150ad1@mail.gmail.com>
Date: Tue, 30 May 2006 18:15:14 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
Subject: Re: execve of /sbin/init fails
In-Reply-To: <b4b98b690605301429q4f474ec4g9545005de192e1d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
	<b4b98b690605301429q4f474ec4g9545005de192e1d6@mail.gmail.com>
Cc: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>,
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

On 5/30/06, Steve Iribarne (GMail) <netstv@gmail.com> wrote:
> On 5/30/06, Anantharaman Chetan-W16155
> <Chetan.S.Anantharaman@motorola.com> wrote:
> >
> >
> >
> >
> > Hi,
> >
> > I am trying to bring up a custom board with a PPC405 processor running Linux
> > 2.4.20 (MontaVista Release) and am having problems with the call to
> > execve("/sbin/init", argv_init, envp_init) not returning in the file main.c.
>
>
> Hmm.. Ok.. so I've read the other suggestions all good, but I think we
> are missing some info.  Are you running Busybox?  If you are using
> Busybox, what version?  Also, what init are you using?  Are you using
> busyboxes?
>
> The ramdisk suggestion was a good one.  First off, check what is in
> your ramdisk.  Also check the rights of the files in the ramdisk.
> Make sure you have the execute bit set.  I've seen exactly what you
> are seeing when my rights on the file init were messed up.
>
> Also I think I've seen a hang with an older version of Busybox using
> their version of init.  I just got sysinit and that seemed to fix it,
> (Although I had to reconfig Busybox to not use their version of init)
>

I guess I totally assumed busybox was being used, so good suggestion.
I too saw this with an older version of busybox (0.60 maybe?) and I
ended up editing the config to contain only init and then compiled it
statically and placed it on the rootfs.  It turned out to be just the
right size and functionality for my needs.  I think I later updated to
a 1.0 or 1.1-series and didn't have to use the same hack.


>
>
>
> > The processor just hangs and there is no output on the terminal.
>
>
> When you say the process just "hangs", where are you in the boot
> cycle?  Is it before you see the linux kernel starting to load?  Or do
> you see any kernel messages start to spew out?
>
> Hope this helps a little.
>
> -stv
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

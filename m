Return-Path: <david.jander@protonic.nl>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 8882267A70
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jan 2005 18:16:55 +1100 (EST)
Received: from linux.local (linux.local [192.168.1.97])
	by protonic.xs4all.nl (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id
	A0E6FD403E for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jan 2005 08:05:54 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 17 Jan 2005 08:16:50 +0100
References: <313680C9A886D511A06000204840E1CF0A6474EC@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6474EC@whq-msgusr-02.pit.comms.marconi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501170816.50398.david.jander@protonic.nl>
Subject: Re: Linux 2.6-10.rc3 8xx - Only 3 characters are printed well in __
	init start_kernel() upon kernel booting - why ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sunday 16 January 2005 20:54, Povolotsky, Alexander wrote:
>[...]
> > to prove it I added printk("ALEX\n"); in __init start_kernel() prior to
> > printk(linux_banner);
> >
> > ...
> > lock_kernel();
> > page_address_init();
> > printk("ALEX\n");
> > printk(linux_banner);
> > setup_arch(&command_line);
> > setup_per_cpu_areas();
> > ...
> >
> > after gunzip
> > done.
> > Now booting the kernel
> > ALE=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=
=FF=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=
=FF=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF
> >=FF =FF=C0=D8=C0=FF=FF
> > <more garbage>
> > <hangs>
> >
> > Why would first 3 characters come out right ?
> > Any ideas ?

My fairly uneducated guess: The system hangs before the last character come=
s=20
out of the uart buffer. Try adding a delay just after printk.
The garbage could be anything produced by a piece of hardware gone wild.

Greetings,

=2D-=20
David Jander
Protonic Holland.

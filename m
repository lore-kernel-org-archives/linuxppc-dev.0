Message-ID: <B2FEA4881D7DD411BFDC000629A819D802BC2D55@POSTAL>
From: "Martin, Tim" <tim.martin@viasat.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: linuxppc_2_4_devel on walnut
Date: Wed, 7 Nov 2001 12:27:48 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can leave the default value of ic_enable at 0 and enter
ip=bootp as part of your boot prompt.

Tim

-----Original Message-----
From: Wright, David [mailto:dwright@infiniswitch.com]
Sent: Wednesday, November 07, 2001 9:47 AM
To: Kenneth Johansson; linuxppc-embedded@lists.linuxppc.org;
akuster@mvista.com
Subject: RE: linuxppc_2_4_devel on walnut



If you're trying to boot a Walnut with an NFS root, it can be done,
but things have changed a bit from earlier versions.  We have it
working on 2.4.14-pre3.

1)  You still need a command line with the nfs root directive

2)  Your .config and autoconf.h need to specify both CONFIG_ROOT_NFS
    and CONFIG_IP_PNP_BOOTP.

There may be a way to do it with command line options, but I just
said the heck with it and changed net/ipv4/ipconfig.c to set the
default value of ic_enable to 1.  It used to be default 1, but now
is default 0.

  -- David Wright, Consulting Engineer, InfiniSwitch Corp.



> -----Original Message-----
> From: Kenneth Johansson [mailto:kenneth.johansson@inn.ericsson.se]
> Sent: Wednesday, November 07, 2001 12:39 PM
> To: linuxppc-embedded@lists.linuxppc.org; akuster@mvista.com
> Subject: Re: linuxppc_2_4_devel on walnut
>
>
>
> This is a litte update.
>
> I did indeed not use the default configuration. The default
> worked fine.
>
> The problem with the network was a typo in the command line
> and no problem
> with the driver code but something is funny in the ip autoconf code.
>
> So now it sets the ip and stuff over bootp but the nfsroot
> fails without even
> trying to go out on the wire. This was with the code from 2001-10-29.
>
> So I updated to todays version recompiled with the default
> and now I don't
> get any output from the kernel even on the serial console. I
> did not have
> time to read thru every patch since oct 29 today so I ask is
> this problem
> known to exist at this point.
>
>
> Kenneth Johansson wrote:
> >
> > I tried the latest version on my walnut card and noticed two things.
> >
> > 1. The default configuration don't compile
> >
> > 2. The ethernet driver gets confused. It reports 10mb and
> half duplex when it
> > really is 100Mb full duplex. And it reports 100Mb full
> duplex when only 10Mb
> > half duplex exist.
> >
> > --
> > Kenneth Johansson
> > Ericsson Business Innovation AB   Tel: +46 8 404 71 83
> > Viderögatan 3                     Fax: +46 8 404 72 72
> > 164 80 Stockholm                  kenneth.johansson@inn.ericsson.se
> >
>
> --
> Kenneth Johansson
> Ericsson Business Innovation AB   Tel: +46 8 404 71 83
> Viderögatan 3                     Fax: +46 8 404 72 72
> 164 80 Stockholm                  kenneth.johansson@inn.ericsson.se
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 19 May 2004 15:44:48 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Hawley <bhawley@luminex.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics
Message-ID: <20040519224447.GE13351@gate.ebshome.net>
References: <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com> <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com> <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com> <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 19, 2004 at 02:34:29PM -0700, Brian Hawley wrote:
> At 03:11 PM 5/19/04 -0700, Eugene Surovegin wrote:
>
> >inird option has nothing to do with MAC address. MAC address is read by
> >ebony.c directly from OpenBIOS VPD area (see ebony.c::ebony_setup_arch())
> >regardless whether initrd is enabled or not.
> >
> >Probably, you have erased this area on your box.
>
> I don't think so, it always appears correct when I print the
> environment variables in uboot.

This is irrelevant, ebony.c doesn't know about u-boot.

> It also appears to be correct when the
> IBM boot prom displays the emac parameters.

It's possible that after you did something with OpenBIOS, e.g. rebuilt it, VPD
area moved to some other place. Or probably you have an old or new boot loader
:)

ebony.h uses hardcoded addresses:

/* Macros to get at Ebony VPD info */
#define EBONY_VPD_BASE          0x00000001fffffe00ULL
#define EBONY_VPD_SIZE          0x24
#define EBONY_NA0_OFFSET        0x0c
#define EBONY_NA1_OFFSET        0x18
#define EBONY_NA0_ADDR(base)    (base + EBONY_NA0_OFFSET)
#define EBONY_NA1_ADDR(base)    (base + EBONY_NA1_OFFSET)

P.S. There is another possible solution for your problems, you can hire somebody
who knows this stuff.

I bet there are people here who are available. Just send a message to the list
with appropriate subject :)

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

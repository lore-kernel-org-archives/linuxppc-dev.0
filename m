Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "John Nikiforos" <ppclinuxuser@yahoo.gr>,
	"Dominique Letty" <dletty@interfaceconcept.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem with MPC8260 buffer descriptor
Date: Thu, 17 Oct 2002 07:30:50 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEIMDNAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-7"
In-Reply-To: <20021017135003.23135.qmail@web13115.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are 2 bits in the rfcr & tfcr fields of parameter RAM that are very
important.

1. GBL - I believe that this is the cache coherency bit you are looking for
2. DTB - this determines which RAM are the data buffers that the BD
structures point to are located

Hint, if you are using local RAM for your buffers you do not need GBL. Your
buffer descriptors must reside in DP RAM. If you want help, post the
information I requested before, otherwise this is a guessing game.

>
>  I don't remember if it is called ECE or ESE.
> I think it is on the HID0. But I am not sure.
> I currently don't have the manual handy.
>
>                        John
>
>  --- Dominique Letty <dletty@interfaceconcept.com>
> έγραψε: >
> > I don't find any information about this ECE bit in
> > MPC8260UM and 603eUM.
> > Where can I enable it?
> >
> > Thinks for your help.
> >
> > Dominique
> > -----Message d'origine-----
> > De : John Nikiforos [mailto:ppclinuxuser@yahoo.gr]
> > Envoye : jeudi 17 octobre 2002 09:57
> > A : acurtis@onz.com; Dominique Letty;
> > linuxppc-embedded@lists.linuxppc.org
> > Objet : RE: Problem with MPC8260 buffer descriptor
> >
> >
> >  Is the ECE bit enabled?
> > (Cache coherency for the 8260, so that the
> > CPM wont get any stalled data)
> >
> >                     John
> >
> >  --- Allen Curtis <acurtis@onz.com> έγραψε: >
> > > > Now I try to port this driver under Linux 2.4.17
> > > Kernel for a MPC8260. I
> > > > have allocated
> > > > Buffer Descriptors in DPRAM and Data Buffers in
> > > SDRAM. When I try
> > > > to send a
> > > > buffer, I fill
> > > > a data buffer and the first BD registers, I
> > think,
> > > with the
> > > > correct values.
> > > > It doesn't work
> > > > anytimes. When the buffer is transmited, the
> > > sending data are correct. The
> > > > problem seems to
> > > > come from the CPM which can't access to the BD
> > > modifications in the DPRAM.
> > > >
> > > > Does anyone have already meet these problems?
> > >
> > > Would it be a problem to post your:
> > >
> > > 1. GSMRH & GSRM_L initialization
> > > 2. SCC Parameter RAM configuration
> > > 3. Location of your BDs in DPRAM
> > >
> > > THX
> > >
> > >
> > >
> >
> >
> >
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

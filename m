From: "Dominique Letty" <dletty@interfaceconcept.com>
To: "'Dominique Letty'" <dletty@interfaceconcept.com>
Cc: <acurtis@onz.com>
Subject: RE: Problem with MPC8260 buffer descriptor
Date: Thu, 17 Oct 2002 19:08:01 +0200
Message-ID: <001801c275ff$c5f87560$3501a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-7"
In-Reply-To: <001701c275fd$e74f3a20$3501a8c0@none>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry,

I forgot the last initialization instruction that enables reception and
transmission.

dominique

        IMAP_ADDR       =       0xff000000
        scc dpram       =       0xff008000
        scc_rbase       =       0x890
        scc_tbase       =       0x8b0
        scc_rfcr        =       0x30
        scc_tfcr        =       0x30
        scc_mrblr       =       0x800
        scc_rstate      =       0x0
        scc_idp         =       0x0
        scc_rbptr       =       0x890
        scc_ibc         =       0x0
        scc_rxtmp       =       0x0
        scc_tstate      =       0x0
        scc_tdp         =       0x0
        scc_tbptr       =       0x8b0
        scc_tbc         =       0x0
        scc_txtmp       =       0x0
        scc_rcrc        =       0x0
        scc_tcrc        =       0x0
        c_mask          =       0xdebb20e3
        c_pres          =       0xffffffff
        disfc           =       0x0
        crcec           =       0x0
        abtsc           =       0x0
        nmarc           =       0x0
        retrc           =       0x0
        mflr            =       0xc8
        max_cnt         =       0x0
        rfthr           =       0x1
        rfcnt           =       0x0
        hmask           =       0x0
        haddr1          =       0x0
        haddr2          =       0x0
        haddr3          =       0x0
        haddr4          =       0x0
        tmp1            =       0x0
        tmp_mb          =       0x0
        SCC register    =       0xff011a00
        scc_gsmrl       =       0x30
        scc_gsmrh       =       0x8000
        scc_pmsr        =       0x800
        scc_todr        =       0x0
        scc_dsr         =       0x7e7e
        scc_scce        =       0x0
        scc_sccm        =       0x1b
        scc_sccs        =       0x2
        rx bd address   =       0xff000890
        tx bd address   =       0xff0008b0

-----Message d'origine-----
De : owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part de Dominique
Letty
Envoye : jeudi 17 octobre 2002 18:55
A : acurtis@onz.com
Objet : RE: Problem with MPC8260 buffer descriptor



Hi Allen,

You will find my SCC configuration below. I was thinking that my problem in
this driver was
cache and MMU configurations. But now, I'm not sure.
Dominique
        IMAP_ADDR       =       0xff000000
        scc dpram       =       0xff008000
        scc_rbase       =       0x890
        scc_tbase       =       0x8b0
        scc_rfcr        =       0x30
        scc_tfcr        =       0x30
        scc_mrblr       =       0x800
        scc_rstate      =       0x0
        scc_idp         =       0x15c006c
        scc_rbptr       =       0x890
        scc_ibc         =       0x64
        scc_rxtmp       =       0x0
        scc_tstate      =       0x0
        scc_tdp         =       0x161c068
        scc_tbptr       =       0x8b0
        scc_tbc         =       0x0
        scc_txtmp       =       0x65f00f42
        scc_rcrc        =       0x9a0ff0bd
        scc_tcrc        =       0x873759e0
        c_mask          =       0xdebb20e3
        c_pres          =       0xffffffff
        disfc           =       0x0
        crcec           =       0x0
        abtsc           =       0x0
        nmarc           =       0x0
        retrc           =       0x0
        mflr            =       0xc8
        max_cnt         =       0x60
        rfthr           =       0x1
        rfcnt           =       0x1
        hmask           =       0x0
        haddr1          =       0x0
        haddr2          =       0x0
        haddr3          =       0x0
        haddr4          =       0x0
        tmp1            =       0x0
        tmp_mb          =       0xc8
        SCC register    =       0xff011a00
        scc_gsmrl       =       0x0
        scc_gsmrh       =       0x8000
        scc_pmsr        =       0x800
        scc_todr        =       0x0
        scc_dsr         =       0x7e7e
        scc_scce        =       0x0
        scc_sccm        =       0x1b
        scc_sccs        =       0x3
        rx bd address   =       0xff000890
        tx bd address   =       0xff0008b0



-----Message d'origine-----
De : Allen Curtis [mailto:acurtis@onz.com]
Envoye : jeudi 17 octobre 2002 16:31
A : John Nikiforos; Dominique Letty
Cc : linuxppc-embedded@lists.linuxppc.org
Objet : RE: Problem with MPC8260 buffer descriptor


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

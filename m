From: marko.virkki@mitron.fi
Message-ID: <17D9D7DF3CD5A94A9B4E82778D24391910A119@MITRON>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux on a Motorola MPC5200 ? 
Date: Thu, 12 Feb 2004 12:58:32 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I'm very interested in usable DMA engine for AC97.
Will new BC uCode provide any help for this?
Do you know what new CAPI will contain or is there any documentation
available?
Is there any attempt to develop an audio device driver for AC97 in MPC5200?

As far as I've understood there are several problems regarding AC97 audio in
MPC5200:
- Variable sample rate mode is impossible (applications level data
conversion required)?
- PSC FIFO's are not "frame aware" (underrun will totally mess things)
- it's hard to syncronize mixer commands with ongoing audio stream
- FIFO can contain data only for ~180uS (BC interrupt latency and data
handling time shall be less than this)
- PCM data payload is less than 10% (huge kernel space buffers required)
- XL-bus overhead (new BC API will definetly not decrease this, but seems
pretty much like waste to me)
- ...

TIA, Marko


> -----Original Message-----
> From:	Wolfgang Denk [SMTP:wd@denx.de]
> Sent:	27. tammikuuta 2004 21:15
> To:	Sylvain Munaut
> Cc:	linuxppc-embedded@lists.linuxppc.org
> Subject:	Re: Linux on a Motorola MPC5200 ?
>
>
> In message <40169FC6.1040805@246tNt.com> you wrote:
> >
> > I'd like to run linux on a future custom board based on a motorola
> > MPC5200 and I have a few questions :
> >
> >  - What is the current support for it ? Stable ... I'd need the DMA (
>
> Yes, it is stable, with a couple of well-known problems.
>
> > well, their 'special DMA fancy stuff' ;) ), ATA, DDR, I2S, AC97 mainly.
>
> ATA: OK as long as you don't enable DMA writes (*)
>
> DDR: OK (use icecube_5200_DDR configuration in U-Boot); the LOWBOOT
>      option is not working yet (we are working on this)
>
> I2S: simultaneous reading and writing is impossible (*)
> AC97: ditto
>
> (*) to fix these issues we're waiting for a  bugfix  release  of  the
>     BestComm CAPI which might become availabe by mid February.
>
> >  - I'd really like to run a 2.6 kernel on it. If it's not yet ported to
>
> Forget it. Why would you want to  do  that?  Which  features  do  you
> expect from 2.6 which are not available in 2.4?
>
> > the 2.6 what is the current ppc support for 2.6 ? Would I "only" need to
> > port MPC specifics ?
>
> No comment.
>
> >  - Where can I find the current stuff ? I've taken what is in
> > ppc.bkbits.net/linux-2.4-mpc5xxx, is there other things I should
> consider ?
>
> Our current stuff is on our CVS  server,  in  the  linuxppc_2_4_devel
> tree.  As  far  as the 5200 is concerned this includes stuff that was
> submitted but not yet added to the linux-2.4-mpc5xxx  tree  (but  Tom
> promised to add our patches).
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Machines take me by surprise with great frequency.      - Alan Turing
>
;==================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

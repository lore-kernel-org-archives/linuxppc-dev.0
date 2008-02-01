Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth14.prod.mesa1.secureserver.net
	(smtpauth14.prod.mesa1.secureserver.net [64.202.165.39])
	by ozlabs.org (Postfix) with SMTP id ACF54DDFE3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 08:38:07 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <mailman.3.1201827605.31777.linuxppc-embedded@ozlabs.org>
	<000001c864c8$4bd81bb0$6405a8c0@absolut>
	<1ADE91E0-282D-4455-9754-886846B3EB90@kernel.crashing.org>
Subject: RE: 83xx immap_qe.h -> SIR type def error?
Date: Fri, 1 Feb 2008 13:37:13 -0800
Message-ID: <000401c8651a$9da265c0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I should state, I am looking at the MPC8360ERM.pdf Rev 2.0

-Russ

> -----Original Message-----
> From: Russell McGuire [mailto:rmcguire@videopresence.com]
> Sent: Friday, February 01, 2008 1:03 PM
> To: 'Kumar Gala'
> Cc: 'linuxppc-embedded@ozlabs.org'
> Subject: RE: 83xx immap_qe.h -> SIR type def error?
> 
> Kumar,
> 
> Yes in the main memeory map they are just listed as 1K RAM blocks.
> However, in the UM Section 36.6.1 <pg 36-12 or pg 1728 in the PDF>.
> 
> It gives the breakout for the RAM, which clearly indicates 16 bit fields.
> <Here is a short clip from Figure 36-8>
> 
> Access: Read/Write
> 0 1 2 3 4 5 6 7 10 11 13 14 15
> MCC SWTR SSEL 1 SSEL 2 SSEL 3 SSEL 4 SGS CSEL CNT BYT LST
> Figure 36-8. SI RAM Entry for UCC
> 
> Honest, mistake as if I were writing the header file I'd not have time to
> ready all 2000+ pages of the UM. We find these only as somebody goes in an
> tries to use them.
> And I am guessing not a lot of customers use the SI block.
> 
> -Russ
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Friday, February 01, 2008 6:56 AM
> > To: rmcguire@videopresence.com
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: 83xx immap_qe.h -> SIR type def error?
> >
> >
> > On Feb 1, 2008, at 5:47 AM, Russell McGuire wrote:
> >
> > > All Freescale,
> > >
> > > Not sure if this is the place to post this, but I have run across
> > > what I
> > > consider to be a possible type error in the immap_qe.h file, for the
> > > asm/powerpc branch.
> > >
> > > In the file immap_qe.h
> > >
> > > /* SI Routing Tables */
> > > struct sir {
> > > 	u8  tx[0x400];
> > > 	u8  rx[0x400];
> > > 	u8  res0[0x800];
> > > }
> > >
> > > Shouldn't these types be defined as __be16 ?
> > >
> > > According to the Freescale manual this is a 16 bit field, not an 8-bit
> > > field.
> > >
> > > Spent an hour trying to figure out why I couldn't fill this field
> > > out with
> > > upper 8 bits last night.
> > >
> > > Thoughts?
> >
> > I'm guessing it was done this way since they are just looked as base
> > offsets.  Where in the UM do you see anything about them being 16-bit
> > quantities?  (I'm really know little about this).
> >
> > - k

Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id CD9FB67B9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 02:24:45 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so2072976nfe
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 09:24:43 -0700 (PDT)
Message-ID: <528646bc0608210924v7dbc55a4gbe2505d15ae42d40@mail.gmail.com>
Date: Mon, 21 Aug 2006 10:24:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wade Maxfield" <wmaxfield@gmail.com>
Subject: Re: PPC beginner questions
In-Reply-To: <45a1b53e0608210907k6acec26ag94b0621273109532@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
	<528646bc0608210714g51928043lb729e80bda753d4d@mail.gmail.com>
	<45a1b53e0608210759p270c2f8dy694e91f409d57729@mail.gmail.com>
	<528646bc0608210838p4071f9eeie560fbba18ae2b3d@mail.gmail.com>
	<45a1b53e0608210907k6acec26ag94b0621273109532@mail.gmail.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/21/06, Wade Maxfield <wmaxfield@gmail.com> wrote:
> On 8/21/06, Grant Likely <grant.likely@secretlab.ca > wrote:
> > On 8/21/06, Wade Maxfield <wmaxfield@gmail.com > wrote:

> > >   I'm assuming inb() outb(), inw() outw()??  I've been googling and have
> > > come up short with info that makes sense. It is almost all x86 centric.
> >
> > in_8, in_be16, in_be32, out_8, out_be16, out_be32 for big-endian
> > device registers
> > in_8, in_le16, in_le32, out_8, out_le16, out_le32 for little endian
> > device registers
>
>
> -->Interesting.  Do these functions do 'eieio'  (Email, Internet, Electronic
> Information Officer functions (southpark cartoon), err, or  Enforce In-Order
> Execution of Input/Output) for me, or do I have to do that?  I'm still
> confused as to that Old MacDonald function.

The in functions do isync
The out functions do eieio

> >
> > heh, yes you can; but if your writing new code why not use good
> > practice from the start?  :)
>
>
> --> Ok, you win.  How about ioread8() or inb() also?  Are they not coded in
> PPC correctly? Or is the in_8() more modern?

read include/asm/io.h.  All the IO routines are defined there.
read[bwl] and write[bwl] are just macros to in_* out_*, as are inb,
outb, etc.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

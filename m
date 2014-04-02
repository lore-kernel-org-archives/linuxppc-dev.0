Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B64C14008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 02:57:09 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 16:57:06 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6F18E2190041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 16:56:57 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32Fup4i66977798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 15:56:51 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32Fv2G8016705
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 11:57:02 -0400
Date: Wed, 2 Apr 2014 17:56:58 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] powerpc/le: enable RTAS events support
Message-ID: <20140402175658.1b4a8c4d@bahia.local>
In-Reply-To: <CAMuHMdXXELjK-t4k025uRE3QPsMiYR9KevtEnq_k32m-4g+fPg@mail.gmail.com>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <53398379.8000203@linux.vnet.ibm.com>
 <CAMuHMdXXELjK-t4k025uRE3QPsMiYR9KevtEnq_k32m-4g+fPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 1 Apr 2014 12:26:32 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Mar 31, 2014 at 5:02 PM, Nathan Fontenot
> <nfont@linux.vnet.ibm.com> wrote:
> >  struct rtas_error_log {
> > -       unsigned long version:8;                /* Architectural version */
> > -       unsigned long severity:3;               /* Severity level of error */
> > -       unsigned long disposition:2;            /* Degree of recovery */
> > -       unsigned long extended:1;               /* extended log present? */
> > -       unsigned long /* reserved */ :2;        /* Reserved for future use */
> > -       unsigned long initiator:4;              /* Initiator of event */
> > -       unsigned long target:4;                 /* Target of failed operation */
> > -       unsigned long type:8;                   /* General event or error*/
> > -       unsigned long extended_log_length:32;   /* length in bytes */
> > -       unsigned char buffer[1];                /* Start of extended log */
> > +       /* Byte 0 */
> > +       uint8_t         version;                /* Architectural version */
> > +
> > +       /* Byte 1 */
> > +       uint8_t         severity;
> > +       /* XXXXXXXX
> > +        * XXX          3: Severity level of error
> > +        *    XX        2: Degree of recovery
> > +        *      X       1: Extended log present?
> > +        *       XX     2: Reserved
> > +        */
> > +
> > +       /* Byte 2 */
> > +       uint8_t         :8;
> > +       /* XXXXXXXX
> > +        * XXXX         4: Initiator of event
> > +        *     XXXX     4: Target of failed operation
> > +        */
> > +       uint8_t         type;                   /* General event or error*/
> > +       uint32_t        extended_log_length;    /* length in bytes */
> 
> Now the bitfields are gone, things like the above can become __be32,
> so we get extra type checking from sparse ("make C=1").
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

I am reworking a patch in this direction.

Thanks.

--
Greg

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/Meiosys                  http://www.ibm.com
Tel +33 (0)562 165 496

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.

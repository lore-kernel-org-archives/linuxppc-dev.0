Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6116E1400AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 21:26:37 +1100 (EST)
Received: by mail-pa0-f49.google.com with SMTP id lj1so9599496pab.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Apr 2014 03:26:33 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <53398379.8000203@linux.vnet.ibm.com>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <53398379.8000203@linux.vnet.ibm.com>
Date: Tue, 1 Apr 2014 12:26:32 +0200
Message-ID: <CAMuHMdXXELjK-t4k025uRE3QPsMiYR9KevtEnq_k32m-4g+fPg@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc/le: enable RTAS events support
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2014 at 5:02 PM, Nathan Fontenot
<nfont@linux.vnet.ibm.com> wrote:
>  struct rtas_error_log {
> -       unsigned long version:8;                /* Architectural version */
> -       unsigned long severity:3;               /* Severity level of error */
> -       unsigned long disposition:2;            /* Degree of recovery */
> -       unsigned long extended:1;               /* extended log present? */
> -       unsigned long /* reserved */ :2;        /* Reserved for future use */
> -       unsigned long initiator:4;              /* Initiator of event */
> -       unsigned long target:4;                 /* Target of failed operation */
> -       unsigned long type:8;                   /* General event or error*/
> -       unsigned long extended_log_length:32;   /* length in bytes */
> -       unsigned char buffer[1];                /* Start of extended log */
> +       /* Byte 0 */
> +       uint8_t         version;                /* Architectural version */
> +
> +       /* Byte 1 */
> +       uint8_t         severity;
> +       /* XXXXXXXX
> +        * XXX          3: Severity level of error
> +        *    XX        2: Degree of recovery
> +        *      X       1: Extended log present?
> +        *       XX     2: Reserved
> +        */
> +
> +       /* Byte 2 */
> +       uint8_t         :8;
> +       /* XXXXXXXX
> +        * XXXX         4: Initiator of event
> +        *     XXXX     4: Target of failed operation
> +        */
> +       uint8_t         type;                   /* General event or error*/
> +       uint32_t        extended_log_length;    /* length in bytes */

Now the bitfields are gone, things like the above can become __be32,
so we get extra type checking from sparse ("make C=1").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

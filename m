Return-Path: <glikely@secretlab.ca>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 986781A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 00:05:22 +1000 (EST)
Received: by mail-ig0-f171.google.com with SMTP id r10so1155148igi.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 07:05:20 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20140909160127.671fef38@marrow.netinsight.se>
References: <20140909160127.671fef38@marrow.netinsight.se>
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 9 Sep 2014 15:05:00 +0100
Message-ID: <CACxGe6uUGT8qVCRr_OiH4Zbykmok+RB=2c3s-ifnU3_WzQPViA@mail.gmail.com>
Subject: Re: [PATCH / RFC] PowerPC: boot: Parse chosen/cmdline-timeout
 parameter
To: =?ISO-8859-1?Q?Simon_K=E5gstr=F6m?= <simon.kagstrom@netinsight.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 9, 2014 at 3:01 PM, Simon K=E5gstr=F6m
<simon.kagstrom@netinsight.net> wrote:
> A 5 second timeout during boot might be too long, so make it
> configurable.
>
> The property is added to the chosen node, e.g.,
>
>         chosen {
>                 bootargs =3D "console=3DttyUL0 root=3D/dev/ram0";
>                 linux,stdout-path =3D "/plb@0/serial@46000000";
>                 cmdline-timeout =3D <100>;
>         } ;
>
>
> Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
> ---
>
> We build a simpleImage for a Virtex 4 PPC405 target, and the
> delay-for-command-line-edits is a significant part of the total boot
> time.
>
> Questions (apart from the patch in general):
>
> - Should the property be in the chosen node?
yes

>
> - Naming of the property?

Use a 'linux,' prefix. "linux,cmdline-timeout"


> -static void serial_edit_cmdline(char *buf, int len)
> +static void serial_edit_cmdline(char *buf, int len, unsigned int timeout=
)
>  {
>         int timer =3D 0, count;
>         char ch, *cp;
> @@ -44,7 +44,7 @@ static void serial_edit_cmdline(char *buf, int len)
>         cp =3D &buf[count];
>         count++;
>
> -       while (timer++ < 5*1000) {
> +       while (timer++ < timeout) {

Perhaps allow the loop to go through at least once so that the editor
can be broken into by holding down a key.

g.

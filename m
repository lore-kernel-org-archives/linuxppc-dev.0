Return-Path: <gorcunov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 86C66DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 15:23:56 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3692769wag
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 20:23:54 -0800 (PST)
Message-ID: <aa79d98a0711222023l31cdec98o47f56e3c87886a02@mail.gmail.com>
Date: Fri, 23 Nov 2007 07:23:54 +0300
From: "Cyrill Gorcunov" <gorcunov@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PPC: CHRP - fix possible NULL pointer dereference
In-Reply-To: <20071123101646.63550945.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071122195423.GA9877@cvg>
	<20071123101646.63550945.sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, PPCML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/23/07, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Thu, 22 Nov 2007 22:54:23 +0300 Cyrill Gorcunov <gorcunov@gmail.com>
> wrote:
> >
> > This patch does fix possible NULL pointer dereference
> > inside of strncmp() if of_get_property() failed.
>
> Thanks for this.
>
> >  static void __init sio_init(void)
> >  {
> >   struct device_node *root;
> > + const char *model = NULL;
>
> You don't need this initialization as you always assign the variable
> before you use it.
>
> > + root = of_find_node_by_path("/");
> > + if (root) {
>
>  if (!root)
>   return;
>
> would save a level of indentation. Not important.
>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>
Oh my :) Thanks. I'll fix it and resend.

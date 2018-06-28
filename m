Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Gh121GxrzF1MV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 23:47:33 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id p185-v6so12602632itp.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
 <20180626074426.hzunfbvwbubt3t3p@mwanda>
 <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
 <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
In-Reply-To: <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 28 Jun 2018 21:47:20 +0800
Message-ID: <CAFgQCTsZk=gQmwpTcaaTkLjmb1W5mPKbo5Bonkd+Bj_rW+mZYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
To: dan.carpenter@oracle.com
Cc: kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2018 at 4:35 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 27, 2018 at 10:34:54AM +0800, Pingfan Liu wrote:
> > > 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> > > 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> > > 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
> > >
> > > If the list is empty then "ret" can be unitialized.  We test a different
> > > list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> > > code to make Smatch try to understand about empty lists, but I don't
> > > think it works...
> > >
> > Yes, if list_empty, then the code can not touch ret. But ret is
> > useless in this scene. Does it matter?
> >
>
> I'm not sure I understand what you're asking?  Of course, it matters?
>
Oh, I misunderstood your original comment. Yes, you are right. I will
fix it in next version, if this code section is still used.

Thanks and regards,
Pingfan

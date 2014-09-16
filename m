Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68FD61A009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 17:00:24 +1000 (EST)
Message-ID: <1410850823.12488.4.camel@concordia>
Subject: Re: [PATCH v2 2/2] pseries: Fix endian issues in cpu hot-removal
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharata B Rao <bharata.rao@gmail.com>
Date: Tue, 16 Sep 2014 17:00:23 +1000
In-Reply-To: <CAGZKiBoaXLc3dKGu5HGbU57+Lvi1KDUX=EYoi54PjYmEUjVUDg@mail.gmail.com>
References: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1410549102-8410-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <CAGZKiBoaXLc3dKGu5HGbU57+Lvi1KDUX=EYoi54PjYmEUjVUDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 12:16 +0530, Bharata B Rao wrote:
> On Sat, Sep 13, 2014 at 12:41 AM, Thomas Falcon
> <tlfalcon@linux.vnet.ibm.com> wrote:
> >
> > diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> > index 9e9f30b2..343dfdf 100644
> > --- a/arch/powerpc/platforms/pseries/dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/dlpar.c
> > @@ -496,15 +498,15 @@ out:
> >  static ssize_t dlpar_cpu_release(const char *buf, size_t count)
> >  {
> >         struct device_node *dn;
> > -       const u32 *drc_index;
> > +       const u32 drc_index;
> >         int rc;
> >
> >         dn = of_find_node_by_path(buf);
> >         if (!dn)
> >                 return -EINVAL;
> >
> > -       drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> > -       if (!drc_index) {
> > +       rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
> 
> Use of const for drc_index causes compilation problems.

Yes that's clearly wrong.

Please fix and retest.

cheers

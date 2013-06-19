Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E93C02C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 07:00:57 +1000 (EST)
Date: Wed, 19 Jun 2013 16:00:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: DEBUG_PAGEALLOC on PPC not working (kernels 2.6-25, 3.0-34)
To: saikia.partha <saikia.partha@gmail.com>
In-Reply-To: <CABeCxOKXpgVaoigGBdCVo3tYgbfJnesNPOuOyTc0EKv_CTKoyg@mail.gmail.com> (from
 saikia.partha@gmail.com on Wed Jun 19 08:09:44 2013)
Message-ID: <1371675646.9073.39@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2013 08:09:44 AM, saikia.partha wrote:
> Hi,
>=20
> We have two Freescale PowerPC boards on which we're trying to enable
> DEBUG_PAGEALLOC with the hope that we'll see an exception whenever =20
> some
> code tries to modify a page that's been already freed. To test it, we =20
> wrote
> this sample code -
>=20
> =3D=3D=3D
> #define BUF_SIZE    4096
> void
> pagealloc_test(void)
> {
>     char *buf =3D kmalloc(BUF_SIZE, GFP_KERNEL);
>=20
>     if (!buf) {
>         printk("%s[%d] - alloc failed!\n", __func__, __LINE__);
>         return;
>     }
>     printk("%s[%d] - alloc'd\n", __func__, __LINE__);
>     memset(&buf[0], 0, BUF_SIZE);
>     printk("%s[%d] - memset'd\n", __func__, __LINE__);
>     kfree(buf);
>     printk("%s[%d] - free'd\n", __func__, __LINE__);
>     memset(&buf[0], 1, BUF_SIZE);
>     printk("%s[%d] - memset'd after free!\n", __func__, __LINE__);
> }
> =3D=3D=3D
>=20
> Here, the last memset() should generate an exception if PAGEALLOC code
> correctly unmapped the page during kfree(). However, kernel is happily
> running after the memset post-free. Any clue?
> Also, the 2nd board has Book-E which has a different MMU architecture.
> Here, I saw that the function __change_page_attr() always returns as =20
> the
> condition v_mapped_by_tlbcam() is true. How do we remove the pte =20
> entry from
> the TLB in this case?  Has anyone tried DEBUG_PAGEALLOC on Book-E?

This is not supported on booke -- the tlbcam mapping is required for =20
all lowmem.

> Please find the board details below -
> Board 1: CPU - e300c4, kernel 2.6-25

For e300, I think I had it working at one point a few years ago (see =20
commit bde6c6e16aa489ea76c762fb7ffb0abb48660dd8).

The reason we can do it on e300 and not on booke is because e300 takes =20
exceptions in real mode.  On e500 the MMU is always enabled, so we need =20
bolted TLB1 entries that cover at least all exception code (up to the =20
point where a TLB miss could safely be taken) and all page tables (in =20
practice, we just bolt all lowmem) and other data that can be =20
referenced from said exception code.  There are not enough TLB1 entries =20
to do this on a fine-grained basis.

-Scott=

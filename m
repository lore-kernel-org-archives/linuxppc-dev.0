Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id DBC7CDE3C8
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 02:39:18 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so230558qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 09:39:17 -0700 (PDT)
Message-ID: <9e4733910809230939wbb89470kca4e4b5c8e6250c6@mail.gmail.com>
Date: Tue, 23 Sep 2008 12:39:17 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wright, Chuck" <Charles.A.Wright@snapon.com>
Subject: Re: Memcpy() on MPC5200B
In-Reply-To: <C0DD8F5AD4467E45B3D82B7D7A57885B16E2559E@LISL-XBCK-C1-V2.snaponglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <mailman.1567.1222082514.3127.linuxppc-dev@ozlabs.org>
	<C0DD8F5AD4467E45B3D82B7D7A57885B16E2559E@LISL-XBCK-C1-V2.snaponglobal.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 4:07 PM, Wright, Chuck
<Charles.A.Wright@snapon.com> wrote:
> I've found a case where memcpy() is failing on copies longer that 4
> bytes.
>
> Closer investigation found that the destination pointer is not pointing
> to a word aligned address.
>
> The problem comes from the JFFS2 driver where there is a struct that is
> being used to create the destination pointer for the memcpy() function.

There is a thread about this problem here:
http://thread.gmane.org/gmane.linux.drivers.mtd/21521

I don't believe it has been resolved yet.


>
> If I insert my own padding into the struct, my memcpy() problems go
> away!
> I'm concerned that this problem may be lurking in other areas of code.
> (I get no warnings during compile)
>
> On the MPC5200B processor, is that the assumed behavior for an unaligned
> memcpy()??
> Is there a gcc option to force word alignment??
>
> I'm using a MontaVista supplied kernel and compiler. (not my choice!)
> Unfortunately, six weeks later, MontaVista is still confused.
>
> Thanks for any help you can offer,
>
> Chuck Wright
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com
